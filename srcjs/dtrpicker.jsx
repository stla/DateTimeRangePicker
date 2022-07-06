import { reactShinyInput } from "reactR";
import DateTimeRangePicker from "@wojtekmaj/react-datetimerange-picker";

class DTRPwidget extends React.PureComponent {
  constructor(props) {
    super(props);
    let v1 = this.props.value.from,
      date1 = new Date(
        v1.date.year,
        v1.date.month - 1,
        v1.date.date,
        v1.time.hour,
        v1.time.minute,
        v1.time.second
      );
    let v2 = this.props.value.to,
      date2 = new Date(
        v2.date.year,
        v2.date.month - 1,
        v2.date.date,
        v2.time.hour,
        v2.time.minute,
        v2.time.second
      );
    this.state = {
      value: [date1, date2]
    };
    this.onChange = this.onChange.bind(this);
  }

  onChange(value) {
    console.log("value: ", value);
    let from = {
      date: {
        year: value[0].getFullYear(),
        month: value[0].getMonth() + 1,
        date: value[0].getDate()
      },
      time: {
        hour: value[0].getHours(),
        minute: value[0].getMinutes(),
        second: value[0].getSeconds()
      }
    };
    let to = {
      date: {
        year: value[1].getFullYear(),
        month: value[1].getMonth() + 1,
        date: value[1].getDate()
      },
      time: {
        hour: value[1].getHours(),
        minute: value[1].getMinutes(),
        second: value[1].getSeconds()
      }
    };
    this.props.setShinyValue({ from: from, to: to });
    this.setState({ value: value });
  }

  componentDidMount() {
    let that = this;
    setTimeout(function () {
      that.onChange(that.state.value);
    }, 0);
  }

  // jshint ignore: start
  render() {
    return (
      <DateTimeRangePicker
        onChange={this.onChange}
        value={this.state.value}
        format="y-MM-dd hh:mm:ss a"
        showLeadingZeros={true}
        amPmAriaLabel="Select AM/PM"
        calendarAriaLabel="Toggle calendar"
        clearAriaLabel="Clear value"
        dayAriaLabel="Day"
        hourAriaLabel="Hour"
        maxDetail="second"
        minuteAriaLabel="Minute"
        monthAriaLabel="Month"
        nativeInputAriaLabel="Date and time"
        secondAriaLabel="Second"
        yearAriaLabel="Year"
      />
    );
  }
  // jshint ignore: end
}

// jshint ignore: start
const DTRPinput = ({ configuration, value, setValue }) => {
  return (
    <DTRPwidget
      value={{ from: configuration.from, to: configuration.to }}
      setShinyValue={setValue}
    />
  );
};
// jshint ignore: end

reactShinyInput(".dtrpicker", "DateTimeRangePicker.dtrpicker", DTRPinput, {
  type: "DateTimeRangePicker.date"
});

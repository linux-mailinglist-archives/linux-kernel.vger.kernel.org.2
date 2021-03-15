Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796BB33C298
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhCOQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:55:31 -0400
Received: from mout01.posteo.de ([185.67.36.65]:34015 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhCOQzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:55:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5D04016005C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 17:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615827311; bh=MFwGXs9NTkJrHFRI9vH2zO4/74fRYDPPwBAwhgCMmoA=;
        h=Date:From:To:Cc:Subject:From;
        b=EaRGNGmqCB6rjsYxaBeJpW7x2wDbraPPE/zT85u7dvTblWco414WW0+9XN1ixRDmD
         QbPVYDE1blFVKA6R8j1hHQ1tq3lMfMBIo17HFi+gT/qHhiu1vJyMIbRrbNUDHhorv+
         qYvZXhJuRqvhCeecYCJMdLKBIvxSrmOJioIxaa9TSnOr8dvghqxQagw86ugFApT0/4
         Lm5JDOmTgNA1z4CMxSDqYZCrFgoGO/Q8+uJQHsDgMlHWIcMAauGnnEUKurYt/Ji0iV
         VVyLIjauzP7jGtVtriZPq3iK6pHKYIAkO/ff81PzXM/gEZvk45d+zSGz+8Fm3lNJ4D
         jGGVyZo91Kg9A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DzjG628s7z9rxG;
        Mon, 15 Mar 2021 17:55:10 +0100 (CET)
Date:   Mon, 15 Mar 2021 17:55:09 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for critical values
Message-ID: <20210315175509.55672ee7@monster.powergraphx.local>
In-Reply-To: <20214c50-5c58-0d3e-5de5-115ed022750e@roeck-us.net>
References: <YE93HebFD0acwZIX@monster.powergraphx.local>
        <20214c50-5c58-0d3e-5de5-115ed022750e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 08:53:25 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 3/15/21 8:02 AM, Wilken Gottwalt wrote:
> > Adds support for reading the critical values of the temperature sensors
> > and the rail sensors (voltage and current) once and caches them. Updates
> > the naming of the constants following a more clear scheme. Also updates
> > the documentation and fixes a typo.
> >=20
> > The new sensors output of a Corsair HX850i will look like this:
> > corsairpsu-hid-3-1
> > Adapter: HID adapter
> > v_in:        230.00 V
> > v_out +12v:   12.14 V  (crit min =3D  +8.41 V, crit max =3D +15.59 V)
> > v_out +5v:     5.03 V  (crit min =3D  +3.50 V, crit max =3D  +6.50 V)
> > v_out +3.3v:   3.30 V  (crit min =3D  +2.31 V, crit max =3D  +4.30 V)
> > psu fan:        0 RPM
> > vrm temp:     +46.2=C2=B0C  (crit =3D +70.0=C2=B0C)
> > case temp:    +39.8=C2=B0C  (crit =3D +70.0=C2=B0C)
> > power total: 152.00 W
> > power +12v:  108.00 W
> > power +5v:    41.00 W
> > power +3.3v:   5.00 W
> > curr in:          N/A
>=20
> What does that mean ? If it isn't supported by the power supply,
> should we drop that entirely ? Maybe drop it via the is_visible
> function if it is available for some variants, but always displaying
> N/A doesn't add value.
>=20
> This is a bit odd, though, since I would assume it translates
> to the PSU_CMD_IN_AMPS command. Any chance to track down what is
> happening here ?

I have one of the earliest PSUs of this series, it is just not supported on
mine. I'm not sure if it would be worth the trouble to catch that and turn
it off dynamically.

> > curr +12v:     9.00 A  (crit max =3D +85.00 A)
> > curr +5v:      8.31 A  (crit max =3D +40.00 A)
> > curr +3.3v:    1.62 A  (crit max =3D +40.00 A)
> > > This patch changes:
> > - hwmon corsair-psu documentation
> > - hwmon corsair-psu driver
> >=20
>=20
> That is obvious; no reason to state in the commit log.
>=20
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v2:
> >   - simplified reading/caching of critical values and hwmon_ops_read fu=
nction
> >   - removed unnecessary debug output and comments
> > ---
> >  Documentation/hwmon/corsair-psu.rst |  13 +-
> >  drivers/hwmon/corsair-psu.c         | 223 +++++++++++++++++++++-------
> >  2 files changed, 185 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/=
corsair-psu.rst
> > index 396b95c9a76a..b77e53810a13 100644
> > --- a/Documentation/hwmon/corsair-psu.rst
> > +++ b/Documentation/hwmon/corsair-psu.rst
> > @@ -45,19 +45,30 @@ Sysfs entries
> >  -------------
> > =20
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +curr2_crit		Current max critical value on the 12v psu rail
> > +curr3_crit		Current max critical value on the 5v psu rail
> > +curr4_crit		Current max critical value on the 3.3v psu rail
> >  curr1_input		Total current usage
> >  curr2_input		Current on the 12v psu rail
> >  curr3_input		Current on the 5v psu rail
> >  curr4_input		Current on the 3.3v psu rail
>=20
> I think it would be better to align those by index.
>=20
> curr1_input
> curr2_input
> curr2_crit
> ...
>=20
> Personally I always list _input first, but that is a matter of
> personal preference.

Yeah, sounds reasonable. I can do that.

> >  fan1_input		RPM of psu fan
> > +in1_crit		Voltage max critical value on the 12v psu rail
> > +in2_crit		Voltage max critical value on the 5v psu rail
> > +in3_crit		Voltage max critical value on the 3.3v psu rail
> >  in0_input		Voltage of the psu ac input
> >  in1_input		Voltage of the 12v psu rail
> >  in2_input		Voltage of the 5v psu rail
> > -in3_input		Voltage of the 3.3 psu rail
> > +in3_input		Voltage of the 3.3v psu rail
> > +in1_lcrit		Voltage min critical value on the 12v psu rail
> > +in2_lcrit		Voltage min critical value on the 5v psu rail
> > +in3_lcrit		Voltage min critical value on the 3.3v psu rail
> >  power1_input		Total power usage
> >  power2_input		Power usage of the 12v psu rail
> >  power3_input		Power usage of the 5v psu rail
> >  power4_input		Power usage of the 3.3v psu rail
> > +temp1_crit		Temperature max cirtical value of the psu vrm component
> > +temp2_crit		Temperature max critical value of psu case
> >  temp1_input		Temperature of the psu vrm component
> >  temp2_input		Temperature of the psu case
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index b0953eeeb2d3..a176ac6a2540 100644
> > --- a/drivers/hwmon/corsair-psu.c
> > +++ b/drivers/hwmon/corsair-psu.c
> > @@ -53,11 +53,17 @@
> >  #define CMD_TIMEOUT_MS		250
> >  #define SECONDS_PER_HOUR	(60 * 60)
> >  #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
> > +#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
> > +#define TEMP_COUNT		2
> > =20
> >  #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
> > -#define PSU_CMD_IN_VOLTS	0x88 /* the rest of the commands expect lengt=
h 3 */
> > +#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expe=
ct length 3 */
> > +#define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
> > +#define PSU_CMD_RAIL_AMPS_HCRIT	0x46
> > +#define PSU_CMD_TEMP_HCRIT	0x4F
> > +#define PSU_CMD_IN_VOLTS	0x88
> >  #define PSU_CMD_IN_AMPS		0x89
> > -#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
> > +#define PSU_CMD_RAIL_VOLTS	0x8B
> >  #define PSU_CMD_RAIL_AMPS	0x8C
> >  #define PSU_CMD_TEMP0		0x8D
> >  #define PSU_CMD_TEMP1		0x8E
> > @@ -116,6 +122,14 @@ struct corsairpsu_data {
> >  	u8 *cmd_buffer;
> >  	char vendor[REPLY_SIZE];
> >  	char product[REPLY_SIZE];
> > +	long temp_crit[TEMP_COUNT];
> > +	long in_crit[RAIL_COUNT];
> > +	long in_lcrit[RAIL_COUNT];
> > +	long curr_crit[RAIL_COUNT];
> > +	u8 temp_crit_support;
> > +	u8 in_crit_support;
> > +	u8 in_lcrit_support;
> > +	u8 curr_crit_support;
> >  };
> > =20
> >  /* some values are SMBus LINEAR11 data which need a conversion */
> > @@ -193,7 +207,10 @@ static int corsairpsu_request(struct corsairpsu_da=
ta *priv, u8 cmd, u8
> > rail, voi=20
> >  	mutex_lock(&priv->lock);
> >  	switch (cmd) {
> > -	case PSU_CMD_RAIL_OUT_VOLTS:
> > +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> > +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> > +	case PSU_CMD_RAIL_AMPS_HCRIT:
> > +	case PSU_CMD_RAIL_VOLTS:
> >  	case PSU_CMD_RAIL_AMPS:
> >  	case PSU_CMD_RAIL_WATTS:
> >  		ret =3D corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
> > @@ -229,9 +246,13 @@ static int corsairpsu_get_value(struct corsairpsu_=
data *priv, u8 cmd, u8
> > rail, l */
> >  	tmp =3D ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + da=
ta[0];
> >  	switch (cmd) {
> > +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> > +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> > +	case PSU_CMD_RAIL_AMPS_HCRIT:
> > +	case PSU_CMD_TEMP_HCRIT:
> >  	case PSU_CMD_IN_VOLTS:
> >  	case PSU_CMD_IN_AMPS:
> > -	case PSU_CMD_RAIL_OUT_VOLTS:
> > +	case PSU_CMD_RAIL_VOLTS:
> >  	case PSU_CMD_RAIL_AMPS:
> >  	case PSU_CMD_TEMP0:
> >  	case PSU_CMD_TEMP1:
> > @@ -256,75 +277,175 @@ static int corsairpsu_get_value(struct corsairps=
u_data *priv, u8 cmd, u8
> > rail, l return ret;
> >  }
> > =20
> > +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
> > +{
> > +	long tmp;
> > +	int ret;
> > +	u8 rail;
>=20
> Side note: Using anything but sizeof(int) for index variables often resul=
ts in more
> complex code because the compiler needs to mask index operations. This do=
esn't
> typically apply to x86 because that architecure has byte operations, but =
to pretty
> much every other architecture.

Yeah, I know what you mean. I thought I match it to the function parameters.
Though I would be more concerned about the "case 1 ... 3" stuff which is
definitly no liked by static code analysis or even "-pedantic", it's not
part of the C standards.

> > +
> > +	priv->temp_crit_support =3D 0;
> > +	priv->in_lcrit_support =3D 0;
> > +	priv->in_crit_support =3D 0;
> > +	priv->curr_crit_support =3D 0;
> > +
> > +	for (rail =3D 0; rail < TEMP_COUNT; ++rail) {
> > +		ret =3D corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp);
> > +		if (ret =3D=3D 0) {
>=20
> Nit: the ret variable isn't really needed here.
> 		if (!corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp)) {
> works just as well. Personal preference, though.

Huh? Damn it ... Nice spot, I really missed that completely. Oh boy, I even
don't use the ret value at all ... Ah yeah, I switched the function to void.

> > +			priv->temp_crit_support |=3D BIT(rail);
> > +			priv->temp_crit[rail] =3D tmp;
> > +		}
> > +	}
> > +
> > +	for (rail =3D 0; rail < RAIL_COUNT; ++rail) {
> > +		ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &=
tmp);
> > +		if (ret =3D=3D 0) {
> > +			priv->in_crit_support |=3D BIT(rail);
> > +			priv->in_crit[rail] =3D tmp;
> > +		}
> > +
> > +		ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &=
tmp);
> > +		if (ret =3D=3D 0) {
> > +			priv->in_lcrit_support |=3D BIT(rail);
> > +			priv->in_lcrit[rail] =3D tmp;
> > +		}
> > +
> > +		ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &t=
mp);
> > +		if (ret =3D=3D 0) {
> > +			priv->curr_crit_support |=3D BIT(rail);
> > +			priv->curr_crit[rail] =3D tmp;
> > +		}
> > +	}
> > +}
> > +
> >  static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum =
hwmon_sensor_types type,
> >  					       u32 attr, int channel)
> >  {
> > -	if (type =3D=3D hwmon_temp && (attr =3D=3D hwmon_temp_input || attr =
=3D=3D hwmon_temp_label))
> > +	if (type =3D=3D hwmon_temp && (attr =3D=3D hwmon_temp_input || attr =
=3D=3D hwmon_temp_label ||
> > +				   attr =3D=3D hwmon_temp_crit))
> >  		return 0444;
> >  	else if (type =3D=3D hwmon_fan && (attr =3D=3D hwmon_fan_input || att=
r =3D=3D hwmon_fan_label))
> >  		return 0444;
> >  	else if (type =3D=3D hwmon_power && (attr =3D=3D hwmon_power_input ||=
 attr =3D=3D
> > hwmon_power_label)) return 0444;
> > -	else if (type =3D=3D hwmon_in && (attr =3D=3D hwmon_in_input || attr =
=3D=3D hwmon_in_label))
> > +	else if (type =3D=3D hwmon_in && (attr =3D=3D hwmon_in_input || attr =
=3D=3D hwmon_in_label ||
> > +				      attr =3D=3D hwmon_in_lcrit || attr =3D=3D hwmon_in_crit))
> >  		return 0444;
> > -	else if (type =3D=3D hwmon_curr && (attr =3D=3D hwmon_curr_input || a=
ttr =3D=3D hwmon_curr_label))
> > +	else if (type =3D=3D hwmon_curr && (attr =3D=3D hwmon_curr_input || a=
ttr =3D=3D hwmon_curr_label ||
> > +					attr =3D=3D hwmon_curr_crit))
> >  		return 0444;
> > =20
> >  	return 0;
> >  }
> > =20
> > -static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_se=
nsor_types type, u32
> > attr,
> > -				     int channel, long *val)
> > +static int corsairpsu_hwmon_temp(struct corsairpsu_data *priv, u32 att=
r, int channel, long
> > *val)
>=20
> Please make those functions _<type>_read, not just _<type>. It makes the =
code easier
> to understand, and we won't have to change it if write functions are ever=
 added.

You will laugh... I named the functions that way before, but then I was unh=
appy
with hitting the 100 chars line length. ;-)

> >  {
> > -	struct corsairpsu_data *priv =3D dev_get_drvdata(dev);
> > -	int ret;
> > +	int err =3D -EOPNOTSUPP;
> > +
> > +	if (channel < 2) {
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 :
> > PSU_CMD_TEMP0,
> > +						    channel, val);
> > +		case hwmon_temp_crit:
> > +			if (priv->temp_crit_support & BIT(channel)) {
> > +				*val =3D priv->temp_crit[channel];
> > +				err =3D 0;
> > +			}
> > +		}
>=20
> Dropping default cases from switch statements is never a good idea. It hi=
des missing
> break statements, like here, and it may result in compiler or static anal=
yzer warnings
> that not all situations are covered. Please don't do that (neither skippi=
ng break;
> statements not dropping default:). Yes, it technically can' happen, but t=
hat kind of
> code invites bugs if/when it is modified later. Pus, it shows that you th=
ought about
> that case, even if it is only
> 		default:
> 			break;

This is odd, usually the compiler complains about this. But he did not in
this patch version. But you are right, I will fix all the switches.

> > +	}
> > =20
> > -	if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input && channel=
 < 2) {
> > -		ret =3D corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD=
_TEMP0,
> > channel,
> > -					   val);
> > -	} else if (type =3D=3D hwmon_fan && attr =3D=3D hwmon_fan_input) {
> > -		ret =3D corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> > -	} else if (type =3D=3D hwmon_power && attr =3D=3D hwmon_power_input) {
> > +	return err;
> > +}
> > +
> > +static int corsairpsu_hwmon_power(struct corsairpsu_data *priv, u32 at=
tr, int channel, long
> > *val) +{
> > +	if (attr =3D=3D hwmon_power_input) {
> >  		switch (channel) {
> >  		case 0:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
> > -			break;
> > +			return corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
> >  		case 1 ... 3:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1,=
 val);
> > -			break;
> > -		default:
> > -			return -EOPNOTSUPP;
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1,
> > val);
>=20
> Same as above and below.
>=20
> >  		}
> > -	} else if (type =3D=3D hwmon_in && attr =3D=3D hwmon_in_input) {
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int corsairpsu_hwmon_in(struct corsairpsu_data *priv, u32 attr,=
 int channel, long *val)
> > +{
> > +	int err =3D -EOPNOTSUPP;
> > +
> > +	switch (attr) {
> > +	case hwmon_in_input:
> >  		switch (channel) {
> >  		case 0:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> > -			break;
> > +			return corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> >  		case 1 ... 3:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel =
- 1,
> > val);
> > -			break;
> > -		default:
> > -			return -EOPNOTSUPP;
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1,
> > val);
> > +		}
> > +		break;
> > +	case hwmon_in_crit:
> > +		if (priv->in_crit_support & BIT(channel - 1)) {
> > +			*val =3D priv->in_crit[channel - 1];
> > +			err =3D 0;
> >  		}
> > -	} else if (type =3D=3D hwmon_curr && attr =3D=3D hwmon_curr_input) {
> > +		break;
> > +	case hwmon_in_lcrit:
> > +		if (priv->in_lcrit_support & BIT(channel - 1)) {
> > +			*val =3D priv->in_lcrit[channel - 1];
> > +			err =3D 0;
> > +		}
> > +		break;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int corsairpsu_hwmon_curr(struct corsairpsu_data *priv, u32 att=
r, int channel, long
> > *val) +{
> > +	int err =3D -EOPNOTSUPP;
> > +
> > +	switch (attr) {
> > +	case hwmon_curr_input:
> >  		switch (channel) {
> >  		case 0:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> > -			break;
> > +			return corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> >  		case 1 ... 3:
> > -			ret =3D corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, =
val);
> > -			break;
> > -		default:
> > -			return -EOPNOTSUPP;
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, v=
al);
> >  		}
> > -	} else {
> > -		return -EOPNOTSUPP;
> > +		break;
> > +	case hwmon_curr_crit:
> > +		if (priv->curr_crit_support & BIT(channel - 1)) {
> > +			*val =3D priv->curr_crit[channel - 1];
> > +			err =3D 0;
> > +		}
> > +		break;
> >  	}
> > =20
> > -	if (ret < 0)
> > -		return ret;
> > +	return err;
> > +}
> > =20
> > -	return 0;
>=20
> Nice, you found that :-)

I was unhappy with the complexity anyway. Splitting it in several functions
was something I should have done right from the start. So yeah, I had to fix
this ugly piece, too.

> > +static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_se=
nsor_types type, u32
> > attr,
> > +				     int channel, long *val)
> > +{
> > +	struct corsairpsu_data *priv =3D dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		return corsairpsu_hwmon_temp(priv, attr, channel, val);
> > +	case hwmon_fan:
> > +		if (attr =3D=3D hwmon_fan_input)
> > +			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> > +		return -EOPNOTSUPP;
> > +	case hwmon_power:
> > +		return corsairpsu_hwmon_power(priv, attr, channel, val);
> > +	case hwmon_in:
> > +		return corsairpsu_hwmon_in(priv, attr, channel, val);
> > +	case hwmon_curr:
> > +		return corsairpsu_hwmon_curr(priv, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> >  }
> > =20
> >  static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum h=
wmon_sensor_types type,
> > @@ -360,8 +481,8 @@ static const struct hwmon_channel_info *corsairpsu_=
info[] =3D {
> >  	HWMON_CHANNEL_INFO(chip,
> >  			   HWMON_C_REGISTER_TZ),
> >  	HWMON_CHANNEL_INFO(temp,
> > -			   HWMON_T_INPUT | HWMON_T_LABEL,
> > -			   HWMON_T_INPUT | HWMON_T_LABEL),
> > +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> > +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
> >  	HWMON_CHANNEL_INFO(fan,
> >  			   HWMON_F_INPUT | HWMON_F_LABEL),
> >  	HWMON_CHANNEL_INFO(power,
> > @@ -371,14 +492,14 @@ static const struct hwmon_channel_info *corsairps=
u_info[] =3D {
> >  			   HWMON_P_INPUT | HWMON_P_LABEL),
> >  	HWMON_CHANNEL_INFO(in,
> >  			   HWMON_I_INPUT | HWMON_I_LABEL,
> > -			   HWMON_I_INPUT | HWMON_I_LABEL,
> > -			   HWMON_I_INPUT | HWMON_I_LABEL,
> > -			   HWMON_I_INPUT | HWMON_I_LABEL),
> > +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT),
> >  	HWMON_CHANNEL_INFO(curr,
> >  			   HWMON_C_INPUT | HWMON_C_LABEL,
> > -			   HWMON_C_INPUT | HWMON_C_LABEL,
> > -			   HWMON_C_INPUT | HWMON_C_LABEL,
> > -			   HWMON_C_INPUT | HWMON_C_LABEL),
> > +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> > +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT),
> >  	NULL
> >  };
> > =20
> > @@ -513,6 +634,8 @@ static int corsairpsu_probe(struct hid_device *hdev=
, const struct
> > hid_device_id goto fail_and_stop;
> >  	}
> > =20
> > +	corsairpsu_get_criticals(priv);
> > +
> >  	priv->hwmon_dev =3D hwmon_device_register_with_info(&hdev->dev, "cors=
airpsu", priv,
> >  							  &corsairpsu_chip_info, 0);
> > =20
> >=20
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A383417D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCSI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:58:42 -0400
Received: from mout01.posteo.de ([185.67.36.65]:50443 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhCSI6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:58:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id F37E8160060
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1616144288; bh=9kUQbkp9rCJHPZ6E03dCL73JdkTduNzrxpz0e71+rWQ=;
        h=Date:From:To:Cc:Subject:From;
        b=d94DrIkV+xjO8r84luKvmJgu+zW0CehVyRwqunvsurYGC5RbfuQO48G8jUMUzEp9Y
         W17Cb2POE8WiZ2K86GyM502IWQTKdRUaU2W0fEwBFyslQb+yh4Wvq2/aqoBs6toSaE
         4XPku8pLSib6SSSmORMDIFsVpyDTltTHL/EL3hr3zMaa1+i1n8AxRHKEqpGEgB88F4
         WBlupSEXwp5UsmzeGzXmlc2HadR07UwwB3l6iG/t8Jq57C5Kc6Ga1/Eyyacexk6+e4
         YgdN2WbZlDjgUUJciNqgjDBNWoCY+OWN3yfuQHCF++QsAKwKjlpxSxgq4YQEu1RkVi
         hCngYSiBOd6iA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F1yTp1g3Kz9rxc;
        Fri, 19 Mar 2021 09:58:06 +0100 (CET)
Date:   Fri, 19 Mar 2021 09:58:05 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: corsair-psu: add support for critical values
Message-ID: <20210319095805.378b7e0e@monster.powergraphx.local>
In-Reply-To: <20210318190150.GA152326@roeck-us.net>
References: <YFNg6vGk3sQmyqgB@monster.powergraphx.local>
        <20210318190150.GA152326@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 12:01:50 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Mar 18, 2021 at 03:17:14PM +0100, Wilken Gottwalt wrote:
> > Adds support for reading the critical values of the temperature sensors
> > and the rail sensors (voltage and current) once and caches them. Updates
> > the naming of the constants following a more clear scheme. Also updates
> > the documentation and fixes some typos. Updates is_visible and ops_read
> > functions to be more readable.
> >=20
> > The new sensors output of a Corsair HX850i will look like this:
> > corsairpsu-hid-3-1
> > Adapter: HID adapter
> > v_in:        230.00 V
> > v_out +12v:   12.14 V  (crit min =3D  +8.41 V, crit max =3D +15.59 V)
> > v_out +5v:     5.03 V  (crit min =3D  +3.50 V, crit max =3D  +6.50 V)
> > v_out +3.3v:   3.30 V  (crit min =3D  +2.31 V, crit max =3D  +4.30 V)
> > psu fan:        0 RPM
> > vrm temp:     +46.2=B0C  (crit =3D +70.0=B0C)
> > case temp:    +39.8=B0C  (crit =3D +70.0=B0C)
> > power total: 152.00 W
> > power +12v:  108.00 W
> > power +5v:    41.00 W
> > power +3.3v:   5.00 W
> > curr +12v:     9.00 A  (crit max =3D +85.00 A)
> > curr +5v:      8.31 A  (crit max =3D +40.00 A)
> > curr +3.3v:    1.62 A  (crit max =3D +40.00 A)
> >=20
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>=20
> Applied.

Thank very much. Hmm, I actually could calculate the in_curr value from tot=
al
power and the ac input as a replacement if the value can not be read. What =
do
you think?

> Thanks,
> Guenter
>=20
> > ---
> > Changed in v4:
> >   - simplified private data structure and collection of critical values=
 and
> >     unsupported command check
> >=20
> > Changes in v3:
> >   - introduced a quirk check function to catch non-working commands
> >   - split is_visible function into subfunctions
> >   - moved the "is value valid" checks into the is_visibility subfunction
> >   - simplified hwmon_ops_read function
> >   - rearranged sysfs entries in the documentation like suggested
> >=20
> > Changes in v2:
> >   - simplified reading/caching of critical values and hwmon_ops_read fu=
nction
> >   - removed unnecessary debug output and comments
> > ---
> >  Documentation/hwmon/corsair-psu.rst |  13 +-
> >  drivers/hwmon/corsair-psu.c         | 325 +++++++++++++++++++++++-----
> >  2 files changed, 282 insertions(+), 56 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/=
corsair-psu.rst
> > index 396b95c9a76a..e8378e7a1d8c 100644
> > --- a/Documentation/hwmon/corsair-psu.rst
> > +++ b/Documentation/hwmon/corsair-psu.rst
> > @@ -47,19 +47,30 @@ Sysfs entries
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  curr1_input		Total current usage
> >  curr2_input		Current on the 12v psu rail
> > +curr2_crit		Current max critical value on the 12v psu rail
> >  curr3_input		Current on the 5v psu rail
> > +curr3_crit		Current max critical value on the 5v psu rail
> >  curr4_input		Current on the 3.3v psu rail
> > +curr4_crit		Current max critical value on the 3.3v psu rail
> >  fan1_input		RPM of psu fan
> >  in0_input		Voltage of the psu ac input
> >  in1_input		Voltage of the 12v psu rail
> > +in1_crit		Voltage max critical value on the 12v psu rail
> > +in1_lcrit		Voltage min critical value on the 12v psu rail
> >  in2_input		Voltage of the 5v psu rail
> > -in3_input		Voltage of the 3.3 psu rail
> > +in2_crit		Voltage max critical value on the 5v psu rail
> > +in2_lcrit		Voltage min critical value on the 5v psu rail
> > +in3_input		Voltage of the 3.3v psu rail
> > +in3_crit		Voltage max critical value on the 3.3v psu rail
> > +in3_lcrit		Voltage min critical value on the 3.3v psu rail
> >  power1_input		Total power usage
> >  power2_input		Power usage of the 12v psu rail
> >  power3_input		Power usage of the 5v psu rail
> >  power4_input		Power usage of the 3.3v psu rail
> >  temp1_input		Temperature of the psu vrm component
> > +temp1_crit		Temperature max cirtical value of the psu vrm component
> >  temp2_input		Temperature of the psu case
> > +temp2_crit		Temperature max critical value of psu case
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > =20
> >  Usage Notes
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index b0953eeeb2d3..3a5807e4a2ef 100644
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
> > @@ -116,6 +122,15 @@ struct corsairpsu_data {
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
> > +	bool in_curr_cmd_support; /* not all commands are supported on every =
PSU */
> >  };
> > =20
> >  /* some values are SMBus LINEAR11 data which need a conversion */
> > @@ -193,7 +208,10 @@ static int corsairpsu_request(struct corsairpsu_da=
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
> > @@ -229,9 +247,13 @@ static int corsairpsu_get_value(struct corsairpsu_=
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
> > @@ -256,75 +278,265 @@ static int corsairpsu_get_value(struct corsairps=
u_data *priv, u8 cmd, u8
> > rail, l return ret;
> >  }
> > =20
> > -static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum =
hwmon_sensor_types type,
> > -					       u32 attr, int channel)
> > +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
> >  {
> > -	if (type =3D=3D hwmon_temp && (attr =3D=3D hwmon_temp_input || attr =
=3D=3D hwmon_temp_label))
> > -		return 0444;
> > -	else if (type =3D=3D hwmon_fan && (attr =3D=3D hwmon_fan_input || att=
r =3D=3D hwmon_fan_label))
> > -		return 0444;
> > -	else if (type =3D=3D hwmon_power && (attr =3D=3D hwmon_power_input ||=
 attr =3D=3D
> > hwmon_power_label))
> > -		return 0444;
> > -	else if (type =3D=3D hwmon_in && (attr =3D=3D hwmon_in_input || attr =
=3D=3D hwmon_in_label))
> > +	long tmp;
> > +	int rail;
> > +
> > +	for (rail =3D 0; rail < TEMP_COUNT; ++rail) {
> > +		if (!corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp)) {
> > +			priv->temp_crit_support |=3D BIT(rail);
> > +			priv->temp_crit[rail] =3D tmp;
> > +		}
> > +	}
> > +
> > +	for (rail =3D 0; rail < RAIL_COUNT; ++rail) {
> > +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp=
)) {
> > +			priv->in_crit_support |=3D BIT(rail);
> > +			priv->in_crit[rail] =3D tmp;
> > +		}
> > +
> > +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp=
)) {
> > +			priv->in_lcrit_support |=3D BIT(rail);
> > +			priv->in_lcrit[rail] =3D tmp;
> > +		}
> > +
> > +		if (!corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp)=
) {
> > +			priv->curr_crit_support |=3D BIT(rail);
> > +			priv->curr_crit[rail] =3D tmp;
> > +		}
> > +	}
> > +}
> > +
> > +static void corsairpsu_check_cmd_support(struct corsairpsu_data *priv)
> > +{
> > +	long tmp;
> > +
> > +	priv->in_curr_cmd_support =3D !corsairpsu_get_value(priv, PSU_CMD_IN_=
AMPS, 0, &tmp);
> > +}
> > +
> > +static umode_t corsairpsu_hwmon_temp_is_visible(const struct corsairps=
u_data *priv, u32 attr,
> > +						int channel)
> > +{
> > +	umode_t res =3D 0444;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +	case hwmon_temp_label:
> > +	case hwmon_temp_crit:
> > +		if (channel > 0 && !(priv->temp_crit_support & BIT(channel - 1)))
> > +			res =3D 0;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return res;
> > +}
> > +
> > +static umode_t corsairpsu_hwmon_fan_is_visible(const struct corsairpsu=
_data *priv, u32 attr,
> > +					       int channel)
> > +{
> > +	switch (attr) {
> > +	case hwmon_fan_input:
> > +	case hwmon_fan_label:
> >  		return 0444;
> > -	else if (type =3D=3D hwmon_curr && (attr =3D=3D hwmon_curr_input || a=
ttr =3D=3D hwmon_curr_label))
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairp=
su_data *priv, u32 attr,
> > +						 int channel)
> > +{
> > +	switch (attr) {
> > +	case hwmon_power_input:
> > +	case hwmon_power_label:
> >  		return 0444;
> > +	default:
> > +		return 0;
> > +	};
> > +}
> > =20
> > -	return 0;
> > +static umode_t corsairpsu_hwmon_in_is_visible(const struct corsairpsu_=
data *priv, u32 attr,
> > +					      int channel)
> > +{
> > +	umode_t res =3D 0444;
> > +
> > +	switch (attr) {
> > +	case hwmon_in_input:
> > +	case hwmon_in_label:
> > +	case hwmon_in_crit:
> > +		if (channel > 0 && !(priv->in_crit_support & BIT(channel - 1)))
> > +			res =3D 0;
> > +		break;
> > +	case hwmon_in_lcrit:
> > +		if (channel > 0 && !(priv->in_lcrit_support & BIT(channel - 1)))
> > +			res =3D 0;
> > +		break;
> > +	default:
> > +		break;
> > +	};
> > +
> > +	return res;
> >  }
> > =20
> > -static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_se=
nsor_types type, u32
> > attr,
> > -				     int channel, long *val)
> > +static umode_t corsairpsu_hwmon_curr_is_visible(const struct corsairps=
u_data *priv, u32 attr,
> > +						int channel)
> >  {
> > -	struct corsairpsu_data *priv =3D dev_get_drvdata(dev);
> > -	int ret;
> > +	umode_t res =3D 0444;
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
> > +	switch (attr) {
> > +	case hwmon_curr_input:
> > +		if (channel =3D=3D 0 && !priv->in_curr_cmd_support)
> > +			res =3D 0;
> > +		break;
> > +	case hwmon_curr_label:
> > +	case hwmon_curr_crit:
> > +		if (channel > 0 && !(priv->curr_crit_support & BIT(channel - 1)))
> > +			res =3D 0;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return res;
> > +}
> > +
> > +static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum =
hwmon_sensor_types type,
> > +					       u32 attr, int channel)
> > +{
> > +	const struct corsairpsu_data *priv =3D data;
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		return corsairpsu_hwmon_temp_is_visible(priv, attr, channel);
> > +	case hwmon_fan:
> > +		return corsairpsu_hwmon_fan_is_visible(priv, attr, channel);
> > +	case hwmon_power:
> > +		return corsairpsu_hwmon_power_is_visible(priv, attr, channel);
> > +	case hwmon_in:
> > +		return corsairpsu_hwmon_in_is_visible(priv, attr, channel);
> > +	case hwmon_curr:
> > +		return corsairpsu_hwmon_curr_is_visible(priv, attr, channel);
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int corsairpsu_hwmon_temp_read(struct corsairpsu_data *priv, u3=
2 attr, int channel,
> > +				      long *val)
> > +{
> > +	int err =3D -EOPNOTSUPP;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_=
TEMP0,
> > +					    channel, val);
> > +	case hwmon_temp_crit:
> > +		*val =3D priv->temp_crit[channel];
> > +		err =3D 0;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int corsairpsu_hwmon_power_read(struct corsairpsu_data *priv, u=
32 attr, int channel,
> > +				       long *val)
> > +{
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
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1,
> > val); default:
> > -			return -EOPNOTSUPP;
> > +			break;
> >  		}
> > -	} else if (type =3D=3D hwmon_in && attr =3D=3D hwmon_in_input) {
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int corsairpsu_hwmon_in_read(struct corsairpsu_data *priv, u32 =
attr, int channel, long
> > *val) +{
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
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1,
> > val); default:
> > -			return -EOPNOTSUPP;
> > +			break;
> >  		}
> > -	} else if (type =3D=3D hwmon_curr && attr =3D=3D hwmon_curr_input) {
> > +		break;
> > +	case hwmon_in_crit:
> > +		*val =3D priv->in_crit[channel - 1];
> > +		err =3D 0;
> > +		break;
> > +	case hwmon_in_lcrit:
> > +		*val =3D priv->in_lcrit[channel - 1];
> > +		err =3D 0;
> > +		break;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int corsairpsu_hwmon_curr_read(struct corsairpsu_data *priv, u3=
2 attr, int channel,
> > +				      long *val)
> > +{
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
> > +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, v=
al);
> >  		default:
> > -			return -EOPNOTSUPP;
> > +			break;
> >  		}
> > -	} else {
> > -		return -EOPNOTSUPP;
> > +		break;
> > +	case hwmon_curr_crit:
> > +		*val =3D priv->curr_crit[channel - 1];
> > +		err =3D 0;
> > +		break;
> > +	default:
> > +		break;
> >  	}
> > =20
> > -	if (ret < 0)
> > -		return ret;
> > +	return err;
> > +}
> > =20
> > -	return 0;
> > +static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_se=
nsor_types type, u32
> > attr,
> > +				     int channel, long *val)
> > +{
> > +	struct corsairpsu_data *priv =3D dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		return corsairpsu_hwmon_temp_read(priv, attr, channel, val);
> > +	case hwmon_fan:
> > +		if (attr =3D=3D hwmon_fan_input)
> > +			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> > +		return -EOPNOTSUPP;
> > +	case hwmon_power:
> > +		return corsairpsu_hwmon_power_read(priv, attr, channel, val);
> > +	case hwmon_in:
> > +		return corsairpsu_hwmon_in_read(priv, attr, channel, val);
> > +	case hwmon_curr:
> > +		return corsairpsu_hwmon_curr_read(priv, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> >  }
> > =20
> >  static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum h=
wmon_sensor_types type,
> > @@ -360,8 +572,8 @@ static const struct hwmon_channel_info *corsairpsu_=
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
> > @@ -371,14 +583,14 @@ static const struct hwmon_channel_info *corsairps=
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
> > @@ -513,6 +725,9 @@ static int corsairpsu_probe(struct hid_device *hdev=
, const struct
> > hid_device_id goto fail_and_stop;
> >  	}
> > =20
> > +	corsairpsu_get_criticals(priv);
> > +	corsairpsu_check_cmd_support(priv);
> > +
> >  	priv->hwmon_dev =3D hwmon_device_register_with_info(&hdev->dev, "cors=
airpsu", priv,
> >  							  &corsairpsu_chip_info, 0);
> > =20


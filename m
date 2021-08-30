Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723283FBF90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhH3Xw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:52:28 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60953 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231601AbhH3Xw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:52:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 482AB3200A8F;
        Mon, 30 Aug 2021 19:51:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Aug 2021 19:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=BiA/IhXbCQsx/XvNeS7AJTMFuPKsKlQPmHOSHvDRy
        dQ=; b=qHuTXqQG+4meXkMuvRRTWomCgfml2k7mzEnp3+KxrGKWy2HKMaK46+1oL
        Cbh4wATOkHZbJPFpSych6sZvP94Q39W+hQ8c8lS4dKce6dsQ2Vg5E7TemFAijjTG
        gnCPNYp7pb7z6N5jAVUNsRcGXKC4ZpKnyfF0wSGTxxtmHhllvEuy5fvdBtO+0mIt
        +sBmcsx0anKXDPiB6FoYaTPAGtBzvCmsDYpxXzhOzAfndXcVKg2LxEMRwRaLgTj0
        aY3WrkgnY3qNl0Sz9XBi7OGWEtRBqVmae3o8dGqnA5ihyMrxvna25KMKUvSfIAC7
        ZxxLghHqYZxURodaPOrH4Bny7y6Tg==
X-ME-Sender: <xms:Am8tYQJTuF1i3qHrGaQ_nZHhPBRRnRcXr2h8YF_i9ztVbENMvH2kkg>
    <xme:Am8tYQJA3QtIAGDftJaEEuNX75kBNaP-FPLMthyuvZMorHOXSam6ky0neaZIliPto
    XZ7ZYWSXrZkL1S_Z7o>
X-ME-Received: <xmr:Am8tYQtl7omKclJP-tjUgJfH6b1SQ06Zqgs3i55Xv2HiobpnmqxzyIop7oc652UixxT9Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgfgsehtqh
    ertdertdhsnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpeekveffieehueelgeelteevleehudethffhge
    ffteevtdefgfelleegteelkefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Am8tYdZTUN7k3A_ZQwMat3d5YH-5zU5WYsEi5b66VN2NyannZyjmoQ>
    <xmx:Am8tYXa6Ee3hPwx5GJ88dd1WI7GMK4kjKYLZjppJvTFOUMwzrKd5Cw>
    <xmx:Am8tYZAEwZfZkd-C77JpxaoMFAp3W4iX87H7LxfpF8FYZOQ3Pp7L_Q>
    <xmx:A28tYWlg8YspmMNgrwNnyD7sBZtNZmA2R_-kBFkOqZARElAWdJw3Ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Aug 2021 19:51:26 -0400 (EDT)
Date:   Tue, 31 Aug 2021 11:51:11 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Message-Id: <BLFOYQ.DC67MOSNFFNW2@ljones.dev>
In-Reply-To: <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
References: <20210830113137.1338683-1-luke@ljones.dev>
        <20210830113137.1338683-2-luke@ljones.dev>
        <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Aug 30 2021 at 21:28:18 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
> 2021. augusztus 30., h=E9tf=F5 13:31 keltez=E9ssel, Luke D. Jones =EDrta:
>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>=20
>>  These laptops have the ability to set a custom curve for the CPU
>>  and GPU fans via an ACPI method call. This patch enables this,
>>  additionally enabling custom fan curves per-profile, where profile
>>  here means each of the 3 levels of "throttle_thermal_policy".
>>=20
>>  This patch adds two blocks of attributes to the hwmon sysfs,
>>  1 block each for CPU and GPU fans.
>>=20
>>  When the user switches profiles the associated curve data for that
>>  profile is then show/store enabled to allow users to rotate through
>>  the profiles and set a fan curve for each profile which then
>>  activates on profile switch if enabled.
>>=20
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 568=20
>> ++++++++++++++++++++-
>>   include/linux/platform_data/x86/asus-wmi.h |   2 +
>>   2 files changed, 566 insertions(+), 4 deletions(-)
>>=20
>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>> b/drivers/platform/x86/asus-wmi.c
>>  index cc5811844012..b594c2475034 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  [...]
>>  +/*
>>  + * Returns as an error if the method output is not a buffer.=20
>> Typically this
>=20
> It seems to me it will simply leave the output buffer uninitialized=20
> if something
> other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered and=20
> return 0.

Oops, see below inline reply:

>=20
>=20
>>  + * means that the method called is unsupported.
>>  + */
>>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
>>  +		u32 arg0, u32 arg1, u8 *ret_buffer)
>>  +{
>>  +	struct bios_args args =3D {
>>  +		.arg0 =3D arg0,
>>  +		.arg1 =3D arg1,
>>  +		.arg2 =3D 0,
>>  +	};
>>  +	struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
>>  +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>  +	acpi_status status;
>>  +	union acpi_object *obj;
>>  +	u32 int_tmp =3D 0;
>>  +
>>  +	status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>>  +				     &input, &output);
>>  +
>>  +	if (ACPI_FAILURE(status))
>>  +		return -EIO;
>>  +
>>  +	obj =3D (union acpi_object *)output.pointer;
>>  +
>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>>  +		int_tmp =3D (u32) obj->integer.value;
>>  +		if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
>>  +			return -ENODEV;
>>  +		return int_tmp;
>=20
> Is anything known about the possible values? You are later
> using it as if it was an errno (e.g. in `custom_fan_check_present()`).
>=20
> And `obj` is leaked in both of the previous two returns.

The return for the method we're calling in this patch returns 0 if the=20
input arg has no match.

>=20
>=20
>>  +	}
>>  +
>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
>>  +		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>=20
> I would suggest you add a "size_t size" argument to this function, and
> return -ENOSPC/-ENODATA depending on whether the returned buffer is=20
> too
> big/small. Maybe return -ENODATA if `obj` is NULL, too.

Got it. So something like this would be suitable?

	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
		if (obj->buffer.length < size)
			err =3D -ENOSPC;
		if (!obj->buffer.length)
			err =3D -ENODATA;
		if (err) {
			kfree(obj);
			return err;
		}
		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
	}

	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
		int_tmp =3D (u32) obj->integer.value;

	kfree(obj);

	if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
		return -ENODEV;

	/* There is at least one method that returns a 0 with no buffer */
	if (obj =3D=3D NULL || int_tmp =3D=3D 0)
		return -ENODATA;

	return 0;

>=20
>=20
>>  +
>>  +	kfree(obj);
>>  +
>>  +	return 0;
>>  +}
>>  [...]
>>  +static ssize_t fan_curve_show(struct device *dev,
>>  +				struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>> attr);
>>  +	int value;
>>  +
>>  +	int index =3D to_sensor_dev_attr_2(attr)->index;
>>  +	int nr =3D to_sensor_dev_attr_2(attr)->nr;
>>  +	int pwm =3D nr & FAN_CURVE_PWM_MASK;
>>  +
>>  +	if (pwm)
>>  +		value =3D 255 * data->percents[index] / 100;
>>  +	else
>>  +		value =3D data->temps[index];
>>  +
>>  +	return scnprintf(buf, PAGE_SIZE, "%d\n", value);
>=20
> sysfs_emit()

Sorry, I usually go by existing code as examples. I might submit a=20
patch after this one that cleans up some of the other parts.

>=20
>=20
>>  +}
>>  +
>>  +/*
>>  + * "dev" is the related WMI method such as=20
>> ASUS_WMI_DEVID_CPU_FAN_CURVE.
>>  + */
>>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev,
>>  +					struct fan_curve_data *data)
>>  +{
>>  +	int ret, i, shift =3D 0;
>>  +	u32 arg1, arg2, arg3, arg4;
>>  +
>>  +	arg1 =3D arg2 =3D arg3 =3D arg4 =3D 0;
>>  +
>>  +	for (i =3D 0; i < FAN_CURVE_POINTS / 2; i++) {
>>  +		arg1 +=3D data->temps[i] << shift;
>>  +		arg2 +=3D data->temps[i + 4] << shift;
>>  +		arg3 +=3D data->percents[0] << shift;
>>  +		arg4 +=3D data->percents[i + 4] << shift;
>>  +		shift +=3D 8;
>>  +	}
>>  +
>>  +	return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
>>  +					arg1, arg2, arg3, arg4, &ret);
>>  +}
>>  +
>>  +/*
>>  + * Called only by throttle_thermal_policy_write()
>>  + */
>=20
> Am I correct in thinking that the firmware does not actually
> support specifying fan curves for each mode, only a single one,
> and the fan curve switching is done by this driver when
> the performance mode is changed?

I'm not 100% certain on this. The WMI method 0x00110024 takes an arg=20
0,1,2 which then returns some factory stored fan profiles, these fit=20
the profiles of ASUS_THROTTLE_THERMAL_POLICY_*, but with 1 and 2=20
swapped.

Looking at the SET part, it seems to write to a different location than=20
where the GET is fetching information.

Because of the fact there are three sets of curves to get, I thought it=20
would be good for users to be able to set per profile. I don't think=20
the set is retained in acpi if the profile is switched.

Do you think it would be best to not have the ability to store per=20
profile in kernel? How would I choose which profile get to populate the=20
initial data with if so?

>=20
>=20
>>  +static int fan_curve_write_data(struct asus_wmi *asus)
>>  +{
>>  +	struct fan_curve_data *cpu;
>>  +	struct fan_curve_data *gpu;
>>  +	int err, mode;
>>  +
>>  +	mode =3D asus->throttle_thermal_policy_mode;
>>  +	cpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_CPU];
>>  +	gpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_GPU];
>>  +
>>  +	if (cpu->enabled) {
>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, cpu);
>>  +		if (err)
>>  +			return err;
>>  +	}
>>  +
>>  +	if (gpu->enabled) {
>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, gpu);
>>  +		if (err)
>>  +			return err;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  [...]
>>  +static ssize_t fan_curve_store(struct device *dev,
>>  +				struct device_attribute *attr,
>>  +				const char *buf, size_t count)
>>  +{
>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>> attr);
>>  +	u8 value, old_value;
>>  +	int err;
>>  +
>>  +	int index =3D to_sensor_dev_attr_2(attr)->index;
>>  +	int nr =3D to_sensor_dev_attr_2(attr)->nr;
>>  +	int pwm =3D nr & FAN_CURVE_PWM_MASK;
>>  +
>>  +	err =3D kstrtou8(buf, 10, &value);
>>  +	if (err < 0)
>>  +		return err;
>>  +
>>  +	if (pwm) {
>>  +		old_value =3D data->percents[index];
>>  +		data->percents[index] =3D 100 * value / 255;
>>  +	} else {
>>  +		old_value =3D data->temps[index];
>>  +		data->temps[index] =3D value;
>>  +	}
>>  +	/*
>>  +	 * The check here forces writing a curve graph in reverse,
>>  +	 * from highest to lowest.
>>  +	 */
>>  +	err =3D fan_curve_verify(data);
>>  +	if (err) {
>>  +		if (pwm) {
>>  +			dev_err(dev, "a fan curve percentage was higher than the next=20
>> in sequence\n");
>>  +			data->percents[index] =3D old_value;
>>  +		} else {
>>  +			dev_err(dev, "a fan curve temperature was higher than the next=20
>> in sequence\n");
>>  +			data->temps[index] =3D old_value;
>>  +		}
>>  +		return err;
>>  +	}
>=20
> Are such sequences rejected by the firmware itself?
> Or is this just an extra layer of protection?

Not really sure here. The DSDT I have is the following which looks like=20
it writes as is. I don't really want to be responsible for allowing a=20
reverse curve to be set.

// SET
If ((IIA0 =3D=3D 0x00110024))
{
    Return (^^PCI0.SBRG.EC0.SUFC (IIA1, IIA2, IIA3, IIA4, 0x40))
}

If ((IIA0 =3D=3D 0x00110025))
{
    Return (^^PCI0.SBRG.EC0.SUFC (IIA1, IIA2, IIA3, IIA4, 0x44))
}

Method (SUFC, 5, NotSerialized)
{
    Name (DUBF, Buffer (0x10)
    {
        /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //=20
........
        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   //=20
........
    })
    Name (UFC0, Buffer (One)
    {
         0x00                                             // .
    })
    DUBF [Zero] =3D (Arg0 >> Zero)
    DUBF [One] =3D (Arg0 >> 0x08)
    DUBF [0x02] =3D (Arg0 >> 0x10)
    DUBF [0x03] =3D (Arg0 >> 0x18)
    DUBF [0x04] =3D (Arg1 >> Zero)
    DUBF [0x05] =3D (Arg1 >> 0x08)
    DUBF [0x06] =3D (Arg1 >> 0x10)
    DUBF [0x07] =3D (Arg1 >> 0x18)
    DUBF [0x08] =3D (Arg2 >> Zero)
    DUBF [0x09] =3D (Arg2 >> 0x08)
    DUBF [0x0A] =3D (Arg2 >> 0x10)
    DUBF [0x0B] =3D (Arg2 >> 0x18)
    DUBF [0x0C] =3D (Arg3 >> Zero)
    DUBF [0x0D] =3D (Arg3 >> 0x08)
    DUBF [0x0E] =3D (Arg3 >> 0x10)
    DUBF [0x0F] =3D (Arg3 >> 0x18)
    UFC0 [Zero] =3D Arg4
    WEBC (0x20, One, UFC0)
    Return (WEBC (0x22, 0x10, DUBF))
}

>=20
>=20
>>  +
>>  +	return count;
>>  +}
>>  +
>>  +static ssize_t fan_curve_enable_show(struct device *dev,
>>  +				struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>> attr);
>>  +
>>  +	return scnprintf(buf, PAGE_SIZE, "%d\n", data->enabled);
>=20
> sysfs_emit()

Ack

>=20
>=20
>>  +}
>>  +
>>  +static ssize_t fan_curve_enable_store(struct device *dev,
>>  +				struct device_attribute *attr,
>>  +				const char *buf, size_t count)
>>  +{
>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>> attr);
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	bool value;
>>  +	int err;
>>  +
>>  +	err =3D kstrtobool(buf, &value);
>>  +	if (err < 0)
>>  +		return err;
>>  +
>>  +	data->enabled =3D value;
>>  +	throttle_thermal_policy_write(asus);
>>  +
>>  +	return count;
>>  +}
>>  +
>>  +/* CPU */
>>  +// TODO: enable
>>  +static SENSOR_DEVICE_ATTR_RW(pwm1_enable, fan_curve_enable,
>>  +				FAN_CURVE_DEV_CPU);
>=20
> FYI, the pwmX_enable attributes can be created by the hwmon
> subsystem itself if you use [devm_]hwmon_device_register_with_info()
> with appropriately populated `struct hwmon_chip_info`.

Thanks, I was hoping for a method liek this and had found the same last=20
night but was unclear on how I could retain the data I need from the=20
following?

static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_pwm, fan_curve,
			FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);


>=20
>=20
>>  [...]
>>  +static const struct attribute_group fan_curve_attribute_group =3D {
>>  +	.is_visible =3D fan_curve_sysfs_is_visible,
>>  +	.attrs =3D fan_curve_attributes
>=20
> Small thing, but it is customary to put commas after non-terminating
> entries in initializers / enum definitions.

Ack

>=20
>=20
>>  +};
>>  +__ATTRIBUTE_GROUPS(fan_curve_attribute);
>>  +
>>  +static int asus_wmi_fan_curve_init(struct asus_wmi *asus)
>>  +{
>>  +	struct device *dev =3D &asus->platform_device->dev;
>>  +	struct device *hwmon;
>>  +
>>  +	hwmon =3D devm_hwmon_device_register_with_groups(dev, "asus", asus,
>>  +						fan_curve_attribute_groups);
>>  +
>>  +	if (IS_ERR(hwmon)) {
>>  +		pr_err("Could not register asus fan_curve device\n");
>=20
> I think `dev_err()` would be better.

Ack. Sorry, I have been trying to keep using dev_err.

>=20
>=20
>>  +		return PTR_ERR(hwmon);
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  [...]
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h=20
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index 17dc5cb6f3f2..a571b47ff362 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -77,6 +77,8 @@
>>   #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
>>   #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
>>   #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
>>  +#define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
>>  +#define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
>>=20
>>   /* Power */
>>   #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
>>  --
>>  2.31.1
>=20
>=20
> Best regards,
> Barnab=E1s P=F5cze



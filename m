Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5913FC555
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbhHaJ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:57:36 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47259 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239629AbhHaJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:57:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9B1993200A54;
        Tue, 31 Aug 2021 05:56:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Aug 2021 05:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3iztF+
        bWFLLKQUrJhdM2C5ZKrRMjaJK8Ho+uKsHjHJg=; b=Cy5kH5tboKZgf7acUmKyFL
        kCg+0H8ZYG2OGucPgfKaEwvgxIcixLEhoWG9PV0X+SmteWr3D+cihcjKG8mb2VTy
        DQ2O/NajB+cnfpa3NOYf0GjDxRP75Ub4otcRmrXPfBDXLz8ES/Y7JDPXlOQxVM55
        xjif3ExZUnW3jidIMuTg3T4AZGW45u2SmolM341sUgxzGF6yiyX5iLECY8NgcmVK
        s3fpl3ddPN0kRryfxVteQhjeS7tDAJormeh4V5JSo48CV4SFIWy1COhJUVZUzRWh
        TMQXUMlBWVHkn4ocPRBnE82aex85/cGe7cq2jjMvJLN3tQUbZLX+5qfDMxR+LDkg
        ==
X-ME-Sender: <xms:z_wtYSibZTIClWJ6FJLYtWZCAkvy8ftTI3jrjCWu7VR5Luj5JT8BSQ>
    <xme:z_wtYTAcf7-YB2s4a2IE6e_Gg7Yq1STqn_pKN50FCEV527wizpCnk30TAyfsPTDhL
    7TndlCstdnbBwhlyZE>
X-ME-Received: <xmr:z_wtYaF4ElCxL83PsenngV8CLItlTMzTUpb7uZrr_0pYWgzWeJaK446m_1q2QVMb2iTxLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesmhdtre
    erredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfdvveeiheekvdevhfdtveegffehhfejjeffje
    egtefhffdtveevjefhgeeghfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:z_wtYbRujcd0a0KGfJMp8uve6eKlvPpJIkSnDfg64IqYpDdR93s04w>
    <xmx:z_wtYfye4WoMtEgEj9LysVQyT8wHqTFSE4zTZ9YceFdJInjxLaZxBA>
    <xmx:z_wtYZ61HdCjIbgy1aE_3UWj73l3gpQx9FnHKDGH3O9ogh578tbzrA>
    <xmx:0PwtYa8PCyTxYumZR3GiA44rTJOgcPvMHNJYGWBdnT-BPjsHbXz1vA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Aug 2021 05:56:25 -0400 (EDT)
Date:   Tue, 31 Aug 2021 21:56:09 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Message-Id: <LL7PYQ.O4HURM6VWLGE3@ljones.dev>
In-Reply-To: <1Y4PYQ.BFC57KCSOTUT1@ljones.dev>
References: <20210830113137.1338683-1-luke@ljones.dev>
        <20210830113137.1338683-2-luke@ljones.dev>
        <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
        <1Y4PYQ.BFC57KCSOTUT1@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YgSO9yNR5AZ+DOb4pniE"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-YgSO9yNR5AZ+DOb4pniE
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable

Additionally to the above I've taken in to account feedback for v7=20
patch, and cleaned up plus tidied a few things.

I'll again attach for quick look over before I submit next patch as=20
full review. I am thinking that this version (v9 here) is the proper=20
and expected outcome.

Cheers,
Luke

On Tue, Aug 31 2021 at 20:58:49 +1200, Luke Jones <luke@ljones.dev>=20
wrote:
> Hi Barnab=E1s,
>=20
> I did another refactor using hwmon_device_register_with_info() and=20
> HWMON_CHANNEL_INFO(). I'm unsure if this is what you were looking for=20
> so I'm going to attach the patch instead of submitting as a V8 for=20
> now.
>=20
> My main concern as that the use of the above removes the=20
> pwm1_auto_point1_pwm + pwm1_auto_point1_temp format and gives two=20
> hwmon<num>, one per cpu/gpu fan with:
>=20
> device power
> fan1_input subsystem
> fan2_input temp1_input
> fan3_input temp2_input
> fan4_input temp3_input
> fan5_input temp4_input
> fan6_input temp5_input
> fan7_input temp6_input
> fan8_input temp7_input
> in0_enable temp8_input
> name uevent
>=20
> cat -p /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/name
> asus_cpu_fan_custom_curve
>=20
> I've named the root name of each as descriptive as possible to convey=20
> exactly what each is
>=20
> Oh and `sensors` now shows:
>=20
> asus_cpu_fan_curve-isa-0000
> Adapter: ISA adapter
> fan1: 8 RPM
> fan2: 10 RPM
> fan3: 18 RPM
> fan4: 20 RPM
> fan5: 28 RPM
> fan6: 34 RPM
> fan7: 44 RPM
> fan8: 56 RPM
> temp1: +0.0=B0C
> temp2: +0.1=B0C
> temp3: +0.1=B0C
> temp4: +0.1=B0C
> temp5: +0.1=B0C
> temp6: +0.1=B0C
> temp7: +0.1=B0C
> temp8: +0.1=B0C
>=20
>=20
> > FYI, the pwmX_enable attributes can be created by the hwmon
> > subsystem itself if you use [devm_]hwmon_device_register_with_info()
> > with appropriately populated `struct hwmon_chip_info`.
>=20
> So when you say this, did you mean *just* for the pwmX_enable=20
> attributes?
>=20
>=20
> On Mon, Aug 30 2021 at 21:28:18 +0000, Barnab=E1s P=F5cze=20
> <pobrn@protonmail.com> wrote:
>> Hi
>>=20
>>=20
>> 2021. augusztus 30., h=E9tf=F5 13:31 keltez=E9ssel, Luke D. Jones =EDrta=
:
>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>>=20
>>>  These laptops have the ability to set a custom curve for the CPU
>>>  and GPU fans via an ACPI method call. This patch enables this,
>>>  additionally enabling custom fan curves per-profile, where profile
>>>  here means each of the 3 levels of "throttle_thermal_policy".
>>>=20
>>>  This patch adds two blocks of attributes to the hwmon sysfs,
>>>  1 block each for CPU and GPU fans.
>>>=20
>>>  When the user switches profiles the associated curve data for that
>>>  profile is then show/store enabled to allow users to rotate through
>>>  the profiles and set a fan curve for each profile which then
>>>  activates on profile switch if enabled.
>>>=20
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c            | 568=20
>>> =7F=7F++++++++++++++++++++-
>>>   include/linux/platform_data/x86/asus-wmi.h |   2 +
>>>   2 files changed, 566 insertions(+), 4 deletions(-)
>>>=20
>>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>>> =7F=7Fb/drivers/platform/x86/asus-wmi.c
>>>  index cc5811844012..b594c2475034 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  [...]
>>>  +/*
>>>  + * Returns as an error if the method output is not a buffer.=20
>>> =7F=7FTypically this
>>=20
>> It seems to me it will simply leave the output buffer uninitialized=20
>> =7Fif something
>> other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered and=20
>> =7Freturn 0.
>>=20
>>=20
>>>  + * means that the method called is unsupported.
>>>  + */
>>>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
>>>  +		u32 arg0, u32 arg1, u8 *ret_buffer)
>>>  +{
>>>  +	struct bios_args args =3D {
>>>  +		.arg0 =3D arg0,
>>>  +		.arg1 =3D arg1,
>>>  +		.arg2 =3D 0,
>>>  +	};
>>>  +	struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
>>>  +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>>  +	acpi_status status;
>>>  +	union acpi_object *obj;
>>>  +	u32 int_tmp =3D 0;
>>>  +
>>>  +	status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>>>  +				     &input, &output);
>>>  +
>>>  +	if (ACPI_FAILURE(status))
>>>  +		return -EIO;
>>>  +
>>>  +	obj =3D (union acpi_object *)output.pointer;
>>>  +
>>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>>>  +		int_tmp =3D (u32) obj->integer.value;
>>>  +		if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
>>>  +			return -ENODEV;
>>>  +		return int_tmp;
>>=20
>> Is anything known about the possible values? You are later
>> using it as if it was an errno (e.g. in=20
>> `custom_fan_check_present()`).
>>=20
>> And `obj` is leaked in both of the previous two returns.
>>=20
>>=20
>>>  +	}
>>>  +
>>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
>>>  +		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>=20
>> I would suggest you add a "size_t size" argument to this function,=20
>> and
>> return -ENOSPC/-ENODATA depending on whether the returned buffer is=20
>> =7Ftoo
>> big/small. Maybe return -ENODATA if `obj` is NULL, too.
>>=20
>>=20
>>>  +
>>>  +	kfree(obj);
>>>  +
>>>  +	return 0;
>>>  +}
>>>  [...]
>>>  +static ssize_t fan_curve_show(struct device *dev,
>>>  +				struct device_attribute *attr, char *buf)
>>>  +{
>>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>>> =7F=7Fattr);
>>>  +	int value;
>>>  +
>>>  +	int index =3D to_sensor_dev_attr_2(attr)->index;
>>>  +	int nr =3D to_sensor_dev_attr_2(attr)->nr;
>>>  +	int pwm =3D nr & FAN_CURVE_PWM_MASK;
>>>  +
>>>  +	if (pwm)
>>>  +		value =3D 255 * data->percents[index] / 100;
>>>  +	else
>>>  +		value =3D data->temps[index];
>>>  +
>>>  +	return scnprintf(buf, PAGE_SIZE, "%d\n", value);
>>=20
>> sysfs_emit()
>>=20
>>=20
>>>  +}
>>>  +
>>>  +/*
>>>  + * "dev" is the related WMI method such as=20
>>> =7F=7FASUS_WMI_DEVID_CPU_FAN_CURVE.
>>>  + */
>>>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev,
>>>  +					struct fan_curve_data *data)
>>>  +{
>>>  +	int ret, i, shift =3D 0;
>>>  +	u32 arg1, arg2, arg3, arg4;
>>>  +
>>>  +	arg1 =3D arg2 =3D arg3 =3D arg4 =3D 0;
>>>  +
>>>  +	for (i =3D 0; i < FAN_CURVE_POINTS / 2; i++) {
>>>  +		arg1 +=3D data->temps[i] << shift;
>>>  +		arg2 +=3D data->temps[i + 4] << shift;
>>>  +		arg3 +=3D data->percents[0] << shift;
>>>  +		arg4 +=3D data->percents[i + 4] << shift;
>>>  +		shift +=3D 8;
>>>  +	}
>>>  +
>>>  +	return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
>>>  +					arg1, arg2, arg3, arg4, &ret);
>>>  +}
>>>  +
>>>  +/*
>>>  + * Called only by throttle_thermal_policy_write()
>>>  + */
>>=20
>> Am I correct in thinking that the firmware does not actually
>> support specifying fan curves for each mode, only a single one,
>> and the fan curve switching is done by this driver when
>> the performance mode is changed?
>>=20
>>=20
>>>  +static int fan_curve_write_data(struct asus_wmi *asus)
>>>  +{
>>>  +	struct fan_curve_data *cpu;
>>>  +	struct fan_curve_data *gpu;
>>>  +	int err, mode;
>>>  +
>>>  +	mode =3D asus->throttle_thermal_policy_mode;
>>>  +	cpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_CPU];
>>>  +	gpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_GPU];
>>>  +
>>>  +	if (cpu->enabled) {
>>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, cpu);
>>>  +		if (err)
>>>  +			return err;
>>>  +	}
>>>  +
>>>  +	if (gpu->enabled) {
>>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, gpu);
>>>  +		if (err)
>>>  +			return err;
>>>  +	}
>>>  +
>>>  +	return 0;
>>>  +}
>>>  [...]
>>>  +static ssize_t fan_curve_store(struct device *dev,
>>>  +				struct device_attribute *attr,
>>>  +				const char *buf, size_t count)
>>>  +{
>>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>>> =7F=7Fattr);
>>>  +	u8 value, old_value;
>>>  +	int err;
>>>  +
>>>  +	int index =3D to_sensor_dev_attr_2(attr)->index;
>>>  +	int nr =3D to_sensor_dev_attr_2(attr)->nr;
>>>  +	int pwm =3D nr & FAN_CURVE_PWM_MASK;
>>>  +
>>>  +	err =3D kstrtou8(buf, 10, &value);
>>>  +	if (err < 0)
>>>  +		return err;
>>>  +
>>>  +	if (pwm) {
>>>  +		old_value =3D data->percents[index];
>>>  +		data->percents[index] =3D 100 * value / 255;
>>>  +	} else {
>>>  +		old_value =3D data->temps[index];
>>>  +		data->temps[index] =3D value;
>>>  +	}
>>>  +	/*
>>>  +	 * The check here forces writing a curve graph in reverse,
>>>  +	 * from highest to lowest.
>>>  +	 */
>>>  +	err =3D fan_curve_verify(data);
>>>  +	if (err) {
>>>  +		if (pwm) {
>>>  +			dev_err(dev, "a fan curve percentage was higher than the next=20
>>> =7F=7Fin sequence\n");
>>>  +			data->percents[index] =3D old_value;
>>>  +		} else {
>>>  +			dev_err(dev, "a fan curve temperature was higher than the next=20
>>> =7F=7Fin sequence\n");
>>>  +			data->temps[index] =3D old_value;
>>>  +		}
>>>  +		return err;
>>>  +	}
>>=20
>> Are such sequences rejected by the firmware itself?
>> Or is this just an extra layer of protection?
>>=20
>>=20
>>>  +
>>>  +	return count;
>>>  +}
>>>  +
>>>  +static ssize_t fan_curve_enable_show(struct device *dev,
>>>  +				struct device_attribute *attr, char *buf)
>>>  +{
>>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>>> =7F=7Fattr);
>>>  +
>>>  +	return scnprintf(buf, PAGE_SIZE, "%d\n", data->enabled);
>>=20
>> sysfs_emit()
>>=20
>>=20
>>>  +}
>>>  +
>>>  +static ssize_t fan_curve_enable_store(struct device *dev,
>>>  +				struct device_attribute *attr,
>>>  +				const char *buf, size_t count)
>>>  +{
>>>  +	struct fan_curve_data *data =3D fan_curve_attr_data_select(dev,=20
>>> =7F=7Fattr);
>>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>>  +	bool value;
>>>  +	int err;
>>>  +
>>>  +	err =3D kstrtobool(buf, &value);
>>>  +	if (err < 0)
>>>  +		return err;
>>>  +
>>>  +	data->enabled =3D value;
>>>  +	throttle_thermal_policy_write(asus);
>>>  +
>>>  +	return count;
>>>  +}
>>>  +
>>>  +/* CPU */
>>>  +// TODO: enable
>>>  +static SENSOR_DEVICE_ATTR_RW(pwm1_enable, fan_curve_enable,
>>>  +				FAN_CURVE_DEV_CPU);
>>=20
>> FYI, the pwmX_enable attributes can be created by the hwmon
>> subsystem itself if you use [devm_]hwmon_device_register_with_info()
>> with appropriately populated `struct hwmon_chip_info`.
>>=20
>>=20
>>>  [...]
>>>  +static const struct attribute_group fan_curve_attribute_group =3D {
>>>  +	.is_visible =3D fan_curve_sysfs_is_visible,
>>>  +	.attrs =3D fan_curve_attributes
>>=20
>> Small thing, but it is customary to put commas after non-terminating
>> entries in initializers / enum definitions.
>>=20
>>=20
>>>  +};
>>>  +__ATTRIBUTE_GROUPS(fan_curve_attribute);
>>>  +
>>>  +static int asus_wmi_fan_curve_init(struct asus_wmi *asus)
>>>  +{
>>>  +	struct device *dev =3D &asus->platform_device->dev;
>>>  +	struct device *hwmon;
>>>  +
>>>  +	hwmon =3D devm_hwmon_device_register_with_groups(dev, "asus", asus,
>>>  +						fan_curve_attribute_groups);
>>>  +
>>>  +	if (IS_ERR(hwmon)) {
>>>  +		pr_err("Could not register asus fan_curve device\n");
>>=20
>> I think `dev_err()` would be better.
>>=20
>>=20
>>>  +		return PTR_ERR(hwmon);
>>>  +	}
>>>  +
>>>  +	return 0;
>>>  +}
>>>  [...]
>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h=20
>>> =7F=7Fb/include/linux/platform_data/x86/asus-wmi.h
>>>  index 17dc5cb6f3f2..a571b47ff362 100644
>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>  @@ -77,6 +77,8 @@
>>>   #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
>>>   #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
>>>   #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
>>>  +#define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
>>>  +#define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
>>>=20
>>>   /* Power */
>>>   #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
>>>  --
>>>  2.31.1
>>=20
>>=20
>> Best regards,
>> Barnab=E1s P=F5cze
>=20


--=-YgSO9yNR5AZ+DOb4pniE
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=v9-0001-asus-wmi-Add-support-for-custom-fan-curves.patch
Content-Transfer-Encoding: base64

RnJvbSAwNWY3ZjljNDk5MGUwOTdiOGE3MWEyYTM5YTM2YWExZDVkMzk3NDJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTHVrZSBELiBKb25lcyIgPGx1a2VAbGpvbmVzLmRldj4KRGF0
ZTogU3VuLCAyOSBBdWcgMjAyMSAxMzoyMToyMyArMTIwMApTdWJqZWN0OiBbUEFUQ0ggdjldIGFz
dXMtd21pOiBBZGQgc3VwcG9ydCBmb3IgY3VzdG9tIGZhbiBjdXJ2ZXMKCkFkZCBzdXBwb3J0IGZv
ciBjdXN0b20gZmFuIGN1cnZlcyBmb3VuZCBvbiBzb21lIEFTVVMgUk9HIGxhcHRvcHMuCgpUaGVz
ZSBsYXB0b3BzIGhhdmUgdGhlIGFiaWxpdHkgdG8gc2V0IGEgY3VzdG9tIGN1cnZlIGZvciB0aGUg
Q1BVCmFuZCBHUFUgZmFucyB2aWEgYW4gQUNQSSBtZXRob2QgY2FsbC4gVGhpcyBwYXRjaCBlbmFi
bGVzIHRoaXMsCmFkZGl0aW9uYWxseSBlbmFibGluZyBjdXN0b20gZmFuIGN1cnZlcyBwZXItcHJv
ZmlsZSwgd2hlcmUgcHJvZmlsZQpoZXJlIG1lYW5zIGVhY2ggb2YgdGhlIDMgbGV2ZWxzIG9mICJ0
aHJvdHRsZV90aGVybWFsX3BvbGljeSIuCgpUaGlzIHBhdGNoIGFkZHMgdHdvIGJsb2NrcyBvZiBh
dHRyaWJ1dGVzIHRvIHRoZSBod21vbiBzeXNmcywKMSBibG9jayBlYWNoIGZvciBDUFUgYW5kIEdQ
VSBmYW5zLgoKV2hlbiB0aGUgdXNlciBzd2l0Y2hlcyBwcm9maWxlcyB0aGUgYXNzb2NpYXRlZCBj
dXJ2ZSBkYXRhIGZvciB0aGF0CnByb2ZpbGUgaXMgdGhlbiBzaG93L3N0b3JlIGVuYWJsZWQgdG8g
YWxsb3cgdXNlcnMgdG8gcm90YXRlIHRocm91Z2gKdGhlIHByb2ZpbGVzIGFuZCBzZXQgYSBmYW4g
Y3VydmUgZm9yIGVhY2ggcHJvZmlsZSB3aGljaCB0aGVuCmFjdGl2YXRlcyBvbiBwcm9maWxlIHN3
aXRjaCBpZiBlbmFibGVkLgoKU2lnbmVkLW9mZi1ieTogTHVrZSBELiBKb25lcyA8bHVrZUBsam9u
ZXMuZGV2PgotLS0KIGRyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgICAgICAgICAgICB8
IDU2OCArKysrKysrKysrKysrKysrKysrKy0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS94
ODYvYXN1cy13bWkuaCB8ICAgMiArCiAyIGZpbGVzIGNoYW5nZWQsIDU2NiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMt
d21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCmluZGV4IGNjNTgxMTg0NDAx
Mi4uYjU5NGMyNDc1MDM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdt
aS5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMKQEAgLTEwNiw4ICsxMDYs
MTggQEAgbW9kdWxlX3BhcmFtKGZubG9ja19kZWZhdWx0LCBib29sLCAwNDQ0KTsKIAogI2RlZmlu
ZSBXTUlfRVZFTlRfTUFTSwkJCTB4RkZGRgogCisvKiBUaGUgbnVtYmVyIG9mIEFTVVNfVEhST1RU
TEVfVEhFUk1BTF9QT0xJQ1lfKiBhdmFpbGFibGUgKi8KKyNkZWZpbmUgRkFOX0NVUlZFX1BST0ZJ
TEVfTlVNCShBU1VTX1RIUk9UVExFX1RIRVJNQUxfUE9MSUNZX1NJTEVOVCArIDEpCisjZGVmaW5l
IEZBTl9DVVJWRV9QT0lOVFMJCTgKKyNkZWZpbmUgRkFOX0NVUlZFX0RFVl9DUFUJCTB4MDAKKyNk
ZWZpbmUgRkFOX0NVUlZFX0RFVl9HUFUJCTB4MDEKKy8qIE1hc2sgdG8gZGV0ZXJtaW5lIGlmIHNl
dHRpbmcgdGVtcGVyYXR1cmUgb3IgcGVyY2VudGFnZSAqLworI2RlZmluZSBGQU5fQ1VSVkVfUFdN
X01BU0sJCTB4MDQKKwogc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBhc2hzX2lkc1tdID0geyAi
QVRLNDAwMSIsICJBVEs0MDAyIiwgTlVMTCB9OwogCitzdGF0aWMgaW50IHRocm90dGxlX3RoZXJt
YWxfcG9saWN5X3dyaXRlKHN0cnVjdCBhc3VzX3dtaSAqKTsKKwogc3RhdGljIGJvb2wgYXNoc19w
cmVzZW50KHZvaWQpCiB7CiAJaW50IGkgPSAwOwpAQCAtMTIyLDcgKzEzMiw4IEBAIHN0cnVjdCBi
aW9zX2FyZ3MgewogCXUzMiBhcmcwOwogCXUzMiBhcmcxOwogCXUzMiBhcmcyOyAvKiBBdCBsZWFz
dCBUVUYgR2FtaW5nIHNlcmllcyB1c2VzIDMgZHdvcmQgaW5wdXQgYnVmZmVyLiAqLwotCXUzMiBh
cmc0OworCXUzMiBhcmczOworCXUzMiBhcmc0OyAvKiBTb21lIFJPRyBsYXB0b3BzIHJlcXVpcmUg
YSBmdWxsIDUgaW5wdXQgYXJncyAqLwogCXUzMiBhcmc1OwogfSBfX3BhY2tlZDsKIApAQCAtMTcz
LDYgKzE4NCwxNyBAQCBlbnVtIGZhbl90eXBlIHsKIAlGQU5fVFlQRV9TUEVDODMsCS8qIHN0YXJ0
aW5nIGluIFNwZWMgOC4zLCB1c2UgQ1BVX0ZBTl9DVFJMICovCiB9OwogCisvKgorICogVGhlIHJl
bGF0ZWQgQUNQSSBtZXRob2QgZm9yIHRlc3RpbmcgYXZhaWxhYmlsaXR5IGFsc28gcmV0dXJucyB0
aGUgZmFjdG9yeQorICogZGVmYXVsdCBmYW4gY3VydmVzLiBXZSBzYXZlIHRoZW0gaGVyZSBzbyB0
aGF0IGEgdXNlciBjYW4gcmVzZXQgY3VzdG9tCisgKiBzZXR0aW5ncyBpZiByZXF1aXJlZC4KKyAq
Lworc3RydWN0IGZhbl9jdXJ2ZV9kYXRhIHsKKwlib29sIGVuYWJsZWQ7CisJdTggdGVtcHNbRkFO
X0NVUlZFX1BPSU5UU107CisJdTggcGVyY2VudHNbRkFOX0NVUlZFX1BPSU5UU107Cit9OworCiBz
dHJ1Y3QgYXN1c193bWkgewogCWludCBkc3RzX2lkOwogCWludCBzcGVjOwpAQCAtMjIwLDYgKzI0
MiwxMSBAQCBzdHJ1Y3QgYXN1c193bWkgewogCWJvb2wgdGhyb3R0bGVfdGhlcm1hbF9wb2xpY3lf
YXZhaWxhYmxlOwogCXU4IHRocm90dGxlX3RoZXJtYWxfcG9saWN5X21vZGU7CiAKKwlib29sIGNw
dV9mYW5fY3VydmVfYXZhaWxhYmxlOworCWJvb2wgZ3B1X2Zhbl9jdXJ2ZV9hdmFpbGFibGU7CisJ
LyogW3Rocm90dGxlIG1vZGVzXVtmYW4gY291bnRdICovCisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRh
IHRocm90dGxlX2Zhbl9jdXJ2ZXNbRkFOX0NVUlZFX1BST0ZJTEVfTlVNXVsyXTsKKwogCXN0cnVj
dCBwbGF0Zm9ybV9wcm9maWxlX2hhbmRsZXIgcGxhdGZvcm1fcHJvZmlsZV9oYW5kbGVyOwogCWJv
b2wgcGxhdGZvcm1fcHJvZmlsZV9zdXBwb3J0OwogCkBAIC0yODUsNiArMzEyLDg0IEBAIGludCBh
c3VzX3dtaV9ldmFsdWF0ZV9tZXRob2QodTMyIG1ldGhvZF9pZCwgdTMyIGFyZzAsIHUzMiBhcmcx
LCB1MzIgKnJldHZhbCkKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGFzdXNfd21pX2V2YWx1YXRlX21l
dGhvZCk7CiAKK3N0YXRpYyBpbnQgYXN1c193bWlfZXZhbHVhdGVfbWV0aG9kNSh1MzIgbWV0aG9k
X2lkLAorCQl1MzIgYXJnMCwgdTMyIGFyZzEsIHUzMiBhcmcyLCB1MzIgYXJnMywgdTMyIGFyZzQs
IHUzMiAqcmV0dmFsKQoreworCXN0cnVjdCBiaW9zX2FyZ3MgYXJncyA9IHsKKwkJLmFyZzAgPSBh
cmcwLAorCQkuYXJnMSA9IGFyZzEsCisJCS5hcmcyID0gYXJnMiwKKwkJLmFyZzMgPSBhcmczLAor
CQkuYXJnNCA9IGFyZzQsCisJfTsKKwlzdHJ1Y3QgYWNwaV9idWZmZXIgaW5wdXQgPSB7IChhY3Bp
X3NpemUpIHNpemVvZihhcmdzKSwgJmFyZ3MgfTsKKwlzdHJ1Y3QgYWNwaV9idWZmZXIgb3V0cHV0
ID0geyBBQ1BJX0FMTE9DQVRFX0JVRkZFUiwgTlVMTCB9OworCWFjcGlfc3RhdHVzIHN0YXR1czsK
Kwl1bmlvbiBhY3BpX29iamVjdCAqb2JqOworCXUzMiB0bXAgPSAwOworCisJc3RhdHVzID0gd21p
X2V2YWx1YXRlX21ldGhvZChBU1VTX1dNSV9NR01UX0dVSUQsIDAsIG1ldGhvZF9pZCwKKwkJCQkg
ICAgICZpbnB1dCwgJm91dHB1dCk7CisKKwlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpCisJCXJl
dHVybiAtRUlPOworCisJb2JqID0gKHVuaW9uIGFjcGlfb2JqZWN0ICopb3V0cHV0LnBvaW50ZXI7
CisJaWYgKG9iaiAmJiBvYmotPnR5cGUgPT0gQUNQSV9UWVBFX0lOVEVHRVIpCisJCXRtcCA9ICh1
MzIpIG9iai0+aW50ZWdlci52YWx1ZTsKKworCWlmIChyZXR2YWwpCisJCSpyZXR2YWwgPSB0bXA7
CisKKwlrZnJlZShvYmopOworCisJaWYgKHRtcCA9PSBBU1VTX1dNSV9VTlNVUFBPUlRFRF9NRVRI
T0QpCisJCXJldHVybiAtRU5PREVWOworCisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiBSZXR1cm5z
IGFzIGFuIGVycm9yIGlmIHRoZSBtZXRob2Qgb3V0cHV0IGlzIG5vdCBhIGJ1ZmZlci4gVHlwaWNh
bGx5IHRoaXMKKyAqIG1lYW5zIHRoYXQgdGhlIG1ldGhvZCBjYWxsZWQgaXMgdW5zdXBwb3J0ZWQu
CisgKi8KK3N0YXRpYyBpbnQgYXN1c193bWlfZXZhbHVhdGVfbWV0aG9kX2J1Zih1MzIgbWV0aG9k
X2lkLAorCQl1MzIgYXJnMCwgdTMyIGFyZzEsIHU4ICpyZXRfYnVmZmVyKQoreworCXN0cnVjdCBi
aW9zX2FyZ3MgYXJncyA9IHsKKwkJLmFyZzAgPSBhcmcwLAorCQkuYXJnMSA9IGFyZzEsCisJCS5h
cmcyID0gMCwKKwl9OworCXN0cnVjdCBhY3BpX2J1ZmZlciBpbnB1dCA9IHsgKGFjcGlfc2l6ZSkg
c2l6ZW9mKGFyZ3MpLCAmYXJncyB9OworCXN0cnVjdCBhY3BpX2J1ZmZlciBvdXRwdXQgPSB7IEFD
UElfQUxMT0NBVEVfQlVGRkVSLCBOVUxMIH07CisJYWNwaV9zdGF0dXMgc3RhdHVzOworCXVuaW9u
IGFjcGlfb2JqZWN0ICpvYmo7CisJdTMyIGludF90bXAgPSAwOworCisJc3RhdHVzID0gd21pX2V2
YWx1YXRlX21ldGhvZChBU1VTX1dNSV9NR01UX0dVSUQsIDAsIG1ldGhvZF9pZCwKKwkJCQkgICAg
ICZpbnB1dCwgJm91dHB1dCk7CisKKwlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpCisJCXJldHVy
biAtRUlPOworCisJb2JqID0gKHVuaW9uIGFjcGlfb2JqZWN0ICopb3V0cHV0LnBvaW50ZXI7CisK
KwlpZiAob2JqICYmIG9iai0+dHlwZSA9PSBBQ1BJX1RZUEVfSU5URUdFUikgeworCQlpbnRfdG1w
ID0gKHUzMikgb2JqLT5pbnRlZ2VyLnZhbHVlOworCQlpZiAoaW50X3RtcCA9PSBBU1VTX1dNSV9V
TlNVUFBPUlRFRF9NRVRIT0QpCisJCQlyZXR1cm4gLUVOT0RFVjsKKwkJcmV0dXJuIGludF90bXA7
CisJfQorCisJaWYgKG9iaiAmJiBvYmotPnR5cGUgPT0gQUNQSV9UWVBFX0JVRkZFUikKKwkJbWVt
Y3B5KHJldF9idWZmZXIsIG9iai0+YnVmZmVyLnBvaW50ZXIsIG9iai0+YnVmZmVyLmxlbmd0aCk7
CisKKwlrZnJlZShvYmopOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgYXN1c193bWlf
ZXZhbHVhdGVfbWV0aG9kX2FnZm4oY29uc3Qgc3RydWN0IGFjcGlfYnVmZmVyIGFyZ3MpCiB7CiAJ
c3RydWN0IGFjcGlfYnVmZmVyIGlucHV0OwpAQCAtMjA0Myw2ICsyMTQ4LDQ0MCBAQCBzdGF0aWMg
c3NpemVfdCBmYW5fYm9vc3RfbW9kZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiAvLyBGYW4g
Ym9vc3QgbW9kZTogMCAtIG5vcm1hbCwgMSAtIG92ZXJib29zdCwgMiAtIHNpbGVudAogc3RhdGlj
IERFVklDRV9BVFRSX1JXKGZhbl9ib29zdF9tb2RlKTsKIAorLyogQ3VzdG9tIGZhbiBjdXJ2ZXMg
cGVyLXByb2ZpbGUgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8KKworc3RhdGljIHZvaWQgaW5pdF9mYW5fY3VydmUoc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpk
YXRhLCB1OCAqYnVmKQoreworCWludCBpOworCisJZm9yIChpID0gMDsgaSA8IEZBTl9DVVJWRV9Q
T0lOVFM7IGkrKykKKwkJZGF0YS0+dGVtcHNbaV0gPSBidWZbaV07CisKKwlmb3IgKGkgPSAwOyBp
IDwgRkFOX0NVUlZFX1BPSU5UUzsgaSsrKQorCQlkYXRhLT5wZXJjZW50c1tpXSA9IGJ1ZltpICsg
OF07Cit9CisKKy8qCisgKiBDaGVjayBpZiB0aGUgYWJpbGl0eSB0byBzZXQgZmFuIGN1cnZlcyBv
biBlaXRoZXIgZmFuIGV4aXN0cywgYW5kIHBvcHVsYXRlCisgKiB3aXRoIHN5c3RlbSBkZWZhdWx0
cyB0byBwcm92aWRlIHVzZXJzIHdpdGggYSBzdGFydGluZyBwb2ludC4KKyAqCisgKiAiZGV2IiBp
cyBlaXRoZXIgQ1BVX0ZBTl9DVVJWRSBvciBHUFVfRkFOX0NVUlZFLgorICovCitzdGF0aWMgaW50
IGN1c3RvbV9mYW5fY2hlY2tfcHJlc2VudChzdHJ1Y3QgYXN1c193bWkgKmFzdXMsCisJCQkJICAg
IGJvb2wgKmF2YWlsYWJsZSwgdTMyIGRldikKK3sKKwlzdHJ1Y3QgZmFuX2N1cnZlX2RhdGEgKmN1
cnZlczsKKwl1OCBidWZbRkFOX0NVUlZFX1BPSU5UUyAqIDJdOworCWludCBmYW5faWR4ID0gMDsK
KwlpbnQgZXJyOworCisJKmF2YWlsYWJsZSA9IGZhbHNlOworCWlmIChkZXYgPT0gQVNVU19XTUlf
REVWSURfR1BVX0ZBTl9DVVJWRSkKKwkJZmFuX2lkeCA9IDE7CisKKwkvKiBCYWxhbmNlZCBkZWZh
dWx0ICovCisJY3VydmVzID0gJmFzdXMtPnRocm90dGxlX2Zhbl9jdXJ2ZXMKKwkJCVtBU1VTX1RI
Uk9UVExFX1RIRVJNQUxfUE9MSUNZX0RFRkFVTFRdW2Zhbl9pZHhdOworCWVyciA9IGFzdXNfd21p
X2V2YWx1YXRlX21ldGhvZF9idWYoYXN1cy0+ZHN0c19pZCwgZGV2LCAwLCBidWYpOworCWlmIChl
cnIpIHsKKwkJaWYgKGVyciA9PSAtRU5PREVWKQorCQkJcmV0dXJuIDA7CisJCXJldHVybiBlcnI7
CisJfQorCWluaXRfZmFuX2N1cnZlKGN1cnZlcywgYnVmKTsKKworCS8qCisJICogUXVpZXQgZGVm
YXVsdC4gVGhlIGluZGV4IG51bSBmb3IgQUNQSSBtZXRob2QgZG9lcyBub3QgbWF0Y2ggdGhlCisJ
ICogdGhyb3R0bGVfdGhlcm1hbCBudW1iZXIsIHNhbWUgZm9yIFBlcmZvcm1hbmNlLgorCSAqLwor
CWN1cnZlcyA9ICZhc3VzLT50aHJvdHRsZV9mYW5fY3VydmVzCisJCQlbQVNVU19USFJPVFRMRV9U
SEVSTUFMX1BPTElDWV9TSUxFTlRdW2Zhbl9pZHhdOworCWVyciA9IGFzdXNfd21pX2V2YWx1YXRl
X21ldGhvZF9idWYoYXN1cy0+ZHN0c19pZCwgZGV2LCAxLCBidWYpOworCWlmIChlcnIpIHsKKwkJ
aWYgKGVyciA9PSAtRU5PREVWKQorCQkJcmV0dXJuIDA7CisJCXJldHVybiBlcnI7CisJfQorCWlu
aXRfZmFuX2N1cnZlKGN1cnZlcywgYnVmKTsKKworCS8qIFBlcmZvcm1hbmNlIGRlZmF1bHQgKi8K
KwljdXJ2ZXMgPSAmYXN1cy0+dGhyb3R0bGVfZmFuX2N1cnZlcworCQkJW0FTVVNfVEhST1RUTEVf
VEhFUk1BTF9QT0xJQ1lfT1ZFUkJPT1NUXVtmYW5faWR4XTsKKwllcnIgPSBhc3VzX3dtaV9ldmFs
dWF0ZV9tZXRob2RfYnVmKGFzdXMtPmRzdHNfaWQsIGRldiwgMiwgYnVmKTsKKwlpZiAoZXJyKSB7
CisJCWlmIChlcnIgPT0gLUVOT0RFVikKKwkJCXJldHVybiAwOworCQlyZXR1cm4gZXJyOworCX0K
Kwlpbml0X2Zhbl9jdXJ2ZShjdXJ2ZXMsIGJ1Zik7CisKKwkqYXZhaWxhYmxlID0gdHJ1ZTsKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBmYW5fY3VydmVfZGF0YSAqZmFuX2N1cnZlX2F0
dHJfZGF0YV9zZWxlY3Qoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyKQoreworCXN0cnVjdCBhc3VzX3dtaSAqYXN1cyA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOworCXU4IG1vZGUgPSBhc3VzLT50aHJvdHRsZV90aGVybWFsX3BvbGljeV9tb2RlOwor
CisJaW50IG5yID0gdG9fc2Vuc29yX2Rldl9hdHRyXzIoYXR0ciktPm5yOworCWludCBmYW4gPSBu
ciAmIEZBTl9DVVJWRV9ERVZfR1BVOworCisJcmV0dXJuICZhc3VzLT50aHJvdHRsZV9mYW5fY3Vy
dmVzW21vZGVdW2Zhbl07Cit9CisKK3N0YXRpYyBzc2l6ZV90IGZhbl9jdXJ2ZV9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAq
YnVmKQoreworCXN0cnVjdCBmYW5fY3VydmVfZGF0YSAqZGF0YSA9IGZhbl9jdXJ2ZV9hdHRyX2Rh
dGFfc2VsZWN0KGRldiwgYXR0cik7CisJaW50IHZhbHVlOworCisJaW50IGluZGV4ID0gdG9fc2Vu
c29yX2Rldl9hdHRyXzIoYXR0ciktPmluZGV4OworCWludCBuciA9IHRvX3NlbnNvcl9kZXZfYXR0
cl8yKGF0dHIpLT5ucjsKKwlpbnQgcHdtID0gbnIgJiBGQU5fQ1VSVkVfUFdNX01BU0s7CisKKwlp
ZiAocHdtKQorCQl2YWx1ZSA9IDI1NSAqIGRhdGEtPnBlcmNlbnRzW2luZGV4XSAvIDEwMDsKKwll
bHNlCisJCXZhbHVlID0gZGF0YS0+dGVtcHNbaW5kZXhdOworCisJcmV0dXJuIHNjbnByaW50Zihi
dWYsIFBBR0VfU0laRSwgIiVkXG4iLCB2YWx1ZSk7Cit9CisKKy8qCisgKiAiZGV2IiBpcyB0aGUg
cmVsYXRlZCBXTUkgbWV0aG9kIHN1Y2ggYXMgQVNVU19XTUlfREVWSURfQ1BVX0ZBTl9DVVJWRS4K
KyAqLworc3RhdGljIGludCBmYW5fY3VydmVfd3JpdGUoc3RydWN0IGFzdXNfd21pICphc3VzLCB1
MzIgZGV2LAorCQkJCQlzdHJ1Y3QgZmFuX2N1cnZlX2RhdGEgKmRhdGEpCit7CisJaW50IHJldCwg
aSwgc2hpZnQgPSAwOworCXUzMiBhcmcxLCBhcmcyLCBhcmczLCBhcmc0OworCisJYXJnMSA9IGFy
ZzIgPSBhcmczID0gYXJnNCA9IDA7CisKKwlmb3IgKGkgPSAwOyBpIDwgRkFOX0NVUlZFX1BPSU5U
UyAvIDI7IGkrKykgeworCQlhcmcxICs9IGRhdGEtPnRlbXBzW2ldIDw8IHNoaWZ0OworCQlhcmcy
ICs9IGRhdGEtPnRlbXBzW2kgKyA0XSA8PCBzaGlmdDsKKwkJYXJnMyArPSBkYXRhLT5wZXJjZW50
c1swXSA8PCBzaGlmdDsKKwkJYXJnNCArPSBkYXRhLT5wZXJjZW50c1tpICsgNF0gPDwgc2hpZnQ7
CisJCXNoaWZ0ICs9IDg7CisJfQorCisJcmV0dXJuIGFzdXNfd21pX2V2YWx1YXRlX21ldGhvZDUo
QVNVU19XTUlfTUVUSE9ESURfREVWUywgZGV2LAorCQkJCQlhcmcxLCBhcmcyLCBhcmczLCBhcmc0
LCAmcmV0KTsKK30KKworLyoKKyAqIENhbGxlZCBvbmx5IGJ5IHRocm90dGxlX3RoZXJtYWxfcG9s
aWN5X3dyaXRlKCkKKyAqLworc3RhdGljIGludCBmYW5fY3VydmVfd3JpdGVfZGF0YShzdHJ1Y3Qg
YXN1c193bWkgKmFzdXMpCit7CisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpjcHU7CisJc3RydWN0
IGZhbl9jdXJ2ZV9kYXRhICpncHU7CisJaW50IGVyciwgbW9kZTsKKworCW1vZGUgPSBhc3VzLT50
aHJvdHRsZV90aGVybWFsX3BvbGljeV9tb2RlOworCWNwdSA9ICZhc3VzLT50aHJvdHRsZV9mYW5f
Y3VydmVzW21vZGVdW0ZBTl9DVVJWRV9ERVZfQ1BVXTsKKwlncHUgPSAmYXN1cy0+dGhyb3R0bGVf
ZmFuX2N1cnZlc1ttb2RlXVtGQU5fQ1VSVkVfREVWX0dQVV07CisKKwlpZiAoY3B1LT5lbmFibGVk
KSB7CisJCWVyciA9IGZhbl9jdXJ2ZV93cml0ZShhc3VzLCBBU1VTX1dNSV9ERVZJRF9DUFVfRkFO
X0NVUlZFLCBjcHUpOworCQlpZiAoZXJyKQorCQkJcmV0dXJuIGVycjsKKwl9CisKKwlpZiAoZ3B1
LT5lbmFibGVkKSB7CisJCWVyciA9IGZhbl9jdXJ2ZV93cml0ZShhc3VzLCBBU1VTX1dNSV9ERVZJ
RF9HUFVfRkFOX0NVUlZFLCBncHUpOworCQlpZiAoZXJyKQorCQkJcmV0dXJuIGVycjsKKwl9CisK
KwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBmYW5fY3VydmVfdmVyaWZ5KHN0cnVjdCBmYW5f
Y3VydmVfZGF0YSAqZGF0YSkKK3sKKwlpbnQgaSA9IDA7CisJdTggdG1wID0gMDsKKwl1OCBwcmV2
X3RtcCA9IDA7CisKKworCWZvciAoaSA9IDA7IGkgPCBGQU5fQ1VSVkVfUE9JTlRTOyBpKyspIHsK
KwkJdG1wID0gZGF0YS0+dGVtcHNbaV07CisJCWlmICh0bXAgPCBwcmV2X3RtcCkKKwkJCXJldHVy
biAtRUlOVkFMOworCQlwcmV2X3RtcCA9IHRtcDsKKwl9CisKKwl0bXAgPSAwOworCXByZXZfdG1w
ID0gMDsKKwlmb3IgKGkgPSAwOyBpIDwgRkFOX0NVUlZFX1BPSU5UUzsgaSsrKSB7CisJCXRtcCA9
IGRhdGEtPnBlcmNlbnRzW2ldOworCQlpZiAodG1wIDwgcHJldl90bXApCisJCQlyZXR1cm4gLUVJ
TlZBTDsKKwkJcHJldl90bXAgPSB0bXA7CisJfQorCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBz
c2l6ZV90IGZhbl9jdXJ2ZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCQkJY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQp
Cit7CisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpkYXRhID0gZmFuX2N1cnZlX2F0dHJfZGF0YV9z
ZWxlY3QoZGV2LCBhdHRyKTsKKwl1OCB2YWx1ZSwgb2xkX3ZhbHVlOworCWludCBlcnI7CisKKwlp
bnQgaW5kZXggPSB0b19zZW5zb3JfZGV2X2F0dHJfMihhdHRyKS0+aW5kZXg7CisJaW50IG5yID0g
dG9fc2Vuc29yX2Rldl9hdHRyXzIoYXR0ciktPm5yOworCWludCBwd20gPSBuciAmIEZBTl9DVVJW
RV9QV01fTUFTSzsKKworCWVyciA9IGtzdHJ0b3U4KGJ1ZiwgMTAsICZ2YWx1ZSk7CisJaWYgKGVy
ciA8IDApCisJCXJldHVybiBlcnI7CisKKwlpZiAocHdtKSB7CisJCW9sZF92YWx1ZSA9IGRhdGEt
PnBlcmNlbnRzW2luZGV4XTsKKwkJZGF0YS0+cGVyY2VudHNbaW5kZXhdID0gMTAwICogdmFsdWUg
LyAyNTU7CisJfSBlbHNlIHsKKwkJb2xkX3ZhbHVlID0gZGF0YS0+dGVtcHNbaW5kZXhdOworCQlk
YXRhLT50ZW1wc1tpbmRleF0gPSB2YWx1ZTsKKwl9CisJLyoKKwkgKiBUaGUgY2hlY2sgaGVyZSBm
b3JjZXMgd3JpdGluZyBhIGN1cnZlIGdyYXBoIGluIHJldmVyc2UsCisJICogZnJvbSBoaWdoZXN0
IHRvIGxvd2VzdC4KKwkgKi8KKwllcnIgPSBmYW5fY3VydmVfdmVyaWZ5KGRhdGEpOworCWlmIChl
cnIpIHsKKwkJaWYgKHB3bSkgeworCQkJZGV2X2VycihkZXYsICJhIGZhbiBjdXJ2ZSBwZXJjZW50
YWdlIHdhcyBoaWdoZXIgdGhhbiB0aGUgbmV4dCBpbiBzZXF1ZW5jZVxuIik7CisJCQlkYXRhLT5w
ZXJjZW50c1tpbmRleF0gPSBvbGRfdmFsdWU7CisJCX0gZWxzZSB7CisJCQlkZXZfZXJyKGRldiwg
ImEgZmFuIGN1cnZlIHRlbXBlcmF0dXJlIHdhcyBoaWdoZXIgdGhhbiB0aGUgbmV4dCBpbiBzZXF1
ZW5jZVxuIik7CisJCQlkYXRhLT50ZW1wc1tpbmRleF0gPSBvbGRfdmFsdWU7CisJCX0KKwkJcmV0
dXJuIGVycjsKKwl9CisKKwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBzc2l6ZV90IGZhbl9j
dXJ2ZV9lbmFibGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0IGRldmljZV9h
dHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKK3sKKwlzdHJ1Y3QgZmFuX2N1cnZlX2RhdGEgKmRh
dGEgPSBmYW5fY3VydmVfYXR0cl9kYXRhX3NlbGVjdChkZXYsIGF0dHIpOworCisJcmV0dXJuIHNj
bnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVkXG4iLCBkYXRhLT5lbmFibGVkKTsKK30KKworc3Rh
dGljIHNzaXplX3QgZmFuX2N1cnZlX2VuYWJsZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJ
CQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCQkJY29uc3QgY2hhciAqYnVmLCBz
aXplX3QgY291bnQpCit7CisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpkYXRhID0gZmFuX2N1cnZl
X2F0dHJfZGF0YV9zZWxlY3QoZGV2LCBhdHRyKTsKKwlzdHJ1Y3QgYXN1c193bWkgKmFzdXMgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlib29sIHZhbHVlOworCWludCBlcnI7CisKKwllcnIgPSBr
c3RydG9ib29sKGJ1ZiwgJnZhbHVlKTsKKwlpZiAoZXJyIDwgMCkKKwkJcmV0dXJuIGVycjsKKwor
CWRhdGEtPmVuYWJsZWQgPSB2YWx1ZTsKKwl0aHJvdHRsZV90aGVybWFsX3BvbGljeV93cml0ZShh
c3VzKTsKKworCXJldHVybiBjb3VudDsKK30KKworLyogQ1BVICovCisvLyBUT0RPOiBlbmFibGUK
K3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfUlcocHdtMV9lbmFibGUsIGZhbl9jdXJ2ZV9lbmFi
bGUsCisJCQkJRkFOX0NVUlZFX0RFVl9DUFUpOworLy8gKG5hbWUsIGZ1bmN0aW9uLCBmYW4sIHBv
aW50KSBUT0RPOiBuZWVkIHRvIG1hc2sgaWYgdGVtcCBvciBwZXJjZW50CitzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50MV90ZW1wLCBmYW5fY3VydmUsCisJCQkJ
RkFOX0NVUlZFX0RFVl9DUFUsIDApOworc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3
bTFfYXV0b19wb2ludDJfdGVtcCwgZmFuX2N1cnZlLAorCQkJCUZBTl9DVVJWRV9ERVZfQ1BVLCAx
KTsKK3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMl9SVyhwd20xX2F1dG9fcG9pbnQzX3RlbXAs
IGZhbl9jdXJ2ZSwKKwkJCQlGQU5fQ1VSVkVfREVWX0NQVSwgMik7CitzdGF0aWMgU0VOU09SX0RF
VklDRV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50NF90ZW1wLCBmYW5fY3VydmUsCisJCQkJRkFO
X0NVUlZFX0RFVl9DUFUsIDMpOworc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTFf
YXV0b19wb2ludDVfdGVtcCwgZmFuX2N1cnZlLAorCQkJCUZBTl9DVVJWRV9ERVZfQ1BVLCA0KTsK
K3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMl9SVyhwd20xX2F1dG9fcG9pbnQ2X3RlbXAsIGZh
bl9jdXJ2ZSwKKwkJCQlGQU5fQ1VSVkVfREVWX0NQVSwgNSk7CitzdGF0aWMgU0VOU09SX0RFVklD
RV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50N190ZW1wLCBmYW5fY3VydmUsCisJCQkJRkFOX0NV
UlZFX0RFVl9DUFUsIDYpOworc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTFfYXV0
b19wb2ludDhfdGVtcCwgZmFuX2N1cnZlLAorCQkJCUZBTl9DVVJWRV9ERVZfQ1BVLCA3KTsKKwor
c3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTFfYXV0b19wb2ludDFfcHdtLCBmYW5f
Y3VydmUsCisJCQlGQU5fQ1VSVkVfREVWX0NQVSB8IEZBTl9DVVJWRV9QV01fTUFTSywgMCk7Citz
dGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50Ml9wd20sIGZhbl9j
dXJ2ZSwKKwkJCUZBTl9DVVJWRV9ERVZfQ1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCAxKTsKK3N0
YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMl9SVyhwd20xX2F1dG9fcG9pbnQzX3B3bSwgZmFuX2N1
cnZlLAorCQkJRkFOX0NVUlZFX0RFVl9DUFUgfCBGQU5fQ1VSVkVfUFdNX01BU0ssIDIpOworc3Rh
dGljIFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTFfYXV0b19wb2ludDRfcHdtLCBmYW5fY3Vy
dmUsCisJCQlGQU5fQ1VSVkVfREVWX0NQVSB8IEZBTl9DVVJWRV9QV01fTUFTSywgMyk7CitzdGF0
aWMgU0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50NV9wd20sIGZhbl9jdXJ2
ZSwKKwkJCUZBTl9DVVJWRV9ERVZfQ1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCA0KTsKK3N0YXRp
YyBTRU5TT1JfREVWSUNFX0FUVFJfMl9SVyhwd20xX2F1dG9fcG9pbnQ2X3B3bSwgZmFuX2N1cnZl
LAorCQkJRkFOX0NVUlZFX0RFVl9DUFUgfCBGQU5fQ1VSVkVfUFdNX01BU0ssIDUpOworc3RhdGlj
IFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTFfYXV0b19wb2ludDdfcHdtLCBmYW5fY3VydmUs
CisJCQlGQU5fQ1VSVkVfREVWX0NQVSB8IEZBTl9DVVJWRV9QV01fTUFTSywgNik7CitzdGF0aWMg
U0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMV9hdXRvX3BvaW50OF9wd20sIGZhbl9jdXJ2ZSwK
KwkJCUZBTl9DVVJWRV9ERVZfQ1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCA3KTsKKworLyogR1BV
ICovCitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSX1JXKHB3bTJfZW5hYmxlLCBmYW5fY3VydmVf
ZW5hYmxlLAorCQkJCUZBTl9DVVJWRV9ERVZfR1BVKTsKK3N0YXRpYyBTRU5TT1JfREVWSUNFX0FU
VFJfMl9SVyhwd20yX2F1dG9fcG9pbnQxX3RlbXAsIGZhbl9jdXJ2ZSwKKwkJCQlGQU5fQ1VSVkVf
REVWX0dQVSwgMCk7CitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3Bv
aW50Ml90ZW1wLCBmYW5fY3VydmUsCisJCQkJRkFOX0NVUlZFX0RFVl9HUFUsIDEpOworc3RhdGlj
IFNFTlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTJfYXV0b19wb2ludDNfdGVtcCwgZmFuX2N1cnZl
LAorCQkJCUZBTl9DVVJWRV9ERVZfR1BVLCAyKTsKK3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJf
Ml9SVyhwd20yX2F1dG9fcG9pbnQ0X3RlbXAsIGZhbl9jdXJ2ZSwKKwkJCQlGQU5fQ1VSVkVfREVW
X0dQVSwgMyk7CitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3BvaW50
NV90ZW1wLCBmYW5fY3VydmUsCisJCQkJRkFOX0NVUlZFX0RFVl9HUFUsIDQpOworc3RhdGljIFNF
TlNPUl9ERVZJQ0VfQVRUUl8yX1JXKHB3bTJfYXV0b19wb2ludDZfdGVtcCwgZmFuX2N1cnZlLAor
CQkJCUZBTl9DVVJWRV9ERVZfR1BVLCA1KTsKK3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFJfMl9S
Vyhwd20yX2F1dG9fcG9pbnQ3X3RlbXAsIGZhbl9jdXJ2ZSwKKwkJCQlGQU5fQ1VSVkVfREVWX0dQ
VSwgNik7CitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3BvaW50OF90
ZW1wLCBmYW5fY3VydmUsCisJCQkJRkFOX0NVUlZFX0RFVl9HUFUsIDcpOworCitzdGF0aWMgU0VO
U09SX0RFVklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3BvaW50MV9wd20sIGZhbl9jdXJ2ZSwKKwkJ
CUZBTl9DVVJWRV9ERVZfR1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCAwKTsKK3N0YXRpYyBTRU5T
T1JfREVWSUNFX0FUVFJfMl9SVyhwd20yX2F1dG9fcG9pbnQyX3B3bSwgZmFuX2N1cnZlLAorCQkJ
RkFOX0NVUlZFX0RFVl9HUFUgfCBGQU5fQ1VSVkVfUFdNX01BU0ssIDEpOworc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUl8yX1JXKHB3bTJfYXV0b19wb2ludDNfcHdtLCBmYW5fY3VydmUsCisJCQlG
QU5fQ1VSVkVfREVWX0dQVSB8IEZBTl9DVVJWRV9QV01fTUFTSywgMik7CitzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3BvaW50NF9wd20sIGZhbl9jdXJ2ZSwKKwkJCUZB
Tl9DVVJWRV9ERVZfR1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCAzKTsKK3N0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFJfMl9SVyhwd20yX2F1dG9fcG9pbnQ1X3B3bSwgZmFuX2N1cnZlLAorCQkJRkFO
X0NVUlZFX0RFVl9HUFUgfCBGQU5fQ1VSVkVfUFdNX01BU0ssIDQpOworc3RhdGljIFNFTlNPUl9E
RVZJQ0VfQVRUUl8yX1JXKHB3bTJfYXV0b19wb2ludDZfcHdtLCBmYW5fY3VydmUsCisJCQlGQU5f
Q1VSVkVfREVWX0dQVSB8IEZBTl9DVVJWRV9QV01fTUFTSywgNSk7CitzdGF0aWMgU0VOU09SX0RF
VklDRV9BVFRSXzJfUlcocHdtMl9hdXRvX3BvaW50N19wd20sIGZhbl9jdXJ2ZSwKKwkJCUZBTl9D
VVJWRV9ERVZfR1BVIHwgRkFOX0NVUlZFX1BXTV9NQVNLLCA2KTsKK3N0YXRpYyBTRU5TT1JfREVW
SUNFX0FUVFJfMl9SVyhwd20yX2F1dG9fcG9pbnQ4X3B3bSwgZmFuX2N1cnZlLAorCQkJRkFOX0NV
UlZFX0RFVl9HUFUgfCBGQU5fQ1VSVkVfUFdNX01BU0ssIDcpOworCitzdGF0aWMgc3RydWN0IGF0
dHJpYnV0ZSAqZmFuX2N1cnZlX2F0dHJpYnV0ZXNbXSA9IHsKKwkvKiBDUFUgKi8KKwkmc2Vuc29y
X2Rldl9hdHRyX3B3bTFfZW5hYmxlLmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9w
d20xX2F1dG9fcG9pbnQxX3RlbXAuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3
bTFfYXV0b19wb2ludDJfdGVtcC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdt
MV9hdXRvX3BvaW50M190ZW1wLmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20x
X2F1dG9fcG9pbnQ0X3RlbXAuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTFf
YXV0b19wb2ludDVfdGVtcC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9h
dXRvX3BvaW50Nl90ZW1wLmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1
dG9fcG9pbnQ3X3RlbXAuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0
b19wb2ludDhfdGVtcC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9hdXRv
X3BvaW50MV9wd20uZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19w
b2ludDJfcHdtLmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9p
bnQzX3B3bS5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9hdXRvX3BvaW50
NF9wd20uZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wb2ludDVf
cHdtLmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ2X3B3
bS5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9hdXRvX3BvaW50N19wd20u
ZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wb2ludDhfcHdtLmRl
dl9hdHRyLmF0dHIsCisJLyogR1BVICovCisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2VuYWJsZS5k
ZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50MV90ZW1wLmRl
dl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQyX3RlbXAuZGV2
X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDNfdGVtcC5kZXZf
YXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50NF90ZW1wLmRldl9h
dHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQ1X3RlbXAuZGV2X2F0
dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDZfdGVtcC5kZXZfYXR0
ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50N190ZW1wLmRldl9hdHRy
LmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQ4X3RlbXAuZGV2X2F0dHIu
YXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDFfcHdtLmRldl9hdHRyLmF0
dHIsCisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQyX3B3bS5kZXZfYXR0ci5hdHRy
LAorCSZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50M19wd20uZGV2X2F0dHIuYXR0ciwK
Kwkmc2Vuc29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDRfcHdtLmRldl9hdHRyLmF0dHIsCisJ
JnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQ1X3B3bS5kZXZfYXR0ci5hdHRyLAorCSZz
ZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50Nl9wd20uZGV2X2F0dHIuYXR0ciwKKwkmc2Vu
c29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDdfcHdtLmRldl9hdHRyLmF0dHIsCisJJnNlbnNv
cl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQ4X3B3bS5kZXZfYXR0ci5hdHRyLAorCU5VTEwKK307
CisKK3N0YXRpYyB1bW9kZV90IGZhbl9jdXJ2ZV9zeXNmc19pc192aXNpYmxlKHN0cnVjdCBrb2Jq
ZWN0ICprb2JqLAorCQkJCQkgICBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBpbnQgaWR4KQorewor
CXN0cnVjdCBkZXZpY2UgKmRldiA9IGNvbnRhaW5lcl9vZihrb2JqLCBzdHJ1Y3QgZGV2aWNlLCBr
b2JqKTsKKwlzdHJ1Y3QgYXN1c193bWkgKmFzdXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2LT5wYXJl
bnQpOworCisJaWYgKGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQxX3Rl
bXAuZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9f
cG9pbnQyX3RlbXAuZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9w
d20xX2F1dG9fcG9pbnQzX3RlbXAuZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9k
ZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ0X3RlbXAuZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0g
JnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ1X3RlbXAuZGV2X2F0dHIuYXR0cgorCXx8
IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ2X3RlbXAuZGV2X2F0dHIu
YXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ3X3RlbXAu
ZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9p
bnQ4X3RlbXAuZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20x
X2F1dG9fcG9pbnQxX3B3bS5kZXZfYXR0ci5hdHRyCisJfHwgYXR0ciA9PSAmc2Vuc29yX2Rldl9h
dHRyX3B3bTFfYXV0b19wb2ludDJfcHdtLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZzZW5z
b3JfZGV2X2F0dHJfcHdtMV9hdXRvX3BvaW50M19wd20uZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIg
PT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9pbnQ0X3B3bS5kZXZfYXR0ci5hdHRyCisJ
fHwgYXR0ciA9PSAmc2Vuc29yX2Rldl9hdHRyX3B3bTFfYXV0b19wb2ludDVfcHdtLmRldl9hdHRy
LmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMV9hdXRvX3BvaW50Nl9wd20u
ZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20xX2F1dG9fcG9p
bnQ3X3B3bS5kZXZfYXR0ci5hdHRyCisJfHwgYXR0ciA9PSAmc2Vuc29yX2Rldl9hdHRyX3B3bTFf
YXV0b19wb2ludDhfcHdtLmRldl9hdHRyLmF0dHIpIHsKKwkJaWYgKCFhc3VzLT5jcHVfZmFuX2N1
cnZlX2F2YWlsYWJsZSkKKwkJCXJldHVybiAwOworCX0KKworCWlmIChhdHRyID09ICZzZW5zb3Jf
ZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50MV90ZW1wLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09
ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50Ml90ZW1wLmRldl9hdHRyLmF0dHIKKwl8
fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50M190ZW1wLmRldl9hdHRy
LmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50NF90ZW1w
LmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3Bv
aW50NV90ZW1wLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdt
Ml9hdXRvX3BvaW50Nl90ZW1wLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2
X2F0dHJfcHdtMl9hdXRvX3BvaW50N190ZW1wLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZz
ZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50OF90ZW1wLmRldl9hdHRyLmF0dHIKKwl8fCBh
dHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50MV9wd20uZGV2X2F0dHIuYXR0
cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQyX3B3bS5kZXZf
YXR0ci5hdHRyCisJfHwgYXR0ciA9PSAmc2Vuc29yX2Rldl9hdHRyX3B3bTJfYXV0b19wb2ludDNf
cHdtLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZzZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRv
X3BvaW50NF9wd20uZGV2X2F0dHIuYXR0cgorCXx8IGF0dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9w
d20yX2F1dG9fcG9pbnQ1X3B3bS5kZXZfYXR0ci5hdHRyCisJfHwgYXR0ciA9PSAmc2Vuc29yX2Rl
dl9hdHRyX3B3bTJfYXV0b19wb2ludDZfcHdtLmRldl9hdHRyLmF0dHIKKwl8fCBhdHRyID09ICZz
ZW5zb3JfZGV2X2F0dHJfcHdtMl9hdXRvX3BvaW50N19wd20uZGV2X2F0dHIuYXR0cgorCXx8IGF0
dHIgPT0gJnNlbnNvcl9kZXZfYXR0cl9wd20yX2F1dG9fcG9pbnQ4X3B3bS5kZXZfYXR0ci5hdHRy
KSB7CisJCWlmICghYXN1cy0+Z3B1X2Zhbl9jdXJ2ZV9hdmFpbGFibGUpCisJCQlyZXR1cm4gMDsK
Kwl9CisKKwlyZXR1cm4gYXR0ci0+bW9kZTsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgZmFuX2N1cnZlX2F0dHJpYnV0ZV9ncm91cCA9IHsKKwkuaXNfdmlzaWJsZSA9
IGZhbl9jdXJ2ZV9zeXNmc19pc192aXNpYmxlLAorCS5hdHRycyA9IGZhbl9jdXJ2ZV9hdHRyaWJ1
dGVzCit9OworX19BVFRSSUJVVEVfR1JPVVBTKGZhbl9jdXJ2ZV9hdHRyaWJ1dGUpOworCitzdGF0
aWMgaW50IGFzdXNfd21pX2Zhbl9jdXJ2ZV9pbml0KHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKK3sK
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmYXN1cy0+cGxhdGZvcm1fZGV2aWNlLT5kZXY7CisJc3Ry
dWN0IGRldmljZSAqaHdtb247CisKKwlod21vbiA9IGRldm1faHdtb25fZGV2aWNlX3JlZ2lzdGVy
X3dpdGhfZ3JvdXBzKGRldiwgImFzdXMiLCBhc3VzLAorCQkJCQkJZmFuX2N1cnZlX2F0dHJpYnV0
ZV9ncm91cHMpOworCisJaWYgKElTX0VSUihod21vbikpIHsKKwkJcHJfZXJyKCJDb3VsZCBub3Qg
cmVnaXN0ZXIgYXN1cyBmYW5fY3VydmUgZGV2aWNlXG4iKTsKKwkJcmV0dXJuIFBUUl9FUlIoaHdt
b24pOworCX0KKworCXJldHVybiAwOworfQorCiAvKiBUaHJvdHRsZSB0aGVybWFsIHBvbGljeSAq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCiBz
dGF0aWMgaW50IHRocm90dGxlX3RoZXJtYWxfcG9saWN5X2NoZWNrX3ByZXNlbnQoc3RydWN0IGFz
dXNfd21pICphc3VzKQpAQCAtMjA1Myw4ICsyNTkyLDggQEAgc3RhdGljIGludCB0aHJvdHRsZV90
aGVybWFsX3BvbGljeV9jaGVja19wcmVzZW50KHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKIAlhc3Vz
LT50aHJvdHRsZV90aGVybWFsX3BvbGljeV9hdmFpbGFibGUgPSBmYWxzZTsKIAogCWVyciA9IGFz
dXNfd21pX2dldF9kZXZzdGF0ZShhc3VzLAotCQkJCSAgICBBU1VTX1dNSV9ERVZJRF9USFJPVFRM
RV9USEVSTUFMX1BPTElDWSwKLQkJCQkgICAgJnJlc3VsdCk7CisJCUFTVVNfV01JX0RFVklEX1RI
Uk9UVExFX1RIRVJNQUxfUE9MSUNZLAorCQkmcmVzdWx0KTsKIAlpZiAoZXJyKSB7CiAJCWlmIChl
cnIgPT0gLUVOT0RFVikKIAkJCXJldHVybiAwOwpAQCAtMjA5Miw2ICsyNjMxLDEyIEBAIHN0YXRp
YyBpbnQgdGhyb3R0bGVfdGhlcm1hbF9wb2xpY3lfd3JpdGUoc3RydWN0IGFzdXNfd21pICphc3Vz
KQogCQlyZXR1cm4gLUVJTzsKIAl9CiAKKwlpZiAoYXN1cy0+Y3B1X2Zhbl9jdXJ2ZV9hdmFpbGFi
bGUgfHwgYXN1cy0+Z3B1X2Zhbl9jdXJ2ZV9hdmFpbGFibGUpIHsKKwkJZXJyID0gZmFuX2N1cnZl
X3dyaXRlX2RhdGEoYXN1cyk7CisJCWlmIChlcnIpCisJCQlyZXR1cm4gZXJyOworCX0KKwogCXJl
dHVybiAwOwogfQogCkBAIC0yOTA0LDcgKzM0NDksNyBAQCBzdGF0aWMgaW50IHNob3dfY2FsbChz
dHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpCiAJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMp
KQogCQlyZXR1cm4gLUVJTzsKIAotCW9iaiA9ICh1bmlvbiBhY3BpX29iamVjdCAqKW91dHB1dC5w
b2ludGVyOworCW9iaiA9IG91dHB1dC5wb2ludGVyOwogCWlmIChvYmogJiYgb2JqLT50eXBlID09
IEFDUElfVFlQRV9JTlRFR0VSKQogCQlzZXFfcHJpbnRmKG0sICIlI3goJSN4LCAlI3gpID0gJSN4
XG4iLCBhc3VzLT5kZWJ1Zy5tZXRob2RfaWQsCiAJCQkgICBhc3VzLT5kZWJ1Zy5kZXZfaWQsIGFz
dXMtPmRlYnVnLmN0cmxfcGFyYW0sCkBAIC0zMDE2LDYgKzM1NjEsMTYgQEAgc3RhdGljIGludCBh
c3VzX3dtaV9hZGQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAllbHNlCiAJCXRocm90
dGxlX3RoZXJtYWxfcG9saWN5X3NldF9kZWZhdWx0KGFzdXMpOwogCisJZXJyID0gY3VzdG9tX2Zh
bl9jaGVja19wcmVzZW50KGFzdXMsICZhc3VzLT5jcHVfZmFuX2N1cnZlX2F2YWlsYWJsZSwKKwkJ
CQkgICAgICAgQVNVU19XTUlfREVWSURfQ1BVX0ZBTl9DVVJWRSk7CisJaWYgKGVycikKKwkJZ290
byBmYWlsX2N1c3RvbV9mYW5fY3VydmU7CisKKwllcnIgPSBjdXN0b21fZmFuX2NoZWNrX3ByZXNl
bnQoYXN1cywgJmFzdXMtPmdwdV9mYW5fY3VydmVfYXZhaWxhYmxlLAorCQkJCSAgICAgICBBU1VT
X1dNSV9ERVZJRF9HUFVfRkFOX0NVUlZFKTsKKwlpZiAoZXJyKQorCQlnb3RvIGZhaWxfY3VzdG9t
X2Zhbl9jdXJ2ZTsKKwogCWVyciA9IHBsYXRmb3JtX3Byb2ZpbGVfc2V0dXAoYXN1cyk7CiAJaWYg
KGVycikKIAkJZ290byBmYWlsX3BsYXRmb3JtX3Byb2ZpbGVfc2V0dXA7CkBAIC0zMDM4LDYgKzM1
OTMsMTAgQEAgc3RhdGljIGludCBhc3VzX3dtaV9hZGQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKIAlpZiAoZXJyKQogCQlnb3RvIGZhaWxfaHdtb247CiAKKwllcnIgPSBhc3VzX3dtaV9m
YW5fY3VydmVfaW5pdChhc3VzKTsKKwlpZiAoZXJyKQorCQlnb3RvIGZhaWxfY3VzdG9tX2Zhbl9j
dXJ2ZTsKKwogCWVyciA9IGFzdXNfd21pX2xlZF9pbml0KGFzdXMpOwogCWlmIChlcnIpCiAJCWdv
dG8gZmFpbF9sZWRzOwpAQCAtMzEwOSw2ICszNjY4LDcgQEAgc3RhdGljIGludCBhc3VzX3dtaV9h
ZGQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlhc3VzX3dtaV9zeXNmc19leGl0KGFz
dXMtPnBsYXRmb3JtX2RldmljZSk7CiBmYWlsX3N5c2ZzOgogZmFpbF90aHJvdHRsZV90aGVybWFs
X3BvbGljeToKK2ZhaWxfY3VzdG9tX2Zhbl9jdXJ2ZToKIGZhaWxfcGxhdGZvcm1fcHJvZmlsZV9z
ZXR1cDoKIAlpZiAoYXN1cy0+cGxhdGZvcm1fcHJvZmlsZV9zdXBwb3J0KQogCQlwbGF0Zm9ybV9w
cm9maWxlX3JlbW92ZSgpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRh
L3g4Ni9hc3VzLXdtaS5oIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL3g4Ni9hc3VzLXdt
aS5oCmluZGV4IDE3ZGM1Y2I2ZjNmMi4uYTU3MWI0N2ZmMzYyIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEveDg2L2FzdXMtd21pLmgKKysrIGIvaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kYXRhL3g4Ni9hc3VzLXdtaS5oCkBAIC03Nyw2ICs3Nyw4IEBACiAjZGVmaW5lIEFT
VVNfV01JX0RFVklEX1RIRVJNQUxfQ1RSTAkweDAwMTEwMDExCiAjZGVmaW5lIEFTVVNfV01JX0RF
VklEX0ZBTl9DVFJMCQkweDAwMTEwMDEyIC8qIGRlcHJlY2F0ZWQgKi8KICNkZWZpbmUgQVNVU19X
TUlfREVWSURfQ1BVX0ZBTl9DVFJMCTB4MDAxMTAwMTMKKyNkZWZpbmUgQVNVU19XTUlfREVWSURf
Q1BVX0ZBTl9DVVJWRQkweDAwMTEwMDI0CisjZGVmaW5lIEFTVVNfV01JX0RFVklEX0dQVV9GQU5f
Q1VSVkUJMHgwMDExMDAyNQogCiAvKiBQb3dlciAqLwogI2RlZmluZSBBU1VTX1dNSV9ERVZJRF9Q
Uk9DRVNTT1JfU1RBVEUJMHgwMDEyMDAxMgotLSAKMi4zMS4xCgo=

--=-YgSO9yNR5AZ+DOb4pniE--


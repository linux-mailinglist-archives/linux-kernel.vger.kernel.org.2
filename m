Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17A3FC48E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhHaJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:00:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51993 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240447AbhHaJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:00:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C19073200A27;
        Tue, 31 Aug 2021 04:59:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 Aug 2021 04:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=n7wF4o
        IBCSN/rq2/Xr+GIvWgOs+r8DUdtUv1Vcs0oCQ=; b=q43FzToV0EDWDEywq2wjTj
        IQMkXVenaC7SjdXEiussLXVEbK/Lq4KTbdzclQxpaVYwdf4zcaclcxJbjrZRxh2v
        igAgs61qrr62W7klcR7PpUgIkSpJIMa85LvngfVusLZY9tGwD63oqPkK+f2ATYF9
        4mV1kSYJXDY5huKJBgfklyifVBxyhayCkXNwX+f8GNdpeJCCdLNlo6OfQhSEJsNg
        JjNjMH7Nkott+87MvJqOFEgFwOHlpt+XQM23WTxcYoGVzfm5HR+2wHh43pXRuMY7
        5QRsipEeNrOnUJLkXHhHjMDv3CNnALF/Th6na0GuEQJ3KoHrynpaJn+6qrsGP8tw
        ==
X-ME-Sender: <xms:YO8tYbdUC3MbnhnzsYYvyG1hGbTQc9mxTXVZhpj_oL8nVOlfEYibng>
    <xme:YO8tYROYmTx5YBgiKduzsjOGR6yA6_qv6sjpGp0_WV_ZJ07_lG2schKFQAMyxCUuK
    boyObeBkADP_yyL1U8>
X-ME-Received: <xmr:YO8tYUgq6249xHV1IfUqbh0od_VEXb96Tdoe8CGSOphN_DIHBIPEBeAY9CzgFSXpap7FVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesmhdtre
    erredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfdvveeiheekvdevhfdtveegffehhfejjeffje
    egtefhffdtveevjefhgeeghfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:YO8tYc8cYTHYdsnnFLlToM5RyKo5tOzEmbIwk8RNewUETQuITlPb8w>
    <xmx:YO8tYXsCU5Nq7vdJrnVds_GTLTIIaECnr23rIeWh_KFGy9ukDXIQgQ>
    <xmx:YO8tYbEs3cIWZFszeQ-N37cAdjol53sBs6ua-L3YTHQvhQJZfTItpQ>
    <xmx:Ye8tYQ7Ezwntqj-p9fNveKhrJo9LHJKb2Ruqrgg1bRy3hPz5rOcXHw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Aug 2021 04:59:07 -0400 (EDT)
Date:   Tue, 31 Aug 2021 20:58:49 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Message-Id: <1Y4PYQ.BFC57KCSOTUT1@ljones.dev>
In-Reply-To: <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
References: <20210830113137.1338683-1-luke@ljones.dev>
        <20210830113137.1338683-2-luke@ljones.dev>
        <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YJCDSKO/ilfhnZq6XSKz"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-YJCDSKO/ilfhnZq6XSKz
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Barnab=E1s,

I did another refactor using hwmon_device_register_with_info() and=20
HWMON_CHANNEL_INFO(). I'm unsure if this is what you were looking for=20
so I'm going to attach the patch instead of submitting as a V8 for now.

My main concern as that the use of the above removes the=20
pwm1_auto_point1_pwm + pwm1_auto_point1_temp format and gives two=20
hwmon<num>, one per cpu/gpu fan with:

device power
fan1_input subsystem
fan2_input temp1_input
fan3_input temp2_input
fan4_input temp3_input
fan5_input temp4_input
fan6_input temp5_input
fan7_input temp6_input
fan8_input temp7_input
in0_enable temp8_input
name uevent

cat -p /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/name
asus_cpu_fan_custom_curve

I've named the root name of each as descriptive as possible to convey=20
exactly what each is

Oh and `sensors` now shows:

asus_cpu_fan_curve-isa-0000
Adapter: ISA adapter
fan1: 8 RPM
fan2: 10 RPM
fan3: 18 RPM
fan4: 20 RPM
fan5: 28 RPM
fan6: 34 RPM
fan7: 44 RPM
fan8: 56 RPM
temp1: +0.0=B0C
temp2: +0.1=B0C
temp3: +0.1=B0C
temp4: +0.1=B0C
temp5: +0.1=B0C
temp6: +0.1=B0C
temp7: +0.1=B0C
temp8: +0.1=B0C


 > FYI, the pwmX_enable attributes can be created by the hwmon
 > subsystem itself if you use [devm_]hwmon_device_register_with_info()
 > with appropriately populated `struct hwmon_chip_info`.

So when you say this, did you mean *just* for the pwmX_enable=20
attributes?


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
>=20
>=20
>>  [...]
>>  +static const struct attribute_group fan_curve_attribute_group =3D {
>>  +	.is_visible =3D fan_curve_sysfs_is_visible,
>>  +	.attrs =3D fan_curve_attributes
>=20
> Small thing, but it is customary to put commas after non-terminating
> entries in initializers / enum definitions.
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


--=-YJCDSKO/ilfhnZq6XSKz
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=v8-0001-asus-wmi-Add-support-for-custom-fan-curves.patch
Content-Transfer-Encoding: base64

RnJvbSA3Mjg1NzNhZmE3ZWRhMDQ5YTU3NjI2Y2MzN2VjNjg3MzMwMzVmZGVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTHVrZSBELiBKb25lcyIgPGx1a2VAbGpvbmVzLmRldj4KRGF0
ZTogU3VuLCAyOSBBdWcgMjAyMSAxMzoyMToyMyArMTIwMApTdWJqZWN0OiBbUEFUQ0ggdjggMS8x
XSBhc3VzLXdtaTogQWRkIHN1cHBvcnQgZm9yIGN1c3RvbSBmYW4gY3VydmVzCgpBZGQgc3VwcG9y
dCBmb3IgY3VzdG9tIGZhbiBjdXJ2ZXMgZm91bmQgb24gc29tZSBBU1VTIFJPRyBsYXB0b3BzLgoK
VGhlc2UgbGFwdG9wcyBoYXZlIHRoZSBhYmlsaXR5IHRvIHNldCBhIGN1c3RvbSBjdXJ2ZSBmb3Ig
dGhlIENQVQphbmQgR1BVIGZhbnMgdmlhIGFuIEFDUEkgbWV0aG9kIGNhbGwuIFRoaXMgcGF0Y2gg
ZW5hYmxlcyB0aGlzLAphZGRpdGlvbmFsbHkgZW5hYmxpbmcgY3VzdG9tIGZhbiBjdXJ2ZXMgcGVy
LXByb2ZpbGUsIHdoZXJlIHByb2ZpbGUKaGVyZSBtZWFucyBlYWNoIG9mIHRoZSAzIGxldmVscyBv
ZiAidGhyb3R0bGVfdGhlcm1hbF9wb2xpY3kiLgoKVGhpcyBwYXRjaCBhZGRzIHR3byBibG9ja3Mg
b2YgYXR0cmlidXRlcyB0byB0aGUgaHdtb24gc3lzZnMsCjEgYmxvY2sgZWFjaCBmb3IgQ1BVIGFu
ZCBHUFUgZmFucy4KCldoZW4gdGhlIHVzZXIgc3dpdGNoZXMgcHJvZmlsZXMgdGhlIGFzc29jaWF0
ZWQgY3VydmUgZGF0YSBmb3IgdGhhdApwcm9maWxlIGlzIHRoZW4gc2hvdy9zdG9yZSBlbmFibGVk
IHRvIGFsbG93IHVzZXJzIHRvIHJvdGF0ZSB0aHJvdWdoCnRoZSBwcm9maWxlcyBhbmQgc2V0IGEg
ZmFuIGN1cnZlIGZvciBlYWNoIHByb2ZpbGUgd2hpY2ggdGhlbgphY3RpdmF0ZXMgb24gcHJvZmls
ZSBzd2l0Y2ggaWYgZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IEx1a2UgRC4gSm9uZXMgPGx1a2VA
bGpvbmVzLmRldj4KLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jICAgICAgICAg
ICAgfCA0OTQgKysrKysrKysrKysrKysrKysrKystCiBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2Rh
dGEveDg2L2FzdXMtd21pLmggfCAgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA0OTIgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9h
c3VzLXdtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYwppbmRleCBjYzU4MTE4
NDQwMTIuLmY4M2YxNTNkNjBiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1
cy13bWkuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCkBAIC0xMDYsOCAr
MTA2LDE2IEBAIG1vZHVsZV9wYXJhbShmbmxvY2tfZGVmYXVsdCwgYm9vbCwgMDQ0NCk7CiAKICNk
ZWZpbmUgV01JX0VWRU5UX01BU0sJCQkweEZGRkYKIAorLyogVGhlIG51bWJlciBvZiBBU1VTX1RI
Uk9UVExFX1RIRVJNQUxfUE9MSUNZXyogYXZhaWxhYmxlICovCisjZGVmaW5lIEZBTl9DVVJWRV9Q
Uk9GSUxFX05VTQkoQVNVU19USFJPVFRMRV9USEVSTUFMX1BPTElDWV9TSUxFTlQgKyAxKQorI2Rl
ZmluZSBGQU5fQ1VSVkVfUE9JTlRTCQk4CisjZGVmaW5lIEZBTl9DVVJWRV9ERVZfQ1BVCQkweDAw
CisjZGVmaW5lIEZBTl9DVVJWRV9ERVZfR1BVCQkweDAxCisKIHN0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QgYXNoc19pZHNbXSA9IHsgIkFUSzQwMDEiLCAiQVRLNDAwMiIsIE5VTEwgfTsKIAorc3Rh
dGljIGludCB0aHJvdHRsZV90aGVybWFsX3BvbGljeV93cml0ZShzdHJ1Y3QgYXN1c193bWkgKik7
CisKIHN0YXRpYyBib29sIGFzaHNfcHJlc2VudCh2b2lkKQogewogCWludCBpID0gMDsKQEAgLTEy
Miw3ICsxMzAsOCBAQCBzdHJ1Y3QgYmlvc19hcmdzIHsKIAl1MzIgYXJnMDsKIAl1MzIgYXJnMTsK
IAl1MzIgYXJnMjsgLyogQXQgbGVhc3QgVFVGIEdhbWluZyBzZXJpZXMgdXNlcyAzIGR3b3JkIGlu
cHV0IGJ1ZmZlci4gKi8KLQl1MzIgYXJnNDsKKwl1MzIgYXJnMzsKKwl1MzIgYXJnNDsgLyogU29t
ZSBST0cgbGFwdG9wcyByZXF1aXJlIGEgZnVsbCA1IGlucHV0IGFyZ3MgKi8KIAl1MzIgYXJnNTsK
IH0gX19wYWNrZWQ7CiAKQEAgLTE3Myw2ICsxODIsMTcgQEAgZW51bSBmYW5fdHlwZSB7CiAJRkFO
X1RZUEVfU1BFQzgzLAkvKiBzdGFydGluZyBpbiBTcGVjIDguMywgdXNlIENQVV9GQU5fQ1RSTCAq
LwogfTsKIAorLyoKKyAqIFRoZSByZWxhdGVkIEFDUEkgbWV0aG9kIGZvciB0ZXN0aW5nIGF2YWls
YWJpbGl0eSBhbHNvIHJldHVybnMgdGhlIGZhY3RvcnkKKyAqIGRlZmF1bHQgZmFuIGN1cnZlcy4g
V2Ugc2F2ZSB0aGVtIGhlcmUgc28gdGhhdCBhIHVzZXIgY2FuIHJlc2V0IGN1c3RvbQorICogc2V0
dGluZ3MgaWYgcmVxdWlyZWQuCisgKi8KK3N0cnVjdCBmYW5fY3VydmVfZGF0YSB7CisJdTggZW5h
YmxlZDsKKwl1OCB0ZW1wc1tGQU5fQ1VSVkVfUE9JTlRTXTsKKwl1OCBwZXJjZW50c1tGQU5fQ1VS
VkVfUE9JTlRTXTsKK307CisKIHN0cnVjdCBhc3VzX3dtaSB7CiAJaW50IGRzdHNfaWQ7CiAJaW50
IHNwZWM7CkBAIC0yMjAsNiArMjQwLDExIEBAIHN0cnVjdCBhc3VzX3dtaSB7CiAJYm9vbCB0aHJv
dHRsZV90aGVybWFsX3BvbGljeV9hdmFpbGFibGU7CiAJdTggdGhyb3R0bGVfdGhlcm1hbF9wb2xp
Y3lfbW9kZTsKIAorCWJvb2wgY3B1X2Zhbl9jdXJ2ZV9hdmFpbGFibGU7CisJYm9vbCBncHVfZmFu
X2N1cnZlX2F2YWlsYWJsZTsKKwkvKiBbdGhyb3R0bGUgbW9kZXNdW2ZhbiBjb3VudF0gKi8KKwlz
dHJ1Y3QgZmFuX2N1cnZlX2RhdGEgdGhyb3R0bGVfZmFuX2N1cnZlc1tGQU5fQ1VSVkVfUFJPRklM
RV9OVU1dWzJdOworCiAJc3RydWN0IHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlciBwbGF0Zm9ybV9w
cm9maWxlX2hhbmRsZXI7CiAJYm9vbCBwbGF0Zm9ybV9wcm9maWxlX3N1cHBvcnQ7CiAKQEAgLTI4
NSw2ICszMTAsMTA1IEBAIGludCBhc3VzX3dtaV9ldmFsdWF0ZV9tZXRob2QodTMyIG1ldGhvZF9p
ZCwgdTMyIGFyZzAsIHUzMiBhcmcxLCB1MzIgKnJldHZhbCkKIH0KIEVYUE9SVF9TWU1CT0xfR1BM
KGFzdXNfd21pX2V2YWx1YXRlX21ldGhvZCk7CiAKK3N0YXRpYyBpbnQgYXN1c193bWlfZXZhbHVh
dGVfbWV0aG9kNSh1MzIgbWV0aG9kX2lkLAorCQl1MzIgYXJnMCwgdTMyIGFyZzEsIHUzMiBhcmcy
LCB1MzIgYXJnMywgdTMyIGFyZzQsIHUzMiAqcmV0dmFsKQoreworCXN0cnVjdCBiaW9zX2FyZ3Mg
YXJncyA9IHsKKwkJLmFyZzAgPSBhcmcwLAorCQkuYXJnMSA9IGFyZzEsCisJCS5hcmcyID0gYXJn
MiwKKwkJLmFyZzMgPSBhcmczLAorCQkuYXJnNCA9IGFyZzQsCisJfTsKKwlzdHJ1Y3QgYWNwaV9i
dWZmZXIgaW5wdXQgPSB7IChhY3BpX3NpemUpIHNpemVvZihhcmdzKSwgJmFyZ3MgfTsKKwlzdHJ1
Y3QgYWNwaV9idWZmZXIgb3V0cHV0ID0geyBBQ1BJX0FMTE9DQVRFX0JVRkZFUiwgTlVMTCB9Owor
CWFjcGlfc3RhdHVzIHN0YXR1czsKKwl1bmlvbiBhY3BpX29iamVjdCAqb2JqOworCXUzMiB0bXAg
PSAwOworCisJc3RhdHVzID0gd21pX2V2YWx1YXRlX21ldGhvZChBU1VTX1dNSV9NR01UX0dVSUQs
IDAsIG1ldGhvZF9pZCwKKwkJCQkgICAgICZpbnB1dCwgJm91dHB1dCk7CisKKwlpZiAoQUNQSV9G
QUlMVVJFKHN0YXR1cykpCisJCXJldHVybiAtRUlPOworCisJb2JqID0gKHVuaW9uIGFjcGlfb2Jq
ZWN0ICopb3V0cHV0LnBvaW50ZXI7CisJaWYgKG9iaiAmJiBvYmotPnR5cGUgPT0gQUNQSV9UWVBF
X0lOVEVHRVIpCisJCXRtcCA9ICh1MzIpIG9iai0+aW50ZWdlci52YWx1ZTsKKworCWlmIChyZXR2
YWwpCisJCSpyZXR2YWwgPSB0bXA7CisKKwlrZnJlZShvYmopOworCisJaWYgKHRtcCA9PSBBU1VT
X1dNSV9VTlNVUFBPUlRFRF9NRVRIT0QpCisJCXJldHVybiAtRU5PREVWOworCisJcmV0dXJuIDA7
Cit9CisKKy8qCisgKiBSZXR1cm5zIGFzIGFuIGVycm9yIGlmIHRoZSBtZXRob2Qgb3V0cHV0IGlz
IG5vdCBhIGJ1ZmZlci4gVHlwaWNhbGx5IHRoaXMKKyAqIG1lYW5zIHRoYXQgdGhlIG1ldGhvZCBj
YWxsZWQgaXMgdW5zdXBwb3J0ZWQuCisgKi8KK3N0YXRpYyBpbnQgYXN1c193bWlfZXZhbHVhdGVf
bWV0aG9kX2J1Zih1MzIgbWV0aG9kX2lkLAorCQl1MzIgYXJnMCwgdTMyIGFyZzEsIHU4ICpyZXRf
YnVmZmVyLCBzaXplX3Qgc2l6ZSkKK3sKKwlzdHJ1Y3QgYmlvc19hcmdzIGFyZ3MgPSB7CisJCS5h
cmcwID0gYXJnMCwKKwkJLmFyZzEgPSBhcmcxLAorCQkuYXJnMiA9IDAsCisJfTsKKwlzdHJ1Y3Qg
YWNwaV9idWZmZXIgaW5wdXQgPSB7IChhY3BpX3NpemUpIHNpemVvZihhcmdzKSwgJmFyZ3MgfTsK
KwlzdHJ1Y3QgYWNwaV9idWZmZXIgb3V0cHV0ID0geyBBQ1BJX0FMTE9DQVRFX0JVRkZFUiwgTlVM
TCB9OworCWFjcGlfc3RhdHVzIHN0YXR1czsKKwl1bmlvbiBhY3BpX29iamVjdCAqb2JqOworCXUz
MiBpbnRfdG1wID0gMDsKKwlpbnQgZXJyID0gMDsKKworCXN0YXR1cyA9IHdtaV9ldmFsdWF0ZV9t
ZXRob2QoQVNVU19XTUlfTUdNVF9HVUlELCAwLCBtZXRob2RfaWQsCisJCQkJICAgICAmaW5wdXQs
ICZvdXRwdXQpOworCisJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKQorCQlyZXR1cm4gLUVJTzsK
KworCW9iaiA9ICh1bmlvbiBhY3BpX29iamVjdCAqKW91dHB1dC5wb2ludGVyOworCisJaWYgKG9i
aiAmJiBvYmotPnR5cGUgPT0gQUNQSV9UWVBFX0JVRkZFUikgeworCQlpZiAob2JqLT5idWZmZXIu
bGVuZ3RoID4gc2l6ZSkKKwkJCWVyciA9IC1FTk9TUEM7CisJCWlmIChvYmotPmJ1ZmZlci5sZW5n
dGggPT0gMCkKKwkJCWVyciA9IC1FTk9EQVRBOworCQlpZiAoZXJyKSB7CisJCQlrZnJlZShvYmop
OworCQkJcmV0dXJuIGVycjsKKwkJfQorCQltZW1jcHkocmV0X2J1ZmZlciwgb2JqLT5idWZmZXIu
cG9pbnRlciwgb2JqLT5idWZmZXIubGVuZ3RoKTsKKwl9CisKKwlpZiAob2JqICYmIG9iai0+dHlw
ZSA9PSBBQ1BJX1RZUEVfSU5URUdFUikgeworCQlpbnRfdG1wID0gKHUzMilvYmotPmludGVnZXIu
dmFsdWU7CisKKwkJa2ZyZWUob2JqKTsKKwkJaWYgKGludF90bXAgPT0gQVNVU19XTUlfVU5TVVBQ
T1JURURfTUVUSE9EKQorCQkJcmV0dXJuIC1FTk9ERVY7CisJCS8qCisJCSAqIEF0IGxlYXN0IG9u
ZSBtZXRob2QgcmV0dXJucyBhIDAgd2l0aCBubyBidWZmZXIgaWYgbm8gYXJnCisJCSAqIGlzIHBy
b3ZpZGVkLCBzdWNoIGFzIEFTVVNfV01JX0RFVklEX0NQVV9GQU5fQ1VSVkUKKwkJICovCisJCWlm
IChpbnRfdG1wID09IDApCisJCQlyZXR1cm4gLUVOT0RBVEE7CisJCXJldHVybiBpbnRfdG1wOwor
CX0KKworCWtmcmVlKG9iaik7CisKKwlpZiAob2JqID09IE5VTEwpCisJCXJldHVybiAtRU5PREFU
QTsKKworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IGFzdXNfd21pX2V2YWx1YXRlX21ldGhv
ZF9hZ2ZuKGNvbnN0IHN0cnVjdCBhY3BpX2J1ZmZlciBhcmdzKQogewogCXN0cnVjdCBhY3BpX2J1
ZmZlciBpbnB1dDsKQEAgLTIwNDMsNiArMjE2NywzNTcgQEAgc3RhdGljIHNzaXplX3QgZmFuX2Jv
b3N0X21vZGVfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAogLy8gRmFuIGJvb3N0IG1vZGU6IDAg
LSBub3JtYWwsIDEgLSBvdmVyYm9vc3QsIDIgLSBzaWxlbnQKIHN0YXRpYyBERVZJQ0VfQVRUUl9S
VyhmYW5fYm9vc3RfbW9kZSk7CiAKKy8qIEN1c3RvbSBmYW4gY3VydmVzIHBlci1wcm9maWxlICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCisKK3N0YXRpYyB2
b2lkIGluaXRfZmFuX2N1cnZlKHN0cnVjdCBmYW5fY3VydmVfZGF0YSAqZGF0YSwgdTggKmJ1ZikK
K3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBGQU5fQ1VSVkVfUE9JTlRTOyBpKyspCisJ
CWRhdGEtPnRlbXBzW2ldID0gYnVmW2ldOworCisJZm9yIChpID0gMDsgaSA8IEZBTl9DVVJWRV9Q
T0lOVFM7IGkrKykKKwkJZGF0YS0+cGVyY2VudHNbaV0gPSBidWZbaSArIDhdOworfQorCisvKgor
ICogQ2hlY2sgaWYgdGhlIGFiaWxpdHkgdG8gc2V0IGZhbiBjdXJ2ZXMgb24gZWl0aGVyIGZhbiBl
eGlzdHMsIGFuZCBwb3B1bGF0ZQorICogd2l0aCBzeXN0ZW0gZGVmYXVsdHMgdG8gcHJvdmlkZSB1
c2VycyB3aXRoIGEgc3RhcnRpbmcgcG9pbnQuCisgKgorICogImRldiIgaXMgZWl0aGVyIENQVV9G
QU5fQ1VSVkUgb3IgR1BVX0ZBTl9DVVJWRS4KKyAqLworc3RhdGljIGludCBjdXN0b21fZmFuX2No
ZWNrX3ByZXNlbnQoc3RydWN0IGFzdXNfd21pICphc3VzLAorCQkJCSAgICBib29sICphdmFpbGFi
bGUsIHUzMiBkZXYpCit7CisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpjdXJ2ZXM7CisJdTggYnVm
W0ZBTl9DVVJWRV9QT0lOVFMgKiAyXTsKKwlpbnQgZmFuX2lkeCA9IDA7CisJaW50IGVycjsKKwor
CSphdmFpbGFibGUgPSBmYWxzZTsKKwlpZiAoZGV2ID09IEFTVVNfV01JX0RFVklEX0dQVV9GQU5f
Q1VSVkUpCisJCWZhbl9pZHggPSAxOworCisJLyogQmFsYW5jZWQgZGVmYXVsdCAqLworCWN1cnZl
cyA9ICZhc3VzLT50aHJvdHRsZV9mYW5fY3VydmVzCisJCVtBU1VTX1RIUk9UVExFX1RIRVJNQUxf
UE9MSUNZX0RFRkFVTFRdW2Zhbl9pZHhdOworCWVyciA9IGFzdXNfd21pX2V2YWx1YXRlX21ldGhv
ZF9idWYoYXN1cy0+ZHN0c19pZCwgZGV2LCAwLCBidWYsCisJCQkJCUZBTl9DVVJWRV9QT0lOVFMg
KiAyKTsKKwlpZiAoZXJyKSB7CisJCWlmIChlcnIgPT0gLUVOT0RFVikKKwkJCXJldHVybiAwOwor
CQlyZXR1cm4gZXJyOworCX0KKwlpbml0X2Zhbl9jdXJ2ZShjdXJ2ZXMsIGJ1Zik7CisKKwkvKgor
CSAqIFF1aWV0IGRlZmF1bHQuIFRoZSBpbmRleCBudW0gZm9yIEFDUEkgbWV0aG9kIGRvZXMgbm90
IG1hdGNoIHRoZQorCSAqIHRocm90dGxlX3RoZXJtYWwgbnVtYmVyLCBzYW1lIGZvciBQZXJmb3Jt
YW5jZS4KKwkgKi8KKwljdXJ2ZXMgPSAmYXN1cy0+dGhyb3R0bGVfZmFuX2N1cnZlcworCQlbQVNV
U19USFJPVFRMRV9USEVSTUFMX1BPTElDWV9TSUxFTlRdW2Zhbl9pZHhdOworCWVyciA9IGFzdXNf
d21pX2V2YWx1YXRlX21ldGhvZF9idWYoYXN1cy0+ZHN0c19pZCwgZGV2LCAxLCBidWYsCisJCQkJ
CUZBTl9DVVJWRV9QT0lOVFMgKiAyKTsKKwlpZiAoZXJyKSB7CisJCWlmIChlcnIgPT0gLUVOT0RF
VikKKwkJCXJldHVybiAwOworCQlyZXR1cm4gZXJyOworCX0KKwlpbml0X2Zhbl9jdXJ2ZShjdXJ2
ZXMsIGJ1Zik7CisKKwkvKiBQZXJmb3JtYW5jZSBkZWZhdWx0ICovCisJY3VydmVzID0gJmFzdXMt
PnRocm90dGxlX2Zhbl9jdXJ2ZXMKKwkJW0FTVVNfVEhST1RUTEVfVEhFUk1BTF9QT0xJQ1lfT1ZF
UkJPT1NUXVtmYW5faWR4XTsKKwllcnIgPSBhc3VzX3dtaV9ldmFsdWF0ZV9tZXRob2RfYnVmKGFz
dXMtPmRzdHNfaWQsIGRldiwgMiwgYnVmLAorCQkJCQlGQU5fQ1VSVkVfUE9JTlRTICogMik7CisJ
aWYgKGVycikgeworCQlpZiAoZXJyID09IC1FTk9ERVYpCisJCQlyZXR1cm4gMDsKKwkJcmV0dXJu
IGVycjsKKwl9CisJaW5pdF9mYW5fY3VydmUoY3VydmVzLCBidWYpOworCisJKmF2YWlsYWJsZSA9
IHRydWU7CisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiAiZGV2IiBpcyB0aGUgcmVsYXRlZCBXTUkg
bWV0aG9kIHN1Y2ggYXMgQVNVU19XTUlfREVWSURfQ1BVX0ZBTl9DVVJWRS4KKyAqLworc3RhdGlj
IGludCBmYW5fY3VydmVfd3JpdGVfYXJnKHN0cnVjdCBhc3VzX3dtaSAqYXN1cywgdTMyIGRldiwK
KwkJCQlzdHJ1Y3QgZmFuX2N1cnZlX2RhdGEgKmRhdGEpCit7CisJdTMyIGFyZzEgPSAwLCBhcmcy
ID0gMCwgYXJnMyA9IDAsIGFyZzQgPSAwOworCWludCByZXQsIGksIHNoaWZ0ID0gMDsKKworCWZv
ciAoaSA9IDA7IGkgPCBGQU5fQ1VSVkVfUE9JTlRTIC8gMjsgaSsrKSB7CisJCWFyZzEgKz0gZGF0
YS0+dGVtcHNbaV0gPDwgc2hpZnQ7CisJCWFyZzIgKz0gZGF0YS0+dGVtcHNbaSArIDRdIDw8IHNo
aWZ0OworCQlhcmczICs9IGRhdGEtPnBlcmNlbnRzWzBdIDw8IHNoaWZ0OworCQlhcmc0ICs9IGRh
dGEtPnBlcmNlbnRzW2kgKyA0XSA8PCBzaGlmdDsKKwkJc2hpZnQgKz0gODsKKwl9CisKKwlyZXR1
cm4gYXN1c193bWlfZXZhbHVhdGVfbWV0aG9kNShBU1VTX1dNSV9NRVRIT0RJRF9ERVZTLCBkZXYs
CisJCQkJCWFyZzEsIGFyZzIsIGFyZzMsIGFyZzQsICZyZXQpOworfQorCisvKgorICogQ2FsbGVk
IG9ubHkgYnkgdGhyb3R0bGVfdGhlcm1hbF9wb2xpY3lfd3JpdGUoKQorICovCitzdGF0aWMgaW50
IGZhbl9jdXJ2ZV93cml0ZV9kYXRhKHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKK3sKKwlzdHJ1Y3Qg
ZmFuX2N1cnZlX2RhdGEgKmNwdTsKKwlzdHJ1Y3QgZmFuX2N1cnZlX2RhdGEgKmdwdTsKKwlpbnQg
ZXJyLCBtb2RlOworCisJbW9kZSA9IGFzdXMtPnRocm90dGxlX3RoZXJtYWxfcG9saWN5X21vZGU7
CisJY3B1ID0gJmFzdXMtPnRocm90dGxlX2Zhbl9jdXJ2ZXNbbW9kZV1bRkFOX0NVUlZFX0RFVl9D
UFVdOworCWdwdSA9ICZhc3VzLT50aHJvdHRsZV9mYW5fY3VydmVzW21vZGVdW0ZBTl9DVVJWRV9E
RVZfR1BVXTsKKworCWlmIChjcHUtPmVuYWJsZWQpIHsKKwkJZXJyID0gZmFuX2N1cnZlX3dyaXRl
X2FyZyhhc3VzLCBBU1VTX1dNSV9ERVZJRF9DUFVfRkFOX0NVUlZFLCBjcHUpOworCQlpZiAoZXJy
KQorCQkJcmV0dXJuIGVycjsKKwl9CisKKwlpZiAoZ3B1LT5lbmFibGVkKSB7CisJCWVyciA9IGZh
bl9jdXJ2ZV93cml0ZV9hcmcoYXN1cywgQVNVU19XTUlfREVWSURfR1BVX0ZBTl9DVVJWRSwgZ3B1
KTsKKwkJaWYgKGVycikKKwkJCXJldHVybiBlcnI7CisJfQorCisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyBpbnQgZmFuX2N1cnZlX3ZlcmlmeShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJZW51bSBo
d21vbl9zZW5zb3JfdHlwZXMgdHlwZSwgdTMyIGZhbl9kZXYpCit7CisJc3RydWN0IGFzdXNfd21p
ICphc3VzID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJdTggbW9kZSA9IGFzdXMtPnRocm90dGxl
X3RoZXJtYWxfcG9saWN5X21vZGU7CisJc3RydWN0IGZhbl9jdXJ2ZV9kYXRhICpkYXRhOworCXU4
IHRtcCA9IDAsIHByZXZfdG1wID0gMDsKKwlpbnQgaTsKKworCXN3aXRjaCAodHlwZSkgeworCWNh
c2UgaHdtb25fdGVtcDoKKwkJZGF0YSA9ICZhc3VzLT50aHJvdHRsZV9mYW5fY3VydmVzW21vZGVd
W2Zhbl9kZXZdOworCQlicmVhazsKKwljYXNlIGh3bW9uX2ZhbjoKKwkJZGF0YSA9ICZhc3VzLT50
aHJvdHRsZV9mYW5fY3VydmVzW21vZGVdW2Zhbl9kZXZdOworCQlicmVhazsKKwlkZWZhdWx0Ogor
CQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJfQorCisJZm9yIChpID0gMDsgaSA8IEZBTl9DVVJWRV9Q
T0lOVFM7IGkrKykgeworCQl0bXAgPSBkYXRhLT50ZW1wc1tpXTsKKwkJaWYgKHRtcCA8IHByZXZf
dG1wKQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCXByZXZfdG1wID0gdG1wOworCX0KKworCXRtcCA9
IHByZXZfdG1wID0gMDsKKwlmb3IgKGkgPSAwOyBpIDwgRkFOX0NVUlZFX1BPSU5UUzsgaSsrKSB7
CisJCXRtcCA9IGRhdGEtPnBlcmNlbnRzW2ldOworCQlpZiAodG1wIDwgcHJldl90bXApCisJCQly
ZXR1cm4gLUVJTlZBTDsKKwkJcHJldl90bXAgPSB0bXA7CisJfQorCisJcmV0dXJuIDA7Cit9CisK
Ky8qIHJldCBpcyBhIHBvaW50ZXIgdG8gdGhlIHJlcXVlc3RlZCBwcm9maWxlLT5mYW4tPnBvaW50
ICovCitzdGF0aWMgaW50IGZhbl9jdXJ2ZV9wb2ludF9zZWxlY3Qoc3RydWN0IGRldmljZSAqZGV2
LAorCQllbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0eXBlLCBpbnQgcG9pbnQsIHUzMiBmYW5fZGV2
LCB1OCAqKnJldCkKK3sKKwlzdHJ1Y3QgYXN1c193bWkgKmFzdXMgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsKKwl1OCBtb2RlID0gYXN1cy0+dGhyb3R0bGVfdGhlcm1hbF9wb2xpY3lfbW9kZTsKKwor
CXN3aXRjaCAodHlwZSkgeworCWNhc2UgaHdtb25fdGVtcDoKKwkJKnJldCA9ICZhc3VzLT50aHJv
dHRsZV9mYW5fY3VydmVzW21vZGVdW2Zhbl9kZXZdLnRlbXBzW3BvaW50XTsKKwkJYnJlYWs7CisJ
Y2FzZSBod21vbl9mYW46CisJCSpyZXQgPSAmYXN1cy0+dGhyb3R0bGVfZmFuX2N1cnZlc1ttb2Rl
XVtmYW5fZGV2XS5wZXJjZW50c1twb2ludF07CisJCWJyZWFrOworCWNhc2UgaHdtb25faW46CisJ
CSpyZXQgPSAmYXN1cy0+dGhyb3R0bGVfZmFuX2N1cnZlc1ttb2RlXVtmYW5fZGV2XS5lbmFibGVk
OworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJfQorCXJldHVy
biAwOworfQorCitzdGF0aWMgaW50IGFzdXNfZmFuX2N1cnZlX3JlYWQoc3RydWN0IGRldmljZSAq
ZGV2LCBlbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0eXBlLAorCQkJCQlpbnQgcG9pbnQsIGxvbmcg
KnZhbCwgdTMyIGZhbl9kZXYpCit7CisJaW50IGVycjsKKwl1OCAqcmV0OworCisJZXJyID0gZmFu
X2N1cnZlX3BvaW50X3NlbGVjdChkZXYsIHR5cGUsIHBvaW50LCBmYW5fZGV2LCAmcmV0KTsKKwlp
ZiAoZXJyKQorCQlyZXR1cm4gZXJyOworCSp2YWwgPSAqcmV0OworCisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyBpbnQgYXN1c19jcHVfZmFuX2N1cnZlX3JlYWQoc3RydWN0IGRldmljZSAqZGV2LAor
CQllbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0eXBlLCB1MzIgYXR0ciwgaW50IHBvaW50LCBsb25n
ICp2YWwpCit7CisJcmV0dXJuIGFzdXNfZmFuX2N1cnZlX3JlYWQoZGV2LCB0eXBlLCBwb2ludCwg
dmFsLCBGQU5fQ1VSVkVfREVWX0NQVSk7Cit9CisKK3N0YXRpYyBpbnQgYXN1c19ncHVfZmFuX2N1
cnZlX3JlYWQoc3RydWN0IGRldmljZSAqZGV2LAorCQllbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0
eXBlLCB1MzIgYXR0ciwgaW50IHBvaW50LCBsb25nICp2YWwpCit7CisJcmV0dXJuIGFzdXNfZmFu
X2N1cnZlX3JlYWQoZGV2LCB0eXBlLCBwb2ludCwgdmFsLCBGQU5fQ1VSVkVfREVWX0dQVSk7Cit9
CisKKworc3RhdGljIGludCBhc3VzX2Zhbl9jdXJ2ZV93cml0ZShzdHJ1Y3QgZGV2aWNlICpkZXYs
CisJCQkJZW51bSBod21vbl9zZW5zb3JfdHlwZXMgdHlwZSwKKwkJCQl1MzIgYXR0ciwgaW50IHBv
aW50LCBsb25nIHZhbCwgdTMyIGZhbl9kZXYpCit7CisJdTggdmFsdWUsIG9sZF92YWx1ZSwgKnJl
dDsKKwlpbnQgZXJyOworCisJZXJyID0gZmFuX2N1cnZlX3BvaW50X3NlbGVjdChkZXYsIHR5cGUs
IHBvaW50LCBmYW5fZGV2LCAmcmV0KTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gZXJyOworCisJdmFs
dWUgPSAqcmV0OworCW9sZF92YWx1ZSA9IHZhbHVlOworCWlmICh0eXBlID09IGh3bW9uX3RlbXAp
CisJCXZhbHVlID0gMTAwICogdmFsdWUgLyAyNTU7CisKKwkvKiBUaGUgY2hlY2sgaGVyZSBmb3Jj
ZXMgd3JpdGluZyBhIGN1cnZlIGdyYXBoIGluIHJldmVyc2UgZm9yIHNhZmV0eSAqLworCWVyciA9
IGZhbl9jdXJ2ZV92ZXJpZnkoZGV2LCB0eXBlLCBmYW5fZGV2KTsKKwlpZiAoZXJyKSB7CisJCXN3
aXRjaCAodHlwZSkgeworCQljYXNlIGh3bW9uX3RlbXA6CisJCQlkZXZfZXJyKGRldiwgImEgZmFu
IGN1cnZlIHRlbXBlcmF0dXJlIHdhcyBoaWdoZXIgdGhhbiB0aGUgbmV4dCBpbiBzZXF1ZW5jZVxu
Iik7CisJCQkqcmV0ID0gb2xkX3ZhbHVlOworCQkJYnJlYWs7CisJCWNhc2UgaHdtb25fZmFuOgor
CQkJZGV2X2VycihkZXYsICJhIGZhbiBjdXJ2ZSBwZXJjZW50YWdlIHdhcyBoaWdoZXIgdGhhbiB0
aGUgbmV4dCBpbiBzZXF1ZW5jZVxuIik7CisJCQkqcmV0ID0gb2xkX3ZhbHVlOworCQkJYnJlYWs7
CisJCWRlZmF1bHQ6CisJCQlicmVhazsKKwkJfQorCQlyZXR1cm4gZXJyOworCX0KKworCXJldHVy
biAwOworfQorCitzdGF0aWMgaW50IGFzdXNfY3B1X2Zhbl9jdXJ2ZV93cml0ZShzdHJ1Y3QgZGV2
aWNlICpkZXYsCisJCWVudW0gaHdtb25fc2Vuc29yX3R5cGVzIHR5cGUsIHUzMiBhdHRyLCBpbnQg
cG9pbnQsIGxvbmcgdmFsKQoreworCXJldHVybiBhc3VzX2Zhbl9jdXJ2ZV93cml0ZShkZXYsIHR5
cGUsIGF0dHIsIHBvaW50LCB2YWwsIEZBTl9DVVJWRV9ERVZfQ1BVKTsKK30KKworc3RhdGljIGlu
dCBhc3VzX2dwdV9mYW5fY3VydmVfd3JpdGUoc3RydWN0IGRldmljZSAqZGV2LAorCQllbnVtIGh3
bW9uX3NlbnNvcl90eXBlcyB0eXBlLCB1MzIgYXR0ciwgaW50IHBvaW50LCBsb25nIHZhbCkKK3sK
KwlyZXR1cm4gYXN1c19mYW5fY3VydmVfd3JpdGUoZGV2LCB0eXBlLCBhdHRyLCBwb2ludCwgdmFs
LCBGQU5fQ1VSVkVfREVWX0dQVSk7Cit9CisKK3N0YXRpYyB1bW9kZV90IGFzdXNfY3B1X2Zhbl9j
dXJ2ZV9pc192aXNpYmxlKGNvbnN0IHZvaWQgKmRhdGEsCisJCWVudW0gaHdtb25fc2Vuc29yX3R5
cGVzIHR5cGUsIHUzMiBhdHRyLCBpbnQgcG9pbnQpCit7CisJY29uc3Qgc3RydWN0IGFzdXNfd21p
ICphc3VzID0gZGF0YTsKKworCWlmIChhc3VzLT5jcHVfZmFuX2N1cnZlX2F2YWlsYWJsZSkKKwkJ
cmV0dXJuIDA2NDQ7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB1bW9kZV90IGFzdXNfZ3B1X2Zh
bl9jdXJ2ZV9pc192aXNpYmxlKGNvbnN0IHZvaWQgKmRhdGEsCisJCQllbnVtIGh3bW9uX3NlbnNv
cl90eXBlcyB0eXBlLCB1MzIgYXR0ciwgaW50IHBvaW50KQoreworCWNvbnN0IHN0cnVjdCBhc3Vz
X3dtaSAqYXN1cyA9IGRhdGE7CisKKwlpZiAoYXN1cy0+Z3B1X2Zhbl9jdXJ2ZV9hdmFpbGFibGUp
CisJCXJldHVybiAwNjQ0OworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGh3
bW9uX29wcyBhc3VzX2NwdV9mYW5fY3VydmVfb3BzID0geworCS5pc192aXNpYmxlID0gYXN1c19j
cHVfZmFuX2N1cnZlX2lzX3Zpc2libGUsCisJLnJlYWQgPSBhc3VzX2NwdV9mYW5fY3VydmVfcmVh
ZCwKKwkud3JpdGUgPSBhc3VzX2NwdV9mYW5fY3VydmVfd3JpdGUsCit9OworCitzdGF0aWMgY29u
c3Qgc3RydWN0IGh3bW9uX29wcyBhc3VzX2dwdV9mYW5fY3VydmVfb3BzID0geworCS5pc192aXNp
YmxlID0gYXN1c19ncHVfZmFuX2N1cnZlX2lzX3Zpc2libGUsCisJLnJlYWQgPSBhc3VzX2dwdV9m
YW5fY3VydmVfcmVhZCwKKwkud3JpdGUgPSBhc3VzX2dwdV9mYW5fY3VydmVfd3JpdGUsCit9Owor
CisvKiBDaGFubmVsIG51bWJlciBkZXRlcm1pbmVzIENQVSBvciBHUFUsIDAtMSA9IENQVSAqLwor
c3RhdGljIGNvbnN0IHN0cnVjdCBod21vbl9jaGFubmVsX2luZm8gKmFzdXNfZmFuX2N1cnZlX2lu
Zm9bXSA9IHsKKwlIV01PTl9DSEFOTkVMX0lORk8odGVtcCwKKwkJSFdNT05fVF9JTlBVVCwgSFdN
T05fVF9JTlBVVCwgSFdNT05fVF9JTlBVVCwgSFdNT05fVF9JTlBVVCwKKwkJSFdNT05fVF9JTlBV
VCwgSFdNT05fVF9JTlBVVCwgSFdNT05fVF9JTlBVVCwgSFdNT05fVF9JTlBVVCksCisJSFdNT05f
Q0hBTk5FTF9JTkZPKGZhbiwKKwkJSFdNT05fRl9JTlBVVCwgSFdNT05fRl9JTlBVVCwgSFdNT05f
Rl9JTlBVVCwgSFdNT05fRl9JTlBVVCwKKwkJSFdNT05fRl9JTlBVVCwgSFdNT05fRl9JTlBVVCwg
SFdNT05fRl9JTlBVVCwgSFdNT05fRl9JTlBVVCksCisJSFdNT05fQ0hBTk5FTF9JTkZPKGluLCBI
V01PTl9JX0VOQUJMRSksCisJTlVMTAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBod21vbl9j
aGlwX2luZm8gYXN1c19jcHVfZmFuX2N1cnZlX2NoaXBfaW5mbyA9IHsKKwkub3BzID0gJmFzdXNf
Y3B1X2Zhbl9jdXJ2ZV9vcHMsCisJLmluZm8gPSBhc3VzX2Zhbl9jdXJ2ZV9pbmZvLAorfTsKKwor
c3RhdGljIGNvbnN0IHN0cnVjdCBod21vbl9jaGlwX2luZm8gYXN1c19ncHVfZmFuX2N1cnZlX2No
aXBfaW5mbyA9IHsKKwkub3BzID0gJmFzdXNfZ3B1X2Zhbl9jdXJ2ZV9vcHMsCisJLmluZm8gPSBh
c3VzX2Zhbl9jdXJ2ZV9pbmZvLAorfTsKKworc3RhdGljIGludCBhc3VzX3dtaV9mYW5fY3VydmVf
aW5pdChzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCit7CisJc3RydWN0IGRldmljZSAqZGV2ID0gJmFz
dXMtPnBsYXRmb3JtX2RldmljZS0+ZGV2OworCXN0cnVjdCBkZXZpY2UgKmh3bW9uOworCWludCBl
cnI7CisKKwllcnIgPSBjdXN0b21fZmFuX2NoZWNrX3ByZXNlbnQoYXN1cywKKwkJJmFzdXMtPmNw
dV9mYW5fY3VydmVfYXZhaWxhYmxlLCBBU1VTX1dNSV9ERVZJRF9DUFVfRkFOX0NVUlZFKTsKKwlp
ZiAoZXJyKQorCQlyZXR1cm4gZXJyOworCisJZXJyID0gY3VzdG9tX2Zhbl9jaGVja19wcmVzZW50
KGFzdXMsCisJCSZhc3VzLT5ncHVfZmFuX2N1cnZlX2F2YWlsYWJsZSwgQVNVU19XTUlfREVWSURf
R1BVX0ZBTl9DVVJWRSk7CisJaWYgKGVycikKKwkJcmV0dXJuIGVycjsKKworCWh3bW9uID0gaHdt
b25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhfaW5mbyhkZXYsCisJCQkJCSJhc3VzX2NwdV9mYW5fY3Vz
dG9tX2N1cnZlIiwgYXN1cywKKwkJCQkJJmFzdXNfY3B1X2Zhbl9jdXJ2ZV9jaGlwX2luZm8sIE5V
TEwpOworCisJaWYgKElTX0VSUihod21vbikpIHsKKwkJZGV2X2VycihkZXYsICJDb3VsZCBub3Qg
cmVnaXN0ZXIgYXN1c19jcHVfZmFuX2N1cnZlIGRldmljZVxuIik7CisJCXJldHVybiBQVFJfRVJS
KGh3bW9uKTsKKwl9CisKKwlod21vbiA9IGh3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8o
ZGV2LAorCQkJCQkiYXN1c19ncHVfZmFuX2N1c3RvbV9jdXJ2ZSIsIGFzdXMsCisJCQkJCSZhc3Vz
X2dwdV9mYW5fY3VydmVfY2hpcF9pbmZvLCBOVUxMKTsKKworCWlmIChJU19FUlIoaHdtb24pKSB7
CisJCWRldl9lcnIoZGV2LCAiQ291bGQgbm90IHJlZ2lzdGVyIGFzdXNfY3B1X2Zhbl9jdXJ2ZSBk
ZXZpY2VcbiIpOworCQlyZXR1cm4gUFRSX0VSUihod21vbik7CisJfQorCisJcmV0dXJuIDA7Cit9
CisKIC8qIFRocm90dGxlIHRoZXJtYWwgcG9saWN5ICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKiovCiAKIHN0YXRpYyBpbnQgdGhyb3R0bGVfdGhlcm1h
bF9wb2xpY3lfY2hlY2tfcHJlc2VudChzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCkBAIC0yMDUzLDgg
KzI1MjgsOCBAQCBzdGF0aWMgaW50IHRocm90dGxlX3RoZXJtYWxfcG9saWN5X2NoZWNrX3ByZXNl
bnQoc3RydWN0IGFzdXNfd21pICphc3VzKQogCWFzdXMtPnRocm90dGxlX3RoZXJtYWxfcG9saWN5
X2F2YWlsYWJsZSA9IGZhbHNlOwogCiAJZXJyID0gYXN1c193bWlfZ2V0X2RldnN0YXRlKGFzdXMs
Ci0JCQkJICAgIEFTVVNfV01JX0RFVklEX1RIUk9UVExFX1RIRVJNQUxfUE9MSUNZLAotCQkJCSAg
ICAmcmVzdWx0KTsKKwkJQVNVU19XTUlfREVWSURfVEhST1RUTEVfVEhFUk1BTF9QT0xJQ1ksCisJ
CSZyZXN1bHQpOwogCWlmIChlcnIpIHsKIAkJaWYgKGVyciA9PSAtRU5PREVWKQogCQkJcmV0dXJu
IDA7CkBAIC0yMDkyLDYgKzI1NjcsMTIgQEAgc3RhdGljIGludCB0aHJvdHRsZV90aGVybWFsX3Bv
bGljeV93cml0ZShzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCiAJCXJldHVybiAtRUlPOwogCX0KIAor
CWlmIChhc3VzLT5jcHVfZmFuX2N1cnZlX2F2YWlsYWJsZSB8fCBhc3VzLT5ncHVfZmFuX2N1cnZl
X2F2YWlsYWJsZSkgeworCQllcnIgPSBmYW5fY3VydmVfd3JpdGVfZGF0YShhc3VzKTsKKwkJaWYg
KGVycikKKwkJCXJldHVybiBlcnI7CisJfQorCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTI5MDQsNyAr
MzM4NSw3IEBAIHN0YXRpYyBpbnQgc2hvd19jYWxsKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAq
ZGF0YSkKIAlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpCiAJCXJldHVybiAtRUlPOwogCi0Jb2Jq
ID0gKHVuaW9uIGFjcGlfb2JqZWN0ICopb3V0cHV0LnBvaW50ZXI7CisJb2JqID0gb3V0cHV0LnBv
aW50ZXI7CiAJaWYgKG9iaiAmJiBvYmotPnR5cGUgPT0gQUNQSV9UWVBFX0lOVEVHRVIpCiAJCXNl
cV9wcmludGYobSwgIiUjeCglI3gsICUjeCkgPSAlI3hcbiIsIGFzdXMtPmRlYnVnLm1ldGhvZF9p
ZCwKIAkJCSAgIGFzdXMtPmRlYnVnLmRldl9pZCwgYXN1cy0+ZGVidWcuY3RybF9wYXJhbSwKQEAg
LTMwMzgsNiArMzUxOSwxMCBAQCBzdGF0aWMgaW50IGFzdXNfd21pX2FkZChzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQogCWlmIChlcnIpCiAJCWdvdG8gZmFpbF9od21vbjsKIAorCWVyciA9
IGFzdXNfd21pX2Zhbl9jdXJ2ZV9pbml0KGFzdXMpOworCWlmIChlcnIpCisJCWdvdG8gZmFpbF9j
dXN0b21fZmFuX2N1cnZlOworCiAJZXJyID0gYXN1c193bWlfbGVkX2luaXQoYXN1cyk7CiAJaWYg
KGVycikKIAkJZ290byBmYWlsX2xlZHM7CkBAIC0zMTA5LDYgKzM1OTQsNyBAQCBzdGF0aWMgaW50
IGFzdXNfd21pX2FkZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWFzdXNfd21pX3N5
c2ZzX2V4aXQoYXN1cy0+cGxhdGZvcm1fZGV2aWNlKTsKIGZhaWxfc3lzZnM6CiBmYWlsX3Rocm90
dGxlX3RoZXJtYWxfcG9saWN5OgorZmFpbF9jdXN0b21fZmFuX2N1cnZlOgogZmFpbF9wbGF0Zm9y
bV9wcm9maWxlX3NldHVwOgogCWlmIChhc3VzLT5wbGF0Zm9ybV9wcm9maWxlX3N1cHBvcnQpCiAJ
CXBsYXRmb3JtX3Byb2ZpbGVfcmVtb3ZlKCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Bs
YXRmb3JtX2RhdGEveDg2L2FzdXMtd21pLmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEv
eDg2L2FzdXMtd21pLmgKaW5kZXggMTdkYzVjYjZmM2YyLi5hNTcxYjQ3ZmYzNjIgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS94ODYvYXN1cy13bWkuaAorKysgYi9pbmNs
dWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEveDg2L2FzdXMtd21pLmgKQEAgLTc3LDYgKzc3LDggQEAK
ICNkZWZpbmUgQVNVU19XTUlfREVWSURfVEhFUk1BTF9DVFJMCTB4MDAxMTAwMTEKICNkZWZpbmUg
QVNVU19XTUlfREVWSURfRkFOX0NUUkwJCTB4MDAxMTAwMTIgLyogZGVwcmVjYXRlZCAqLwogI2Rl
ZmluZSBBU1VTX1dNSV9ERVZJRF9DUFVfRkFOX0NUUkwJMHgwMDExMDAxMworI2RlZmluZSBBU1VT
X1dNSV9ERVZJRF9DUFVfRkFOX0NVUlZFCTB4MDAxMTAwMjQKKyNkZWZpbmUgQVNVU19XTUlfREVW
SURfR1BVX0ZBTl9DVVJWRQkweDAwMTEwMDI1CiAKIC8qIFBvd2VyICovCiAjZGVmaW5lIEFTVVNf
V01JX0RFVklEX1BST0NFU1NPUl9TVEFURQkweDAwMTIwMDEyCi0tIAoyLjMxLjEKCn==

--=-YJCDSKO/ilfhnZq6XSKz--


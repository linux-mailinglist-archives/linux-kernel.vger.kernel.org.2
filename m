Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA973FA416
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhH1G5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 02:57:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50369 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233088AbhH1G52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 02:57:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C5E45C00EE;
        Sat, 28 Aug 2021 02:56:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 28 Aug 2021 02:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=bsesDEfBRIBGjlN9fmv8V76YVUHoahubMNaMQqDIU
        s8=; b=bx9mliEBznqrVIOXAlpo4wIQdQZHaN2xVtYlRcHOpJLmlyrCriTqTW2UU
        bZCMG92RD2GTD1rXz2RfcCkgsb9hRXKW3UcfAmsgykjwQao3TIvg4SFvy8Dqo1IA
        25dFW1onfaCydBKxmLykmZdfkHqlO2ZTGiqa2o9IVKuuXIZajyE+jafeWYFzU8/n
        oZgI8aiHHVnWU7TL4gdt+64CddRqWPu+/tEbRu4a2yuClLiKXS2lv20Jl1Z+1v/s
        //VSRjzRkZeNEeeem3XXo4kMGG0DmzTgI7ha9U6kEl03PLLanRiNV2+ZfTivK8kG
        cXjPwh/eyfSzmrnuptXKoRigfYSHQ==
X-ME-Sender: <xms:JN4pYeph-lzJC9HGkaodgWGDQrFtJkgk3emA7EM_87gtWy2e4r8_4w>
    <xme:JN4pYcoIQgKkSl96KMl7P7YrX5i6YUv4YTmxw7B-nC9ZJb5QM8SfgEio4wphttiSA
    oWVxFM3RFzQdrUMGdU>
X-ME-Received: <xmr:JN4pYTOSm4eOcGSu9TOhNAV3InWGq901ASRpR598fhjWIH5Hdv5IabNT1WjvsR_QXjcArQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddugedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtgfesth
    hqredtredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepkeevffeiheeuleegleetveelhedutefhhf
    egffetvedtfefgleelgeetleekgfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:JN4pYd59fsjkdDnxjZsd5fNiIoyr4EQWNfTnvxhZ87N2emHVcJ6Jnw>
    <xmx:JN4pYd7P3Ms9Y-l0i7U6PYKkFH5_pNUJovHghYkFGlSYrGd9uVUD6g>
    <xmx:JN4pYdiRVNWo7Yyua-RBXALpSTGn5PuQMhaGxHI7r8FJiR-UnCPWVA>
    <xmx:Jd4pYXlaXCj2QgYHairOz88IYcWC6M-Wj9h-DIoEiOWyi8qWK9oUkA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Aug 2021 02:56:29 -0400 (EDT)
Date:   Sat, 28 Aug 2021 18:56:13 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v5] asus-wmi: Add support for custom fan curves
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-Id: <P9FJYQ.MFQ4LNL2O0AY@ljones.dev>
In-Reply-To: <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
References: <20210826234259.5980-1-luke@ljones.dev>
        <20210826234259.5980-2-luke@ljones.dev>
        <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnab=E1s,

Many thanks for the quality feedback. I'll try to address some of the=20
comments you have and then begin work on changes to suit. I feel it is=20
necessary to be clear that C is not a language I'm comfortable in (I=20
use Rust 90% of the time) and so I rely on feedback such as what you've=20
provided to ensure I'm on the right track.

Okay, so I refactored according to your feedback and the result is a=20
pretty different V6 (will submit soon).

On Fri, Aug 27 2021 at 15:26:11 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
> +CC Guenter Roeck as he may be able to tell us if there's an=20
> established
> way to export fan curves.
>=20
> I have added a couple comments.
> There are places where spaces are used instead of tabs.
>=20
>=20
> 2021. augusztus 27., p=E9ntek 1:42 keltez=E9ssel, Luke D. Jones =EDrta:
>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>=20
>>  These laptops have the ability to set a custom curve for the CPU
>>  and GPU fans via an ACPI method call. This patch enables this,
>>  additionally enabling custom fan curves per-profile, where profile
>>  here means each of the 3 levels of "throttle_thermal_policy".
>>=20
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 616=20
>> ++++++++++++++++++++-
>>   include/linux/platform_data/x86/asus-wmi.h |   2 +
>>   2 files changed, 616 insertions(+), 2 deletions(-)
>>=20
>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>> b/drivers/platform/x86/asus-wmi.c
>>  index cc5811844012..944644ae0acd 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -108,6 +108,11 @@ module_param(fnlock_default, bool, 0444);
>>=20
>>   static const char * const ashs_ids[] =3D { "ATK4001", "ATK4002",=20
>> NULL };
>>=20
>>  +static int throttle_thermal_policy_write(struct asus_wmi*);
>>  +static ssize_t fan_curve_store(struct asus_wmi *asus, const char=20
>> *buf,
>>  +								size_t count, u32 dev, char **curve,
>>  +								char *default_curve);
>>  +
>>   static bool ashs_present(void)
>>   {
>>   	int i =3D 0;
>>  @@ -122,7 +127,8 @@ struct bios_args {
>>   	u32 arg0;
>>   	u32 arg1;
>>   	u32 arg2; /* At least TUF Gaming series uses 3 dword input=20
>> buffer. */
>>  -	u32 arg4;
>>  +	u32 arg3;
>>  +	u32 arg4; /* Some ROG laptops require a full 5 input args */
>>   	u32 arg5;
>>   } __packed;
>>=20
>>  @@ -173,6 +179,21 @@ enum fan_type {
>>   	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
>>   };
>>=20
>>  +struct fan_curve {
>>  +	char *balanced;
>>  +	char *balanced_default;
>>  +	char *performance;
>>  +	char *performance_default;
>>  +	char *quiet;
>>  +	char *quiet_default;
>>  +};
>>  +
>>  +struct enabled_fan_curves {
>>  +	bool balanced;
>>  +	bool performance;
>>  +	bool quiet;
>>  +};
>>  +
>>   struct asus_wmi {
>>   	int dsts_id;
>>   	int spec;
>>  @@ -220,6 +241,14 @@ struct asus_wmi {
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>>=20
>>  +	bool cpu_fan_curve_available;
>>  +	struct fan_curve cpu_fan_curve;
>>  +
>>  +    bool gpu_fan_curve_available;
>>  +	struct fan_curve gpu_fan_curve;
>>  +
>>  +	struct enabled_fan_curves enabled_fan_curve_profiles;
>=20
> I would suggest something like the following:
>=20
>   struct fan_curve {
>     /* bool enabled; */
>     u8 temps[FAN_CURVE_SIZE];
>     u8 percents[FAN_CURVE_SIZE];
>   };
>=20
>   struct fan {
>     bool available;
>     struct fan_curve curves[NUM_PERF_PROFILES];
>   };
>=20
>   struct asus_wmi {
>     ...
>=20
>     struct fan fans[NUM_FANS];
>=20
>     bool fan_curve_enabled_for_profile[NUM_PERF_PROFILES];
>     /* or maybe you could add it as `bool enabled;` into the inner=20
> struct */
>   };
>=20
> see the reason later.

I initially started doing something like this but took current path for=20
a reason I don't remember. Might have been personal preference to be=20
more explicit. However I will use what you've suggested here, paired=20
with an enum for the 3 profiles so they are named. There are only 3=20
possible profiles due to curves paired with throttle_thermal_policy in=20
the related platform_profile patch.

>=20
>=20
>>  +
>>   	struct platform_profile_handler platform_profile_handler;
>>   	bool platform_profile_support;
>>=20
>>  @@ -285,6 +314,85 @@ int asus_wmi_evaluate_method(u32 method_id,=20
>> u32 arg0, u32 arg1, u32 *retval)
>>   }
>>   EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
>>=20
>>  +static int asus_wmi_evaluate_method5(u32 method_id,
>>  +		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
>>  +{
>>  +	struct bios_args args =3D {
>>  +		.arg0 =3D arg0,
>>  +		.arg1 =3D arg1,
>>  +		.arg2 =3D arg2,
>>  +		.arg3 =3D arg3,
>>  +		.arg4 =3D arg4,
>>  +	};
>>  +	struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
>>  +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>  +	acpi_status status;
>>  +	union acpi_object *obj;
>>  +	u32 tmp =3D 0;
>>  +
>>  +	status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>>  +				     &input, &output);
>>  +
>>  +	if (ACPI_FAILURE(status))
>>  +		return -EIO;
>>  +
>>  +	obj =3D (union acpi_object *)output.pointer;
>=20
> Small thing, but this cast is unnecessary.

Copy/paste from asus_wmi_evaluate_method3(). There are 3 other examples=20
of that. Being unfamiliar with many things I tend to read the source to=20
find examples of what I want to achieve. In either case, I'll update=20
this.

>=20
>=20
>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
>>  +		tmp =3D (u32) obj->integer.value;
>=20
> Same here.

Also from asus_wmi_evaluate_method3()

>=20
>=20
>>  +
>>  +	if (retval)
>>  +		*retval =3D tmp;
>>  +
>>  +	kfree(obj);
>>  +
>>  +	if (tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
>>  +		return -ENODEV;
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +/*
>>  + * Returns as an error if the method output is not a buffer.=20
>> Typically this
>>  + * means that the method called is unsupported.
>>  +*/
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
>>  +	}
>>  +
>>  +	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
>>  +		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>  +	}
>>  +
>>  +	kfree(obj);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>   static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer=20
>> args)
>>   {
>>   	struct acpi_buffer input;
>>  @@ -1813,7 +1921,7 @@ static ssize_t fan1_label_show(struct device=20
>> *dev,
>>   					  struct device_attribute *attr,
>>   					  char *buf)
>>   {
>>  -	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
>>  +	return sprintf(buf, "%s", ASUS_FAN_DESC);
>=20
> What is the reason for this change?

Oops... No reason at all. Not quite sure how that happened, will revert.

>=20
>=20
>>   }
>>=20
>>   static ssize_t asus_hwmon_temp1(struct device *dev,
>>  @@ -2043,6 +2151,458 @@ static ssize_t fan_boost_mode_store(struct=20
>> device *dev,
>>   // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>>   static DEVICE_ATTR_RW(fan_boost_mode);
>>=20
>>  +/* Custom fan curves per-profile=20
>> **********************************************/
>>  +
>>  +/*
>>  + * Check if the ability to set fan curves on either fan exists,=20
>> and store the
>>  + * defaults for recall later plus to provide users with a starting=20
>> point.
>>  + *
>>  + * "dev" is either CPU_FAN_CURVE or GPU_FAN_CURVE.
>>  +*/
>>  +static int custom_fan_check_present(struct asus_wmi *asus,
>>  +									bool *available, u32 dev)
>>  +{
>>  +	struct fan_curve *curves =3D &asus->cpu_fan_curve;
>>  +	u8 *buf =3D kzalloc(16 * sizeof(u8), GFP_KERNEL);
>=20
> Is dynamic allocation needed here? No early return frees it.

Oh. Just me forgetting how to declare an array and doing something=20
silly. Fixed with u8 buf[16];

>=20
>=20
>>  +	/* 15 punctuation marks + 16 sets of numbers up to 3 char each */
>>  +	int str_len =3D 15 + 16 * 3;
>=20
> It appears to me that the terminating null byte is not accounted for.=20
> E.g.:
>=20
>   255:255,255:255,255:255,255:255,255:255,255:255,255:255,255:255
>=20
> is itself already 63 (=3D 15 + 16 x 3) characters.
>=20
> And if the maximum length is known, and it's reasonably small, why is=20
> it not
> part of the struct as a char array? E.g.:
>=20
>   struct fan_curve {
>     char balanced[FAN_CURVE_STR_SIZE]; /* #define FAN_CURVE_STR_SIZE=20
> 64 */
>     ...
>   };
>=20
> I would actually suggest storing the u8 array itself in the fan curve=20
> struct,
> and not a string representation of it. I think the data is easier to=20
> deal with
> that way, and the price of formatting it for the sysfs attribute is=20
> not
> significant.

Yeah I've gone and done it so that the u8 array is stored now.=20
Certainly easier to manage.

>=20
>=20
>>  +	int err;
>>  +
>>  +	*available =3D false;
>>  +
>>  +	if (dev =3D=3D ASUS_WMI_DEVID_GPU_FAN_CURVE)
>>  +		curves =3D &asus->gpu_fan_curve;
>>  +
>>  +	/* Balanced default */
>>  +	err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, buf);
>>  +	if (err) {
>>  +		if (err =3D=3D -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	curves->balanced =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
>>  +	if (!curves->balanced)
>>  +		return -ENOMEM;
>>  +
>>  +	curves->balanced_default =3D kzalloc(str_len * sizeof(char),=20
>> GFP_KERNEL);
>>  +	if (!curves->balanced_default)
>>  +		return -ENOMEM;
>>  +
>>  +	sprintf(curves->balanced,=20
>> "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>>  +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7],=20
>> buf[15]);
>>  +	sprintf(curves->balanced_default, curves->balanced);
>>  +
>>  +	/* Quiet default */
>>  +	err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, buf);
>>  +	if (err) {
>>  +		if (err =3D=3D -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	curves->quiet =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
>>  +	if (!curves->quiet)
>>  +		return -ENOMEM;
>>  +
>>  +	curves->quiet_default =3D kzalloc(str_len * sizeof(char),=20
>> GFP_KERNEL);
>>  +	if (!curves->quiet_default)
>>  +		return -ENOMEM;
>>  +
>>  +	sprintf(curves->quiet,=20
>> "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>>  +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7],=20
>> buf[15]);
>>  +	sprintf(curves->quiet_default, curves->quiet);
>>  +
>>  +	/* Performance default */
>>  +	err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, buf);
>>  +	if (err) {
>>  +		if (err =3D=3D -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	curves->performance =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
>>  +	if (!curves->performance)
>>  +		return -ENOMEM;
>>  +
>>  +	curves->performance_default =3D kzalloc(str_len * sizeof(char),=20
>> GFP_KERNEL);
>>  +	if (!curves->performance_default)
>>  +		return -ENOMEM;
>>  +
>>  +	sprintf(curves->performance,
>>  +		"%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>>  +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7],=20
>> buf[15]);
>>  +	sprintf(curves->performance_default, curves->performance);
>=20
> More or less the same code is repeated three times, I'd consider=20
> adding an e.g.
>=20
>   void fan_curve_to_str(..., char[static FAN_CURVE_STR_SIZE]);
>=20
> function.

I guess this part is moot now that the data is stored as u8 array now.

>=20
>=20
>>  +
>>  +	kfree(buf);
>>  +
>>  +	*available =3D true;
>>  +	return 0;
>>  +}
>>  +
>>  +/*
>>  + * The expected input is of the format
>>  + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
>>  + * where a pair is 30:1, with 30 =3D temperature, and 1 =3D percentage
>>  +*/
>>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char=20
>> *curve)
>>  +{
>>  +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
>>  +    int err, ret;
>>  +
>>  +	char *set_delimiter =3D ",";
>>  +	char *pair_delimiter =3D ":";
>>  +	bool half_complete =3D false;
>>  +	bool pair_start =3D true;
>>  +	u32 prev_percent =3D 0;
>>  +	u32 prev_temp =3D 0;
>>  +	u32 percent =3D 0;
>>  +	u32 shift =3D 0;
>>  +	u32 temp =3D 0;
>>  +    u32 arg1 =3D 0;
>>  +    u32 arg2 =3D 0;
>>  +    u32 arg3 =3D 0;
>>  +    u32 arg4 =3D 0;
>>  +
>>  +    buf =3D set_end =3D pair_end =3D kstrdup(curve, GFP_KERNEL);
>>  +
>>  +	while( (set =3D strsep(&set_end, set_delimiter)) !=3D NULL ) {
>>  +		pair_tmp =3D kstrdup(set, GFP_KERNEL);
>>  +        pair_start =3D true;
>>  +		while( (pair =3D strsep(&pair_tmp, pair_delimiter)) !=3D NULL ) {
>>  +			err =3D kstrtouint(pair, 10, &ret);
>>  +            if (err) {
>>  +                kfree(pair_tmp);
>>  +                kfree(buf);
>>  +                return err;
>>  +            }
>>  +
>>  +            if (pair_start) {
>>  +                temp =3D ret;
>>  +                pair_start =3D false;
>>  +            } else {
>>  +                percent =3D ret;
>>  +            }
>>  +		}
>>  +		kfree(pair_tmp);
>>  +
>>  +		if (temp < prev_temp || percent < prev_percent || percent > 100)=20
>> {
>>  +            pr_info("Fan curve invalid");
>>  +			pr_info("A value is sequentially lower or percentage is > 100");
>>  +            kfree(buf);
>>  +            return -EINVAL;
>>  +        }
>>  +
>>  +        prev_temp =3D temp;
>>  +        prev_percent =3D percent;
>>  +
>>  +        if (!half_complete) {
>>  +            arg1 +=3D temp << shift;
>>  +            arg3 +=3D percent << shift;
>>  +        } else {
>>  +            arg2 +=3D temp << shift;
>>  +            arg4 +=3D percent << shift;
>>  +        }
>=20
> As far as I see using 64-bit integers would avoid the need for=20
> `half_complete`, et al.

Reworked all that as part of the u8-array stuff. Look forward to seeing=20
what you think.

>=20
>=20
>>  +        shift +=3D 8;
>>  +
>>  +        if (shift =3D=3D 32) {
>>  +            shift =3D 0;
>>  +            half_complete =3D true;
>>  +        }
>>  +	}
>>  +	kfree(buf);
>>  +
>=20
> If you don't insist on using commas, I think it is much simpler to
> parse it using `sscanf()`, e.g.:
>=20
>   unsigned int temp, prct;
>   int at =3D 0, len;
>=20
>   while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
>     /* process `temp` and `prct` */
>=20
>     at +=3D len;
>   }
>=20
>   if (buf[at] !=3D '\0')
>     /* error */;
>=20
> This also has the advantage that you don't need dynamic memory=20
> allocation.

Half the reason I did it in the format of 10:20,30:40,.. is to keep=20
close to a format that many people using some external tools for fan=20
curves (using acpi_call modue!) are using. I'm open to improvements ofc.

>=20
>=20
>>  +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
>>  +									 arg1, arg2, arg3, arg4, &ret);
>>  +}
>>  +
>>  +static int fan_curve_cpu_write(struct asus_wmi *asus)
>>  +{
>>  +	char *curve =3D NULL;
>>  +	int err, mode;
>>  +
>>  +	mode =3D asus->throttle_thermal_policy_mode;
>>  +
>>  +	if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>>  +					&& asus->enabled_fan_curve_profiles.balanced) {
>>  +		curve =3D asus->cpu_fan_curve.balanced;
>>  +	} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>>  +					&& asus->enabled_fan_curve_profiles.performance) {
>>  +		curve =3D asus->cpu_fan_curve.performance;
>>  +	} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_SILENT
>>  +					&& asus->enabled_fan_curve_profiles.quiet) {
>>  +		curve =3D asus->cpu_fan_curve.quiet;
>>  +	}
>>  +
>>  +	if (curve !=3D NULL) {
>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, curve);
>>  +		if (err)
>>  +			return err;
>>  +	}
>>  +	return 0;
>>  +}
>>  +
>>  +
>>  +static int fan_curve_gpu_write(struct asus_wmi *asus)
>>  +{
>>  +	char *curve =3D NULL;
>>  +	int err, mode;
>>  +
>>  +	mode =3D asus->throttle_thermal_policy_mode;
>>  +
>>  +	if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>>  +					&& asus->enabled_fan_curve_profiles.balanced) {
>>  +		curve =3D asus->gpu_fan_curve.balanced;
>>  +	} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>>  +					&& asus->enabled_fan_curve_profiles.performance) {
>>  +		curve =3D asus->gpu_fan_curve.performance;
>>  +	} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_SILENT
>>  +					&& asus->enabled_fan_curve_profiles.quiet) {
>>  +		curve =3D asus->gpu_fan_curve.quiet;
>>  +	}
>>  +
>>  +	if (curve !=3D NULL) {
>>  +		err =3D fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, curve);
>>  +		if (err)
>>  +			return err;
>>  +	}
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t fan_curve_store(struct asus_wmi *asus, const char=20
>> *buf,
>>  +								size_t count, u32 dev, char **curve,
>>  +								char *default_curve)
>>  +{
>>  +    int err;
>>  +
>>  +	/* Allow a user to write "" or " " to erase a curve setting */
>>  +	if (strlen(buf) <=3D 1 || strcmp(buf, " \n") =3D=3D 0) {
>>  +		kfree(*curve);
>>  +		*curve =3D kstrdup(default_curve, GFP_KERNEL);
>>  +		err =3D throttle_thermal_policy_write(asus);
>>  +		if (err)
>>  +			return err;
>>  +		return count;
>>  +	}
>>  +
>>  +	if (*curve)
>>  +		kfree(*curve);
>>  +    *curve =3D kstrdup(buf, GFP_KERNEL);
>>  +
>>  +	/* Maybe activate fan curve if in associated mode */
>>  +	err =3D throttle_thermal_policy_write(asus);
>>  +	if (err) {
>>  +		kfree(*curve);
>>  +		*curve =3D kstrdup(default_curve, GFP_KERNEL);
>>  +		return err;
>>  +	}
>>  +
>>  +    return count;
>>  +}
>>  +
>>  +/*
>>  + * CPU Fan Curves
>>  +*/
>>  +
>>  +static ssize_t cpu_fan_curve_balanced_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s",=20
>> asus->cpu_fan_curve.balanced);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +							&asus->cpu_fan_curve.balanced,
>>  +							asus->cpu_fan_curve.balanced_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
>>  +
>>  +static ssize_t cpu_fan_curve_performance_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s",=20
>> asus->cpu_fan_curve.performance);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_performance_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +							&asus->cpu_fan_curve.performance,
>>  +							asus->cpu_fan_curve.performance_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_performance);
>>  +
>>  +static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.quiet);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +							&asus->cpu_fan_curve.quiet,
>>  +							asus->cpu_fan_curve.quiet_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_quiet);
>>  +
>>  +/*
>>  + * GPU Fan Curves
>>  +*/
>>  +
>>  +static ssize_t gpu_fan_curve_balanced_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s",=20
>> asus->gpu_fan_curve.balanced);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +							&asus->gpu_fan_curve.balanced,
>>  +							asus->gpu_fan_curve.balanced_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
>>  +
>>  +static ssize_t gpu_fan_curve_performance_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s",=20
>> asus->gpu_fan_curve.performance);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_performance_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +							&asus->gpu_fan_curve.performance,
>>  +							asus->gpu_fan_curve.performance_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_performance);
>>  +
>>  +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.quiet);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,=20
>> ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +							&asus->gpu_fan_curve.quiet,
>>  +							asus->gpu_fan_curve.quiet_default);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
>=20
> Even though it is a hwmon thing, I think `SENSOR_ATTR_2()` (from=20
> linux/hwmon-sysfs.h)
> would be very useful here as you'd avoid creating n+1 functions, e.g:
>=20
>   static ssize_t fan_curve_show(struct device *dev, struct=20
> device_attribute *attr, char *buf)
>   {
>     struct sensor_device_attribute_2 *sattr =3D=20
> to_sensor_dev_attr_2(attr);
>     struct asus_wmi *asus =3D dev_get_drvdata(dev);
>=20
>     /*
>      * if you stored fan curves in an array, you could then access=20
> the fan
>      * curve in `asus->fans[sattr->index].curves[sattr->nr]`
>      * /
>   }
>=20
>   static SENSOR_DEVICE_ATTR_2(some_name1, 0644, fan_curve_show,=20
> fan_curve_store,
>                               FAN_CPU /* index in the "fans" array */,
>                               ASUS_THROTTLE_THERMAL_POLICY_SILENT /*=20
> index in the "curves" array */);
>=20

I'm sorry I don't really understand how this works. Is there a good doc=20
for it anywhere? Being unfamiliar with C makes it look a little more=20
intimidating than what I've managed to do so far.

>=20
>>  +
>>  +/*
>>  + * Profiles with enabled fan curve setting
>>  +*/
>>  +
>>  +static int enabled_fan_curve_profiles_write(struct asus_wmi *asus,
>>  +											const char *names)
>>  +{
>>  +    char *buf, *set, *set_end;
>>  +    int err;
>>  +
>>  +    buf =3D set_end =3D kstrdup(names, GFP_KERNEL);
>>  +
>>  +	/* Reset before checking */
>>  +	asus->enabled_fan_curve_profiles.balanced =3D false;
>>  +	asus->enabled_fan_curve_profiles.quiet =3D false;
>>  +	asus->enabled_fan_curve_profiles.performance =3D false;
>>  +
>>  +	while( (set =3D strsep(&set_end, " ")) !=3D NULL ) {
>>  +		if (set =3D=3D NULL)
>=20
> When is this possible?

Uh... Removed XD

>=20
>=20
>>  +			set =3D buf;
>>  +
>>  +		if (strcmp(set, "balanced") =3D=3D 0
>>  +				|| strcmp(set, "balanced\n") =3D=3D 0)
>>  +			asus->enabled_fan_curve_profiles.balanced =3D true;
>>  +
>>  +		if (strcmp(set, "quiet") =3D=3D 0
>>  +				|| strcmp(set, "quiet\n") =3D=3D 0)
>>  +			asus->enabled_fan_curve_profiles.quiet =3D true;
>>  +
>>  +		if (strcmp(set, "performance") =3D=3D 0
>>  +				|| strcmp(set, "performance\n") =3D=3D 0)
>>  +			asus->enabled_fan_curve_profiles.performance =3D true;
>=20
> If you store the enabled curves in an array, and you have a list of=20
> profile names,
> then `sysfs_match_string()`, will be very helpful here. You could do=20
> something like:
>=20
>   int profile =3D sysfs_match_string(profile_names, set);
>   if (profile < 0) {
>     /* not found */
>   }
>=20
>   asus->fan_curve_enabled_for_profile[profile] =3D true;

Okay now that's cool. I'll just the relevant parts to use this. Thanks!

>=20
>=20
>>  +	}
>>  +
>>  +	err =3D throttle_thermal_policy_write(asus);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	kfree(buf);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t enabled_fan_curve_profiles_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	int len =3D 0;
>>  +
>>  +	if (asus->enabled_fan_curve_profiles.balanced)
>>  +		len +=3D sysfs_emit_at(buf, len, "balanced ");
>>  +
>>  +	if (asus->enabled_fan_curve_profiles.performance)
>>  +		len +=3D sysfs_emit_at(buf, len, "performance ");
>>  +
>>  +	if (asus->enabled_fan_curve_profiles.quiet)
>>  +		len +=3D sysfs_emit_at(buf, len, "quiet ");
>>  +
>>  +	len +=3D sysfs_emit_at(buf, len, "\n");
>>  +	return len;
>>  +}
>>  +
>>  +static ssize_t enabled_fan_curve_profiles_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
>>  +	int err;
>>  +
>>  +	err =3D enabled_fan_curve_profiles_write(asus, buf);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +    return count;
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(enabled_fan_curve_profiles);
>>  +
>>   /* Throttle thermal policy=20
>> ****************************************************/
>>=20
>>   static int throttle_thermal_policy_check_present(struct asus_wmi=20
>> *asus)
>>  @@ -2092,6 +2652,26 @@ static int=20
>> throttle_thermal_policy_write(struct asus_wmi *asus)
>>   		return -EIO;
>>   	}
>>=20
>>  +	if (asus->cpu_fan_curve_available) {
>>  +		err =3D fan_curve_cpu_write(asus);
>>  +		if (err) {
>>  +			dev_warn(&asus->platform_device->dev,
>>  +				"Failed to set custom CPU curve for thermal policy: %d\n",
>>  +				err);
>>  +			return err;
>>  +		}
>>  +	}
>>  +
>>  +	if (asus->gpu_fan_curve_available) {
>>  +		err =3D fan_curve_gpu_write(asus);
>>  +		if (err) {
>>  +			dev_warn(&asus->platform_device->dev,
>>  +				"Failed to set custom GPU curve for thermal policy: %d\n",
>>  +				err);
>>  +			return err;
>>  +		}
>>  +	}
>>  +
>>   	return 0;
>>   }
>>=20
>>  @@ -2711,6 +3291,13 @@ static struct attribute=20
>> *platform_attributes[] =3D {
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>>   	&dev_attr_throttle_thermal_policy.attr,
>>  +	&dev_attr_cpu_fan_curve_balanced.attr,
>>  +	&dev_attr_cpu_fan_curve_performance.attr,
>>  +	&dev_attr_cpu_fan_curve_quiet.attr,
>>  +    &dev_attr_gpu_fan_curve_balanced.attr,
>>  +	&dev_attr_gpu_fan_curve_performance.attr,
>>  +	&dev_attr_gpu_fan_curve_quiet.attr,
>>  +	&dev_attr_enabled_fan_curve_profiles.attr,
>>   	&dev_attr_panel_od.attr,
>>   	NULL
>>   };
>>  @@ -2741,6 +3328,20 @@ static umode_t asus_sysfs_is_visible(struct=20
>> kobject *kobj,
>>   		ok =3D asus->fan_boost_mode_available;
>>   	else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
>>   		ok =3D asus->throttle_thermal_policy_available;
>>  +	else if (attr =3D=3D &dev_attr_cpu_fan_curve_balanced.attr)
>>  +		ok =3D asus->cpu_fan_curve_available;
>>  +	else if (attr =3D=3D &dev_attr_cpu_fan_curve_performance.attr)
>>  +		ok =3D asus->cpu_fan_curve_available;
>>  +	else if (attr =3D=3D &dev_attr_cpu_fan_curve_quiet.attr)
>>  +		ok =3D asus->cpu_fan_curve_available;
>>  +    else if (attr =3D=3D &dev_attr_gpu_fan_curve_balanced.attr)
>>  +		ok =3D asus->gpu_fan_curve_available;
>>  +	else if (attr =3D=3D &dev_attr_gpu_fan_curve_performance.attr)
>>  +		ok =3D asus->gpu_fan_curve_available;
>>  +	else if (attr =3D=3D &dev_attr_gpu_fan_curve_quiet.attr)
>>  +		ok =3D asus->gpu_fan_curve_available;
>>  +	else if (attr =3D=3D &dev_attr_enabled_fan_curve_profiles.attr)
>>  +		ok =3D asus->cpu_fan_curve_available ||=20
>> asus->gpu_fan_curve_available;
>>   	else if (attr =3D=3D &dev_attr_panel_od.attr)
>>   		ok =3D asus->panel_overdrive_available;
>>=20
>>  @@ -3016,6 +3617,16 @@ static int asus_wmi_add(struct=20
>> platform_device *pdev)
>>   	else
>>   		throttle_thermal_policy_set_default(asus);
>>=20
>>  +	err =3D custom_fan_check_present(asus,=20
>> &asus->cpu_fan_curve_available,
>>  +			ASUS_WMI_DEVID_CPU_FAN_CURVE);
>>  +	if (err)
>>  +		goto fail_custom_fan_curve;
>>  +
>>  +    err =3D custom_fan_check_present(asus,=20
>> &asus->gpu_fan_curve_available,
>>  +			ASUS_WMI_DEVID_GPU_FAN_CURVE);
>>  +	if (err)
>>  +		goto fail_custom_fan_curve;
>>  +
>>   	err =3D platform_profile_setup(asus);
>>   	if (err)
>>   		goto fail_platform_profile_setup;
>>  @@ -3109,6 +3720,7 @@ static int asus_wmi_add(struct=20
>> platform_device *pdev)
>>   	asus_wmi_sysfs_exit(asus->platform_device);
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>>  +fail_custom_fan_curve:
>>   fail_platform_profile_setup:
>>   	if (asus->platform_profile_support)
>>   		platform_profile_remove();
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



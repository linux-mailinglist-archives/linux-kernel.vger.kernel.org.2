Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849803F1454
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhHSH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:27:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46611 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231939AbhHSH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:27:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E102C5C01B9;
        Thu, 19 Aug 2021 03:27:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 03:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MqxZwq
        AE1ar+L0AwfMPynfMpNpLOfKm18zHW2OCjeEA=; b=e5+Ia/TpxTAK8AgsYY/O5W
        l7xLddsDcbgNSwW9Uib6MLKUKGIxavaAbsQSYiQepTEE1Tchrre5iT2T1aw40voq
        RYxCZ2/gOui/+OVFp4bpGA9vI1t1Szb704K5XEQ8awl43hPahI1HPlnHcAMwlRFw
        e0kiPHZQaWAszEOTn6pu0NAa7vEBaKCC46kbiJzxOjQH8eIaC5OwacaTIOdm3tVm
        h1i6TPE/BMK54dfszD3zbqR5+ytkTt54maz+tOz30Ez8VdZT0EMjAj36eXVIaqSU
        HC/uLvhu9SAK8meszM7oUBbjN8YPruhfnu86iff2t4VwTOPF593Fs6lAhbss2xFw
        ==
X-ME-Sender: <xms:ygceYfrKryDjDUP7arsUBVNymzUpHD9mOhSbpBKtfbs0b1X-yMDuBA>
    <xme:ygceYZokpA2c4I83koOcq_kGSCpPUPufI-to28KeoYXwFzoF22HIA8F6jU48dxzMM
    saYGrJU2Mv-Ee-8Yb4>
X-ME-Received: <xmr:ygceYcNJHolaJ1VgG971EqDhBGD_MtCrbFKnagmY5yQamhZvroDSJTswc-_r8f1QNyr3HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ygceYS4G0vayYJ_GYaIJwzGMFEhOQGaXfTd495R55bRg8HP1_useng>
    <xmx:ygceYe65pZtVTXFN-IAX8d-mwy2kxc7-zjA_cMgQoi-XeGceH7Ei_Q>
    <xmx:ygceYaia6nb0siWwQlQdgDT-G4aS7iWQDAywq398k55np97I8xHSEA>
    <xmx:ywceYURp5tSzIZcDnDP281d9OEOIQYwPARXVOTg3ETcJQHocbSg16Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 03:27:03 -0400 (EDT)
Date:   Thu, 19 Aug 2021 19:26:48 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] asus-wmi: Add support for custom fan curves
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <OOS2YQ.5V2ZXNMIG4DC3@ljones.dev>
In-Reply-To: <20210819011733.231756-2-luke@ljones.dev>
References: <20210819011733.231756-1-luke@ljones.dev>
        <20210819011733.231756-2-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the largest patch I've written so far I think, and there may be 
mistakes. So far in testing it's been good though.
Feedback is absolutely welcomed. Some of my own comments are inline 
here, and this version is a WIP - I expect we'll have a round or two of 
changes.

Cheers

On Thu, Aug 19 2021 at 13:17:33 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> These laptops have the ability to set a custom curve for the CPU
> and GPU fans via an ACPI method call. This patch enables this,
> additionally enabling custom fan curves per-profile, where profile
> here means each of the 3 levels of "throttle_thermal_policy".
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 498 
> +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 500 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index cc5811844012..dd107301cc1e 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -122,6 +122,7 @@ struct bios_args {
>  	u32 arg0;
>  	u32 arg1;
>  	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. 
> */
> +	u32 arg3;
>  	u32 arg4;
>  	u32 arg5;
>  } __packed;
> @@ -173,6 +174,12 @@ enum fan_type {
>  	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
>  };
> 
> +struct fan_curve {
> +	char *balanced;
> +	char *performance;
> +	char *quiet;
> +};
> +
>  struct asus_wmi {
>  	int dsts_id;
>  	int spec;
> @@ -220,6 +227,12 @@ struct asus_wmi {
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> 
> +	bool cpu_fan_curve_available;
> +	struct fan_curve cpu_fan_curve;
> +
> +    bool gpu_fan_curve_available;
> +	struct fan_curve gpu_fan_curve;
> +
>  	struct platform_profile_handler platform_profile_handler;
>  	bool platform_profile_support;
> 
> @@ -285,6 +298,90 @@ int asus_wmi_evaluate_method(u32 method_id, u32 
> arg0, u32 arg1, u32 *retval)
>  }
>  EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
> 
> +static int asus_wmi_evaluate_method5(u32 method_id,
> +		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> +{
> +	struct bios_args args = {
> +		.arg0 = arg0,
> +		.arg1 = arg1,
> +		.arg2 = arg2,
> +		.arg3 = arg3,
> +		.arg4 = arg4,
> +	};
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u32 tmp = 0;
> +
> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +				     &input, &output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		tmp = (u32) obj->integer.value;
> +
> +	if (retval)
> +		*retval = tmp;
> +
> +	kfree(obj);
> +
> +	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Returns as an error if the method output is not a buffer. 
> Typically this
> + * means that the method called is unsupported.
> +*/
> +static int asus_wmi_evaluate_method_buf(u32 method_id,
> +		u32 arg0, u32 arg1, u8 **ret_buffer)
> +{
> +	struct bios_args args = {
> +		.arg0 = arg0,
> +		.arg1 = arg1,
> +		.arg2 = 0,
> +	};
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u8 *buf_tmp;
> +	u32 int_tmp = 0;
> +
> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +				     &input, &output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = (union acpi_object *)output.pointer;
> +
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		int_tmp = (u32) obj->integer.value;
> +		if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
> +			return -ENODEV;
> +
> +		return int_tmp;
> +	}
> +
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		buf_tmp = obj->buffer.pointer;
> +	}
> +
> +	if (ret_buffer)
> +		ret_buffer = &buf_tmp;
> +
> +	kfree(obj);
> +
> +	return 0;
> +}
> +
>  static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer 
> args)
>  {
>  	struct acpi_buffer input;
> @@ -2043,6 +2140,311 @@ static ssize_t fan_boost_mode_store(struct 
> device *dev,
>  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>  static DEVICE_ATTR_RW(fan_boost_mode);
> 
> +/* Custom fan curves per-profile 
> **********************************************/
> +
> +static int custom_fan_check_present(struct asus_wmi *asus,
> +									bool *available, u32 dev)
> +{
> +	u8 *buffer;
> +	int err;
> +
> +	*available = false;
> +
> +	/*
> +	 * We don't do anything with the buffer from this call except 
> ensure that
> +	 * it is a buffer. A fail or unsupported returns an int (from ACPI)
> +	*/

Discovering the buffer content is underway. It looks as if the format 
is the same as what we write to the ACPI method (should have been 
obvious :| )

> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	*available = true;
> +	return 0;
> +}
> +
> +/*
> + * The expected input is of the format
> + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
> + * where a pair is 30:1, with 30 = temperature, and 1 = percentage
> +*/
> +static int fan_curve_check_valid(const char *curve)
> +{
> +    char * buf, *set, *set_end, *pair_tmp, *pair, *pair_end;
> +	int err, ret;
> +
> +	char *set_delimiter = ",";
> +	char *pair_delimiter = ":";
> +    bool pair_start = true;
> +	u32 prev_percent = 0;
> +	u32 prev_temp = 0;
> +    u32 percent = 0;
> +	u32 temp = 0;
> +
> +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
> +
> +	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
> +		pair_tmp = kstrdup(set, GFP_KERNEL);
> +        pair_start = true;
> +		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
> +			err = kstrtouint(pair, 10, &ret);
> +            if (err) {
> +                kfree(pair_tmp);
> +                kfree(buf);
> +                return err;
> +            }
> +
> +            if (pair_start) {
> +                temp = ret;
> +                pair_start = false;
> +            } else {
> +                percent = ret;
> +            }
> +		}
> +		kfree(pair_tmp);
> +
> +        if (temp < prev_temp || percent < prev_percent || percent > 
> 100) {
> +            pr_info("Fan curve invalid");
> +			pr_info("A value is sequentially lower or percentage is > 100");
> +            kfree(buf);
> +            return -EINVAL;
> +        }
> +
> +        prev_temp = temp;
> +        prev_percent = percent;
> +	}
> +	kfree(buf);
> +
> +    return 0;
> +}
> +
> +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char 
> *curve)
> +{
> +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
> +    int err, ret;
> +
> +	char *set_delimiter = ",";
> +	char *pair_delimiter = ":";
> +	bool half_complete = false;
> +	bool pair_start = true;
> +	u32 percent = 0;
> +	u32 shift = 0;
> +	u32 temp = 0;
> +    u32 arg1 = 0;
> +    u32 arg2 = 0;
> +    u32 arg3 = 0;
> +    u32 arg4 = 0;
> +
> +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
> +
> +	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
> +		pair_tmp = kstrdup(set, GFP_KERNEL);
> +        pair_start = true;
> +		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
> +			err = kstrtouint(pair, 10, &ret);
> +            if (err) {
> +                kfree(pair_tmp);
> +                kfree(buf);
> +                return err;
> +            }
> +
> +            if (pair_start) {
> +                temp = ret;
> +                pair_start = false;
> +            } else {
> +                percent = ret;
> +            }
> +		}
> +		kfree(pair_tmp);
> +
> +        if (!half_complete) {
> +            arg1 += temp << shift;
> +            arg3 += percent << shift;
> +        } else {
> +            arg2 += temp << shift;
> +            arg4 += percent << shift;
> +        }
> +        shift += 8;
> +
> +        if (shift == 32) {
> +            shift = 0;
> +            half_complete = true;
> +        }
> +	}
> +	kfree(buf);
> +
> +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
> +									 arg1, arg2, arg3, arg4, &ret);
> +}
> +
> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char 
> *buf,
> +								size_t count, u32 dev, char **curve,
> +								u32 throttle_policy)
> +{
> +    int err;
> +
> +	/* Allow a user to write "" or " " to erase a curve setting */
> +	if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
> +		kfree(*curve);
> +		*curve = NULL;

I'll be adding a call to throttle_thermal_policy_write() here to ensure 
the EC resets the fan defaults for the current mode.

> >
> ---
>  drivers/platform/x86/asus-wmi.c            | 498 
> +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 500 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index cc5811844012..dd107301cc1e 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -122,6 +122,7 @@ struct bios_args {
>  	u32 arg0;
>  	u32 arg1;
>  	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. 
> */
> +	u32 arg3;
>  	u32 arg4;
>  	u32 arg5;
>  } __packed;
> @@ -173,6 +174,12 @@ enum fan_type {
>  	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
>  };
> 
> +struct fan_curve {
> +	char *balanced;
> +	char *performance;
> +	char *quiet;
> +};
> +
>  struct asus_wmi {
>  	int dsts_id;
>  	int spec;
> @@ -220,6 +227,12 @@ struct asus_wmi {
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> 
> +	bool cpu_fan_curve_available;
> +	struct fan_curve cpu_fan_curve;
> +
> +    bool gpu_fan_curve_available;
> +	struct fan_curve gpu_fan_curve;
> +
>  	struct platform_profile_handler platform_profile_handler;
>  	bool platform_profile_support;
> 
> @@ -285,6 +298,90 @@ int asus_wmi_evaluate_method(u32 method_id, u32 
> arg0, u32 arg1, u32 *retval)
>  }
>  EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
> 
> +static int asus_wmi_evaluate_method5(u32 method_id,
> +		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> +{
> +	struct bios_args args = {
> +		.arg0 = arg0,
> +		.arg1 = arg1,
> +		.arg2 = arg2,
> +		.arg3 = arg3,
> +		.arg4 = arg4,
> +	};
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u32 tmp = 0;
> +
> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +				     &input, &output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		tmp = (u32) obj->integer.value;
> +
> +	if (retval)
> +		*retval = tmp;
> +
> +	kfree(obj);
> +
> +	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Returns as an error if the method output is not a buffer. 
> Typically this
> + * means that the method called is unsupported.
> +*/
> +static int asus_wmi_evaluate_method_buf(u32 method_id,
> +		u32 arg0, u32 arg1, u8 **ret_buffer)
> +{
> +	struct bios_args args = {
> +		.arg0 = arg0,
> +		.arg1 = arg1,
> +		.arg2 = 0,
> +	};
> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *obj;
> +	u8 *buf_tmp;
> +	u32 int_tmp = 0;
> +
> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +				     &input, &output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = (union acpi_object *)output.pointer;
> +
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		int_tmp = (u32) obj->integer.value;
> +		if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
> +			return -ENODEV;
> +
> +		return int_tmp;
> +	}
> +
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		buf_tmp = obj->buffer.pointer;
> +	}
> +
> +	if (ret_buffer)
> +		ret_buffer = &buf_tmp;
> +
> +	kfree(obj);
> +
> +	return 0;
> +}
> +
>  static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer 
> args)
>  {
>  	struct acpi_buffer input;
> @@ -2043,6 +2140,311 @@ static ssize_t fan_boost_mode_store(struct 
> device *dev,
>  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>  static DEVICE_ATTR_RW(fan_boost_mode);
> 
> +/* Custom fan curves per-profile 
> **********************************************/
> +
> +static int custom_fan_check_present(struct asus_wmi *asus,
> +									bool *available, u32 dev)
> +{
> +	u8 *buffer;
> +	int err;
> +
> +	*available = false;
> +
> +	/*
> +	 * We don't do anything with the buffer from this call except 
> ensure that
> +	 * it is a buffer. A fail or unsupported returns an int (from ACPI)
> +	*/
> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, &buffer);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	*available = true;
> +	return 0;
> +}
> +
> +/*
> + * The expected input is of the format
> + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
> + * where a pair is 30:1, with 30 = temperature, and 1 = percentage
> +*/
> +static int fan_curve_check_valid(const char *curve)
> +{
> +    char * buf, *set, *set_end, *pair_tmp, *pair, *pair_end;
> +	int err, ret;
> +
> +	char *set_delimiter = ",";
> +	char *pair_delimiter = ":";
> +    bool pair_start = true;
> +	u32 prev_percent = 0;
> +	u32 prev_temp = 0;
> +    u32 percent = 0;
> +	u32 temp = 0;
> +
> +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
> +
> +	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
> +		pair_tmp = kstrdup(set, GFP_KERNEL);
> +        pair_start = true;
> +		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
> +			err = kstrtouint(pair, 10, &ret);
> +            if (err) {
> +                kfree(pair_tmp);
> +                kfree(buf);
> +                return err;
> +            }
> +
> +            if (pair_start) {
> +                temp = ret;
> +                pair_start = false;
> +            } else {
> +                percent = ret;
> +            }
> +		}
> +		kfree(pair_tmp);
> +
> +        if (temp < prev_temp || percent < prev_percent || percent > 
> 100) {
> +            pr_info("Fan curve invalid");
> +			pr_info("A value is sequentially lower or percentage is > 100");
> +            kfree(buf);
> +            return -EINVAL;
> +        }
> +
> +        prev_temp = temp;
> +        prev_percent = percent;
> +	}
> +	kfree(buf);
> +
> +    return 0;
> +}
> +
> +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char 
> *curve)
> +{
> +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
> +    int err, ret;
> +
> +	char *set_delimiter = ",";
> +	char *pair_delimiter = ":";
> +	bool half_complete = false;
> +	bool pair_start = true;
> +	u32 percent = 0;
> +	u32 shift = 0;
> +	u32 temp = 0;
> +    u32 arg1 = 0;
> +    u32 arg2 = 0;
> +    u32 arg3 = 0;
> +    u32 arg4 = 0;
> +
> +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
> +
> +	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
> +		pair_tmp = kstrdup(set, GFP_KERNEL);
> +        pair_start = true;
> +		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
> +			err = kstrtouint(pair, 10, &ret);
> +            if (err) {
> +                kfree(pair_tmp);
> +                kfree(buf);
> +                return err;
> +            }
> +
> +            if (pair_start) {
> +                temp = ret;
> +                pair_start = false;
> +            } else {
> +                percent = ret;
> +            }
> +		}
> +		kfree(pair_tmp);
> +
> +        if (!half_complete) {
> +            arg1 += temp << shift;
> +            arg3 += percent << shift;
> +        } else {
> +            arg2 += temp << shift;
> +            arg4 += percent << shift;
> +        }
> +        shift += 8;
> +
> +        if (shift == 32) {
> +            shift = 0;
> +            half_complete = true;
> +        }
> +	}
> +	kfree(buf);
> +
> +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
> +									 arg1, arg2, arg3, arg4, &ret);
> +}
> +
> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char 
> *buf,
> +								size_t count, u32 dev, char **curve,
> +								u32 throttle_policy)
> +{
> +    int err;
> +
> +	/* Allow a user to write "" or " " to erase a curve setting */
> +	if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
> +		kfree(*curve);
> +		*curve = NULL;
> +		return count;
> +	}
>  if (attr == &dev_attr_cpu_fan_curve_performance.attr)
> +		ok = asus->cpu_fan_curve_available;
> +	else if (attr == &dev_attr_cpu_fan_curve_quiet.attr)
> +		ok = asus->cpu_fan_curve_available;
> +    else if (attr == &dev_attr_gpu_fan_curve_balanced.attr)
> +		ok = asus->gpu_fan_curve_available;
> +	else if (attr == &dev_attr_gpu_fan_curve_performance.attr)
> +		ok = asus->gpu_fan_curve_available;
> +	else if (attr == &dev_attr_gpu_fan_curve_quiet.attr)
> +		ok = asus->gpu_fan_curve_available;
>  	else if (attr == &dev_attr_panel_od.attr)
>  		ok = asus->panel_overdrive_available;
> 
> @@ -3016,6 +3503,16 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	else
>  		throttle_thermal_policy_set_default(asus);
> 
> +	err = custom_fan_check_present(asus, &asus->cpu_fan_curve_available,
> +			ASUS_WMI_DEVID_CPU_FAN_CURVE);
> +	if (err)
> +		goto fail_throttle_fan_curve;
> +
> +    err = custom_fan_check_present(asus, 
> &asus->gpu_fan_curve_available,
> +			ASUS_WMI_DEVID_GPU_FAN_CURVE);
> +	if (err)
> +		goto fail_throttle_fan_curve;
> +
>  	err = platform_profile_setup(asus);
>  	if (err)
>  		goto fail_platform_profile_setup;
> @@ -3109,6 +3606,7 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	asus_wmi_sysfs_exit(asus->platform_device);
>  fail_sysfs:
>  fail_throttle_thermal_policy:
> +fail_throttle_fan_curve:
>  fail_platform_profile_setup:
>  	if (asus->platform_profile_support)
>  		platform_profile_remove();
> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
> b/include/linux/platform_data/x86/asus-wmi.h
> index 17dc5cb6f3f2..a571b47ff362 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -77,6 +77,8 @@
>  #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
>  #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
>  #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
> +#define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
> +#define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
> 
>  /* Power */
>  #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
> --
> 2.31.1
> 



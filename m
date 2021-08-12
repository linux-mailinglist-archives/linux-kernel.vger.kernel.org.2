Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E733EA00D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhHLH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbhHLH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628755162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+dzKNm48/cahGNh0e4kgt/hHDqDP+Lhc1dI/DEnfBM=;
        b=hHdlp2uNQ/qVWXl07zAzkI46t6mvvpOeFuVEXlr0xR85vPKOyZgwQECTZW16hCkqSTg/58
        t5jd0sXT4SGeGFm8hJCSz6mrABKCAoijwuKNRxmMW1m8uqy+aU1Y8JFNZHiO3/LaL+bG5/
        9zrSBSbxzzaPr466sqQ3EljzQgQzewA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-1WEFsZfPO4KIRHW8NE0Phg-1; Thu, 12 Aug 2021 03:59:20 -0400
X-MC-Unique: 1WEFsZfPO4KIRHW8NE0Phg-1
Received: by mail-ed1-f71.google.com with SMTP id n4-20020aa7c6840000b02903be94ce771fso2112801edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+dzKNm48/cahGNh0e4kgt/hHDqDP+Lhc1dI/DEnfBM=;
        b=IdIi1jZLK6/lY/6zMTZDIwevi54/VfSB1QNu0i3hxJP1z0WHtle3t/lC/Doq2nToRu
         z/cIS1itue/nQg/SL+PTDhVX32by1T9AxEjfAUq0sbOgxHOEBgBTvr5v6Ov1oiSKFOGz
         YrEpV0o/EC+7HomYNrqPw3ErICmWAiTRWNQRpEPWYP7HboCTwIG+UHqNCXA1BLnFYJ0w
         ca7iwfGGHD5zDZCCDQZFO/1SjdPq/1buX9PXKerj/bP5moxVQ36TX0qVO1i5iJ8arm9r
         rJwydhuaLRDlkfwB1/MDFFABjHOuOg5Pccxyi/M/9afgNr+GJzPQnkk0AmR/0v7J6xno
         B4fQ==
X-Gm-Message-State: AOAM532oeeg2vTd29NChKo+btTLmyLHR2MsqVJKgCdskl95IRSW4CiWH
        n0IdG92dIfiGFUW4IulWZrNIOOTHase7rn+QUs8dsqX/+kVifiO41WAqqg29RJjdrVQCXxuY306
        4CmEz7ttl8k3J6yr0iC617Fdw
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr2474708ejc.168.1628755158680;
        Thu, 12 Aug 2021 00:59:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc04rd5YY+0VVrazWdG/5oamRQqmcGkI7ODDDwqWHgKrb4OyFH7bPQyojZiDobjcVFpWWawA==
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr2474693ejc.168.1628755158433;
        Thu, 12 Aug 2021 00:59:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o22sm760440edr.19.2021.08.12.00.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:59:17 -0700 (PDT)
Subject: Re: [PATCH v4] platform/x86: acer-wmi: Add Turbo Mode support for
 Acer PH315-53
To:     JafarAkhondali <jafar.akhoondali@gmail.com>, jlee@suse.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mgross@linux.intel.com
References: <20210810233928.1389320-1-jafar.akhoondali@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8f295c56-1963-f1f9-b88c-062b71f7f0e6@redhat.com>
Date:   Thu, 12 Aug 2021 09:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810233928.1389320-1-jafar.akhoondali@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jafar,

On 8/11/21 1:39 AM, JafarAkhondali wrote:
> Hi,
> 
> The Acer Predator Helios series (usually denoted by PHxxx-yy) features
> a special key above the keyboard named "TURBO". The turbo key does 3
> things:
> 1. Set all fan's speeds to TURBO mode
> 2. Overclocks the CPU and GPU in the safe range
> 3. Turn on an LED just below the turbo button
> 
> All of these actions are done by WMI function calls, and there is no
> custom OC level for turbo. It acts as a flag for enabling turbo
> mode instead of telling processors to use 1.3x of power.
> 
> I've run some benchmark tests and it worked fine:
> 
> GpuTest 0.7.0
> http://www.geeks3d.com
> 
> Module: FurMark
> Normal mode Score: 7289 points (FPS: 121)
> Turbo mode Score: 7675 points (FPS: 127)
> Settings:
> - 1920x1080 fullscreen
> - antialiasing: Off
> - duration: 60000 ms
> 
> Renderer:
> - GeForce RTX 2060/PCIe/SSE2
> - OpenGL: 4.6.0 NVIDIA 460.32.03
> 
> This feature is presented by Acer officially and should not harm
> hardware in any case.
> 
> A challenging part of implementing this feature is that calling
> overclocking the function requires knowing the exact count of fans for CPU
> and GPU for each model, which to the best of my knowledge is not
> available in the kernel.
> 
> So after checking the official PredatorSense application methods, it
> turned out they have provided the software the list of fans in each model.
> I have access to the mentioned list, and all similar PH-iii-jj can be
> added easily by matching "DMI_PRODUCT_NAME".
> 
> Creating a separate file for the gaming interface was not possible because
> the current WMI event GUID is needed for the turbo button, and it's not
> possible to register multiple functions on the same event GUID.
> 
> 
> Signed-off-by: JafarAkhondali <jafar.akhoondali@gmail.com>
> ---
>  Changes in v4:
>  - Fix Indents
>  - Make functions return early

This is looking good, the kernel-buildbot (which finally has managed
to build the patch now that the indents are fixed) found one last
small thing to fix.

And while looking at that I also found one last small thing to
improve, see my comments inline / below.

So we will need one more version and then this should be ready to
get merged.



>  Changes in v3:
>  - Remove usages of gaming_interface
>  - Add ACPI output for u32 buffer length
>  - Remove set_u64 and get_u64 functions
>  - Remove unrelated whitespace changes for to this patch
> 
>  Changes in v2:
>  - Fix formatting problems
> 
> 
>  drivers/platform/x86/acer-wmi.c | 183 ++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 85db9403cc14..183faa6db4b2 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -60,6 +60,11 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_GET_THREEG_METHODID		10
>  #define ACER_WMID_SET_THREEG_METHODID		11
>  
> +#define ACER_WMID_SET_GAMING_LED_METHODID 2
> +#define ACER_WMID_GET_GAMING_LED_METHODID 4
> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
> +#define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
> +
>  /*
>   * Acer ACPI method GUIDs
>   */
> @@ -68,6 +73,7 @@ MODULE_LICENSE("GPL");
>  #define WMID_GUID1		"6AF4F258-B401-42FD-BE91-3D4AC2D7C0D3"
>  #define WMID_GUID2		"95764E09-FB56-4E83-B31A-37761F60994A"
>  #define WMID_GUID3		"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
> +#define WMID_GUID4		"7A4DDFE7-5B5D-40B4-8595-4408E0CC7F56"
>  
>  /*
>   * Acer ACPI event GUIDs
> @@ -81,6 +87,7 @@ MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
>  enum acer_wmi_event_ids {
>  	WMID_HOTKEY_EVENT = 0x1,
>  	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
> +	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
>  };
>  
>  static const struct key_entry acer_wmi_keymap[] __initconst = {
> @@ -215,6 +222,9 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_THREEG			BIT(4)
>  #define ACER_CAP_SET_FUNCTION_MODE	BIT(5)
>  #define ACER_CAP_KBD_DOCK		BIT(6)
> +#define ACER_CAP_TURBO_OC     BIT(7)
> +#define ACER_CAP_TURBO_LED     BIT(8)
> +#define ACER_CAP_TURBO_FAN     BIT(9)
>  
>  /*
>   * Interface type flags
> @@ -301,6 +311,9 @@ struct quirk_entry {
>  	u8 mailled;
>  	s8 brightness;
>  	u8 bluetooth;
> +	u8 turbo;
> +	u8 cpu_fans;
> +	u8 gpu_fans;
>  };
>  
>  static struct quirk_entry *quirks;
> @@ -312,6 +325,10 @@ static void __init set_quirks(void)
>  
>  	if (quirks->brightness)
>  		interface->capability |= ACER_CAP_BRIGHTNESS;
> +
> +	if (quirks->turbo)
> +		interface->capability |= ACER_CAP_TURBO_OC | ACER_CAP_TURBO_LED
> +					 | ACER_CAP_TURBO_FAN;
>  }
>  
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -340,6 +357,12 @@ static struct quirk_entry quirk_acer_travelmate_2490 = {
>  	.mailled = 1,
>  };
>  
> +static struct quirk_entry quirk_acer_predator_ph315_53 = {
> +	.turbo = 1,
> +	.cpu_fans = 1,
> +	.gpu_fans = 1,
> +};
> +
>  /* This AMW0 laptop has no bluetooth */
>  static struct quirk_entry quirk_medion_md_98300 = {
>  	.wireless = 1,
> @@ -507,6 +530,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
>  		},
>  		.driver_data = &quirk_acer_travelmate_2490,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Acer Predator PH315-53",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH315-53"),
> +		},
> +		.driver_data = &quirk_acer_predator_ph315_53,
> +	},
>  	{
>  		.callback = set_force_caps,
>  		.ident = "Acer Aspire Switch 10E SW3-016",
> @@ -1344,6 +1376,93 @@ static struct wmi_interface wmid_v2_interface = {
>  	.type = ACER_WMID_v2,
>  };
>  
> +/*
> + * WMID Gaming interface
> + */
> +
> +static acpi_status
> +WMI_gaming_execute_u64(u32 method_id, u64 in, u64 *out)
> +{
> +	struct acpi_buffer input = { (acpi_size) sizeof(u64), (void *)(&in) };
> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	u32 tmp = 0;
> +	acpi_status status;
> +
> +	status = wmi_evaluate_method(WMID_GUID4, 0, method_id, &input, &result);
> +
> +	if (ACPI_FAILURE(status))
> +		return status;
> +	obj = (union acpi_object *) result.pointer;
> +
> +	if (obj) {
> +		if (obj->type == ACPI_TYPE_BUFFER) {
> +			if (obj->buffer.length == sizeof(u32))
> +				tmp = *((u32 *) obj->buffer.pointer);
> +			else if (obj->buffer.length == sizeof(u64))
> +				tmp = *((u64 *) obj->buffer.pointer);
> +		} else if (obj->type == ACPI_TYPE_INTEGER) {
> +			tmp = (u64) obj->integer.value;
> +		}
> +	}
> +
> +	if (out)
> +		*out = tmp;
> +
> +	kfree(result.pointer);
> +
> +	return status;
> +}
> +
> +static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
> +{
> +	u32 method_id = 0;
> +
> +	if (!(interface->capability & cap))
> +		return AE_BAD_PARAMETER;
> +
> +	switch (cap) {
> +	case ACER_CAP_TURBO_LED:
> +		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
> +		break;
> +	case ACER_CAP_TURBO_FAN:
> +		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
> +		break;
> +	case ACER_CAP_TURBO_OC:
> +		method_id = ACER_WMID_SET_GAMING_MISC_SETTING_METHODID;
> +		break;
> +	default:
> +		return AE_BAD_PARAMETER;
> +	}
> +
> +	return WMI_gaming_execute_u64(method_id, value, NULL);
> +}
> +
> +static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
> +{
> +	acpi_status status;
> +	u64 result;
> +	u64 input;
> +	u32 method_id;
> +
> +	if (!(interface->capability & cap))
> +		return AE_BAD_PARAMETER;
> +
> +	switch (cap) {
> +	case ACER_CAP_TURBO_LED:
> +		method_id = ACER_WMID_GET_GAMING_LED_METHODID;
> +		input = 0x1;
> +		break;
> +	default:
> +		return AE_BAD_PARAMETER;
> +	}
> +	status = WMI_gaming_execute_u64(method_id, input, &result);
> +	if (ACPI_SUCCESS(status))
> +		*value = (u64) result;
> +
> +	return status;
> +}
> +
>  /*
>   * Generic Device (interface-independent)
>   */
> @@ -1575,6 +1694,66 @@ static int acer_gsensor_event(void)
>  	return 0;
>  }
>  
> +/*
> + *  Predator series turbo button
> + */
> +static int acer_toggle_turbo(void)
> +{
> +	/* Get current state from turbo button */
> +	u64 turbo_led_state, gpu_fan_config1, gpu_fan_config2;

As the buildbot pointed out these should be initialized to 0.


> +	u8 i;
> +
> +	if (ACPI_FAILURE(WMID_gaming_get_u64(&turbo_led_state, ACER_CAP_TURBO_LED)))
> +		return -1;
> +
> +	if (turbo_led_state) {
> +		// turns off turbo led
> +		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
> +> +		// set FAN mode to auto

From here...

> +		if (quirks->cpu_fans > 0)
> +			gpu_fan_config2 |= 1;
> +		for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +			gpu_fan_config2 |= 1 << (i + 1);
> +		for (i = 0; i < quirks->gpu_fans; ++i)
> +			gpu_fan_config2 |= 1 << (i + 3);
> +		if (quirks->cpu_fans > 0)
> +			gpu_fan_config1 |= 1;
> +		for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +			gpu_fan_config1 |= 1 << (2 * i + 2);
> +		for (i = 0; i < quirks->gpu_fans; ++i)
> +			gpu_fan_config1 |= 1 << (2 * i + 6);
> +		WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);

Till here...

> +
> +		// set OC to normal
> +		WMID_gaming_set_u64(0x5, ACER_CAP_TURBO_OC);
> +		WMID_gaming_set_u64(0x7, ACER_CAP_TURBO_OC);
> +	} else {
> +		// turn on turbo led
> +		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
> +
> +		// set FAN to turbo mode

The code is identical as the code from here...

> +		if (quirks->cpu_fans > 0)
> +			gpu_fan_config2 |= 1;
> +		for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +			gpu_fan_config2 |= 1 << (i + 1);
> +		for (i = 0; i < quirks->gpu_fans; ++i)
> +			gpu_fan_config2 |= 1 << (i + 3);
> +		if (quirks->cpu_fans > 0)
> +			gpu_fan_config1 |= 2;
> +		for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +			gpu_fan_config1 |= 2 << (2 * i + 2);
> +		for (i = 0; i < quirks->gpu_fans; ++i)
> +			gpu_fan_config1 |= 2 << (2 * i + 6);
> +		WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);

Till here. With the exception of the value being or-ed into gpu_fan_config1, being 1 in the
"// set FAN mode to auto" case and 2 in the "// set FAN to turbo mode" mode case.

Please add a new helper for this like this:

void WMID_gaming_set_fan_mode(u8 value)
{
	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
	int i;

	if (quirks->cpu_fans > 0)
		gpu_fan_config2 |= 1;
	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
		gpu_fan_config2 |= 1 << (i + 1);
	for (i = 0; i < quirks->gpu_fans; ++i)
		gpu_fan_config2 |= 1 << (i + 3);
	if (quirks->cpu_fans > 0)
		gpu_fan_config1 |= value;
	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
		gpu_fan_config1 |= value << (2 * i + 2);
	for (i = 0; i < quirks->gpu_fans; ++i)
		gpu_fan_config1 |= value << (2 * i + 6);
	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);
}

And call that in both places to remove the duplication.


Also I just noticed that you are using c++ style '//' comments here. Please use
standard C-style '/* ... */' comments instead like we do every where else in
the drivers/platform/x86 code.

Thanks & Regards,

Hans



> +
> +		// set OC to turbo mode
> +		WMID_gaming_set_u64(0x205, ACER_CAP_TURBO_OC);
> +		WMID_gaming_set_u64(0x207, ACER_CAP_TURBO_OC);
> +	}
> +	return turbo_led_state;
> +}
> +
>  /*
>   * Switch series keyboard dock status
>   */
> @@ -1872,6 +2051,10 @@ static void acer_wmi_notify(u32 value, void *context)
>  		acer_gsensor_event();
>  		acer_kbd_dock_event(&return_value);
>  		break;
> +	case WMID_GAMING_TURBO_KEY_EVENT:
> +		if (return_value.key_num == 0x4)
> +			acer_toggle_turbo();
> +		break;
>  	default:
>  		pr_warn("Unknown function number - %d - %d\n",
>  			return_value.function, return_value.key_num);
> 


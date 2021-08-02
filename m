Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB213DD4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhHBLjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233526AbhHBLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627904370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eb11UNcu8mEFKIdPzmiDn9WkPTsh759ib8CnfJVbb8=;
        b=BzX0HVGqh+GvfEPC7/S1kw2nwxwE2wBgCQLo79N5yV6/VKlmKUSv65xqy6z+470zSrk3Hj
        gsjtpSKOQUKmO1XCKW0R/jeMCcR4JYg3cehyggHuBVpZx4DdQqAFbPqlEF9faVyoZilKeV
        4p8MZjQg5hpza3bEZZW115c+MeEJP0E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-9whdZ4BSN-CqglcPI783HQ-1; Mon, 02 Aug 2021 07:39:29 -0400
X-MC-Unique: 9whdZ4BSN-CqglcPI783HQ-1
Received: by mail-ed1-f70.google.com with SMTP id de5-20020a0564023085b02903bb92fd182eso8642503edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 04:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1eb11UNcu8mEFKIdPzmiDn9WkPTsh759ib8CnfJVbb8=;
        b=Rjtxmnp7+/kUDcbUEirri+RBBqBKLXmjkCvt8RFdebllHi5yRpnc1493nT965B6flO
         vgSL9xd7eRGEe6R0kjdmWl4lKgLXSzO9B29NhD+JYHNIAoyzMbS0tS5XhWrcnnihlA0G
         E7ekc1HJLiZPc8akmkaX8ak5kb5nrg5I1C9ynxumjLRi2rVEc9ROJYsREMcDKt2lF9s8
         IhZbGPOPpC3CyUumkUyFGgJUhsknyk1cqxR5mecRUqDQIkQ/l0C1JyYwXPtuOfkhifiB
         lf1mhp+oK13Lx+UAPTEzqgWGmxk5MBD7N+Tt0c2NzvNEMx+nPqOtPsWrvCsEreMSd0u1
         +Kuw==
X-Gm-Message-State: AOAM533AWEARGLIcxKnyILadsg5dtLc+bfbMtkzDMcczAbo6lI1WMdnu
        F7HWryhMzX2zYehiN8AdF0wVjCQsgIteM+JmbVzL+84JAKQh1ROuvCm+C1mZFzI7wTj6yeH+alp
        UE/XTLzYpmlmMFxGlaIIz1VUjwGOkyn/g2GdSCLY967ANG3ZIaYSb70+IESNKt+ZwDB3T+THbGC
        7K
X-Received: by 2002:a17:907:11c4:: with SMTP id va4mr14928983ejb.37.1627904368033;
        Mon, 02 Aug 2021 04:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq9nd/zxRa7CiPUAPjpBkilNRPRt0iJW8XDKU/0rI04YBuKmPTU6QNCQOab711B8+Dud4Xmw==
X-Received: by 2002:a17:907:11c4:: with SMTP id va4mr14928965ejb.37.1627904367762;
        Mon, 02 Aug 2021 04:39:27 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id dn18sm5931780edb.42.2021.08.02.04.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 04:39:27 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: acer-wmi: Add Turbo Mode support for
 Acer PH315-53
To:     Jafar Akhondali <jafar.akhoondali@gmail.com>, jlee@suse.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAMW3L+2yurdggGpYSHZw6x07SboxqYRrDA6B699=SagAVp6Euw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f50d9ced-a2c3-7d46-01a0-794b31ee73a2@redhat.com>
Date:   Mon, 2 Aug 2021 13:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMW3L+2yurdggGpYSHZw6x07SboxqYRrDA6B699=SagAVp6Euw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/21 12:25 AM, Jafar Akhondali wrote:
> Looks like the previous patch got some indentation problems, here is
> the fixed version.

Thank you for the new version, this is much better.

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
> A challenging part of implementing this feature is that calling overclocking
> the function requires knowing the exact count of fans for CPU and GPU
> for each model, which to the best of my knowledge is not available in
> the kernel.
> 
> So after checking the official PredatorSense application methods, it
> turned out they have provided the software the list of fans in each model.
> I have access to the mentioned list, and all similar PH-iii-jj can be
> added easily by matching "DMI_PRODUCT_NAME".
> 
> Creating a separate file for the gaming interface was not possible because
> the current WMI event GUID is needed for the turbo button, and it's not possible
> to register multiple functions on the same event GUID.
> 
> 
> Some small indent problems have been also fixed.
> 
> Signed-off-by: JafarAkhondali <jafar.akhoondali@gmail.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 243 ++++++++++++++++++++++++++++++--
>  1 file changed, 231 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 85db9403cc14..06b25ddf04ee 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -30,10 +30,12 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <acpi/video.h>
> 
> +
>  MODULE_AUTHOR("Carlos Corbacho");
>  MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
>  MODULE_LICENSE("GPL");
> 
> +
>  /*
>   * Magic Number
>   * Meaning is unknown - this number is required for writing to ACPI for AMW0

These 2 whitespace changes are unrelated to the turbo feature, please drop.

> @@ -59,7 +61,10 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_SET_BRIGHTNESS_METHODID    6
>  #define ACER_WMID_GET_THREEG_METHODID        10
>  #define ACER_WMID_SET_THREEG_METHODID        11
> -

Please keep the empty line here.
 
> +#define ACER_WMID_SET_GAMING_LED_METHODID 2
> +#define ACER_WMID_GET_GAMING_LED_METHODID 4
> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
> +#define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22

And add an extra empty line here.

>  /*
>   * Acer ACPI method GUIDs
>   */
> @@ -68,6 +73,7 @@ MODULE_LICENSE("GPL");
>  #define WMID_GUID1        "6AF4F258-B401-42FD-BE91-3D4AC2D7C0D3"
>  #define WMID_GUID2        "95764E09-FB56-4E83-B31A-37761F60994A"
>  #define WMID_GUID3        "61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
> +#define WMID_GUID4        "7A4DDFE7-5B5D-40B4-8595-4408E0CC7F56"
> 
>  /*
>   * Acer ACPI event GUIDs
> @@ -81,6 +87,7 @@ MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
>  enum acer_wmi_event_ids {
>      WMID_HOTKEY_EVENT = 0x1,
>      WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
> +    WMID_GAMING_TURBO_KEY_EVENT = 0x7,
>  };
> 
>  static const struct key_entry acer_wmi_keymap[] __initconst = {
> @@ -144,6 +151,7 @@ struct event_return_value {
> 
>  #define ACER_WMID3_GDS_TOUCHPAD        (1<<1)    /* Touchpad */
> 
> +
>  /* Hotkey Customized Setting and Acer Application Status.
>   * Set Device Default Value and Report Acer Application Status.
>   * When Acer Application starts, it will run this method to inform

Unrelated whitespace change, please drop.

> @@ -215,6 +223,9 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_THREEG            BIT(4)
>  #define ACER_CAP_SET_FUNCTION_MODE    BIT(5)
>  #define ACER_CAP_KBD_DOCK        BIT(6)
> +#define ACER_CAP_TURBO_OC     BIT(7)
> +#define ACER_CAP_TURBO_LED     BIT(8)
> +#define ACER_CAP_TURBO_FAN     BIT(9)
> 
>  /*
>   * Interface type flags
> @@ -224,6 +235,7 @@ enum interface_flags {
>      ACER_AMW0_V2,
>      ACER_WMID,
>      ACER_WMID_v2,
> +    ACER_WMID_GAMING,
>  };
> 
>  #define ACER_DEFAULT_WIRELESS  0
> @@ -290,6 +302,9 @@ struct wmi_interface {
>  /* The static interface pointer, points to the currently detected interface */
>  static struct wmi_interface *interface;
> 
> +/* The static gaming interface pointer, points to the currently
> detected gaming interface */
> +static struct wmi_interface *gaming_interface;
> +

The interface pointer stuff is intended to point to one of the
4 types of main Acer WMI interfaces, since there is only one
gamig interface, there is no need for this separate
gaming_interface pointer, please drop it.


>  /*
>   * Embedded Controller quirks
>   * Some laptops require us to directly access the EC to either enable or query
> @@ -301,6 +316,9 @@ struct quirk_entry {
>      u8 mailled;
>      s8 brightness;
>      u8 bluetooth;
> +    u8 turbo;
> +    u8 cpu_fans;
> +    u8 gpu_fans;
>  };
> 
>  static struct quirk_entry *quirks;
> @@ -312,6 +330,10 @@ static void __init set_quirks(void)
> 
>      if (quirks->brightness)
>          interface->capability |= ACER_CAP_BRIGHTNESS;
> +
> +    if (quirks->turbo)
> +        gaming_interface->capability |= ACER_CAP_TURBO_OC | ACER_CAP_TURBO_LED
> +                | ACER_CAP_TURBO_FAN;

Just use interface->capability here.

>  }
> 
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -340,6 +362,12 @@ static struct quirk_entry quirk_acer_travelmate_2490 = {
>      .mailled = 1,
>  };
> 
> +static struct quirk_entry quirk_acer_predator_ph315_53 = {
> +    .turbo = 1,
> +    .cpu_fans = 1,
> +    .gpu_fans = 1,
> +};
> +
>  /* This AMW0 laptop has no bluetooth */
>  static struct quirk_entry quirk_medion_md_98300 = {
>      .wireless = 1,
> @@ -507,6 +535,15 @@ static const struct dmi_system_id acer_quirks[]
> __initconst = {
>          },
>          .driver_data = &quirk_acer_travelmate_2490,
>      },
> +    {
> +        .callback = dmi_matched,
> +        .ident = "Acer Predator PH315-53",
> +        .matches = {
> +            DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +            DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH315-53"),
> +        },
> +        .driver_data = &quirk_acer_predator_ph315_53,
> +    },
>      {
>          .callback = set_force_caps,
>          .ident = "Acer Aspire Switch 10E SW3-016",
> @@ -903,7 +940,7 @@ static acpi_status __init AMW0_set_capabilities(void)
>       */
>      if (wmi_has_guid(AMW0_GUID2)) {
>          if ((quirks != &quirk_unknown) ||
> -            !AMW0_set_cap_acpi_check_device())
> +            !AMW0_set_cap_acpi_check_device())
>              interface->capability |= ACER_CAP_WIRELESS;
>          return AE_OK;
>      }

Unrelated whitespace change, please drop.

> @@ -1344,6 +1381,93 @@ static struct wmi_interface wmid_v2_interface = {
>      .type = ACER_WMID_v2,
>  };
> 
> +
> +/*
> + * WMID Gaming interface
> + */
> +
> +static struct wmi_interface wmid_gaming_interface = {
> +    .type = ACER_WMID_GAMING
> +};

Not necessary, please drop.

> +
> +static acpi_status
> +WMI_gaming_execute_u64(u32 method_id, u64 in, u64 *out)
> +{
> +    struct acpi_buffer input = { (acpi_size) sizeof(u64), (void *)(&in) };
> +    struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> +    union acpi_object *obj;
> +    u32 tmp = 0;
> +    acpi_status status;
> +
> +    status = wmi_evaluate_method(WMID_GUID4, 0, method_id, &input, &result);
> +
> +    if (ACPI_FAILURE(status))
> +        return status;
> +    obj = (union acpi_object *) result.pointer;
> +
> +    if (obj) {
> +        if (obj->type == ACPI_TYPE_BUFFER &&
> +            (obj->buffer.length == sizeof(u32) ||
> +             obj->buffer.length == sizeof(u64))) {
> +            tmp = *((u64 *) obj->buffer.pointer);

You need to have a separate case for length == sizeof(u32), in that
case you must use:

		tmp = *((u32 *) obj->buffer.pointer);

So that you don't read beyond the end of the buffer.

> +        } else if (obj->type == ACPI_TYPE_INTEGER) {
> +            tmp = (u64) obj->integer.value;
> +        }
> +    }
> +
> +    if (out)
> +        *out = tmp;
> +
> +    kfree(result.pointer);
> +
> +    return status;
> +}
> +
> +static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
> +{
> +    u32 method_id = 0;
> +
> +    switch (cap) {
> +    case ACER_CAP_TURBO_LED:
> +        method_id = ACER_WMID_SET_GAMING_LED_METHODID;
> +        break;
> +    case ACER_CAP_TURBO_FAN:
> +        method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
> +        break;
> +    case ACER_CAP_TURBO_OC:
> +        method_id = ACER_WMID_SET_GAMING_MISC_SETTING_METHODID;
> +        break;
> +    default:
> +        return AE_ERROR;

AE_BAD_PARAMETER ?

> +    }
> +    return WMI_gaming_execute_u64(method_id, value, NULL);
> +}
> +
> +static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
> +{
> +    acpi_status status;
> +    u64 result;
> +    u64 input;
> +    u32 method_id;
> +
> +
> +    switch (cap) {
> +    case ACER_CAP_TURBO_LED:
> +        method_id = ACER_WMID_GET_GAMING_LED_METHODID;
> +        input = 0x1;
> +        break;
> +    default:
> +        return AE_ERROR;

AE_BAD_PARAMETER ?

> +    }
> +
> +    status = WMI_gaming_execute_u64(method_id, input, &result);
> +    if (ACPI_SUCCESS(status))
> +        *value = (u64) result;
> +
> +    return status;
> +}
> +
> +
>  /*
>   * Generic Device (interface-independent)
>   */
> @@ -1374,7 +1498,6 @@ static acpi_status get_u32(u32 *value, u32 cap)
>              status = WMID_get_u32(value, cap);
>          break;
>      }
> -
>      return status;
>  }
> 

Unrelated whitespace change, please drop.

> @@ -1422,6 +1545,34 @@ static acpi_status set_u32(u32 value, u32 cap)
>      return AE_BAD_PARAMETER;
>  }
> 
> +static acpi_status set_u64(u64 value, u32 cap)
> +{
> +    if (gaming_interface->capability & cap) {

Just use interface->capability here and move this
check into WMID_gaming_set_u64() and drop this
(set_u64) function and instead use WMID_gaming_set_u64()
directly.

If the WMID_GUID4 GUID does not exist then wmi_evaluate_method()
will catch this.


> +        switch (gaming_interface->type) {
> +        case ACER_WMID_GAMING:
> +            return WMID_gaming_set_u64(value, cap);
> +        default:
> +            return AE_BAD_PARAMETER;
> +        }
> +    }
> +    return AE_BAD_PARAMETER;
> +}
> +
> +
> +static acpi_status get_u64(u64 *value, u32 cap)
> +{
> +    acpi_status status = AE_ERROR;
> +
> +    if (gaming_interface->capability & cap) {

Same here.

> +        switch (gaming_interface->type) {
> +        case ACER_WMID_GAMING:
> +            status = WMID_gaming_get_u64(value, cap);
> +            break;
> +        }
> +    }
> +    return status;
> +}
> +
>  static void __init acer_commandline_init(void)
>  {
>      /*
> @@ -1501,7 +1652,7 @@ static int acer_backlight_init(struct device *dev)
>      props.type = BACKLIGHT_PLATFORM;
>      props.max_brightness = max_brightness;
>      bd = backlight_device_register("acer-wmi", dev, NULL, &acer_bl_ops,
> -                       &props);
> +                       &props);
>      if (IS_ERR(bd)) {
>          pr_err("Could not register Acer backlight device\n");
>          acer_backlight_device = NULL;

Unrelated whitespace change, please drop.

> @@ -1575,6 +1726,67 @@ static int acer_gsensor_event(void)
>      return 0;
>  }
> 
> +/*
> + *  Predator series turbo button
> + */
> +static int acer_toggle_turbo(void)
> +{
> +    /* Get current state from turbo button */
> +    u64 turbo_led_state, gpu_fan_config1, gpu_fan_config2;
> +    u8 i;
> +
> +    if (ACPI_FAILURE(get_u64(&turbo_led_state, ACER_CAP_TURBO_LED)))
> +        return -1;
> +
> +    if (turbo_led_state) {
> +        // turns off turbo led
> +        set_u64(0x1, ACER_CAP_TURBO_LED);
> +
> +        // set FAN mode to auto
> +        if (quirks->cpu_fans > 0)
> +            gpu_fan_config2 |= 1;
> +        for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +            gpu_fan_config2 |= 1 << (i + 1);
> +        for (i = 0; i < quirks->gpu_fans; ++i)
> +            gpu_fan_config2 |= 1 << (i + 3);
> +        if (quirks->cpu_fans > 0)
> +            gpu_fan_config1 |= 1;
> +        for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +            gpu_fan_config1 |= 1 << (2 * i + 2);
> +        for (i = 0; i < quirks->gpu_fans; ++i)
> +            gpu_fan_config1 |= 1 << (2 * i + 6);
> +        set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);
> +
> +        // set OC to normal
> +        set_u64(0x5, ACER_CAP_TURBO_OC);
> +        set_u64(0x7, ACER_CAP_TURBO_OC);
> +    } else {
> +        // turn on turbo led
> +        set_u64(0x10001, ACER_CAP_TURBO_LED);
> +
> +        // set FAN to turbo mode
> +        if (quirks->cpu_fans > 0)
> +            gpu_fan_config2 |= 1;
> +        for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +            gpu_fan_config2 |= 1 << (i + 1);
> +        for (i = 0; i < quirks->gpu_fans; ++i)
> +            gpu_fan_config2 |= 1 << (i + 3);
> +        if (quirks->cpu_fans > 0)
> +            gpu_fan_config1 |= 2;
> +        for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> +            gpu_fan_config1 |= 2 << (2 * i + 2);
> +        for (i = 0; i < quirks->gpu_fans; ++i)
> +            gpu_fan_config1 |= 2 << (2 * i + 6);
> +        set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);
> +
> +        // set OC to turbo mode
> +        set_u64(0x205, ACER_CAP_TURBO_OC);
> +        set_u64(0x207, ACER_CAP_TURBO_OC);
> +    }
> +    return turbo_led_state;
> +}
> +
> +
>  /*
>   * Switch series keyboard dock status
>   */
> @@ -1605,7 +1817,7 @@ static void acer_kbd_dock_get_initial_state(void)
>      status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input_buf, &output_buf);
>      if (ACPI_FAILURE(status)) {
>          pr_err("Error getting keyboard-dock initial status: %s\n",
> -               acpi_format_exception(status));
> +               acpi_format_exception(status));
>          return;
>      }
>

Unrelated whitespace change, please drop.
 
> @@ -1618,7 +1830,7 @@ static void acer_kbd_dock_get_initial_state(void)
>      output = obj->buffer.pointer;
>      if (output[0] != 0x00 || (output[3] != 0x05 && output[3] != 0x45)) {
>          pr_err("Unexpected output [0]=0x%02x [3]=0x%02x getting
> keyboard-dock initial status\n",
> -               output[0], output[3]);
> +               output[0], output[3]);
>          goto out_free_obj;
>      }
> 

Unrelated whitespace change, please drop.

> @@ -1759,7 +1971,7 @@ static int acer_rfkill_init(struct device *dev)
>      rfkill_inited = true;
> 
>      if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
> -        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
> +        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
>          schedule_delayed_work(&acer_rfkill_work,
>              round_jiffies_relative(HZ));
> 

Unrelated whitespace change, please drop.

> @@ -1782,7 +1994,7 @@ static int acer_rfkill_init(struct device *dev)
>  static void acer_rfkill_exit(void)
>  {
>      if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
> -        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
> +        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
>          cancel_delayed_work_sync(&acer_rfkill_work);
> 
>      if (has_cap(ACER_CAP_WIRELESS)) {

Unrelated whitespace change, please drop.

> @@ -1872,6 +2084,10 @@ static void acer_wmi_notify(u32 value, void *context)
>          acer_gsensor_event();
>          acer_kbd_dock_event(&return_value);
>          break;
> +    case WMID_GAMING_TURBO_KEY_EVENT:
> +        if (return_value.key_num == 0x4)
> +            acer_toggle_turbo();
> +        break;
>      default:
>          pr_warn("Unknown function number - %d - %d\n",
>              return_value.function, return_value.key_num);
> @@ -2251,8 +2467,8 @@ static int __init acer_wmi_init(void)
>       * in the past quirk list.
>       */
>      if (wmi_has_guid(AMW0_GUID1) &&
> -        !dmi_check_system(amw0_whitelist) &&
> -        quirks == &quirk_unknown) {
> +        !dmi_check_system(amw0_whitelist) &&
> +        quirks == &quirk_unknown) {
>          pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
>          return -ENODEV;
>      }

Unrelated whitespace change, please drop.

> @@ -2266,8 +2482,11 @@ static int __init acer_wmi_init(void)
>      if (!wmi_has_guid(AMW0_GUID1) && wmi_has_guid(WMID_GUID1))
>          interface = &wmid_interface;
> 
> -    if (wmi_has_guid(WMID_GUID3))
> +    if (wmi_has_guid(WMID_GUID3)) {
>          interface = &wmid_v2_interface;
> +        if (wmi_has_guid(WMID_GUID4))
> +            gaming_interface = &wmid_gaming_interface;
> +    }
> 

Since we don't need the gaming_interface this entire chunk
can be dropped too.

>      if (interface)
>          dmi_walk(type_aa_dmi_decode, NULL);
> @@ -2316,7 +2535,7 @@ static int __init acer_wmi_init(void)
>          interface->capability = force_caps;
> 
>      if (wmi_has_guid(WMID_GUID3) &&
> -        (interface->capability & ACER_CAP_SET_FUNCTION_MODE)) {
> +        (interface->capability & ACER_CAP_SET_FUNCTION_MODE)) {
>          if (ACPI_FAILURE(acer_wmi_enable_rf_button()))
>              pr_warn("Cannot enable RF Button Driver\n");
> 

Unrelated whitespace change, please drop.


Regards,

Hans


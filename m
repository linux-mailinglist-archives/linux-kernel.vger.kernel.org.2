Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF81C3D89F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhG1Ip4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhG1Ipz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:45:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD26C061757;
        Wed, 28 Jul 2021 01:45:53 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so1321322otu.8;
        Wed, 28 Jul 2021 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMMCLcPJVgcGCj/avVty54K/TQgpNAa+k5yTqQuOHhA=;
        b=U5X5pJgXseiDMghw6fLUnztURtLfErd0jIcftTOZu0cux6U1BAvtCSNrTB4eX/vIZ1
         vznHKQU9BVeBiEoOHvtanrbGBVTo7OX8JXybFtuSPhfz9wI27qKE68IE/hcB11O2DJpH
         cIMygMd5Fo//6FSMGcv8iFWInr6ZjoiskeEB4ZY4ZAoSIOpsNU3j1AGbbtfFikBlDy7P
         Y5sj9QnfljWgIyCdHEbjUZaY9RozLRQLg5j9ydBzArMZVZsFvyTKcwmgbQkCz6iRNzsW
         WWABgej+JjD4DoLoUe0//UAqg7IIKAdXJd0MAW9MXNoa/CEreArNi+CCSxD1A/u2mqz2
         cscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMMCLcPJVgcGCj/avVty54K/TQgpNAa+k5yTqQuOHhA=;
        b=At+QXYkIwzOJ3Q1xhf5Lxw+0zAN5v6yUqMQV0sCWXdynGPcmppc5G5GJeSAqHuJi8j
         LHe/sgAu00oXlonnRo5lraEsRQNAEdmrhRPCg12bMB1nC1Ya2Lrxi9STIMCMDMzBYEQ2
         D7wtQKKzQ58RZL+UcIxVyP787UNs2oKqRTeLkzgjMtW3IojCUv056+ioPD7Mh9zOJVOP
         35liBLgiM7SQyf9BrVR8DnkmFL9vkC8VPeR+juy9rijig0I+X5GSSOOXwW8LibofI53H
         T4TS4IL1lKqu0EQ0G2MDswSN/HM1TZXTi/MTNxsfTaaAstgEZIeFBYs0vp2d0+ygdEmc
         dHzA==
X-Gm-Message-State: AOAM531wmTV3NAMjTk/lFTd1IheSRS16MSvPM+jFdGtoqozyPyGEoSia
        O+GNgkMhhiowMgCzxpL9C0s90vLugOh/w6iXG10=
X-Google-Smtp-Source: ABdhPJwJvGnbfGjlMExpj/WwdfKnxRos3y8l2Y3xFIIrETl6gCOxLCZYI4oQ+W3jliBBtKAAGznt3CcP2eeOzEcHLRk=
X-Received: by 2002:a05:6830:544:: with SMTP id l4mr17959770otb.164.1627461952569;
 Wed, 28 Jul 2021 01:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMW3L+2yurdggGpYSHZw6x07SboxqYRrDA6B699=SagAVp6Euw@mail.gmail.com>
In-Reply-To: <CAMW3L+2yurdggGpYSHZw6x07SboxqYRrDA6B699=SagAVp6Euw@mail.gmail.com>
From:   Jafar Akhondali <jafar.akhoondali@gmail.com>
Date:   Wed, 28 Jul 2021 13:15:41 +0430
Message-ID: <CAMW3L+03N2bFK2YFwQDgc_S9ajDpT2GbCL9H4+WWEchGq58Ogg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: acer-wmi: Add Turbo Mode support for
 Acer PH315-53
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     jlee@suse.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mgross@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm looking forward to comments on this patch.
Also as turbo mode is usually available only in gaming laptops, I've
also uploaded a demo video using this patch:
https://www.youtube.com/watch?v=sQ5TW30VuFc

Thanks in Advance


On Mon, Jul 12, 2021 at 2:55 AM Jafar Akhondali
<jafar.akhoondali@gmail.com> wrote:
>
> Looks like the previous patch got some indentation problems, here is
> the fixed version.
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
> @@ -59,7 +61,10 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_SET_BRIGHTNESS_METHODID    6
>  #define ACER_WMID_GET_THREEG_METHODID        10
>  #define ACER_WMID_SET_THREEG_METHODID        11
> -
> +#define ACER_WMID_SET_GAMING_LED_METHODID 2
> +#define ACER_WMID_GET_GAMING_LED_METHODID 4
> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
> +#define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
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
> @@ -1422,6 +1545,34 @@ static acpi_status set_u32(u32 value, u32 cap)
>      return AE_BAD_PARAMETER;
>  }
>
> +static acpi_status set_u64(u64 value, u32 cap)
> +{
> +    if (gaming_interface->capability & cap) {
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
> @@ -1759,7 +1971,7 @@ static int acer_rfkill_init(struct device *dev)
>      rfkill_inited = true;
>
>      if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
> -        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
> +        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
>          schedule_delayed_work(&acer_rfkill_work,
>              round_jiffies_relative(HZ));
>
> @@ -1782,7 +1994,7 @@ static int acer_rfkill_init(struct device *dev)
>  static void acer_rfkill_exit(void)
>  {
>      if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
> -        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
> +        has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
>          cancel_delayed_work_sync(&acer_rfkill_work);
>
>      if (has_cap(ACER_CAP_WIRELESS)) {
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
> --
> 2.27.0

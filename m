Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89AC371144
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhECFdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhECFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:33:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:32:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v6so5392145ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+x9X+bH9sVIQ7YhvysouTeiyyXRivn1vpvp9jCbJ/A=;
        b=MlUPJ8cVgmBivf5rX8Cdn25uK5zo5i6ImJV9Xvcp1dTtH+2/zGlukHMVhK7Cp+i1Ly
         jn/Sa5pWbXbVw4raldm7Pt0215esET2yMzV5Wf/h/m6NXP1UDpjP7R4wdm1kbiy2GtWi
         w4Kkq1KwliNHOsLIXL0uxGzokOpHnsJdfR5c0r/7RvE6d0AENXCw3vgXi3GwIGteWvNG
         FcjidFNOFxVOQ8RaFMEyFAo3kO0th4X2q7BPIrHeOthIUJB9aRW0SMOc7ZIgz0RPQpNT
         KKWzwWJjUDaISDq2cYwE+z5o9tdePsLLc9cdV/2AZA7skfrCbp3SENw2oyWXIa9VSDFX
         WcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+x9X+bH9sVIQ7YhvysouTeiyyXRivn1vpvp9jCbJ/A=;
        b=kk5m3333JCHHqZBMcJNz7LK/0qmcnUMLBpw/7J+j0VpcfPpKFwjrEX46D28Uewkv1B
         G9k6F6f9MhgZL1HtFuurxcc05fUkQti2iFz3DFESpGa1FmDF5UxTq5VvuVdqjpZqGala
         HZahg74/glMVNhZOL9JhJT/MhJ6uLsiotMMQVSL8AqT1pGbIrmhKYQu1f60mQNlOvjP7
         T571J13ZfT9TUtP7IpTmZvgruXP5/YF1MwbesRZlT3IgcABf0wAjVFV9evsuZSx4Kg8a
         At0ScxAygQxQ53VC/qQGZ+rXsmk95vblSt3gClrkvNSXAS9UFse8R55Oc9J0HVBuPqNy
         33NQ==
X-Gm-Message-State: AOAM530meD4UuBBrKadtTALXbf/+yfmb2F1j2XGLmFBny5EBVs1SvNnf
        dgfP6tbHt5+a+BIODZ/MUpJed2UYSdwWf1PxwUAy1A==
X-Google-Smtp-Source: ABdhPJx4yaGFvb9iHAdHysyvdFWzFQ1snaGsMOViAQAGAMCBJHwCSKUUuMB0yV4s0/wZFQdgBb/wlvsz2z0EXdDzRpw=
X-Received: by 2002:a2e:8797:: with SMTP id n23mr12234159lji.347.1620019969150;
 Sun, 02 May 2021 22:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775@changeid>
In-Reply-To: <20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 3 May 2021 13:32:38 +0800
Message-ID: <CAJQfnxHcag62zp4_0R9=KomC7FJB=xaRbmfaHsTp8JrOgkV9Pg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Add driver capabilities for RTL8822CS
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     drinkcat@chromium.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers,

Could you take another look at this patch?

Thanks,
Archie


On Sat, 10 Oct 2020 at 04:32, Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Certain controller capabilities must be exposed by the driver because it
> can't be queried from HCI (wideband speech support, for example). Update
> the match data structure to set the supported capabilities and set the
> proper quirks on hdev after registering the device.
>
> Also update the 8822CS capabilities to show it supports wideband speech
> and has valid le states (allows central peripheral role).
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  drivers/bluetooth/hci_h5.c | 53 +++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index a10d710fc3f13e..3833a2d276665f 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -97,6 +97,11 @@ struct h5 {
>         struct gpio_desc *device_wake_gpio;
>  };
>
> +enum h5_capabilities {
> +       H5_CAP_WIDEBAND_SPEECH = BIT(0),
> +       H5_CAP_VALID_LE_STATES = BIT(1),
> +};
> +
>  struct h5_vnd {
>         int (*setup)(struct h5 *h5);
>         void (*open)(struct h5 *h5);
> @@ -106,6 +111,11 @@ struct h5_vnd {
>         const struct acpi_gpio_mapping *acpi_gpio_map;
>  };
>
> +struct h5_device_data {
> +       uint32_t capabilities;
> +       struct h5_vnd *vnd;
> +};
> +
>  static void h5_reset_rx(struct h5 *h5);
>
>  static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
> @@ -791,7 +801,10 @@ static const struct hci_uart_proto h5p = {
>  static int h5_serdev_probe(struct serdev_device *serdev)
>  {
>         struct device *dev = &serdev->dev;
> +       struct hci_dev *hdev;
>         struct h5 *h5;
> +       const struct h5_device_data *data;
> +       int err;
>
>         h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
>         if (!h5)
> @@ -808,23 +821,21 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>                 if (!match)
>                         return -ENODEV;
>
> -               h5->vnd = (const struct h5_vnd *)match->driver_data;
> +               data = (const struct h5_device_data *)match->driver_data;
> +               h5->vnd = data->vnd;
>                 h5->id  = (char *)match->id;
>
>                 if (h5->vnd->acpi_gpio_map)
>                         devm_acpi_dev_add_driver_gpios(dev,
>                                                        h5->vnd->acpi_gpio_map);
>         } else {
> -               const void *data;
> -
>                 data = of_device_get_match_data(dev);
>                 if (!data)
>                         return -ENODEV;
>
> -               h5->vnd = (const struct h5_vnd *)data;
> +               h5->vnd = data->vnd;
>         }
>
> -
>         h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
>         if (IS_ERR(h5->enable_gpio))
>                 return PTR_ERR(h5->enable_gpio);
> @@ -834,7 +845,20 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>         if (IS_ERR(h5->device_wake_gpio))
>                 return PTR_ERR(h5->device_wake_gpio);
>
> -       return hci_uart_register_device(&h5->serdev_hu, &h5p);
> +       err = hci_uart_register_device(&h5->serdev_hu, &h5p);
> +       if (err)
> +               return err;
> +
> +       hdev = h5->serdev_hu.hdev;
> +
> +       /* Set match specific quirks */
> +       if (data->capabilities & H5_CAP_WIDEBAND_SPEECH)
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> +
> +       if (data->capabilities & H5_CAP_VALID_LE_STATES)
> +               set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +
> +       return 0;
>  }
>
>  static void h5_serdev_remove(struct serdev_device *serdev)
> @@ -1000,12 +1024,21 @@ static struct h5_vnd rtl_vnd = {
>         .resume         = h5_btrtl_resume,
>         .acpi_gpio_map  = acpi_btrtl_gpios,
>  };
> +
> +static const struct h5_device_data h5_data_rtl8822cs = {
> +       .capabilities = H5_CAP_WIDEBAND_SPEECH | H5_CAP_VALID_LE_STATES,
> +       .vnd = &rtl_vnd,
> +};
> +
> +static const struct h5_device_data h5_data_rtl8723bs = {
> +       .vnd = &rtl_vnd,
> +};
>  #endif
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id h5_acpi_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
> -       { "OBDA8723", (kernel_ulong_t)&rtl_vnd },
> +       { "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs},
>  #endif
>         { },
>  };
> @@ -1019,9 +1052,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
>  static const struct of_device_id rtl_bluetooth_of_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
>         { .compatible = "realtek,rtl8822cs-bt",
> -         .data = (const void *)&rtl_vnd },
> +         .data = &h5_data_rtl8822cs,
> +       },
>         { .compatible = "realtek,rtl8723bs-bt",
> -         .data = (const void *)&rtl_vnd },
> +         .data = &h5_data_rtl8723bs,
> +       },
>  #endif
>         { },
>  };
> --
> 2.28.0.1011.ga647a8990f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chromium.org.
> To view this discussion on the web visit https://groups.google.com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/20201009133147.1.Ie792480ac24829a48669e83c0045157eb3d46775%40changeid.

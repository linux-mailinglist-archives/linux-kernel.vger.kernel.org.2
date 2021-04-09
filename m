Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16FC35A4B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhDIRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhDIRdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:33:18 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8BC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:33:05 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id z23so898839uan.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oabdM8jRxHNDcjomZqbQRjSlgoKt15wAzyQGzFiwnNw=;
        b=BwX/YPvs1OM4ve4WFxiRz+9C6cY4rhSvlDXWbnqT2g9Dy3ic1FdirzwvJkmnOx7K/m
         1lfLwV/RMnDmcOZL6MEVM+O56lcYlgcq4Le21TXLQfUAUZ4qF0SyM+jkEJGF7WlPHOTp
         uamBsSUhRBHdb7eJWIbK9yoSq0yY0ZtViDoAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oabdM8jRxHNDcjomZqbQRjSlgoKt15wAzyQGzFiwnNw=;
        b=NhwOMl1mCihsvGG5H418EhZsRxg/Mpo/qv0K3pMV+FdeZPNEFS8lcgtjX9RcD+Co0Z
         hMYGOyG/MuOphfIu0U6o4qRRPm1eBG8Lr721PzvQq3lewyilYMJt9SHLviQWQXIBjLZ+
         MtWXG844r8DQDSH3r4vJ8Vi5eX9WKjwb/xw5rxHyUQDkkOCct9KlqYjBP/F6ihtsrRVL
         fKHXHtbKMgO/umxLP/iJkPX353KiHEpOeIexogBDcnS+jfckdJ32uZIEACCQC8+w0NSF
         gmMJYFJ9Uvfbzxn1ZAAcPPEfdstWQnV89qh8twdVr1bg7NJgGEBp9CINf4UyKfskRpSs
         vZTg==
X-Gm-Message-State: AOAM530Drsr+zSo5yHZiid/gv5gBO7PluyH5wjSIOfoDeSnVUKCz3/3M
        GLCKGSJrXoRAGPA/WjuEc7tZpknZr0OuPMtR
X-Google-Smtp-Source: ABdhPJz5XzF7weMGeM87oB5uYlA68LcuTetVn/3E+gz1Tlk67aZO+Nauhxn0yVvPxSOLkuyPt+cBEA==
X-Received: by 2002:ab0:7317:: with SMTP id v23mr12227797uao.9.1617989584255;
        Fri, 09 Apr 2021 10:33:04 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id j124sm310185vke.32.2021.04.09.10.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:33:03 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id k124so3317428vsk.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:33:03 -0700 (PDT)
X-Received: by 2002:a67:d994:: with SMTP id u20mr12243960vsj.29.1617989582125;
 Fri, 09 Apr 2021 10:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <1617778157-11007-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1617778157-11007-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 9 Apr 2021 10:32:50 -0700
X-Gmail-Original-Message-ID: <CA+jURcvgOf5NYONj8u-WN6euBkyYbBOv7GJxF=iiDmZ-y8dA_A@mail.gmail.com>
Message-ID: <CA+jURcvgOf5NYONj8u-WN6euBkyYbBOv7GJxF=iiDmZ-y8dA_A@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Skip ELAN power-on command after reset
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>,
        Douglas Anderson <dianders@chromium.org>,
        Jingle <jingle.wu@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 23:49, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> Previous commit 43b7029f475e ("HID: i2c-hid:
> Send power-on command after reset"), it fixed issue for SIS touchscreen.
>
> For ELAN touchscreen, we found our boot code of IC was not flexible enough
> to receive and handle this command.
> Once the FW main code of our controller is crashed for some reason,
> the controller could not be enumerated successfully to be recognized
> by the system host. therefore, it lost touch functionality.
>
> Add quirk for skip send power-on command after reset.
> It will impact to ELAN touchscreen and touchpad on HID over I2C projects.
>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 9993133..6b407f7 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -45,6 +45,7 @@
>  #define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>  #define I2C_HID_QUIRK_RESET_ON_RESUME          BIT(5)
>  #define I2C_HID_QUIRK_BAD_INPUT_SIZE           BIT(6)
> +#define I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET    BIT(7)
>
>
>  /* flags */
> @@ -157,6 +158,10 @@ struct i2c_hid {
>         struct i2chid_ops       *ops;
>  };
>
> +/*
> + * Sending the wakeup after reset actually break ELAN touchscreen controller
> + * So add I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET to skip wakeup after reset
> + */

You should put this comment next to the quirk entry itself, since it
doesn't apply to the whole list.

>  static const struct i2c_hid_quirks {
>         __u16 idVendor;
>         __u16 idProduct;
> @@ -178,6 +183,8 @@ static const struct i2c_hid_quirks {
>                  I2C_HID_QUIRK_RESET_ON_RESUME },
>         { USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
>                 I2C_HID_QUIRK_BAD_INPUT_SIZE },

(comment should go here)

> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +                I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET },
>         { 0, 0 }
>  };
>
> @@ -461,7 +468,8 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>         }
>
>         /* At least some SIS devices need this after reset */
> -       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> +       if (!(ihid->quirks & I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET))
> +               ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>
>  out_unlock:
>         mutex_unlock(&ihid->reset_lock);
> --
> 2.7.4
>

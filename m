Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB6387FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbhERScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbhERScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:32:48 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC94C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:31:26 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 105so3554007uak.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlRGZjJj/DKd/6vvvywZgHdNgo8vhcAzP5bk7gbmXl0=;
        b=AuvCRx3Na55hsRvVQ7Qk8LH6h99ctF/osTMPFdCw7akw3Ac2ptsnHStAt+bSDdXmG8
         T/XBdXL3HqF43XXB2OKKIbBKPLE3lH4W6ZcGO84HdRgortMEE9FQ3EuXX6qrRTGQQcxo
         qo674H23wgrtKpCwBVTtpBMPcplJIdNLm+PZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlRGZjJj/DKd/6vvvywZgHdNgo8vhcAzP5bk7gbmXl0=;
        b=aLD/v5JqCEvoB1Qs0waJP9q75kKVgvHBsUW3/Ee+V/sO1Fdjvye3lYTHSaoB1V41Ae
         CtDmHnnffaRgg5Ie0yb4E63BVRPLSSMOVc8fuvYT4HjqhzJIgi6rLszou3lTohZ+XgGQ
         p1nPXN6moPtrfYcuZrBZy13U6hHf2preHKYpwYEXE/NYVh3vdLr0JnqVE75b2MaSW/jo
         13hjZTVus2bVd3VOCPMIbVH/teYrXwi3gMpZ1gdoHtElSAsYfLC1DMLV6x0d09ilNhex
         205v3kDSw7CbQOFakZfWcp7kfTDXPrDncAp4J3VTPrztHEMmceVv+Q2DNHqrBOVHY2fY
         KchA==
X-Gm-Message-State: AOAM532RXMpyGhbSKvIfHvs7TBk8IO1k2k/wjbZiPXnh8dPh0zQsxc1m
        c3pXEDBcilrYfwgXyG+EPhRydBcxBm31aXL2
X-Google-Smtp-Source: ABdhPJwyS4/QdtqOE6lH+e4CtvRRMp6PiFB1Ov3DIpPrP3w/E7APydrt0bqyXQpn0gLAW4qiXNnMUQ==
X-Received: by 2002:ab0:20d0:: with SMTP id z16mr8134014ual.33.1621362684752;
        Tue, 18 May 2021 11:31:24 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id d12sm2905791vsc.8.2021.05.18.11.31.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 11:31:24 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id f15so4131747vsq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:31:23 -0700 (PDT)
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr5179662vss.29.1621362682979;
 Tue, 18 May 2021 11:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <1621301832-25479-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1621301832-25479-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Tue, 18 May 2021 11:31:12 -0700
X-Gmail-Original-Message-ID: <CA+jURcvXr7UpQjKMCmNJwkiaxB6eACxDs4Rq8G+zEsrqO2UM3A@mail.gmail.com>
Message-ID: <CA+jURcvXr7UpQjKMCmNJwkiaxB6eACxDs4Rq8G+zEsrqO2UM3A@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Add I2C_HID_QUIRK_NO_DELAY_AFTER_PWR_ON
 to optimize timing
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
        Jingle <jingle.wu@emc.com.tw>, Paris Yeh <pyeh@google.com>,
        "sukumar . ghorai" <sukumar.ghorai@intel.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 at 18:37, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> There is a hard coding 60ms delay after I2C_HID_PWR_ON commadn.
> Elan didn't need the delay, so we add a quirk to reduce boot time and resume time.
>
> Fixed: eef4016243e9("HID: i2c-hid: Always sleep 60ms after I2C_HID_PWR_ON commands")
>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>

Reviewed-by: Harry Cutts <hcutts@chromium.org>

> ---
> Change in v2:
>     - Modify Optimized tag to Fixed tag
>     - Modify comment for i2c_hid_quirks
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 9993133..f4ee690 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -45,6 +45,7 @@
>  #define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>  #define I2C_HID_QUIRK_RESET_ON_RESUME          BIT(5)
>  #define I2C_HID_QUIRK_BAD_INPUT_SIZE           BIT(6)
> +#define I2C_HID_QUIRK_NO_DELAY_AFTER_PWR_ON    BIT(8)
>
>
>  /* flags */
> @@ -178,6 +179,11 @@ static const struct i2c_hid_quirks {
>                  I2C_HID_QUIRK_RESET_ON_RESUME },
>         { USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
>                 I2C_HID_QUIRK_BAD_INPUT_SIZE },
> +       /*
> +        * Elan devices don't need delay after I2C_HID_PWR_ON
> +        */
> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +                I2C_HID_QUIRK_NO_DELAY_AFTER_PWR_ON },
>         { 0, 0 }
>  };
>
> @@ -427,7 +433,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>          * PWR_ON requests. Testing has confirmed that several devices
>          * will not work properly without a delay after a PWR_ON request.
>          */
> -       if (!ret && power_state == I2C_HID_PWR_ON)
> +       if (!ret && power_state == I2C_HID_PWR_ON &&
> +           !(ihid->quirks & I2C_HID_QUIRK_NO_DELAY_AFTER_PWR_ON))
>                 msleep(60);
>
>         return ret;
> --
> 2.7.4
>

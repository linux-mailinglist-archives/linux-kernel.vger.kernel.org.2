Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE71937664A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhEGNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236049AbhEGNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620394732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lBldkVI1Lz29e5G5ZcuHtAMgpbsiACK1LzJjPj1N0E=;
        b=cYmlm2XVt2Tn7ovvlKKyC7o19t9KVJhr41IkaBeo1c5ro3OWrSijjZdW2FKLV65Qxp4J48
        bu/OZq3zkBtQF3MIIKxuW7gmYV7s3r5BHoeWMrOgOg82raf7JHlrxRa/skCTS6z52Bkih6
        4OrPSPPWcKwXSSBVFUhH6Igh4c0R1Z0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-pMTVdwy0Ptyu2aJpR3rJMQ-1; Fri, 07 May 2021 09:38:48 -0400
X-MC-Unique: pMTVdwy0Ptyu2aJpR3rJMQ-1
Received: by mail-pg1-f197.google.com with SMTP id g5-20020a63f4050000b02901f6c7b9a6d0so5426985pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 06:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lBldkVI1Lz29e5G5ZcuHtAMgpbsiACK1LzJjPj1N0E=;
        b=B3ELsavBaBK/oMPKNfs92VGwQNf81TtYh8DgCD7OvwtsKoxSUA6cH+vC7O2q45Qypc
         QQHAFdICTKZuMOPJwMZcDjglX8NX5Lh3TrRMUsOzTApJnTL/5uL/aqdx3KtBq3lGkDNE
         h2B6qjmwIDi0+bE42Y19RunomMBWSSbYK3FqfMjoPKk5/uct3xfozMFaE7ILm7HemdHq
         5uUjLKMwXoiaxofreZuy+hE9at6ZaK4hPpIQEsUO1SYkRDewsp8UZK2QlG3Htinui7p+
         wG6fHtlGlMxIxsPBQ2ywvol6ARiUlrxyCxHlYRZ7O+/SfzHMrEU+vdajFUqZjPlCPG8G
         8pIQ==
X-Gm-Message-State: AOAM5308G7Y9ihD1a2qHQJ4WUAt0hn393qx9I6kZ9fmPAQGOV/G/C9go
        MD4dBT6hNV5RtUPDq1jgFDQOwpj2zKD9R/tAbFJeMZzkAhyrHA7bLQwd5O4gGzGity7miQzSNip
        WigiMfDAjRo/oGHqf7aJuPpYZuNWUO7mVMICHY8wA
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr10768507pjr.234.1620394727616;
        Fri, 07 May 2021 06:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTx0E1DzDaW8HBGJ7bD9cKUSs/UfJO/Q2YfaYjiJSZQ898sjau4tHQZy81CQ3yjgb+FYIVmcN7sCgesANTjbs=
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr10768485pjr.234.1620394727364;
 Fri, 07 May 2021 06:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 7 May 2021 15:38:36 +0200
Message-ID: <CAO-hwJL1RFXDTHaMj+rHrERBMhNhYv57TBM1VSoTx2a4OA25NQ@mail.gmail.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Skip ELAN power-on command after reset
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
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

Hi Johnny,

Apologies fo the delay.

When I first saw your patch I wondered why we need a  special case for Elan.
But then, we need a special case for SIS, as mentioned by
43b7029f475e. Given that this patch was in for a year and a half, and
not many people seemed to complain about it, I decided to apply your
patch.


On Tue, Apr 13, 2021 at 3:21 AM Johnny Chuang
<johnny.chuang.emc@gmail.com> wrote:
>
> Fixes: 43b7029f475e ("HID: i2c-hid: Send power-on command after reset").

As requested per Doug, I have moved that Fixes tag at the end, though
I forgot to remove the extra '.' at the end :-(

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
> Changes in V3:
>     - intent the comment at qurik entry
>     - add Fixes:flag for previous commit id
>
> Changes in v2:
>     - move comment to quirk entry
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 9993133..32e3287 100644
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
> @@ -178,6 +179,12 @@ static const struct i2c_hid_quirks {
>                  I2C_HID_QUIRK_RESET_ON_RESUME },
>         { USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
>                 I2C_HID_QUIRK_BAD_INPUT_SIZE },
> +       /*
> +        * Sending the wakeup after reset actually break ELAN touchscreen controller
> +        * Add I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET to skip wakeup after reset

I removed that extra second line.

Also added Cc: stable, and pushed to for-5.13/upstream-fixes

Cheers,
Benjamin

> +        */
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


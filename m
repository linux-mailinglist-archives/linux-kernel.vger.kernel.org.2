Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB314435E98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhJUKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634810752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OGJuGgtDPx6oFIaSi1hNMo6S5k5dak1uMNO1VJPHxFE=;
        b=JHchKhZUf3UVtELN8yItu2f3oJTYB9kQSCX4QFAGwIhzveptzp2tlSVzoWnCgstKzQ0Jdl
        yZaEglBtECVIaMrJJhJ2hxqAON9hI9BNllZUhWbAJvwP5xWc+tn6C2lTcmSm7mszPIurDc
        e9ezRBFl78wyfr1UvbSY8JgKkP+4GMQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-u0DAnYq3OwaDw5xGqNJZjw-1; Thu, 21 Oct 2021 06:05:51 -0400
X-MC-Unique: u0DAnYq3OwaDw5xGqNJZjw-1
Received: by mail-pf1-f198.google.com with SMTP id t79-20020a627852000000b0044d0ecd9f7aso105371pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGJuGgtDPx6oFIaSi1hNMo6S5k5dak1uMNO1VJPHxFE=;
        b=U16Jr2UJVfsKrCkasNmUhrrF0fln6sxBaYZGj4DjTOpyWacYPFywnwvRlXJ9PzH4Lu
         oEmA0HmiaoyRCgqNfje50gaSZ4oDRvH5l9CII5c1khlOFBdOQYmEh7QFgUHx3x3zYJ4Q
         7AlmDaskfLTpvIrbVcomP4EJ0Sbmamzzsdo9s6CqiOKvkVZud/9/jsapftr+GsP/siIc
         Zw1S5139Pb8PAwyk7eVZ3In1pMjezUD9jGRYRb3krdkrfxHUH2bwFoLXbI++K+mwROZ1
         seYpkPUlHwg1FkW6PczRGcrYP2GIisONj3C8Aj72ROnBI4CnanCgbD3+gC78dOFnSFq3
         lXfg==
X-Gm-Message-State: AOAM530yf7yAmT31IaAD30rAP1qIVXPCk+f97FctaD+0kZVA66B3JiS6
        TjsgBUbGfDZzFaQOzri12oPcn6ar4kc4olpcrc/kSM8Zar5qYDo5GvZZJRJGzQMoYRrAycpP4Lh
        oJj1mcvRoJDweBjmQtZYDnp/QtzvCpzGuomL+Foob
X-Received: by 2002:a62:5304:0:b0:44c:719c:a2c with SMTP id h4-20020a625304000000b0044c719c0a2cmr4461591pfb.13.1634810750230;
        Thu, 21 Oct 2021 03:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTESYzdC+s7ND80mBlLJkwm3zpKysVZ2TDB8sOhj9e2qyfKZqcTsjG/GRhajqpBqMfx5LXnPbc9Q1coduy7Pw=
X-Received: by 2002:a62:5304:0:b0:44c:719c:a2c with SMTP id
 h4-20020a625304000000b0044c719c0a2cmr4461563pfb.13.1634810750002; Thu, 21 Oct
 2021 03:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211021095107.116292-1-alistair@alistair23.me> <20211021095107.116292-2-alistair@alistair23.me>
In-Reply-To: <20211021095107.116292-2-alistair@alistair23.me>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Oct 2021 12:05:39 +0200
Message-ID: <CAO-hwJKY7-qyVQmWAe=eejCmtuNEGAA_1f+MgA_uS63Ma7LiiQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] HID: quirks: Invert X/Y values for rM2 Wacom
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:51 AM Alistair Francis
<alistair@alistair23.me> wrote:
>
> Enable the HID_QUIRK_XY_INVERT quirk for the Wacom digitiser used on the
> reMarkable 2.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/hid/hid-ids.h    | 2 ++
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 29564b370341..9dc17bf3e550 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1260,8 +1260,10 @@
>  #define USB_DEVICE_ID_VTL_MULTITOUCH_FF3F      0xff3f
>
>  #define USB_VENDOR_ID_WACOM            0x056a
> +#define USB_VENDOR_ID_WACOM_HID                0x2D1F
>  #define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH 0x81
>  #define USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH   0x00BD
> +#define I2C_DEVICE_ID_WACOM_REMARKABLE2                0x0095
>
>  #define USB_VENDOR_ID_WALTOP                           0x172f
>  #define USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH      0x0032
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 2e104682c22b..b081af3329a5 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -186,6 +186,7 @@ static const struct hid_device_id hid_quirks[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD), HID_QUIRK_NOGET },
>         { HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60), HID_QUIRK_MULTI_INPUT },
> +       { HID_I2C_DEVICE(USB_VENDOR_ID_WACOM_HID, I2C_DEVICE_ID_WACOM_REMARKABLE2), HID_QUIRK_XY_INVERT },

Well, there is no guarantee that this PID will always be installed in
this particular configuration.

Can you instead set the quirk in i2c_hid?:
- retrieve that information from the DT in
drivers/hid/i2c-hid/i2c-hid-of.c (with the generic touchscreen OF
properties)
- amend the signature of i2c_hid_core_probe() to account for extra quirks
- after having allocated the device, add the provided quirks

Then I still need to figure out how we can add tests for the quirk.

Cheers,
Benjamin

>         { HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET), HID_QUIRK_MULTI_INPUT },
> --
> 2.31.1
>


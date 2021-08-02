Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1043DE2A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHBWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:44:54 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:36626 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:44:52 -0400
Received: by mail-qt1-f170.google.com with SMTP id w10so12793764qtj.3;
        Mon, 02 Aug 2021 15:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZpEUuMrd4GatuNwSTb1C/8V/y6Tmj4WRl8BBaTN31A=;
        b=YR9yEPPIk08sI3US8+XqoaWvrCTQrDon6z3R0QlLl69ZziWp4ni0omi451a+5lRsGw
         q2qtPrentbuoAh6wuIS5kfzmYYS8dCWgY784l79veZs7nJMJrZN9/WS9Y92Ka5loZK/q
         uGhbmobkrB+lKB780Im1KQHh6zLbZ0pRyj7J2L08MEzUK/SqsEKCrAl472kmOIGqoqXH
         eCosEaoqX3CJY6IdJJbJ3T0wnU5RU6ou/MWhZkRUIQad+KP6OeDd5hGvdPY2B4eAamNM
         e5nIYHwW9BBI7zEEHWu04ThnApX0IfVTad6Ofnp+jCeCSFW64PZGp027ZjhwRA4MdQk4
         rCig==
X-Gm-Message-State: AOAM533co0zYYXXqCGF0KFK36RLTKuzZtqY9n665oSu8Ueak/y1eZCxe
        55t9pJXy//X8Qo4Nnvu8sfl29oXN5TQ=
X-Google-Smtp-Source: ABdhPJzmttkq5ye43bf7BNv43Qo+i3AZHFslVgMz2Za2LoZ1duNU+Dv9TrRFxX4lhXprC4qGs8MWuw==
X-Received: by 2002:ac8:4545:: with SMTP id z5mr16357832qtn.198.1627944281739;
        Mon, 02 Aug 2021 15:44:41 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id o63sm6757558qkf.4.2021.08.02.15.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 15:44:40 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id em4so4848284qvb.0;
        Mon, 02 Aug 2021 15:44:40 -0700 (PDT)
X-Received: by 2002:ad4:58cb:: with SMTP id dh11mr18599135qvb.29.1627944280772;
 Mon, 02 Aug 2021 15:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <1627927742-8675-1-git-send-email-raagjadav@gmail.com>
In-Reply-To: <1627927742-8675-1-git-send-email-raagjadav@gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 2 Aug 2021 17:44:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ2M1N1pV2brfFRXOf1ASK2bhiZpQivNhNws_+RUfCT-g@mail.gmail.com>
Message-ID: <CADRPPNQ2M1N1pV2brfFRXOf1ASK2bhiZpQivNhNws_+RUfCT-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1046a: fix eeprom entries
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 1:10 PM Raag Jadav <raagjadav@gmail.com> wrote:
>
> ls1046afrwy and ls1046ardb boards have CAT24C04[1] and CAT24C05[2]
> eeproms respectively. Both are 4Kb (512 bytes) in size.

These part names are from onsemi instead of atmel.  Are there same
part names from atmel which are also compatible with the onsemi parts?
 If we want to use onsemi only part names, probably we will need two
compatible strings with the first one from onsemi and the second from
atmel.  Although the binding doesn't support onsemi prefix yet.

> Remove multi-address entries, as we have auto-rollover support
> in at24 driver.

The device tree should describe hardware instead of matching how
driver deal with it.  Is the board really using a single chip or
multiple chips here?

>
> [1] https://www.onsemi.com/pdf/datasheet/cat24c01-d.pdf
> [2] https://www.onsemi.com/pdf/datasheet/cat24c03-d.pdf
>
> Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 8 +-------
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 7 +------
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> index db3d303..83afe21 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> @@ -83,15 +83,9 @@
>                         };
>
>                         eeprom@52 {
> -                               compatible = "atmel,24c512";
> +                               compatible = "atmel,24c04";
>                                 reg = <0x52>;
>                         };
> -
> -                       eeprom@53 {
> -                               compatible = "atmel,24c512";
> -                               reg = <0x53>;
> -                       };
> -
>                 };
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index 60acdf0..d220f98 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -59,14 +59,9 @@
>         };
>
>         eeprom@52 {
> -               compatible = "atmel,24c512";
> +               compatible = "atmel,24c04";
>                 reg = <0x52>;
>         };
> -
> -       eeprom@53 {
> -               compatible = "atmel,24c512";
> -               reg = <0x53>;
> -       };
>  };
>
>  &i2c3 {
> --
> 2.7.4
>

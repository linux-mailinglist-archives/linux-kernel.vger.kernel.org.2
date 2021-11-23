Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BFD45A1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhKWLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhKWLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:55:15 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:52:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i63so10592594lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoJDXoyZkF2M4S1f/BsuXg6VLy0u1Wa1fYGourUXVyc=;
        b=THJXv7yq/Gdt+eDt2Mv4VXnw6yps94MacurxfcXG7ow3GRNkxx6G1eEG9oKbbdzW4P
         0xdcB7joaxEz+srNcPehLSVxWUILX9joO9CpG9zADf0+rPJij8vxlf6ODoakj8k9LHDb
         J1WvHoJWocT7uK9LCJM+bzuT6hn3Vl774EbXU7aYhj4gheRGH3mExTRL18EUxM5ItJRa
         d/JHGvf0WsSSPZoxL/IT5O5Kcr/1n8Q7X5J3yMehfgS2sj0TsR9WjjfQvXXd4Q2lnZNN
         P1CrpBiT3BCx/GGo66ZdtHHNsXnfnnaWp4iGTzEM9BXCkF+0PGw04lSiXxSKSri06/Bv
         C03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoJDXoyZkF2M4S1f/BsuXg6VLy0u1Wa1fYGourUXVyc=;
        b=WS1EjS2DuRU70JWSnwU+7/Ti55ndZjWHY4FyWblgz7NYypgG3/HCTuG1R+zGRGKoHf
         9BjJBTeAzn2y/6MmJObtMWdRIcDz/1tjgzbmTSyYVa42lmBX1jMG+g1dbgBkVhZoHVyD
         PXYv/Nh95MCMFpYvkyIgII4CiDatIX3zrNJLxeoouootdFVffIV86lSKjc1MUJ/MNrY5
         BodvjoBPOUHbVNUR9IuRjjMmApm3wyRryP/eE/MnxjFTb/qdDHLnfPNpFmQv2yQBQwV9
         wkY8bFkrRHku5aVHz5FU39iFMLOtrWQPqSyOj59uV3QQI5f7tclGUWLtKpj9MFBj4p4q
         fT7A==
X-Gm-Message-State: AOAM531bEjvU4qVJEh9DTu3rQUKMuWzU/wopopwHZKb4oAGYLYVG/pBt
        mQ8Gq44Ys6qsuDX9eM7TTsDtxXs+Sr94Y1lzJEx3TBd1cWI=
X-Google-Smtp-Source: ABdhPJytRBvLS5/syk0XulOTnxYchcLOdKwucYqY0unNScGSPuSZjDG4Er8M3zgxnh3mTojt6eGTiqSsUxWB81L0bik=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr4334703ljc.229.1637668325223;
 Tue, 23 Nov 2021 03:52:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637186803.git.wbartczak@marvell.com> <f1aa09f05ea34c2970785a79c3d791626da9bc32.1637186803.git.wbartczak@marvell.com>
In-Reply-To: <f1aa09f05ea34c2970785a79c3d791626da9bc32.1637186803.git.wbartczak@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 12:51:29 +0100
Message-ID: <CAPDyKFoETfEWgMGWfLM8Mij1LDu1SA4L43Lbx=pXWLk7SjpwRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: Add vmmc/vqmmc for Cavium driver
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     linux-mmc@vger.kernel.org, beanhuo@micron.com,
        tanxiaofei@huawei.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 23:28, Wojciech Bartczak <wbartczak@marvell.com> wrote:
>
> Octeon/OcteonTX MMC supports up to 3 card slots.
> Each slot can support SD or MMC cards with various speed.
> However, any level-shifting to accommodate different signal voltages
> for the cards is done by external hardware, under control of an optional
> vqmmc regulator object, typically controlled by gpio.
> The details of device-tree control of MMC signals via GPIO at reset
> is available in this file.
>
> If any mmc-slots have a vqmmc-supply property,
> take it as a warning that we must switch carefully between
> slots (unless they have the same vqmmc object), tri-stating
> MMC signals to avoid any transient states as level-shifters
> are enabled/disabled, by zeroing MIO_EMM_CFG[bus_id].
>
> There's no need to list vqmmc property if all the mmc-slots
> on a board run at same signal voltage, and have same width.
> In this case the old behavior, enabling all probed slots in
> MIO_EMM_CFG, allows faster slot-switching.

Overall, I suggest you avoid mixing software behaviour with the HW
description. The DT bindings should describe the way the HW works, not
the software.

This applies further down to the description of the new properties as
well. But please, don't get me wrong, I appreciate the detailed
explanations, just make sure it's more focused on describing the HW.

>
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cavium-mmc.txt    | 47 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 2 deletions(-)

We have moved to describe DT bindings in the yaml format. I would
appreciate it if you make that conversion and then extend it with the
new things, rather than continue to extend the txt based one.

Kind regards
Uffe

>
> diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> index 1433e6201dff..d0b750e23332 100644
> --- a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> @@ -28,6 +28,46 @@ Deprecated properties:
>  - power-gpios : use vmmc-supply instead
>  - cavium,octeon-6130-mmc-slot : use mmc-slot instead
>
> +GPIO control via vmmc-supply & vqmmc-supply:
> +  Two types of regulator object can be specified as mmc properties,
> +  typically regulator-fixed controlled by GPIO pins.
> +
> +  Octeon/OcteonTX chips commonly use GPIO8 as an MMC-reset pin.
> +  In systems which may boot from MMC, it starts as input, and is gently
> +  pulled up/down by board logic to indicate the active sense of the
> +  signal. Chip reset then drives the signal in the opposite direction
> +  to effect a reset of target devices.
> +  Device tree should model this with a vmmc-supply regulator, gated by
> +  GPIO8, so GPIO8 is driven in the non-reset direction when MMC devices
> +  are probed, and held there until rmmod/shutdown/suspend.
> +  This allows a warm reboot to reset the MMC devices.
> +
> +  Octeon/OcteonTX MMC supports up to 3 mmc slots, but any
> +  level-shifting to accommodate different signal voltages is
> +  done by external hardware, under control of an optional
> +  vqmmc regulator object, typically controlled by GPIO.
> +
> +  If any mmc-slots have a vqmmc-supply property, it is taken as a warning
> +  that we must switch carefully between slots (unless they have the same
> +  vqmmc object), tri-stating MMC signals to avoid any transient states
> +  as level-shifters are enabled/disabled.
> +
> +  Even when so-called bi-directional level shifters are used,
> +  this technique should be employed when using different bus-widths
> +  on different slots, disabling level shifters to avoid presenting
> +  non-uniform impedance across DATA0-7 & CMD when non-selected
> +  4-wide slots are left enabled, while accessing 8-wide targets.
> +
> +  Note that it's not possible to specify multiple regulators
> +  controlled by same GPIO pin, but with different active state.
> +  If one GPIO line is require to switch voltage/routing between
> +  different mmc-slots, specify a vqmmc-supply on one slot, but
> +  not the other. The regulator_disable call on leaving that slot
> +  will implicitly switch the state to support the unmarked slot.
> +
> +  There's no need to list vqmmc-supply if all the mmc-slots on
> +  a board run at same voltage, and have same width.
> +
>  Examples:
>         mmc_1_4: mmc@1,4 {
>                 compatible = "cavium,thunder-8390-mmc";
> @@ -40,7 +80,8 @@ Examples:
>                         compatible = "mmc-slot";
>                         reg = <0>;
>                         vmmc-supply = <&mmc_supply_3v3>;
> -                       max-frequency = <42000000>;
> +                       vqmmc-supply = <&vqmmc_3v3>;
> +                       max-frequency = <52000000>;
>                         bus-width = <4>;
>                         cap-sd-highspeed;
>                 };
> @@ -49,9 +90,11 @@ Examples:
>                         compatible = "mmc-slot";
>                         reg = <1>;
>                         vmmc-supply = <&mmc_supply_3v3>;
> -                       max-frequency = <42000000>;
> +                       vqmmc-supply = <&vqmmc_1v8>;
> +                       max-frequency = <100000000>;
>                         bus-width = <8>;
>                         cap-mmc-highspeed;
>                         non-removable;
>                 };
>         };
> +
> --
> 2.17.1
>

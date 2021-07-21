Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A293D11AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbhGUONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbhGUONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:13:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3863C061575;
        Wed, 21 Jul 2021 07:53:55 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r16so2499897ilt.11;
        Wed, 21 Jul 2021 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39/icZ4895+m49O8ui8jK8s2YjESquae62yWMw3Ir4c=;
        b=Guo73mZ6yKHiZEmwWSRxAODeMC+83TtcsfX8BJAhI48v2UJRUUcF4upLXHb4Lrdb0L
         po+YJuoSUpi2NwBBE3sZFLrMxQriAhcPhsuh1k9Gq5omgHSlp66KafL9ziJNC79uDngy
         ZyKAutlVy3QInJurrVKEbXqCfox2pN99kwZFSqRzCSAwszGcpPsEZKaUNFZUE3srjo8j
         Cwh2xWPhdGSluOIWtQgDV4HpSDaDWW2Au3wN/ro0nsCwaGZAl+YgkP8afmA+HuRWIrC7
         7Kcnq1gSYbXqBKU4TQ0RG+YwrVrrhlGdWAtXigdm3hiyQiB7dCoyWF6bXUJDxrx0lHwZ
         efhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39/icZ4895+m49O8ui8jK8s2YjESquae62yWMw3Ir4c=;
        b=Gs2ipof5Y/ry6vahZcd27E7rXePJh1SeV0o+U+o3GcNdK+hB8JuLHZuQ9MsqpPTzxl
         jGV0cCiHDyCd6+5FHWne0sILUPFl6t4EClWbEdfBR0lh00hMNS3D/yv4FWKV6ICPbB1+
         3V0wCLulnCy85XsyT0WBY6kvx2q/KxvMnbbpYZL3EovmxPbVrpvP7xIDEbaVZv2N3t0h
         94EYwzkt6c/js99U/iRzFKqdJdZ3u0O4JqHIk73ov7mRxSIyw7qeWba86x5nFiuhMPQ0
         5CRszDHCT0az6U3aa2HAKbCdi/7s+b+0a/OyrQU81jHHefJbSwehRTFt2Uohnfso/Abx
         ezqw==
X-Gm-Message-State: AOAM531OFfesRdUTqVUPcYpcR01TOVC7Gq83BBHdXSNvdrAylBfzdbKG
        Lt38fyPI/Hfca9FPFRFTEZrKwTE7i8Knrg2SoiU=
X-Google-Smtp-Source: ABdhPJw1i62IODwqJG85RIGShGbX/nNmMKibJ4lq9B3eoCKP4Zhoh2+aEP3HFa6R+ujOCRWL8PdWXsy8PnQESunRSag=
X-Received: by 2002:a05:6e02:e82:: with SMTP id t2mr24437728ilj.218.1626879235022;
 Wed, 21 Jul 2021 07:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com> <1626853288-31223-3-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1626853288-31223-3-git-send-email-dillon.minfei@gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 21 Jul 2021 22:53:19 +0800
Message-ID: <CAL9mu0J=Z5je9GJP8karYL=aaeMyQF5pCP7pU-c4QAr7eApUmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341
 dts binding
To:     thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I suppose you will going to review this patch,
I forgot to add the Fixes tag in v2, just add it.
I will submit v3 to add this tag in case necessary.

Thanks, Best Regards.
Dillon

On Wed, 21 Jul 2021 at 15:41, <dillon.minfei@gmail.com> wrote:
>
> From: Dillon Min <dillon.minfei@gmail.com>
>
> Since the compatible string defined from ilitek,ili9341.yaml is
> "st,sf-tc240t-9370-t", "ilitek,ili9341"
>
> so, append "ilitek,ili9341" to avoid below dtbs_check warning.
>
> arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
> ['st,sf-tc240t-9370-t'] is too short
>

It's should be a Fixes tag here.

Fixes: a726e2f000ec ("ARM: dts: stm32: enable ltdc binding with
ili9341, gyro l3gd20 on stm32429-disco board")

> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/arm/boot/dts/stm32f429-disco.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 075ac57d0bf4..6435e099c632 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -192,7 +192,7 @@
>
>         display: display@1{
>                 /* Connect panel-ilitek-9341 to ltdc */
> -               compatible = "st,sf-tc240t-9370-t";
> +               compatible = "st,sf-tc240t-9370-t", "ilitek,ili9341";
>                 reg = <1>;
>                 spi-3wire;
>                 spi-max-frequency = <10000000>;
> --
> 2.7.4
>

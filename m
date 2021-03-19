Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B63414A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhCSFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhCSFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:20:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12877C06174A;
        Thu, 18 Mar 2021 22:20:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so10380701lja.13;
        Thu, 18 Mar 2021 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KD7NBAK+4Rp9SsLbxbAqM6nGsZ0UIVgR+zzJ73WPa8=;
        b=VKgAsSPp7XJZsRpn+a7h46waRIltfczCpXv1GgDwjp6+Myford91fYemGNfZdVcgE1
         hdZq0HCsI2BK+wLJXjx2WWGdSbd4L5Qg2dEJrYq+PI7lIZA791TN07CV+8fzxeN0rWYD
         O8JNQcv18rjB6SuMWaIgyG9edG5H2DFAm4Rw0P0DUxFHJlLMis+J1lNs+JJjmoW323Wx
         E52/49bjdvH1Btp8wqm371jH4BTE/eMaMRQqiagX9eM2it+/FK4peQmMD69v6bCZne9T
         Ppm3/ds8Gp85SiJxFO+ZY4uz3URKU5YrWwxYgQcD//uRv5zh6VvSco+QPI8/NOIc4Zfn
         Jw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KD7NBAK+4Rp9SsLbxbAqM6nGsZ0UIVgR+zzJ73WPa8=;
        b=KuFz74WYi2X2kKQbnDUBtfVjnj1Fc4kJxNwake6/G7iqwViZO4BQSVYdRYTHLaDuwj
         Y1gzUanJt6X8fNQhZl/kQ1TBQBZZ2nsJ3tniJF98HOcVcZneSDn8b2vz6tKBPpfvVdNk
         YrChqhJ1jNrA8PJ53eRyncy9eEXQJqdUpk5BhLqklszvNhbSnQ3A4ihCebp45CxW80Gv
         BWvSmQv3eSnJe7nbQZCyPjNcFAMbcA8Q3MF1pGDJta/h4PZGfUB14sy8iLIXBYb4WlHG
         ZJSUCpl5XYT7vpWz0p1esi5LEwuiTKQGbJQD0yO1Y0pdep785XTgyJ2sdMnNAA7SM5Lw
         jO5g==
X-Gm-Message-State: AOAM5334rzPz+L59Rm8VRsGiMh6i4fZNvyFNayoCz3EFnKxt8KrwcQyO
        eaCfOQku76EhS3dZt7wnkXUVLDBVNyXU2b2d06E=
X-Google-Smtp-Source: ABdhPJxvT7sa2Q3Z5WwT1E+D8H+Ezxins5VaY6wNnxwe7OVa/ao4zxTDjbQbbrizDX/iwBMXzK2nwfLDVht34eGQVhs=
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr7608722ljf.164.1616131223387;
 Thu, 18 Mar 2021 22:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210319051047.27619-1-cnsztl@gmail.com>
In-Reply-To: <20210319051047.27619-1-cnsztl@gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Fri, 19 Mar 2021 13:20:11 +0800
Message-ID: <CAOP2_Tjo+5tOEJ-oLCMqref1JtA13FP91urxe86H6bhK=QsKng@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Jonker <jbx6244@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry everyone, please ignore these patches as I forgot to update them...
New patches were sent.

On 2021-03-19 13:10, Tianling Shen <cnsztl@gmail.com> wrote:
>
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S.
>
> Changes in v5:
> - Dropped the empty PCIe node
> - Dropped useless `/delete-property/`
> - Renamed LED nodes
>
> Changes in v4:
> - Correctly dropped `display-subsystem` node
> - Dropped meaningless `pwm-fan` node
> - Dropped wrong `sdmmc` node
> - Disabled `i2c4` and `uart0` as they don't exist in the design
> - Format fixes
>
> Changes in v3:
> - Dropped non-existent node `display_subsystem`
>
> Changes in v2:
> - Disable display for NanoPi R4S (reference commit: 74532de460ec)
> - Light "sys" LED on NanoPi R4S (reference commit: 833821eeab91)
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index c3036f95c7bc..4a6f772c1043 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -134,6 +134,7 @@ properties:
>                - friendlyarm,nanopi-m4
>                - friendlyarm,nanopi-m4b
>                - friendlyarm,nanopi-neo4
> +              - friendlyarm,nanopi-r4s
>            - const: rockchip,rk3399
>
>        - description: GeekBuying GeekBox
> --
> 2.17.1
>

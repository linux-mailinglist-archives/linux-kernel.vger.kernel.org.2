Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07EF32F54D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEVbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:31:23 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39230 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:31:18 -0500
Received: by mail-ot1-f50.google.com with SMTP id h22so3201152otr.6;
        Fri, 05 Mar 2021 13:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaYRFmOSsTSCJH3nlj7VYHkJOn8JEF8SQCyPLZclNWk=;
        b=Q1kNUbRnGaaFTW5TR5WwXzkFp+ChSR4DJ2ByDUMYGTfQsKuhTuaFYr3AOzbtiAPTnL
         pHNTLgZrbcGcBxRgw/FHphCtZrrW6HOeL9J89yhm3mPxW2xDYilu5S1ii6BzTj7s9ldV
         mXjFN1zSC+ILGEAxBcfO3WqlcCbZ1a/M2ENgu5RXgvp+PPcnFrKldZvi43HAymTxLFvi
         xuPGUyTt8JXkPzp/SbiV7HoRx5dsSaHXhzRDh3ag6hH3e64A/LCM4iU1h3m80LmbEG+v
         /GT2gBMtG01hJT6awHPSZP5azHFLZw1+c25wLWKNETn1Xn7689zn80C+01Hs/DJRj/po
         KWoQ==
X-Gm-Message-State: AOAM5301D1hTxO48s01EUb3X2no1R34dYGNmfel5mvKOuugmAFV7KPUa
        EPsdYdQQ7eAlnjd4D8QpKA==
X-Google-Smtp-Source: ABdhPJzEJR00WVTj8cfDpg5WVP9Pt+R77bzbj6urppKWYJmUZ3DXDxunIzI8Rc3KQC9HjtNKp5r/fQ==
X-Received: by 2002:a9d:4004:: with SMTP id m4mr9734139ote.63.1614979877565;
        Fri, 05 Mar 2021 13:31:17 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n6sm767969oop.48.2021.03.05.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:31:17 -0800 (PST)
Received: (nullmailer pid 680730 invoked by uid 1000);
        Fri, 05 Mar 2021 21:31:15 -0000
Date:   Fri, 5 Mar 2021 15:31:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     shawnguo@kernel.org, m.felsch@pengutronix.de, festevam@gmail.com,
        narmstrong@baylibre.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL
 compatibles
Message-ID: <20210305213115.GA676128@robh.at.kernel.org>
References: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
 <1613308450-27958-4-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613308450-27958-4-git-send-email-oliver.graute@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 02:13:50PM +0100, Oliver Graute wrote:
> Add the compatibles for Variscite i.MX6UL compatibles
> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> ---
> 
> Changelog:
> 
> v4:
>  - added missing 6 in i.MX6
> 
>  v3:
>  - rebased
> 
>  v2:
>  - renamed binding
>  - removed superflous "
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 297c87f..e67b622 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -499,6 +499,7 @@ properties:
>                - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
>                - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
>                - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
> +              - variscite,imx6ul-var-6ulcustomboard # i.MX6 UltraLite Carrier-board

Doesn't match your dts file. Plus looks like a lot of redundancy.

Run dtbs_checks and with W=1 and make sure you aren't adding more 
warnings. Lots will be from the base SoC dtsi, but feel free to fix some 
of those too.

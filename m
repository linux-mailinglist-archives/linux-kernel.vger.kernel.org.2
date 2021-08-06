Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF63E3145
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbhHFVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:42:23 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:42634 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhHFVmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:42:22 -0400
Received: by mail-io1-f48.google.com with SMTP id h1so14150983iol.9;
        Fri, 06 Aug 2021 14:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmfrqnjwoNjULKei+83ZCuOTdf232qIaGlCJ5LO8Ffs=;
        b=Rlm8NsBvuIZDcvrelgR7/9d/LabztbQTD6JG0HAx42pSIlnVIlBINp4/1f3pVPjutZ
         Y2ALap7V83Pesfnt4yQRFazRtenW1Jq+PzshbFkviqvWyD359oLo5cpeGcuSEibkwsAW
         K9nPunw7yd9RwP8ayhqiBs1fe6fQzaE9xcwrtOMIyCdR99GqOQOYD87xJADh2ejXyzFT
         jYnddjFTQurtNUs07tRN+KZY0tz2izQHLSwi9lQxLvfKlaB1z4DeG5E+qLVUxMbxn6z1
         97iAezejhFlsXoHCHQYfyGGuuFZa9i2O80Bx/z4rBCfMP8J3FO4ynJ/gYEXyNf33Kfa6
         lo7A==
X-Gm-Message-State: AOAM532335t58HtVuBQPpQETLgtQVv0/dzvz3fyyqekThR4GbOlhRaNj
        SB6mjeyJgYb7sDTToXNJYg==
X-Google-Smtp-Source: ABdhPJxL9tTMYas12MdJSTLo1bjOtXg69j1t+6wn3v8IxOh6v5bWwr2JiiTBXP8uR8M6U1QRLQ8B/Q==
X-Received: by 2002:a05:6602:27ca:: with SMTP id l10mr198908ios.16.1628286125249;
        Fri, 06 Aug 2021 14:42:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t16sm3891958ilf.63.2021.08.06.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:42:04 -0700 (PDT)
Received: (nullmailer pid 1853406 invoked by uid 1000);
        Fri, 06 Aug 2021 21:42:02 -0000
Date:   Fri, 6 Aug 2021 15:42:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] clk: sunxi=ng: add support for R329 R-CCU
Message-ID: <YQ2sqouVblVWMbye@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-11-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-11-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:22:05PM +0800, Icenowy Zheng wrote:
> Allwinner R329 has clock controls in PRCM, like other new Allwinner
> SoCs.
> 
> Add support for them.
> 
> This driver is added before the main CCU because PLLs are controlled by
> R-CCU on R329.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig                  |   5 +
>  drivers/clk/sunxi-ng/Makefile                 |   1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c      | 374 ++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h      |  33 ++
>  include/dt-bindings/clock/sun50i-r329-r-ccu.h |  33 ++
>  include/dt-bindings/reset/sun50i-r329-r-ccu.h |  24 ++

These 2 belong in the binding patch.

>  6 files changed, 470 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h

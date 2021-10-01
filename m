Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4541EE60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJANTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:19:47 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39636 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhJANSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:18:49 -0400
Received: by mail-ot1-f53.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so11428743ota.6;
        Fri, 01 Oct 2021 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GpaCFBluFudPZ/yH9IF+RzTInuanJkVWpBhaYtuvn70=;
        b=CN0QfsG/2V9NCnju8N2IcSC6qYSDaG6PKOcjRl+1y5x5+8SE3n9Cr2H59q73IZV9iz
         SXq1LO8uQSVqPt0VlxOLZBf+52Y6XB/cIvbkPwCyYyqplwXdef3/K5JCyApL7KOJ+4iO
         XNmpUYzz0+NvOL4Wq5O16sbHkllW3unOVOgxl6dDJWxhrPV1BWqWeROcKsTD9HyXtRjf
         sOlbEWdBs/zcJeQkKFTGEFMkWrJRyO2/KUPetNfNlvJKMqKkRGYl0UcMFpHE5X4E1voE
         kwG6fjVdkD60Uyec3UvmQ9HfWgYCL/WcZCbduj/YaJpRiRbL4qOJhbRv9rvi1RzxCgLx
         EmCw==
X-Gm-Message-State: AOAM531zMTa+ojPHzFuCQIzMb0FlgBzW0TgqPfMzR1C4z0QqpY1nR8K+
        TcSCk7RRY5lNVeDCtWOFbA==
X-Google-Smtp-Source: ABdhPJzzeLKszTrXu+Szgav1S9FdZxShBPRvj5IXzS/1VS1vS3CRzG7P9PPuOKzQLyPVho+hlNMAMg==
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr10003411otp.186.1633094225354;
        Fri, 01 Oct 2021 06:17:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm1169115ooa.36.2021.10.01.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:17:04 -0700 (PDT)
Received: (nullmailer pid 3666446 invoked by uid 1000);
        Fri, 01 Oct 2021 13:16:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20211001000417.15334-3-leoyang.li@nxp.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com> <20211001000417.15334-3-leoyang.li@nxp.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align with original txt binding
Date:   Fri, 01 Oct 2021 08:16:57 -0500
Message-Id: <1633094217.893290.3666445.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 19:04:03 -0500, Li Yang wrote:
> When the binding was converted from txt to yaml, it actually added more
> constrains than the original txt binding which was already used in many
> in-tree DTSes.  Some of the newly added constrains are either not valid
> or not neccessary.
> 
> Not all SoCs use ipg as the clock name for i2c.  There is no point in
> having SoC integration information defined in i2c binding.  Remove the
> clock name requirement in the schema.
> 
> The original txt binding didn't require the order of tx and rx for
> dmas/dma-names.  Many in tree DTSes are already using the other order.
> Both orders should just work fine.  Update the schema to allow both.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
> v2:
> Updated the patch description
> 
>  Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1535099


i2c@21a4000: clock-frequency:0:0: 50000 is not one of [100000, 400000]
	arch/arm/boot/dts/imx6dl-alti6p.dt.yaml

i2c@21f8000: clock-frequency:0:0: 50000 is not one of [100000, 400000]
	arch/arm/boot/dts/imx6dl-alti6p.dt.yaml

i2c@30a20000: clock-frequency:0:0: 387000 is not one of [100000, 400000]
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml

i2c@30a30000: clock-frequency:0:0: 387000 is not one of [100000, 400000]
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml

i2c@30a40000: clock-frequency:0:0: 387000 is not one of [100000, 400000]
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml

i2c@30a50000: clock-frequency:0:0: 387000 is not one of [100000, 400000]
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml


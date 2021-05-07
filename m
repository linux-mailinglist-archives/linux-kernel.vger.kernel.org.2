Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44CF375E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhEGBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:03:15 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43938 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhEGBDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:03:13 -0400
Received: by mail-oi1-f177.google.com with SMTP id j75so7246083oih.10;
        Thu, 06 May 2021 18:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXiJZrGbZjzgbLliOToiyd4IL0REs+uGfEV/o4ly1e0=;
        b=l/wGpF3JermtzfRRO1KLpSR+OZEIDLYGOx6XYQp/yH7RugchDBfwhbrFeGihNZjzYm
         pGpDWv6aMmjVkGVMdU2zNSwerH5H34lrhdSWHa/3/j4YUGfJmzLrKhWT8TF0SW/qd9Gn
         r6WLQ68ltkXA4PWynUBFbrsUK+GvFrN7AmAl+cowdCJdDMmgtEfCnyk9ns9G1wGY7nSP
         VA7MPxPEXbiwPMnIGQ0xmI9jY2RRB/8CqZEBY9rTr4gB7cfzVazFYR0K7UUpFQmNtlou
         Nffz96n7w8vas9ycYABjGr4zY++KgeowAseCEIOxQWGTPN7Xh/7FG+SFSqEojUKtQDmR
         QIVA==
X-Gm-Message-State: AOAM533RN1dwuddR9lVwN9X2i4ysWYhP9CrYBrRaeKgsvpw+NMbsYdOd
        PCBrOCtBXsf+2rVH9whrA7ThyAxiQQ==
X-Google-Smtp-Source: ABdhPJxClQbl0oRzitQgd0eDa9VZsBQjgqsj9ikLZ5y2ls5Wy6PkJBvdBuvuYYGEQadrHhJSfPH4FA==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr4995991oij.163.1620349333920;
        Thu, 06 May 2021 18:02:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m127sm745539oib.32.2021.05.06.18.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:02:13 -0700 (PDT)
Received: (nullmailer pid 1110456 invoked by uid 1000);
        Fri, 07 May 2021 01:02:11 -0000
Date:   Thu, 6 May 2021 20:02:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     l.stach@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew.smirnov@gmail.com, abel.vesa@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        krzk@kernel.org, aford173@gmail.com, robh+dt@kernel.org,
        p.zabel@pengutronix.de, frieder.schrempf@kontron.de,
        ping.bai@nxp.com, linux-imx@nxp.com, agx@sigxcpu.org,
        kernel@pengutronix.de, marex@denx.de, festevam@gmail.com
Subject: Re: [PATCH V3 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Message-ID: <20210507010211.GA1110407@robh.at.kernel.org>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
 <20210506041555.10719-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506041555.10719-3-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021 12:15:53 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Each BLK CTL have different power domain inputs and they have different
> names, so we are not able to list all the power domain names for each
> BLK CTL here.
> 
> For example:
> i.MX8MM dispmix BLK CTL, it has
> 	power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> 	power-domain-names = "dispmix", "mipi";
> 
> vpumix BLK CTL, it has
> 	power-domains = <&vpumix_pd>, <&vpu_g1_pd>, <&vpu_g2_pd>,
> 			<&vpu_h1_pd>;
> 	power-domain-names = "vpumix", "g1", "g2", "h1";
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

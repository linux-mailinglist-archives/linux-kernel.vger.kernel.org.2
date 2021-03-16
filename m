Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5033E155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCPWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:23:48 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:43515 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhCPWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:23:35 -0400
Received: by mail-il1-f178.google.com with SMTP id b5so14193144ilq.10;
        Tue, 16 Mar 2021 15:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lcEgacFxEXTOUONKpaBOr7CK/rmW0Nxi28Yhlw7TNto=;
        b=T30qwcOCg8Isg2PM/bwmTsP9Vy7nLy39HX9tih5bhp06oBqRJgQ+kXW/e+neQFseCV
         ppMorHNGmYSbxgKET77VlqMNNHqfhlP6FWgisapCEOcl+zWG/OlUXzkQX9wd1bmbrQQo
         hjy73Wy6A/0ZmhxPFpvQu2z2TNNJA5VcSBdzPZEFez6PWpSLopZ0QrnPGW6/COJ7fQ2d
         ZbQOOL8Nll1yqDnMR7n4UwtprJ0eeY3s8+h9Ufw03hkioq4QdiuNbOdj5R+zzS3guo7C
         PD5I5F+U48X4aw/RxFV9HV9TVfJNXqdQMeMu5qIAnn7MDZFPzFkuO7BpszYRdsHA+Vtw
         Y3fw==
X-Gm-Message-State: AOAM5317QY1VnvbuhWXSw7dxCmK+e/wCP/Xqj5DTABqyGUmN4B1YPZFx
        FR89in52bpQNOXa8nfBsXQ==
X-Google-Smtp-Source: ABdhPJxQlggYieg0A96D07xQPL8UIkwZdQVG3xRj5IAyYzwC6Evtykc7FEXQvQZl3JBs/NaD+ze+qQ==
X-Received: by 2002:a92:d201:: with SMTP id y1mr5711020ily.129.1615933414864;
        Tue, 16 Mar 2021 15:23:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h2sm8619148ioj.30.2021.03.16.15.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:23:34 -0700 (PDT)
Received: (nullmailer pid 3790746 invoked by uid 1000);
        Tue, 16 Mar 2021 22:23:31 -0000
Date:   Tue, 16 Mar 2021 16:23:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mtd@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: arm: imx: add imx8mm gw7901 support
Message-ID: <20210316222331.GA3790694@robh.at.kernel.org>
References: <20210309220014.22205-1-tharvey@gateworks.com>
 <20210309220014.22205-3-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309220014.22205-3-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021 14:00:13 -0800, Tim Harvey wrote:
> The Gateworks GW7901 is an ARM based single board computer (SBC)
> featuring:
>  - i.MX8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - SPI FRAM
>  - Gateworks System Controller (GSC)
>  - Atmel ATECC Crypto Authentication
>  - USB 2.0
>  - Microchip GbE Switch
>  - Multiple multi-protocol RS232/RS485/RS422 Serial ports
>  - onboard 802.11ac WiFi / BT
>  - microSD socket
>  - miniPCIe socket with PCIe, USB 2.0 and dual SIM sockets
>  - Wide range DC power input
>  - 802.3at PoE
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

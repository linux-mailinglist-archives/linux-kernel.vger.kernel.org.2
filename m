Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073C31EB02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhBROi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:38:56 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37675 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhBRMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:42:16 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8C02A2223A;
        Thu, 18 Feb 2021 13:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613652010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMaI1JCs8AyzPhsR0chT2qUINg/FBYO4QSkEtbiKpPQ=;
        b=vYRL9aAXDB3M0i7FcITA5HXA7XBdknvKc0lIvYFtoHI2Ip7vCBT7vEUe/32jjS6pSA3cs7
        8GoKEURza0Ir305ZxP+iaHwE8epI8zkn2XpOx/+n2utCGC6BVAa8EIzSy2NkbP5y72sH6z
        1YLiSdqqLr81OofeT1AfoSWl8xj5fBs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Feb 2021 13:40:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m board
In-Reply-To: <20210218123327.25486-2-heiko.thiery@gmail.com>
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
 <20210218123327.25486-2-heiko.thiery@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <41a82ef512928b3b88a62c16e252441d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-18 13:33, schrieb Heiko Thiery:
> Add the Kontron pITX-imx8m board compatibles binding.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 297c87f45db8..0a0d03dd5e31 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -734,6 +734,7 @@ properties:
>                - fsl,imx8mq-evk            # i.MX8MQ EVK Board
>                - google,imx8mq-phanbell    # Google Coral Edge TPU
>                - purism,librem5-devkit     # Purism Librem5 devkit
> +              - kontron,pitx-imx8m        # Kontron pITX-imx8m Board

Looks like it should be sorted alphabetically.

>                - solidrun,hummingboard-pulse # SolidRun Hummingboard 
> Pulse
>                - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
>            - const: fsl,imx8mq

-michael

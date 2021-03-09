Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937803331D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhCIXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhCIXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:00:04 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2677C06174A;
        Tue,  9 Mar 2021 15:00:03 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 899DA2223E;
        Tue,  9 Mar 2021 23:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615330799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjc66xppdsM/m27TCXE1d+gcnxieQJuu1mjlbGwyArE=;
        b=vv1L9XMjbDif4VxOwWm5WMkgXWlJ9xbVE50Czcsy6+HsLjl3wpUqnOQSuOF+ARl9TG4uxk
        UvHHchYvZU10EbpxaPk2vsgOxd4Je4nRRYbHWq125EzH1jzolkNxaTadr/cBG+esedQl+B
        qOQPXWpzK/L2nQ41P68b4vdiuGeXrLk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Mar 2021 23:59:58 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: at25: add Fujitsu MB85RS4MT
In-Reply-To: <20210309220014.22205-1-tharvey@gateworks.com>
References: <20210309220014.22205-1-tharvey@gateworks.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8ca5c54140d69307f3c08ca85a09f0b5@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Am 2021-03-09 23:00, schrieb Tim Harvey:
> Document the compatible value for the Fujitsu MB85RS4MT SPI
> FRAM EEPROM device so that it can be used in DTS files.
> 
> This is a 512KiB FRAM EEPROM.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml
> b/Documentation/devicetree/bindings/eeprom/at25.yaml
> index 6a2dc8b3ed14..f594db72b711 100644
> --- a/Documentation/devicetree/bindings/eeprom/at25.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
> @@ -26,6 +26,7 @@ properties:
>                - anvo,anv32e61w
>                - atmel,at25256B
>                - fujitsu,mb85rs1mt
> +              - fujitsu,mb85rs4mt
>                - fujitsu,mb85rs64
>                - microchip,at25160bn
>                - microchip,25lc040

Hm, the driver is spi-nor but this is for the at25 driver. Is
this correct? Doesn't it work if you just add the ID to
spi-nor/fujitsu.c and use 'compatible = "jedec,spi-nor' ?

-michael

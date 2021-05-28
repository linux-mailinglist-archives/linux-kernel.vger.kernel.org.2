Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A653945C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhE1QYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhE1QYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:24:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA389C061574;
        Fri, 28 May 2021 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=z9V7Sz2Li++gpMer9U2Re90Rrj9gFCj79IAmGS6MWIY=; b=nLkvP0H1Abvl178UUUziHUuFvA
        yqI0K4SJIfnOF62n1OJIK+XxwsRALbCvC7r/fFSPCjX5Dr0vhUCY8dt3FmqDty6ieRWV3zmRtfeVK
        6tlWLrxBQtah7A+cgal4VF094w2dOTx7jvajnbOm63pX07qfmX900LDklOZqFulkxO7WDw8xK6Vwj
        rNf7ZOjDvD2CMIJhUPFXVah1kCl2IZ/yZuD1lzKQOtWiRiKZ6iXMgcnVuHO/mIIvEZiUVJQYkvmjm
        pkOCLYSbVMMqmq3yazaTtQd2y25JDORu5Qtvw0bXg/HnD4EnRoIYgpms91auCDfx9mamiSBfasaS0
        oZhZ3IsQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmfFe-00GxOI-7V; Fri, 28 May 2021 16:22:22 +0000
Subject: Re: [PATCH v5 3/3] power: supply: mt6360_charger: add MT6360 charger
 support
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        matthias.bgg@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
 <20210528081300.64759-4-gene.chen.richtek@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <61bc1ea0-0a67-0b36-6d9f-407ca074c815@infradead.org>
Date:   Fri, 28 May 2021 09:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210528081300.64759-4-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 1:13 AM, Gene Chen wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e696364126f1..3257b1ad5e36 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -577,6 +577,17 @@ config CHARGER_MP2629
>  	  Battery charger. This driver provides Battery charger power management
>  	  functions on the systems.
>  
> +config CHARGER_MT6360
> +	tristate "Mediatek MT6360 Charger Driver"
> +	depends on MFD_MT6360
> +	depends on REGULATOR
> +	select LINEAR_RANGES
> +	help
> +	  Say Y here to enable MT6360 Charger Part.
> +	  The device supports High-Accuracy Voltage/Current Regulation,
> +	  Average Input Current Regulation, Battery Tempature Sensing,

	                                            Temperature

> +	  Over-Temperature Protection, DPDM Detection for BC1.2
	                                                  BC1.2.


thanks.
-- 
~Randy


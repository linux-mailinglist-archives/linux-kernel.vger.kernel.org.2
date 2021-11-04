Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794E8444E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKDFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKDFMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:12:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F6C061714;
        Wed,  3 Nov 2021 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6OWAtdCupSFrLuBu31xzmcyfWszRgVMLVjbFq1XcUP4=; b=ifK17sxY1FBdTAef15IZ0KmE4p
        VFwvSzArpnI746SKWhY4ekAlycA/5p/4MkzJitnjCchHvjUCA0lSSzXC3vgw+ZvDuH2bZFBO16PCS
        1jRxJD7q90FurhNolTtpHsny/XHHUymysuJ3+65dUPl1S2TewD4CJkPaDDfnwBZJsCeTO97vWYuUK
        5e5E9I+Z2Z18yKj9XZB+Gs+Ogs1E5AyCs5mcMm0RYBkTSv0+gZ7A36sIsygfXo6K/iX8UCj5qok6v
        QV0FiTwKc5W6YX2QsH0TgbIvQ9aHbHJVqng/L83ifJrHdQhN1o6ax1Hi2kRJtXND+F8KuBHvC2Axj
        egH8pkyw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miV0F-007s5C-C1; Thu, 04 Nov 2021 05:09:31 +0000
Subject: Re: [PATCH v4 08/10] irqchip: Add Sunplus SP7021 interrupt controller
 driver
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <60972227de67203117017e1fc74982313f89bb19.1635993377.git.qinjian@cqplus1.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2d4d43ac-5cfa-4509-4cd0-f5ab5afb95e3@infradead.org>
Date:   Wed, 3 Nov 2021 22:09:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <60972227de67203117017e1fc74982313f89bb19.1635993377.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 7:57 PM, Qin Jian wrote:
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index aca7b595c..6f0bc0871 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -602,4 +602,13 @@ config APPLE_AIC
>   	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
>   	  such as the M1.
>   
> +config SUNPLUS_SP7021_INTC
> +	bool "Sunplus SP7021 interrupt controller"
> +	help
> +	  Support for the Sunplus SP7021 Interrupt Controller IP core.
> +	  SP7021 SoC has 2 Chips: C-Chip & P-Chip. This is used as a
> +	  chained controller, routed all interrupt source in P-Chip to

	                      routing all interrupt sources

> +	  the primary controller on C-Chip.
> +	  This is selected automatically by platform config.


-- 
~Randy

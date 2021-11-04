Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF17444E19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhKDFMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhKDFL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:11:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9299C061714;
        Wed,  3 Nov 2021 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ql6v+6nB7CCyDIKt7jTzoiJt79dauGpCARnrzJbER5Y=; b=H4AJtKIzEIcITKfO10Jjh+QaQ3
        Dqh/+2851GZfXBIhU+qPJPe1T7eBEkBegU+VbNm64TNjlJ6Is6KoR5Fyw5kg1+8b5Jv4sIVaOUA5K
        FJkssK2TPUe7BeqYiIgdncKBZRh5LxUoj3+bTFg4DMc3oPU/sYD997Ogb1TxEt9m1nLKFEXxNYxHG
        HOajDWdTtD0NFkBKCvvoejZJxtinc6+2mBhLeGKx3tjaS9MJulv37mu3tI9Pd+3w9TKU7D8Oguj7m
        2FX1Lza38uFsVup8HGR7+BxWhTKSOdRH6D+C/tKb7e9Oqg+IFA588Bn8bEVyQN2YhOVetFxSG/Uoz
        9QK26Ffg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miV02-007s2j-KM; Thu, 04 Nov 2021 05:09:18 +0000
Subject: Re: [PATCH v4 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <480a3ab57b45f4483612db1211dd25d424d90ec5.1635993377.git.qinjian@cqplus1.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <089b1d0f-1a98-59fc-d766-1fbe744ddf4d@infradead.org>
Date:   Wed, 3 Nov 2021 22:09:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <480a3ab57b45f4483612db1211dd25d424d90ec5.1635993377.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 7:57 PM, Qin Jian wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 59baf6c13..feba287eb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -487,6 +487,24 @@ config ARCH_S3C24XX
>   	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
>   	  Samsung SMDK2410 development board (and derivatives).
>   
> +config ARCH_SUNPLUS
> +	bool "Sunplus SoCs"
> +	select CLKSRC_OF
> +	select COMMON_CLK
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IRQ_CHIP
> +	select GENERIC_IRQ_MULTI_HANDLER
> +	select SERIAL_SUNPLUS
> +	select SERIAL_SUNPLUS_CONSOLE
> +	select USE_OF
> +	select RTC_CLASS
> +	select RESET_SUNPLUS
> +	help
> +	  Support for Sunplus SoC family: SP7021 and succeed SoCs based systems,

	                                             succeeding or successsor or following
	                                                     SoC-based systems,

> +	  such as the Banana Pi BPI-F2S development board ( and derivatives).

	                                                  (and derivatives).

> +	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
> +	  (<https://tibbo.com/store/plus1.html>)


-- 
~Randy

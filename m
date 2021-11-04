Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4526E444E22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKDFMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKDFMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:12:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC9C061714;
        Wed,  3 Nov 2021 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=DlU9hmw4W8D9x6aVOx0iFXlJ+qpIS36/C+b8G40GJkE=; b=pslMV/T+V+ssGajnysctcPW9c4
        7HZaM79NzDGy2w5GuPU0YREHlw7YVP0rGrk4uaMSpbMkejUzF/rD0Ys0a2uaGoFq9BiHlH+cFr9Mx
        kQgI4u8shJGTRhCSQa3+rMqw/bzJcgdR78OIreWQNx8TJiwLMxg7FLiUHfSGUsSLCATEcLmEQGdWn
        2S80VNW366tCEMmCuPR3dalvG1tt0uhybCXbDgSYncMaBSZocjo2b81JkGUlbtdwfB39wzVrHUog2
        uhSBu/DK8kJyqybDC93UzpIoLso9Hm95A3mjHTh4Do8J+ixzRHSaZ8jefwCfkS0ggEmFZ6+OT977i
        1A0b+1pQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miV0L-007s7W-3M; Thu, 04 Nov 2021 05:09:37 +0000
Subject: Re: [PATCH v4 06/10] clk: Add Sunplus SP7021 clock driver
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <2373006c300bfde8b0a1470f81d252d3766ae1c3.1635993377.git.qinjian@cqplus1.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d5986ac-68ef-5537-8882-f34b8436d16a@infradead.org>
Date:   Wed, 3 Nov 2021 22:09:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2373006c300bfde8b0a1470f81d252d3766ae1c3.1635993377.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 7:57 PM, Qin Jian wrote:
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc973..1cd7ae7a3 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -334,6 +334,15 @@ config COMMON_CLK_VC5
>   	  This driver supports the IDT VersaClock 5 and VersaClock 6
>   	  programmable clock generators.
>   
> +config COMMON_CLK_SP7021
> +	bool "Clock driver for Sunplus SP7021 SoC"
> +	help
> +	  This driver supports the Sunplus SP7021 SoC clocks.
> +	  It implemented SP7021 PLLs/gate.

	     implements

> +	  Not all features of the PLL are currently supported
> +	  by the driver.
> +	  This driver is selected automatically by platform config.


-- 
~Randy

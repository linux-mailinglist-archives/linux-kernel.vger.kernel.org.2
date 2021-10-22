Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67204438073
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhJVXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhJVXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:04:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74602C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ThrVyvhYD0JHsukgsvqkog71VG0MPB0g06xCAvRcMD4=; b=e8Cjs7buEx4bsEfiWkh2nzBPNz
        T6KFnfVL6DevecROt5TglVhfYYQGXPMbo/1J8wk4pvToIexT0CcYsly6pIuz9xmYqHdrwL0eVg6DE
        wYqXX3wu+75vXysyCx63BGt+G7bbPs6DKSlXdc7zO3IijrG39ojmAllglEznUwdodDI7JImuuTjC9
        +O09IjlYRo/MUZO1yRuBkgObYcYdeDqIcnSkUR4hPf6DaQQNqvFB+n4RR4fi+2r0QpCKxgQZeWM0c
        +kPrkKklGLE1XZ24d3qhoQHJcNqjNWhNzet2P6TU2oB+SLZFtbE513TDB+Quedq0Es8a2M4PYbzD7
        /AbDzNjA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me3Xn-00C5aV-1J; Fri, 22 Oct 2021 23:01:47 +0000
Subject: Re: [PATCH] reset: Add Sunplus SP7021 reset driver
To:     qinjian <qinjian@cqplus1.com>, p.zabel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
References: <20211022091157.456755-1-qinjian@cqplus1.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d32de27d-510e-520e-f616-4167a6ceebb4@infradead.org>
Date:   Fri, 22 Oct 2021 16:01:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022091157.456755-1-qinjian@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 2:11 AM, qinjian wrote:
> Add reset driver for Sunplus SP7021 SoC.
> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/reset/Kconfig         |   9 ++
>   drivers/reset/Makefile        |   1 +
>   drivers/reset/reset-sunplus.c | 159 ++++++++++++++++++++++++++++++++++
>   4 files changed, 170 insertions(+)
>   create mode 100644 drivers/reset/reset-sunplus.c
> 

Hi,

> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index be799a5ab..3e2e49998 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -249,6 +249,15 @@ config RESET_TI_SYSCON
>   	  you wish to use the reset framework for such memory-mapped devices,
>   	  say Y here. Otherwise, say N.
>   
> +config RESET_SUNPLUS
> +	bool "Sunplus SoCs Reset Driver"
> +	default SOC_SP7021 || SOC_Q645
> +	help
> +	  This enables the reset driver support for Sunplus SP7021 and Q645
> +	  SoC family. Say Y if you want to control reset signals by the reset
> +	  controller. Otherwise, say N.
> +	  This will be enabled by default.

What does that last sentence mean?

thanks.
-- 
~Randy

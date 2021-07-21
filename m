Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED753D177C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhGUTZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGUTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:25:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1EC061575;
        Wed, 21 Jul 2021 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bDhvQ5YCOhcXTke9r+u6SsmUS3hGfHOc7ntSpGhNKLg=; b=3Rv/FfjlP3R98vmcNifWRESui9
        Jfe+4cJRBjgGEuVzc1OdMlfV1CQ7ev49jyz5i5CwSEoyJZ8m76jORYARGu75dIE7nFL9rHK8Ogp/A
        nQibJ2Gs9ELzCFy/w0v9bXiRlRBfsRZLPflXMcWwwBtTYFpH9CKByxusXHhDYJP8CwGfo6mpK16Qu
        XQXBX71gMSAIYDc7/aOIozF7f3dSDfcmMr/YRPHkowu+Pe3TN9/0WIQ8C0OQg47pUQJo8hlQoB6Qs
        9EHVE2Q7ntA5+UMpLl1Nq+XB77pCnKMSZgyIkAOJjXWmAzPFBEWAtHfEGBtMTGDxginicnsnQqpou
        xEMpmEPQ==;
Received: from [2601:1c0:6280:3f0:7629:afff:fe72:e49d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6ITp-00H42X-Or; Wed, 21 Jul 2021 20:06:09 +0000
Subject: Re: [PATCH] clk: hisilicon: hi3559A: select CONFIG_RESET_HISI
To:     Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210721151136.2060107-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <721190b5-2a72-2ef1-b76c-65d311813fc0@infradead.org>
Date:   Wed, 21 Jul 2021 13:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721151136.2060107-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 8:11 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The reset functions are in a library that has to be selected
> for each driver using them:
> 
> aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi3559av100_crg_remove':
> clk-hi3559a.c:(.text+0x1c8): undefined reference to `hisi_reset_exit'
> clk-hi3559a.c:(.text+0x1c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_exit'
> aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi3559av100_crg_probe':
> clk-hi3559a.c:(.text+0x284): undefined reference to `hisi_reset_init'
> clk-hi3559a.c:(.text+0x284): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_init'
> aarch64-linux-ld: clk-hi3559a.c:(.text+0x2e8): undefined reference to `hisi_reset_exit'
> clk-hi3559a.c:(.text+0x2e8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_exit'
> 
> Add the select to 3559 as well.
> 
> Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/hisilicon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
> index 5ecc37aaa118..c1ec75aa4ccd 100644
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig
> @@ -18,6 +18,7 @@ config COMMON_CLK_HI3519
>  config COMMON_CLK_HI3559A
>  	bool "Hi3559A Clock Driver"
>  	depends on ARCH_HISI || COMPILE_TEST
> +	select RESET_HISI
>  	default ARCH_HISI
>  	help
>  	  Build the clock driver for hi3559a.
> 

https://lore.kernel.org/lkml/20210717043159.12566-1-rdunlap@infradead.org/


-- 
~Randy


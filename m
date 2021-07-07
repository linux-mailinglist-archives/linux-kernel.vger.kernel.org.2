Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10913BE803
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGGMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhGGMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 213BF61C82;
        Wed,  7 Jul 2021 12:30:33 +0000 (UTC)
Subject: Re: [PATCH] m68k/coldfire: change pll var. to clk_pll
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, linux-m68k@lists.linux-m68k.org,
        uclinux-dev@uclinux.org, Arnd Bergmann <arnd@arndb.de>
References: <20210704230137.28915-1-rdunlap@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <024360ce-41b2-c072-f399-7e87f516bfd0@linux-m68k.org>
Date:   Wed, 7 Jul 2021 22:30:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704230137.28915-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/21 9:01 am, Randy Dunlap wrote:
> DEFINE_CLK() makes the variable name be clk_xyz, so variable
> 'pll' should instead be 'clk_pll'.
> 
> In file included from ../arch/m68k/coldfire/m525x.c:12:
> ../arch/m68k/coldfire/m525x.c:29:30: error: 'pll' undeclared here (not in a function)
>     29 |  CLKDEV_INIT(NULL, "pll.0", &pll),
>        |                              ^~~
> ../include/linux/clkdev.h:30:10: note: in definition of macro 'CLKDEV_INIT'
>     30 |   .clk = c, \
>        |          ^
> In file included from ../arch/m68k/coldfire/m525x.c:21:
> ../arch/m68k/include/asm/mcfclk.h:43:27: warning: 'clk_pll' defined but not used [-Wunused-variable]
>     43 |         static struct clk clk_##clk_ref = { \
>        |                           ^~~~
> ../arch/m68k/coldfire/m525x.c:25:1: note: in expansion of macro 'DEFINE_CLK'
>     25 | DEFINE_CLK(pll, "pll.0", MCF_CLK);
>        | ^~~~~~~~~~
> 
> Fixes: 63aadb77669a ("m68k: coldfire: use clkdev_lookup on most coldfire")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: uclinux-dev@uclinux.org
> Cc: Arnd Bergmann <arnd@arndb.de>

Thanks Randy.

Arnd: since this has hit mainline do you want me to pick it up
in the m68knommu git tree and push to Linus from there?

Regards
Greg



> ---
>   arch/m68k/coldfire/m525x.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210701.orig/arch/m68k/coldfire/m525x.c
> +++ linux-next-20210701/arch/m68k/coldfire/m525x.c
> @@ -26,7 +26,7 @@ DEFINE_CLK(pll, "pll.0", MCF_CLK);
>   DEFINE_CLK(sys, "sys.0", MCF_BUSCLK);
>   
>   static struct clk_lookup m525x_clk_lookup[] = {
> -	CLKDEV_INIT(NULL, "pll.0", &pll),
> +	CLKDEV_INIT(NULL, "pll.0", &clk_pll),
>   	CLKDEV_INIT(NULL, "sys.0", &clk_sys),
>   	CLKDEV_INIT("mcftmr.0", NULL, &clk_sys),
>   	CLKDEV_INIT("mcftmr.1", NULL, &clk_sys),
> 

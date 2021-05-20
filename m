Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1A389AED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhETBgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:36:36 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:50622 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:36:34 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 21:36:34 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 7564612ED;
        Thu, 20 May 2021 09:27:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32138T140105872516864S1621474013383973_;
        Thu, 20 May 2021 09:26:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6158bed3826150f8b8c821007edef603>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] clk: rockchip: fix rk3568 cpll clk gate bits
To:     Peter Geis <pgwipeout@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210519174149.3691335-1-pgwipeout@gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <91fb0c11-1626-4a8c-7e01-2ef71faddc64@rock-chips.com>
Date:   Thu, 20 May 2021 09:26:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519174149.3691335-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: Michael:

Thanks for your patch.

Reviewed-by: Elaine Zhang<zhangqing@rock-chips.com>

ÔÚ 2021/5/20 ÉÏÎç1:41, Peter Geis Ð´µÀ:
> The cpll clk gate bits had an ordering issue. This led to the loss of
> the boot sdmmc controller when the gmac was shut down with:
> `ip link set eth0 down`
> as the cpll_100m was shut off instead of the cpll_62p5.
> cpll_62p5, cpll_50m, cpll_25m were all off by one with cpll_100m
> misplaced.
>
> Fixes: cf911d89c4c5 ("clk: rockchip: add clock controller for rk3568")
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   drivers/clk/rockchip/clk-rk3568.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
> index 946ea2f45bf3..75ca855e720d 100644
> --- a/drivers/clk/rockchip/clk-rk3568.c
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -454,17 +454,17 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
>   	COMPOSITE_NOMUX(CPLL_125M, "cpll_125m", "cpll", CLK_IGNORE_UNUSED,
>   			RK3568_CLKSEL_CON(80), 0, 5, DFLAGS,
>   			RK3568_CLKGATE_CON(35), 10, GFLAGS),
> +	COMPOSITE_NOMUX(CPLL_100M, "cpll_100m", "cpll", CLK_IGNORE_UNUSED,
> +			RK3568_CLKSEL_CON(82), 0, 5, DFLAGS,
> +			RK3568_CLKGATE_CON(35), 11, GFLAGS),
>   	COMPOSITE_NOMUX(CPLL_62P5M, "cpll_62p5", "cpll", CLK_IGNORE_UNUSED,
>   			RK3568_CLKSEL_CON(80), 8, 5, DFLAGS,
> -			RK3568_CLKGATE_CON(35), 11, GFLAGS),
> +			RK3568_CLKGATE_CON(35), 12, GFLAGS),
>   	COMPOSITE_NOMUX(CPLL_50M, "cpll_50m", "cpll", CLK_IGNORE_UNUSED,
>   			RK3568_CLKSEL_CON(81), 0, 5, DFLAGS,
> -			RK3568_CLKGATE_CON(35), 12, GFLAGS),
> +			RK3568_CLKGATE_CON(35), 13, GFLAGS),
>   	COMPOSITE_NOMUX(CPLL_25M, "cpll_25m", "cpll", CLK_IGNORE_UNUSED,
>   			RK3568_CLKSEL_CON(81), 8, 6, DFLAGS,
> -			RK3568_CLKGATE_CON(35), 13, GFLAGS),
> -	COMPOSITE_NOMUX(CPLL_100M, "cpll_100m", "cpll", CLK_IGNORE_UNUSED,
> -			RK3568_CLKSEL_CON(82), 0, 5, DFLAGS,
>   			RK3568_CLKGATE_CON(35), 14, GFLAGS),
>   	COMPOSITE_NOMUX(0, "clk_osc0_div_750k", "xin24m", CLK_IGNORE_UNUSED,
>   			RK3568_CLKSEL_CON(82), 8, 6, DFLAGS,



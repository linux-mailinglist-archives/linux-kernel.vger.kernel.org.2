Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29133378F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhCKQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhCKQNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:13:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 706A860241;
        Thu, 11 Mar 2021 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615478623;
        bh=dVsP+STyCM204me9sPtkFjD1L6E5GjVrtXP5uVUENU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=umpZhUA5RdXY7XEyc6DOL4b2RPOtUkL8zrWWG714WEf9Vs9RdRuAFY3z086hP1lth
         1HFQQnMEVsTP93TSPOgjIejya3taNlvc28pOJviNGv+JJ0Kwy/1EZ3i6CGxurOzlQS
         ByIC935VB/FEzpnoMZ7FTcTUF/JIpD8GoemSn7Wc2jTMO7l+DreUranianOlEndlGM
         cq76Pksfm6ZgZpr/IR7wZbhBNng3iVzzSwr34ZkDOUHnNkyvRR0LY7boung1RCo7ej
         2d617j6alGuNAq79E0mFtvHrSsarkcTAH/5+dV+Lpv3+UH2K5XnHHiqMReCfNlJJvX
         0vYfSdEClP22Q==
Subject: Re: [PATCH] clk: socfpga: fix iomem pointer cast on 64-bit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210311144833.1313387-1-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <70efd621-3125-21a2-cd5a-cc01284f0e75@kernel.org>
Date:   Thu, 11 Mar 2021 10:03:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311144833.1313387-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/21 8:48 AM, Krzysztof Kozlowski wrote:
> Pointers should be cast to unsigned long instead of integer.  This fixes
> warning when compile testing on ARM64:
> 
>    drivers/clk/socfpga/clk-gate.c: In function ‘socfpga_clk_recalc_rate’:
>    drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/clk/socfpga/clk-gate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 43ecd507bf83..c876523d5d51 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -99,7 +99,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>   		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
>   		val &= GENMASK(socfpgaclk->width - 1, 0);
>   		/* Check for GPIO_DB_CLK by its offset */
> -		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
> +		if ((unsigned long) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
>   			div = val + 1;
>   		else
>   			div = (1 << val);
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

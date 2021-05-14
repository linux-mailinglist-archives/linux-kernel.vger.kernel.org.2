Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60DC380C97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhENPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhENPNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:13:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95BEC613AF;
        Fri, 14 May 2021 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621005118;
        bh=eme2e7HJkMlbGwvCXTVrQTdbAt9gbHgcBXlx+tOw9p4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kiY/zGHBoKFVARznQj/wPcUvARwS/ciBM5r+GXeyL01xJLzJPvkzCfKg6mLv8w3GO
         QL/reQ53YLcFdF853bwk8EGY4QTJ2tuNQt0Hn1ps0MHz3SRRfr8MtmQ3nhhtDbiANS
         Djea3wgqCnjQjwOXDeCw8fgoof96T3w4f8Vd1hAC6MmZH0+E+mNdsfh+9MYRbO9Hvo
         6JBa+tiXVL2eD3xs+SNo5qORQbFc3XYGr9GBeE9KLIWyAkZ7dKnaAGJgXh7PQbZKep
         jWY6+r3HPF+MZtpK8R9UTvwLxl+ZpCzQg4WAAc6Q1LsZg0GbqqUdWEfPKZCpOHmYJR
         yoJ6gLrv4v+yg==
Subject: Re: [PATCH] clk: socfpga: remove set but not used variable 'rc'
To:     Yu Kuai <yukuai3@huawei.com>, mturquette@baylibre.com,
        sboyd@kernel.org, s.trumtrar@pengutronix.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210514062234.3534615-1-yukuai3@huawei.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <786d67c5-1470-098b-79cd-801b06a72bf3@kernel.org>
Date:   Fri, 14 May 2021 10:11:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210514062234.3534615-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/21 1:22 AM, Yu Kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/clk/socfpga/clk-pll.c:83:6: warning: variable ‘rc’ set but
> not used [-Wunused-but-set-variable]
> 
> The returned value of of_clk_add_provider() is never used, and so
> can be removed.
> 
> Fixes: 97259e99bdc9 ("clk: socfpga: split clk code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/clk/socfpga/clk-pll.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index dcb573d44034..127cc849c5ee 100644
> --- a/drivers/clk/socfpga/clk-pll.c
> +++ b/drivers/clk/socfpga/clk-pll.c
> @@ -80,7 +80,6 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
>   	const char *parent_name[SOCFPGA_MAX_PARENTS];
>   	struct clk_init_data init;
>   	struct device_node *clkmgr_np;
> -	int rc;
>   	int err;
>   
>   	of_property_read_u32(node, "reg", &reg);
> @@ -114,7 +113,7 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
>   		kfree(pll_clk);
>   		return ERR_PTR(err);
>   	}
> -	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +	of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
>   	return hw_clk;
>   }
>   
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

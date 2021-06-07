Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C139D84C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFGJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:09:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3446 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFGJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:09:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fz6rr5GXzz6vpG;
        Mon,  7 Jun 2021 17:05:00 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:08:02 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:08:02 +0800
Subject: Re: [PATCH V2] clk: socfpga: err out if of_clk_add_provider() failed
 in __socfpga_pll_init()
To:     <dinguyen@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <162262008540.4130789.916741380026683860@swboyd.mtv.corp.google.com>
 <20210602084259.1267768-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f706a87b-fb25-8d63-43e5-9e71a0f8fec8@huawei.com>
Date:   Mon, 7 Jun 2021 17:08:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210602084259.1267768-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On 2021/06/02 16:42, Yu Kuai wrote:
> __socfpga_pll_init() should fail if of_clk_add_provider() failed.
> remove 'rc' in the meantime to avoid gcc
> '-Wunused-but-set-variable' warning.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> changes in V2:
>   - remove 'rc' and use err' instead of 'rc'
>   - err out if of_clk_add_provider() failed
> 
>   drivers/clk/socfpga/clk-pll.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index dcb573d44034..5a9eec2eca80 100644
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
> @@ -110,12 +109,16 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
>   	hw_clk = &pll_clk->hw.hw;
>   
>   	err = clk_hw_register(NULL, hw_clk);
> -	if (err) {
> -		kfree(pll_clk);
> -		return ERR_PTR(err);
> -	}
> -	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +	if (err)
> +		goto err_out;
> +	err = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +	if (err)
> +		goto err_out;
>   	return hw_clk;
> +
> +err_out:
> +	kfree(pll_clk);
> +	return ERR_PTR(err);
>   }
>   
>   void __init socfpga_pll_init(struct device_node *node)
> 

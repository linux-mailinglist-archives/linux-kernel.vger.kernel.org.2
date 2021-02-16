Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230D431C684
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 07:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBPGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 01:35:37 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33082 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBPGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 01:35:35 -0500
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0DA548F2;
        Tue, 16 Feb 2021 07:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613457291;
        bh=J/LhAGBfwF0LvhZz0isCODk9qUkT8DA7sIP0DTq7xKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=miCVxHvi6mSU62jD3ftEtIpmiBKI6bQMZ+MrDhDke4fTk/nAZdGTh1rC8DttfIqWA
         9jcL/XXy4vC/qvL2fv3WNQUuo9LZC5nUW7Qrv0XWmsO8VEPKNFAEwBVPix/A2v2stV
         pWLgJvBKyB1hvC1S9wK+x/JFdZJ/W8kOXpk91/9Y=
Subject: Re: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>
References: <20200903160237.932818-1-maz@kernel.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
Message-ID: <d35d3960-c2a6-491d-fd1a-cf3aa95ce109@ideasonboard.com>
Date:   Tue, 16 Feb 2021 08:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903160237.932818-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 03/09/2020 19:02, Marc Zyngier wrote:
> The name allocated for the regmap_config structure is freed
> pretty early, right after the registration of the MMIO region.
> 
> Unfortunately, that doesn't follow the life cycle that debugfs
> expects, as it can access the name field long after the free
> has occured.
> 
> Move the free on the error path, and keep it forever otherwise.
> 
> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 75859e492984..7a660411c562 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,7 +108,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> -	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret = PTR_ERR(regmap);
> @@ -145,6 +144,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> +	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);
> 

This patch causes lots of kmemleak reports, for example:

unreferenced object 0xc8e6f000 (size 64):
  comm "kworker/1:1", pid 22, jiffies 4294938454 (age 95.540s)
  hex dump (first 32 bytes):
    64 73 70 5f 73 79 73 74 65 6d 40 34 30 64 30 30  dsp_system@40d00
    30 30 30 00 e0 09 4d c1 ac 1b 4d c1 64 74 4c c1  000...M...M.dtL.
  backtrace:
    [<(ptrval)>] __kmalloc_track_caller+0x2bc/0x418
    [<(ptrval)>] kvasprintf+0x9c/0x124
    [<(ptrval)>] kasprintf+0x70/0xac
    [<(ptrval)>] of_syscon_register+0x1f0/0x4f0
    [<(ptrval)>] device_node_get_regmap+0x12c/0x158
    [<(ptrval)>] syscon_regmap_lookup_by_phandle+0x5c/0x6c
    [<(ptrval)>] omap_iommu_probe+0x6ac/0xc28
    [<(ptrval)>] platform_probe+0x120/0x1e0
    [<(ptrval)>] really_probe+0x2b4/0x121c
    [<(ptrval)>] driver_probe_device+0x10c/0x4c0
    [<(ptrval)>] __device_attach_driver+0x1d8/0x26c
    [<(ptrval)>] bus_for_each_drv+0x174/0x200
    [<(ptrval)>] __device_attach+0x2f0/0x45c
    [<(ptrval)>] device_initial_probe+0x1c/0x20
    [<(ptrval)>] bus_probe_device+0x224/0x2b8
    [<(ptrval)>] device_add+0xad0/0x1e18

 Tomi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26A3A9654
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhFPJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:38:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24906 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFPJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:38:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210616093644euoutp024e9adfa58927f6269f3663b1d81ed207~JBmzA-Aqw2533225332euoutp02k
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210616093644euoutp024e9adfa58927f6269f3663b1d81ed207~JBmzA-Aqw2533225332euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623836204;
        bh=wW8MZ+uJeIfwvh/94TGH5oTGzJnnv/yEZfmpRzfEyRA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ut9IJv19vlu6ofz3Pxi6MtHI9O51o+EumiMwUCOR29bC1CjbVs7esdFCP6Y3k4vMx
         7xPEfAWSiPt8vF3UwKhlSFYIqtLycsC59FA/VAV2rO7idZlMtg1hgJdrqxAujQeHvh
         zNPpSsDuBFFR6YQY6jvxj3dBSCzJ6cYrfoObXgw8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210616093644eucas1p29279367444c5360519fecf56264a9e2c~JBmy2_h9g1361513615eucas1p2o;
        Wed, 16 Jun 2021 09:36:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0A.FB.09444.C26C9C06; Wed, 16
        Jun 2021 10:36:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210616093644eucas1p2edfbd8b164059d77cd8f109eb80b161f~JBmyZ2Iu51360713607eucas1p29;
        Wed, 16 Jun 2021 09:36:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210616093644eusmtrp227d0c29e21469914b29d022e5aea7861~JBmyVOW9J0919909199eusmtrp2D;
        Wed, 16 Jun 2021 09:36:44 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-60-60c9c62c3bda
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.56.08705.B26C9C06; Wed, 16
        Jun 2021 10:36:44 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210616093643eusmtip1e01ea3df96ba5cd79bf0ed941a75903b~JBmx9osCs2395123951eusmtip1T;
        Wed, 16 Jun 2021 09:36:43 +0000 (GMT)
Subject: Re: [PATCH 1/3] of: Fix truncation of memory sizes on 32-bit
 platforms
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0c2be5ec-8a22-d398-d455-847ddbcece86@samsung.com>
Date:   Wed, 16 Jun 2021 11:36:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4a1117e72d13d26126f57be034c20dac02f1e915.1623835273.git.geert+renesas@glider.be>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ1pO9RULyPKSTWoVYkYioBIGm2IBhKJhsQtbg9ChQmobHZA
        BKJBiFvFhQZZChR3sFiXUqEUZbMCoizSgATBVIUHUUTcNVG0jChv3/nvf5Y/uRRBn+JLqN2x
        CYwqVhktFYjIisbv7TLPxodh3u8uLJAXW9v48vy3YwJ5UYEGyW2WQoH8yD2rcBU/OKtVFlyl
        7RcGG/UnBMEfjW7ryR0iRQQTvXs/o1oaECaKGix6zY8fkxwwaJoFaahopho5UYD94ErLqECN
        RBSNSxG0Wh/wuOITgrIGncDhovFHBJe7FRMdrYYMkjOVIGjPvoq4YhTBe/srocM1A2+Ap11V
        pINdcCpk9NeMM4EV0GOwIQcLsA+oh9V/NlCUGAeAJXefQybxItBf6uU5eCYOhxFdHt/BYuwM
        D/MHxsc44Z1grhwmuJFzoXK48C+7Qu9A8XgCwFYKKs+UIu7qICh+riM5ngFDTSYhx3NgrGqi
        IQPBizaDkCsyEdjS8/52r4S+th/jlxLYA25alnLyajh9qQs5ZMDToGfYmTtiGmgqcglOFsPx
        ozTndgdt041/a+s7OomzSKqdFE07KY52Uhzt/73nEalHrkwiGxPJsL6xTJIXq4xhE2MjvcLj
        Yozoz4959KvpkxmVDI16NSAehRoQUITURSxjm8NocYQyOYVRxYWqEqMZtgHNpkipq3iX6Xoo
        jSOVCcxeholnVBOvPMpJksZDRnvx5x9TPdLKM2fHYz/FSTqzZe0mVXXg7Uyd/WAvEkWnmEJq
        LnYEmdY9AsmyZ7Wb23v6Io59xTGPnx6O6pyjCeiUyUuJaxs8njmlntnTVi4uTOjfp75zpf6L
        1TduBUjoszxvpn7x/ZAWvcuWFmeTbO+d5Faf5dZVty2i1I07ktCI+rHtUL1Xd8mx7SUFrB/P
        zVZd+U3juS3A3yfcYDBL6grnrRk0vekz625m+fqfmo7rXppy3rf/DPT2z1vYfEM/teKrsMpe
        UQs1yqMhC765z/LdOnLX7YPiiZurJf/+Ce+fQY3zm0M79piXG7Kh1h6SQzXWld+iy6c8LzOe
        S5eSbJTSZwmhYpW/ASOmgCygAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7o6x04mGBxcwmQx/8g5VouZb/6z
        WcydPYnR4vKuOWwWrXuPsDuwekw8q+uxc9Zddo9NqzrZPD5vkgtgidKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeDr3JWvBf6mKtZNOsDUwzhXt
        YuTkkBAwkTi7tpkFxBYSWMoocbbNHSIuI3FyWgMrhC0s8edaF1sXIxdQzXtGiTu/DrKBJIQF
        AiWuX90J1iwiUC2x/tkjZhCbWcBG4sbay4wQDY8YJU5fuwXWwCZgKNH1FmQSBwevgJ3ErumF
        IGEWAVWJVYtvMYHYogLJEj/Xt4OV8woISpyc+QRsPqdAnMSO7W+h5ptJzNv8EMqWl9j+dg6U
        LS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbU
        tmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8usUnEoR4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5
        HxjVeSXxhmYGpoYmZpYGppZmxkrivFvnrokXEkhPLEnNTk0tSC2C6WPi4JRqYGpJ6jeQ/Dwn
        XeUezy+m5k2OHJoHlNLZ/RarP0707dpYK7BhpyHf4sci+4pKrY2FBR7t3urYMPHCtsLWKX/X
        RZhw+Ya80y3Z3S68J+/6rsb9S7a4xbvYydTNPBR2fQbHhJONB3Zeyo6/H7/CQ771xxXBIn6+
        WfNV3HdFfV6oPeutcbNKQOG6A6I2czx6nl4I/bfgM+e5ZsbFPo+9lyVcn2b1tWfpxiMuH2+w
        Xn60RfTGWpUJ7hdlv19ctGHv/7g76ybNXxcw4aWDyw9+nZQ31fx7r5ZnzQuxNHDiTpg813Vh
        4tRIX+EEq4tevL/SRac258UcmFEcbFNWYOGe8PQyU/gs2TPz1no859/WxNmVnqzEUpyRaKjF
        XFScCADuygo1MgMAAA==
X-CMS-MailID: 20210616093644eucas1p2edfbd8b164059d77cd8f109eb80b161f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210616092756eucas1p2bc7078a1a343f83f416bf6ba3acbc9ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210616092756eucas1p2bc7078a1a343f83f416bf6ba3acbc9ff
References: <cover.1623835273.git.geert+renesas@glider.be>
        <CGME20210616092756eucas1p2bc7078a1a343f83f416bf6ba3acbc9ff@eucas1p2.samsung.com>
        <4a1117e72d13d26126f57be034c20dac02f1e915.1623835273.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2021 11:27, Geert Uytterhoeven wrote:
> Variable "size" has type "phys_addr_t", which can be either 32-bit or
> 64-bit on 32-bit systems, while "unsigned long" is always 32-bit on
> 32-bit systems.  Hence the cast in
>
>      (unsigned long)size / SZ_1M
>
> may truncate a 64-bit size to 32-bit, as casts have a higher operator
> precedence than divisions.
>
> Fix this by inverting the order of the cast and division, which should
> be safe for memory blocks smaller than 4 PiB.  Note that the division is
> actually a shift, as SZ_1M is a power-of-two constant, hence there is no
> need to use div_u64().
>
> While at it, use "%lu" to format "unsigned long".
>
> Fixes: e8d9d1f5485b52ec ("drivers: of: add initialization code for static reserved memory")
> Fixes: 3f0c8206644836e4 ("drivers: of: add initialization code for dynamic reserved memory")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/of/fdt.c             | 8 ++++----
>   drivers/of/of_reserved_mem.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a03d43f95495d8e1..970fa8cdc9303195 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -510,11 +510,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>   
>   		if (size &&
>   		    early_init_dt_reserve_memory_arch(base, size, nomap) == 0)
> -			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %ld MiB\n",
> -				uname, &base, (unsigned long)size / SZ_1M);
> +			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
> +				uname, &base, (unsigned long)(size / SZ_1M));
>   		else
> -			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %ld MiB\n",
> -				uname, &base, (unsigned long)size / SZ_1M);
> +			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
> +				uname, &base, (unsigned long)(size / SZ_1M));
>   
>   		len -= t_len;
>   		if (first) {
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 4592b71aba5cf4a1..333d33bad59d7888 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -136,9 +136,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>   			ret = early_init_dt_alloc_reserved_memory_arch(size,
>   					align, start, end, nomap, &base);
>   			if (ret == 0) {
> -				pr_debug("allocated memory for '%s' node: base %pa, size %ld MiB\n",
> +				pr_debug("allocated memory for '%s' node: base %pa, size %lu MiB\n",
>   					uname, &base,
> -					(unsigned long)size / SZ_1M);
> +					(unsigned long)(size / SZ_1M));
>   				break;
>   			}
>   			len -= t_len;
> @@ -148,8 +148,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>   		ret = early_init_dt_alloc_reserved_memory_arch(size, align,
>   							0, 0, nomap, &base);
>   		if (ret == 0)
> -			pr_debug("allocated memory for '%s' node: base %pa, size %ld MiB\n",
> -				uname, &base, (unsigned long)size / SZ_1M);
> +			pr_debug("allocated memory for '%s' node: base %pa, size %lu MiB\n",
> +				uname, &base, (unsigned long)(size / SZ_1M));
>   	}
>   
>   	if (base == 0) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E914135005E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhCaMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235668AbhCaM36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9D9D619EA;
        Wed, 31 Mar 2021 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617193797;
        bh=6mxWdwyZ+0OCFlssSvpvvsbni0ng5CFRshB25j/A10I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/riIKShzYjOVvxgxDs3wPB5rrR10eESV3fmZwiiqzqBF9OLJXxzYZ1qodOGJkrte
         9Hlpj/hOZbmx8Wri24t4Cc19uMkcnOf+BxefbGzCoTI/Or2vDhOP5guwmg9rI9DNQl
         Zk2jFIJwUhYBOF2QZWp27ZfNSfSL9u1N5YsPoXIpvjPOtgZbDdxX9y8GPSWFnuNgKZ
         HIto9E7quKwqSlw9nuUDvE7KaFBCgZUT3JaMRP0GNFi5abTE8jIA+QFJd4Y3CXMvT0
         UCy1pgk8VxbgF7DZU+cbpL+Mlc9VPv8T4j55kl8yICByo5tjwAQA5k4/wPlPbZINkF
         uWsYvcHb31xCg==
Date:   Wed, 31 Mar 2021 17:59:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     kishon@ti.com, xuejiancheng@huawei.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
Subject: Re: [PATCH] phy: hisilicon: Use the correct HiSilicon copyright
Message-ID: <YGRrQV8VEp3rs19L@vkoul-mobl.Dlink>
References: <1617086861-13900-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617086861-13900-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-21, 14:47, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S,
> according to https://www.hisilicon.com/en/terms-of-use.

And I have not agreed to those terms of use! If you wish to change the
name, please do send the patch dropping this terms of use link. I dont
mind name appearing properly...

Thanks
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/phy/hisilicon/phy-hi6220-usb.c   | 2 +-
>  drivers/phy/hisilicon/phy-hix5hd2-sata.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/hisilicon/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
> index be05292..e92ba78 100644
> --- a/drivers/phy/hisilicon/phy-hi6220-usb.c
> +++ b/drivers/phy/hisilicon/phy-hi6220-usb.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2015 Linaro Ltd.
> - * Copyright (c) 2015 Hisilicon Limited.
> + * Copyright (c) 2015 HiSilicon Limited.
>   */
>  
>  #include <linux/mfd/syscon.h>
> diff --git a/drivers/phy/hisilicon/phy-hix5hd2-sata.c b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
> index c67b78c..b0f99a9 100644
> --- a/drivers/phy/hisilicon/phy-hix5hd2-sata.c
> +++ b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2014 Linaro Ltd.
> - * Copyright (c) 2014 Hisilicon Limited.
> + * Copyright (c) 2014 HiSilicon Limited.
>   */
>  
>  #include <linux/delay.h>
> -- 
> 2.8.1

-- 
~Vinod

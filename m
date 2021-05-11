Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69337AD00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhEKRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhEKRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A28261261;
        Tue, 11 May 2021 17:20:23 +0000 (UTC)
Date:   Tue, 11 May 2021 18:20:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luo Longjun <luolongjun@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sangyan@huawei.com,
        ningyu9@huawei.com, luchunhua@huawei.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
Message-ID: <20210511172020.GB21033@arm.com>
References: <20210507182410.10515-1-luolongjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507182410.10515-1-luolongjun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 02:24:10AM +0800, Luo Longjun wrote:
> When I compile kernel in ARM64, it produces the following output:
> 
> *** Default configuration is based on 'defconfig'
> arch/arm64/configs/defconfig:1018:warning: override: reassigning to
> symbol MTK_PMIC_WRAP
> 
> After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.
> 
> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..9907a431db0d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_SPI_SH_MSIOF=m
>  CONFIG_SPI_SUN6I=y
>  CONFIG_SPI_SPIDEV=m
> -CONFIG_MTK_PMIC_WRAP=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y

Adding Matthias and Enric. This change looks fine to me but I think it
should go in via the arm-soc tree. Commit 9fd5449e061e introduced the =m
option while commit fbbe38309d56 introduced the =y variant.

You could add:

Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")

-- 
Catalin

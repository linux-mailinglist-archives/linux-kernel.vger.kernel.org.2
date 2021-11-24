Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD40E45B874
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbhKXKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:39:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60584 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhKXKjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:39:01 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mppcu-0004vP-Bj; Wed, 24 Nov 2021 11:35:44 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
Date:   Wed, 24 Nov 2021 11:35:43 +0100
Message-ID: <2895944.ZOkXcVNkQQ@diego>
In-Reply-To: <20211124021325.858139-1-knaerzche@gmail.com>
References: <20211124021325.858139-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. November 2021, 03:13:25 CET schrieb Alex Bee:
> With the submission of iommu driver for RK3568 a subtle bug was
> introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
> the other way arround - that leads to random errors, especially when
> addresses beyond 32 bit are used.
> 
> Fix it.
> 
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> 
> I've found this bug, when testing the recent VOP2 submission, which is
> the first perpherial which uses iommu for RK356x. I could use it on my
> quartz64 8GB board only, when limiting the available memory to less 4GB.
> 
> This patch fixes it.
> 
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5cb260820eda..7f23ad61c094 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
>  #define DTE_HI_MASK2	GENMASK(7, 4)
>  #define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
>  #define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
> -#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
> -#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK1	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK2	GENMASK_ULL(39, 36)

With this change the PAGE_DESC_HI_MASK* now match the other
constants above them in what bits they access, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





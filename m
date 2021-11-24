Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98345B683
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhKXI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhKXI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:28:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:25:39 -0800 (PST)
Received: from [IPv6:2a01:e0a:120:3210:4f87:f4f0:a34a:671f] (unknown [IPv6:2a01:e0a:120:3210:4f87:f4f0:a34a:671f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9972E1F4546D;
        Wed, 24 Nov 2021 08:25:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637742337; bh=vRI49dQQwsck28Fum3XIvDQAfd/iwxihc8UsPhq3ZWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XG2omBbppW8i4p4VZZh1zKY+NKk5++WhfkWyQiJIuKIlXVAOQPC+cjbVPK5t7bsQb
         xCRax8AIOAlAbTRBRWrqvW60/yjDajFXff7pxQy3o1FHmrrzwPM2vMRvBYHFEFoNYh
         MYbMb5tWSyVjhCopdaVHw3kCoTD3MNRT69MiA/dDeUSDZEG4eij3LrzYeJdae/Bx3K
         docplAecOWcrrQl34BYSo0XivLSkF8zQENSIOgoy8RWp3U50+ZC85K58tYYXUOsam1
         06nT7sN39xkGlt97eFiXI3wUXXDGCMkTmstZdcmZoTofxr3iLfn+L3yfgdXr9zccyk
         wbdG6MQdHuEhA==
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
To:     Alex Bee <knaerzche@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211124021325.858139-1-knaerzche@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <ce137254-eee4-3241-a977-84cccb44b7cd@collabora.com>
Date:   Wed, 24 Nov 2021 09:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124021325.858139-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/11/2021 à 03:13, Alex Bee a écrit :
> With the submission of iommu driver for RK3568 a subtle bug was
> introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
> the other way arround - that leads to random errors, especially when
> addresses beyond 32 bit are used.
>
> Fix it.
>
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Thanks for the fix.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>
> I've found this bug, when testing the recent VOP2 submission, which is
> the first perpherial which uses iommu for RK356x. I could use it on my
> quartz64 8GB board only, when limiting the available memory to less 4GB.
>
> This patch fixes it.
>
>   drivers/iommu/rockchip-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5cb260820eda..7f23ad61c094 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
>   #define DTE_HI_MASK2	GENMASK(7, 4)
>   #define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
>   #define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
> -#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
> -#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK1	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK2	GENMASK_ULL(39, 36)
>   
>   static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
>   {

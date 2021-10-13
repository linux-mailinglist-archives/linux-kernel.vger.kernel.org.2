Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD242C13C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhJMNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:21:42 -0400
Received: from rosenzweig.io ([138.197.143.207]:46934 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:21:41 -0400
Date:   Wed, 13 Oct 2021 08:51:04 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] iommu/dart: use kmemdup instead of kzalloc and memcpy
Message-ID: <YWbWOMlMtx3h32Ei@sunset>
References: <20211013063441.29888-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013063441.29888-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Wed, Oct 13, 2021 at 02:34:41AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> drivers/iommu/apple-dart.c:704:20-27: WARNING opportunity for kmemdup
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 280ff8df728d..5eeb8d6b72e2 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -701,13 +701,12 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
>  	if (!group)
>  		goto out;
>  
> -	group_master_cfg = kzalloc(sizeof(*group_master_cfg), GFP_KERNEL);
> +	group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg), GFP_KERNEL);
>  	if (!group_master_cfg) {
>  		iommu_group_put(group);
>  		goto out;
>  	}
>  
> -	memcpy(group_master_cfg, cfg, sizeof(*group_master_cfg));
>  	iommu_group_set_iommudata(group, group_master_cfg,
>  		apple_dart_release_group);
>  
> -- 
> 2.20.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD173C29E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhGIUAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhGIUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:00:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9AC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=DMkCA7RWHPqMAEch6YhvJNGp023fMsLOLTIjvY4qQXk=; b=ViBLf56PgJRJJZYN2TYDaYNBu4
        THCdgBqNIbQ2Aam/paqj1Icj5vEA7z23n4iZKgzGwt4DNlB5ZreC+A3Nn02a1kMnfen2p45CFJy4i
        lxSrXNubjkYBpQGwtFgGXRFoA2EBw8F+l5pWrzUCUkE+7eZy1vEt2T1EMTvtZhnO1NT8JrV6dLY9Q
        dfHJD7VgCqOreaYe0rvCVjXXVqfxkh39Kf0HVwBqkisS33TOvuKpi/ZjTU+p+XniNGz4cQTP0In18
        ZyxqBk4o0v0XdtBwp3gtgTqVkPCF1FP0lDTzVJnqChK+sGh6y/j11xVIJP8l6bcxAhutZZB3QT1lL
        HY9a+3mg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1wd3-002QSM-I6; Fri, 09 Jul 2021 19:57:41 +0000
Subject: Re: [PATCH v1] fix vmwgfx compilation error due to a missing include
To:     Tong Zhang <ztong0001@gmail.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210709180944.2533114-1-ztong0001@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1951c951-753d-e752-d296-c1e172e2c971@infradead.org>
Date:   Fri, 9 Jul 2021 12:57:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709180944.2533114-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 11:09 AM, Tong Zhang wrote:
> This patch fixes vmwgfx driver compilation error due to a missing include
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_init’:
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:678:8: error: implicit declaration of function ‘ttm_range_man_init’ [-Werror=implicit-function-declaration]
>   678 |  ret = ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
>       |        ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_fini’:
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:690:2: error: implicit declaration of function ‘ttm_range_man_fini’ [-Werror=implicit-function-declaration]
>   690 |  ttm_range_man_fini(&dev_priv->bdev, TTM_PL_VRAM);
>       |  ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 6f5ea00973e0..6eb93aa2f311 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -37,6 +37,7 @@
>  #include <drm/drm_sysfs.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_placement.h>
> +#include <drm/ttm/ttm_range_manager.h>
>  #include <generated/utsrelease.h>
>  
>  #include "ttm_object.h"
> 

Yes, it's time to get one of these (3 or more) such patches
merged so that linux-next does not continue to have build errors,
like it has for about the last 2 weeks.

thanks.

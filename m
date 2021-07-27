Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32D93D787E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhG0O3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhG0O3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:29:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=THKIyKaJItuuzn+mjxOm4jQhHXAEqt5rES7irp8lkI8=; b=mP2oppjzOfiz9gxL+744ngdIHc
        9tUSQWJl+Kcahr7QnZuzRMtFTwcEOftgJ9lRl/DOWqAUM/3HfKToyoFC7dqh9cv1kt9u3WVDSIAvZ
        e3EoFm3zSppD8M9TMvc6ehypDfPWegxaAiLaiHMFNIpLFnqo/UxFD7EhbMsaDySz6cJNDDuOv9qmf
        BDFMQsilOWdXjnAAHim22EaZcfO+d+ar4kgBqQKgzU2eSmInugSRar5atA+9CtLZYmQsK1SI4bbgG
        Kxmx0lukpOa5MrSGArBQLF3RswGUkunZYHOrkZ4oPvITmCSDbFj1gZpuGfvnWg6JbQyufqfM4/NqP
        WyewaO3w==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8O56-00F4E1-9B; Tue, 27 Jul 2021 14:29:16 +0000
Subject: Re: [PATCH] drm/pl111: Remove unused including <linux/version.h>
To:     Cai Huoqing <caihuoqing@baidu.com>, emma@anholt.net,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210727052107.659-1-caihuoqing@baidu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ecafb6ba-ec4f-b98f-c07a-1b03a46a8b71@infradead.org>
Date:   Tue, 27 Jul 2021 07:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727052107.659-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 10:21 PM, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

as reported by 'make versioncheck':

../drivers/gpu/drm/pl111/pl111_display.c: 14 linux/version.h not needed.
../drivers/gpu/drm/pl111/pl111_drv.c: 47 linux/version.h not needed.


> ---
>  drivers/gpu/drm/pl111/pl111_display.c | 1 -
>  drivers/gpu/drm/pl111/pl111_drv.c     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index b5a8859739a2..443e3b932322 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -11,7 +11,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/version.h>
>  #include <linux/dma-buf.h>
>  #include <linux/of_graph.h>
>  
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index fa0a737e9dea..520301b405f1 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -44,7 +44,6 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/slab.h>
> -#include <linux/version.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> 

thanks.
-- 
~Randy


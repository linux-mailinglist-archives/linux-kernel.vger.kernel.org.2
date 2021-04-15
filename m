Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA715361388
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhDOUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234226AbhDOUdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:33:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F2B561131;
        Thu, 15 Apr 2021 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1618518791;
        bh=W2nMmH/TIbeIB5kU2kUp8LI+os2a3rcGm1HyUvE3oCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bMN/FgOL0iZZcydKxfGEO6IUq8f9VCFjKW5nDFVmpFmRHDHbX+bZcY7CmDZkf3cZA
         212qkV1WoyWHObEIbZJt1E80HyukEUqB0JXYC65vzut6c2zFJJaeAjKyuO3kUZ1JK3
         tcVEGhAEMe2SHPBB0rAd05jEAxNDQY2hCG6GHlAU=
Date:   Thu, 15 Apr 2021 13:33:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?ISO-8859-1?Q? "Christian_K=F6nig" ?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vbabka@suse.cz, daniel@ffwll.ch,
        ray.huang@amd.com
Subject: Re: [PATCH 2/2] drm/ttm: optimize the pool shrinker a bit v2
Message-Id: <20210415133310.1ee9df70a9eb887be937c3a3@linux-foundation.org>
In-Reply-To: <20210415115624.2904-2-christian.koenig@amd.com>
References: <20210415115624.2904-1-christian.koenig@amd.com>
        <20210415115624.2904-2-christian.koenig@amd.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 13:56:24 +0200 "Christian K=F6nig" <ckoenig.leichtzumer=
ken@gmail.com> wrote:

> @@ -530,6 +525,11 @@ void ttm_pool_fini(struct ttm_pool *pool)
>  			for (j =3D 0; j < MAX_ORDER; ++j)
>  				ttm_pool_type_fini(&pool->caching[i].orders[j]);
>  	}
> +
> +	/* We removed the pool types from the LRU, but we need to also make sure
> +	 * that no shrinker is concurrently freeing pages from the pool.
> +	 */
> +	sync_shrinkers();

It isn't immediately clear to me how this works.  ttm_pool_fini() has
already freed all the pages hasn't it?  So why would it care if some
shrinkers are still playing with the pages?

Or is it the case that ttm_pool_fini() is assuming that there will be
some further action against these pages, which requires that shrinkers
no longer be accessing the pages and which further assumes that future
shrinker invocations will not be able to look up these pages?

IOW, a bit more explanation about the dynamics here would help!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF239EA5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFGXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFGXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CB93610E7;
        Mon,  7 Jun 2021 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623109663;
        bh=bnHo1ahnMtzIECUmZYxoFPz90v3g99AYWe+v6R24ZI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otp3fkgcxCcUHl4PHxHfR4hE+jxni87eLJ+77Q2/3vEFxJKGtH8iv+nrPj+qI3G7B
         yhfX4u8HMbztotB4IUC6Kkv9Id961rgnwySwcA2y0hy5JT9v7c0lif7ZJyHZsz/iG3
         tt67TmxR74r1ZDTq3OekzIAFEHJAZU3s6yK3/XpWQIJMU0MUIfY01cbyfeITYVH0lm
         0K9ennsNvHNQEkTdBqwVo+je0IDWZtPNeX/rMPQVDWvLZmhwksznnhdX/CWkd++cCD
         mFklQ9yG52Hqw03QlbOaswBBcgxIGapIfwf5C8vE8lZ9r7cwHD+pOschngJKcr9zVd
         A7vH5zm7PKc1Q==
Date:   Mon, 7 Jun 2021 16:47:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce cf_name_slab cache
Message-ID: <YL6wHViJbCKVGx4K@gmail.com>
References: <20210607232715.3669-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607232715.3669-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:27:15AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Add a slab cache: "f2fs_casefold_name_entry" for memory allocation
> of casefold name.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c      | 16 ++++++++++------
>  fs/f2fs/recovery.c |  6 +++++-
>  fs/f2fs/super.c    | 24 ++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 7 deletions(-)

Looks good, but "f2fs_casefolded_name" would be a better name for this cache.

"f2fs_casefold_name_entry" makes it sounds like it contains some bookkeeping
information and not the actual casefolded filenames.

> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 96dcc4aca639..ee400562157d 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -16,6 +16,10 @@
>  #include "xattr.h"
>  #include <trace/events/f2fs.h>
>  
> +#ifdef CONFIG_UNICODE
> +extern struct kmem_cache *cf_name_slab;
> +#endif

Also this variable needs to be prefixed with "f2fs_".  Otherwise this will cause
a build error if/when ext4 adds the same thing.

- Eric

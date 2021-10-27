Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B243CD52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhJ0PTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233168AbhJ0PSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:18:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F7A4610A3;
        Wed, 27 Oct 2021 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635347789;
        bh=JJobKs5YY7qyeufVo1SHRPviZaZYNzLXnXZBNGwkMKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cQ1oHfhsg9r8TlxSIWV5KsIeQo8EVLa8ZzmnJKeJAuJD6wskVVqIPHjeAbUfiJpt5
         DYWUjigYWmnd2f4e8694QPCKDFenTwhbB9PzOeQRTNFVkwnUbfdn70ecSAd5jC8nTa
         45JFz0qJeUJpCU9zob1xQQMEbClXJNGttvcBVtvy17L52XH45BLZjrnmIlj7e/QlAC
         AYCqr5ExiVtXRpxzOb+pji+fN4oyCE0Rve2vvKMu5tKyk2ZACHohhPEzUst0dmJTtA
         gsuETm0ITWUniun0aPkqC0WtJOiHY91u9QvC4Ul6NnVmfZfk7gDPoYOcNB1IXdnEbw
         xpt+SPKOYrDTg==
Message-ID: <a2f738d08d14417a693c6f0d7f97faff448595ab.camel@kernel.org>
Subject: Re: [PATCH] fscache: fix GPF in fscache_free_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 27 Oct 2021 11:16:28 -0400
In-Reply-To: <20211027150732.4158273-1-mudongliangabcd@gmail.com>
References: <20211027150732.4158273-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 23:07 +0800, Dongliang Mu wrote:
> If fscache_alloc_cookie encounters memory allocation failure, it will
> go to nomem label and invoke fscache_free_cookie. However,
> fscache_alloc_cookie assumes current cookie is already linked into
> fscache_cookies and directly calls list_del. This assumption does not
> hold since list_add is not called in the above scenario. As a result, it
> will lead to Null Pointer Dereference. The stack trace is in the
> following.
> 
> Call Trace:
>  __list_del_entry include/linux/list.h:132 [inline]
>  list_del include/linux/list.h:146 [inline]
>  fscache_free_cookie fs/fscache/cookie.c:71 [inline]
>  fscache_free_cookie+0x3f/0x100 fs/fscache/cookie.c:66
>  fscache_alloc_cookie+0x2e2/0x300 fs/fscache/cookie.c:195
>  __fscache_acquire_cookie fs/fscache/cookie.c:296 [inline]
>  __fscache_acquire_cookie+0x132/0x380 fs/fscache/cookie.c:257
>  fscache_acquire_cookie include/linux/fscache.h:334 [inline]
>  v9fs_cache_session_get_cookie+0x74/0x120 fs/9p/cache.c:60
>  v9fs_session_init+0x724/0xa90 fs/9p/v9fs.c:471
>  v9fs_mount+0x56/0x450 fs/9p/vfs_super.c:126
>  legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>  vfs_get_tree+0x28/0x100 fs/super.c:1498
>  do_new_mount fs/namespace.c:2988 [inline]
>  path_mount+0xb92/0xfe0 fs/namespace.c:3318
>  do_mount+0xa1/0xc0 fs/namespace.c:3331
>  __do_sys_mount fs/namespace.c:3539 [inline]
>  __se_sys_mount fs/namespace.c:3516 [inline]
>  __x64_sys_mount+0xf4/0x160 fs/namespace.c:3516
> 
> Fix this by moving the list_add_tail before goto statements.
> 
> Fixes: 884a76881fc5 ("fscache: Procfile to display cookies")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/fscache/cookie.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index cd42be646ed3..d101e212db74 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -150,6 +150,11 @@ struct fscache_cookie *fscache_alloc_cookie(
>  	if (!cookie)
>  		return NULL;
>  
> +	/* move list_add_tail before any error handling code */
> +	write_lock(&fscache_cookies_lock);
> +	list_add_tail(&cookie->proc_link, &fscache_cookies);
> +	write_unlock(&fscache_cookies_lock);
> +
>  	cookie->key_len = index_key_len;
>  	cookie->aux_len = aux_data_len;
>  
> @@ -186,9 +191,6 @@ struct fscache_cookie *fscache_alloc_cookie(
>  	 * told it may not wait */
>  	INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
>  
> -	write_lock(&fscache_cookies_lock);
> -	list_add_tail(&cookie->proc_link, &fscache_cookies);
> -	write_unlock(&fscache_cookies_lock);
>  	return cookie;
>  
>  nomem:

Nice catch!

Reviewed-by: Jeff Layton <jlayton@kernel.org>


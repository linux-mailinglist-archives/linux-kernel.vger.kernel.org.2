Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2143DF10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1KmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1KmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:42:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2607560296;
        Thu, 28 Oct 2021 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635417594;
        bh=epjA4bOi3Sjz1EjfLxkcfhOD6RWiQGylAdLkk168yjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KQUvorfuLNZn2YoO3IE4dCWiZLfYOdoLiMGEFcJ+R/rdKVS1tC4fo42BPsnWxbyFh
         XTzu9vFInZSK27Ur7BXjSfl3JKrMRYB0kwcgrmU8yFWNaeblv8yDAFOlSiX0HhO5qf
         5JYKXYWVJ5AByuPtFl8YsyKjX2t5iNj4icAa88croVrmCCR+bw1OD3izv6Nd+r2kUf
         b5pcVrB9vZsWWUoCo1hFsz5QjyksFt9PtSpARswc/sf1ICEIQqiV5+McUUKynEXeny
         Y2P0RPTYtKHbIaJSw14Tdn9HBpC9nOfr9lyDrtKNU3OBU5CP3cUyN2xh+OUZKvZexD
         KanL+/Ftf4chw==
Message-ID: <d7f1a7c0b94a582ac90508bac5e29aa64c70c356.camel@kernel.org>
Subject: Re: [PATCH] fscache: fix GPF in fscache_free_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Oct 2021 06:39:53 -0400
In-Reply-To: <CAD-N9QV=Nd+T3wa6xyq6WOP7Mex7s4_sCFnvAM8FU+_dOFHgqQ@mail.gmail.com>
References: <20211027150732.4158273-1-mudongliangabcd@gmail.com>
         <a2f738d08d14417a693c6f0d7f97faff448595ab.camel@kernel.org>
         <CAD-N9QV=Nd+T3wa6xyq6WOP7Mex7s4_sCFnvAM8FU+_dOFHgqQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-28 at 10:20 +0800, Dongliang Mu wrote:
> On Wed, Oct 27, 2021 at 11:16 PM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Wed, 2021-10-27 at 23:07 +0800, Dongliang Mu wrote:
> > > If fscache_alloc_cookie encounters memory allocation failure, it will
> > > go to nomem label and invoke fscache_free_cookie. However,
> > > fscache_alloc_cookie assumes current cookie is already linked into
> > > fscache_cookies and directly calls list_del. This assumption does not
> > > hold since list_add is not called in the above scenario. As a result, it
> > > will lead to Null Pointer Dereference. The stack trace is in the
> > > following.
> > > 
> > > Call Trace:
> > >  __list_del_entry include/linux/list.h:132 [inline]
> > >  list_del include/linux/list.h:146 [inline]
> > >  fscache_free_cookie fs/fscache/cookie.c:71 [inline]
> > >  fscache_free_cookie+0x3f/0x100 fs/fscache/cookie.c:66
> > >  fscache_alloc_cookie+0x2e2/0x300 fs/fscache/cookie.c:195
> > >  __fscache_acquire_cookie fs/fscache/cookie.c:296 [inline]
> > >  __fscache_acquire_cookie+0x132/0x380 fs/fscache/cookie.c:257
> > >  fscache_acquire_cookie include/linux/fscache.h:334 [inline]
> > >  v9fs_cache_session_get_cookie+0x74/0x120 fs/9p/cache.c:60
> > >  v9fs_session_init+0x724/0xa90 fs/9p/v9fs.c:471
> > >  v9fs_mount+0x56/0x450 fs/9p/vfs_super.c:126
> > >  legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
> > >  vfs_get_tree+0x28/0x100 fs/super.c:1498
> > >  do_new_mount fs/namespace.c:2988 [inline]
> > >  path_mount+0xb92/0xfe0 fs/namespace.c:3318
> > >  do_mount+0xa1/0xc0 fs/namespace.c:3331
> > >  __do_sys_mount fs/namespace.c:3539 [inline]
> > >  __se_sys_mount fs/namespace.c:3516 [inline]
> > >  __x64_sys_mount+0xf4/0x160 fs/namespace.c:3516
> > > 
> > > Fix this by moving the list_add_tail before goto statements.
> > > 
> > > Fixes: 884a76881fc5 ("fscache: Procfile to display cookies")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  fs/fscache/cookie.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> > > index cd42be646ed3..d101e212db74 100644
> > > --- a/fs/fscache/cookie.c
> > > +++ b/fs/fscache/cookie.c
> > > @@ -150,6 +150,11 @@ struct fscache_cookie *fscache_alloc_cookie(
> > >       if (!cookie)
> > >               return NULL;
> > > 
> > > +     /* move list_add_tail before any error handling code */
> > > +     write_lock(&fscache_cookies_lock);
> > > +     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > > +     write_unlock(&fscache_cookies_lock);
> > > +
> > >       cookie->key_len = index_key_len;
> > >       cookie->aux_len = aux_data_len;
> > > 
> > > @@ -186,9 +191,6 @@ struct fscache_cookie *fscache_alloc_cookie(
> > >        * told it may not wait */
> > >       INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
> > > 
> > > -     write_lock(&fscache_cookies_lock);
> > > -     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > > -     write_unlock(&fscache_cookies_lock);
> > >       return cookie;
> > > 
> > >  nomem:
> > 
> > Nice catch!
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> Hi Jeff,
> 
> fscache_free_cookie also has an issue in cookie->backing_objects, but
> it does not affect the execution. The reason is in the following:
> 
> At first, I observed that the cookie->backing_objects in
> fscache_alloc_cookie is not initialized with INIT_HLIST_HEAD when an
> error occurs. It may lead to some issues in the fscache_free_cookie,
> e.g., WARN_ON.
> 
> Actually, it does not due to the zero initialization of
> kmem_cache_zalloc before. cookie->backing_objects is already with two
> null pointers. It does not need INIT_HLIST_HEAD.
> 
> And in the fscache_free_cookie, it actually does not trigger
> WARN_ON(!hlist_empty()).
> 
> So I wonder if we need to explicitly move INIT_HLIST_HEAD before any
> error handling code.
> 
> 

I don't think so. INIT_HLIST_HEAD just does this:

    #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)

...so I think it's unnecessary in this case, since the thing is
zalloc'ed (like you said), it's already initialized. Probably we could
just skip the INIT_HLIST_HEAD call altogether in the
fscache_cookie_alloc, but David has a pile of patches in flight that
rework this code substantially, so I wouldn't worry about it at the
moment.

-- 
Jeff Layton <jlayton@kernel.org>


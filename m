Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718D43D944
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhJ1CXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1CXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:23:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:20:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so18558448edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+wQZhyCwuaSol1jeoxc8MwW4vFU/MqWckHBmmor4ps=;
        b=d3rxyvyvSBLHMyaELlrw4KjAwd85ZPlkWOHepm8hSxrIrkKBdrJHQxXwge2VEMENxw
         O+m9CEPvTqednDfMw5jXMo+qUXu+CFde1/KRbYhjqEqYffxeEqeg2eQLet9t8UGe6iEN
         mupYQIsQRV+CkzS1S52QSpt1reM6LgZVOISjpJepePsAf1S1HKPfy6h/Zf8gjXtUAFCm
         NDCtr7TEI+sJ/Y8vKzhKoKv3TyJHuvGPVMlRPw94NFuyBnoUqAdQMOzhxLCIYvxWygek
         g35RsvShH/gv+TRuuDFURz7SrZSkmSKhd0w+NxSXS8PpmRRsrVHPtJ39hjcj3Y7rtQXZ
         vFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+wQZhyCwuaSol1jeoxc8MwW4vFU/MqWckHBmmor4ps=;
        b=GjY0+2LWy/PZMpt+l8yh/a/kIOD/KDn43987TzRDgo0TE19//PmSSFbQCD+Knq24/6
         +HTzNdXV9QcTX/RQglWCK1uC/g9YjwUoKL9QBOky00zMPtlEpStm1eZEmK3rY4y/w6P1
         8POBhTMka9+Wc4XqE5Kw5Qz1QKVrZMRgCiFr7iQ8juLX7JuUV7gUFLhUJTCsmx6z82kl
         7LfqKmyR322BEIhUnbesmKU1jyNvLIi9xCRW8aZX7biJZ7dgybc650f4mPXsGKi/1QQZ
         sxU8paLPC95bz+KW3rPEu3Q6NBRv9QSAksWHZ0kNi6zW3tLrMKxZqwuMmSo6iE5iKV2B
         2Scw==
X-Gm-Message-State: AOAM530vryxhuwn0eSGa/7MnuVEd1cL0OVdKL8Gu7g/Nc2Xi/WBtMwVN
        aAKe6gfcZiyBoaoXF2ASzl5rnGE0MjGEzUuKRhQ=
X-Google-Smtp-Source: ABdhPJzmVKkRycepS+exbnYCD1GiRrAHb9ylHxB5j/gQ8W6QUWHxQfuoZmhJVTcVtNezDFUKSTz7Io1giVRPzC23FNE=
X-Received: by 2002:a17:906:794:: with SMTP id l20mr1671760ejc.419.1635387633269;
 Wed, 27 Oct 2021 19:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211027150732.4158273-1-mudongliangabcd@gmail.com> <a2f738d08d14417a693c6f0d7f97faff448595ab.camel@kernel.org>
In-Reply-To: <a2f738d08d14417a693c6f0d7f97faff448595ab.camel@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 28 Oct 2021 10:20:07 +0800
Message-ID: <CAD-N9QV=Nd+T3wa6xyq6WOP7Mex7s4_sCFnvAM8FU+_dOFHgqQ@mail.gmail.com>
Subject: Re: [PATCH] fscache: fix GPF in fscache_free_cookie
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:16 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2021-10-27 at 23:07 +0800, Dongliang Mu wrote:
> > If fscache_alloc_cookie encounters memory allocation failure, it will
> > go to nomem label and invoke fscache_free_cookie. However,
> > fscache_alloc_cookie assumes current cookie is already linked into
> > fscache_cookies and directly calls list_del. This assumption does not
> > hold since list_add is not called in the above scenario. As a result, it
> > will lead to Null Pointer Dereference. The stack trace is in the
> > following.
> >
> > Call Trace:
> >  __list_del_entry include/linux/list.h:132 [inline]
> >  list_del include/linux/list.h:146 [inline]
> >  fscache_free_cookie fs/fscache/cookie.c:71 [inline]
> >  fscache_free_cookie+0x3f/0x100 fs/fscache/cookie.c:66
> >  fscache_alloc_cookie+0x2e2/0x300 fs/fscache/cookie.c:195
> >  __fscache_acquire_cookie fs/fscache/cookie.c:296 [inline]
> >  __fscache_acquire_cookie+0x132/0x380 fs/fscache/cookie.c:257
> >  fscache_acquire_cookie include/linux/fscache.h:334 [inline]
> >  v9fs_cache_session_get_cookie+0x74/0x120 fs/9p/cache.c:60
> >  v9fs_session_init+0x724/0xa90 fs/9p/v9fs.c:471
> >  v9fs_mount+0x56/0x450 fs/9p/vfs_super.c:126
> >  legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
> >  vfs_get_tree+0x28/0x100 fs/super.c:1498
> >  do_new_mount fs/namespace.c:2988 [inline]
> >  path_mount+0xb92/0xfe0 fs/namespace.c:3318
> >  do_mount+0xa1/0xc0 fs/namespace.c:3331
> >  __do_sys_mount fs/namespace.c:3539 [inline]
> >  __se_sys_mount fs/namespace.c:3516 [inline]
> >  __x64_sys_mount+0xf4/0x160 fs/namespace.c:3516
> >
> > Fix this by moving the list_add_tail before goto statements.
> >
> > Fixes: 884a76881fc5 ("fscache: Procfile to display cookies")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  fs/fscache/cookie.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> > index cd42be646ed3..d101e212db74 100644
> > --- a/fs/fscache/cookie.c
> > +++ b/fs/fscache/cookie.c
> > @@ -150,6 +150,11 @@ struct fscache_cookie *fscache_alloc_cookie(
> >       if (!cookie)
> >               return NULL;
> >
> > +     /* move list_add_tail before any error handling code */
> > +     write_lock(&fscache_cookies_lock);
> > +     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > +     write_unlock(&fscache_cookies_lock);
> > +
> >       cookie->key_len = index_key_len;
> >       cookie->aux_len = aux_data_len;
> >
> > @@ -186,9 +191,6 @@ struct fscache_cookie *fscache_alloc_cookie(
> >        * told it may not wait */
> >       INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
> >
> > -     write_lock(&fscache_cookies_lock);
> > -     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > -     write_unlock(&fscache_cookies_lock);
> >       return cookie;
> >
> >  nomem:
>
> Nice catch!
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Hi Jeff,

fscache_free_cookie also has an issue in cookie->backing_objects, but
it does not affect the execution. The reason is in the following:

At first, I observed that the cookie->backing_objects in
fscache_alloc_cookie is not initialized with INIT_HLIST_HEAD when an
error occurs. It may lead to some issues in the fscache_free_cookie,
e.g., WARN_ON.

Actually, it does not due to the zero initialization of
kmem_cache_zalloc before. cookie->backing_objects is already with two
null pointers. It does not need INIT_HLIST_HEAD.

And in the fscache_free_cookie, it actually does not trigger
WARN_ON(!hlist_empty()).

So I wonder if we need to explicitly move INIT_HLIST_HEAD before any
error handling code.

>

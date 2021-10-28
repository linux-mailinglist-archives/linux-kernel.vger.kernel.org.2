Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437A943E087
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1MJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJ1MJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:09:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20620C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:06:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r12so23938621edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNt8b7PWxf3z/NNRR4cGQBiHavLwUjJWuUtOOUoysrA=;
        b=BSPu6FEG2YHgU6CaLUkG6ykuWjVtuQ1Nb/uQVngtQQ78gjqBckoXYx4+kLqXHuO2jX
         pWFBMfp9zcEn9itdr/p2mF1rYMoZ2H5mM9yLI2bdxmiFZlUTm5YFlpex8aObRL7i3SK2
         9h9yuYbWtOygPu3Xi1Jq70/ei7BYDK6PcQuEK/5QrgBRM7PmCNkhN6ERwJWwXmfA8IIY
         DZzu3B5Q1ruEODds09T3wpomuQnf8+spgX9fGyle/Ju3EshgpNvXRKCOcBrpdoO3/I7+
         Z9CSmSRgPeH2KbubfXSBUaWPiGSWQJskYOQmaiFUBoq6xxrJ5XMPWagnuH0TWjyMQktD
         7QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNt8b7PWxf3z/NNRR4cGQBiHavLwUjJWuUtOOUoysrA=;
        b=bG4Dcvl6WvtAZmTeCAVZ/w7BxUuFtx6RylCsxlzZpup69kwZo7tCHgEsXiay9yvmId
         NqKDzbSJ8MMjFRlFOEn8onYHT7s0BJ9edb9Ah0batfn9yoG6+QeQxr9l8gzPWM7Rz7rn
         Hd0F7+A3TSuHOZk59s2hxTcbqoNCcpmHHMLeWI7cvGAOCvwjxDKgRjdE0TTB7uWR1EiG
         Ym0T5xjXaBfcPqrim6WbO5gP5GeTHocejpDT8tyNzN/N0syOCxtRZ/4n/+1zmBl9JsbL
         5s7wxGmLV7Ee4Xpg7+l0CG7yaf9g0VgBxpQdmil8h5GC45yaZxrMUPpndV4mHBnVgcKB
         V9Zw==
X-Gm-Message-State: AOAM532XnV2DPn9uXjM1tTersOxZxwdM/1uNhqqHinmxuZAJU6HzUU05
        apTgNza0H3C0gqwwEsAd8DJV76BE0uVeY+3Nnx0=
X-Google-Smtp-Source: ABdhPJxpdWT9NAjoHcn3IIcFCrSHNOrlvdm8GxecKOEdDZgVJ4kXWCtFBXyCgQkGnR5ocX8ewacUElZyMgx14VgDBpo=
X-Received: by 2002:a05:6402:5ca:: with SMTP id n10mr5646723edx.216.1635422806634;
 Thu, 28 Oct 2021 05:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211027150732.4158273-1-mudongliangabcd@gmail.com>
 <a2f738d08d14417a693c6f0d7f97faff448595ab.camel@kernel.org>
 <CAD-N9QV=Nd+T3wa6xyq6WOP7Mex7s4_sCFnvAM8FU+_dOFHgqQ@mail.gmail.com> <d7f1a7c0b94a582ac90508bac5e29aa64c70c356.camel@kernel.org>
In-Reply-To: <d7f1a7c0b94a582ac90508bac5e29aa64c70c356.camel@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 28 Oct 2021 20:06:19 +0800
Message-ID: <CAD-N9QXCHwzz_4JOkJTETYssfhKf0gip12zuOewrSBHaZQQnOA@mail.gmail.com>
Subject: Re: [PATCH] fscache: fix GPF in fscache_free_cookie
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 6:39 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2021-10-28 at 10:20 +0800, Dongliang Mu wrote:
> > On Wed, Oct 27, 2021 at 11:16 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Wed, 2021-10-27 at 23:07 +0800, Dongliang Mu wrote:
> > > > If fscache_alloc_cookie encounters memory allocation failure, it will
> > > > go to nomem label and invoke fscache_free_cookie. However,
> > > > fscache_alloc_cookie assumes current cookie is already linked into
> > > > fscache_cookies and directly calls list_del. This assumption does not
> > > > hold since list_add is not called in the above scenario. As a result, it
> > > > will lead to Null Pointer Dereference. The stack trace is in the
> > > > following.
> > > >
> > > > Call Trace:
> > > >  __list_del_entry include/linux/list.h:132 [inline]
> > > >  list_del include/linux/list.h:146 [inline]
> > > >  fscache_free_cookie fs/fscache/cookie.c:71 [inline]
> > > >  fscache_free_cookie+0x3f/0x100 fs/fscache/cookie.c:66
> > > >  fscache_alloc_cookie+0x2e2/0x300 fs/fscache/cookie.c:195
> > > >  __fscache_acquire_cookie fs/fscache/cookie.c:296 [inline]
> > > >  __fscache_acquire_cookie+0x132/0x380 fs/fscache/cookie.c:257
> > > >  fscache_acquire_cookie include/linux/fscache.h:334 [inline]
> > > >  v9fs_cache_session_get_cookie+0x74/0x120 fs/9p/cache.c:60
> > > >  v9fs_session_init+0x724/0xa90 fs/9p/v9fs.c:471
> > > >  v9fs_mount+0x56/0x450 fs/9p/vfs_super.c:126
> > > >  legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
> > > >  vfs_get_tree+0x28/0x100 fs/super.c:1498
> > > >  do_new_mount fs/namespace.c:2988 [inline]
> > > >  path_mount+0xb92/0xfe0 fs/namespace.c:3318
> > > >  do_mount+0xa1/0xc0 fs/namespace.c:3331
> > > >  __do_sys_mount fs/namespace.c:3539 [inline]
> > > >  __se_sys_mount fs/namespace.c:3516 [inline]
> > > >  __x64_sys_mount+0xf4/0x160 fs/namespace.c:3516
> > > >
> > > > Fix this by moving the list_add_tail before goto statements.
> > > >
> > > > Fixes: 884a76881fc5 ("fscache: Procfile to display cookies")
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > > >  fs/fscache/cookie.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> > > > index cd42be646ed3..d101e212db74 100644
> > > > --- a/fs/fscache/cookie.c
> > > > +++ b/fs/fscache/cookie.c
> > > > @@ -150,6 +150,11 @@ struct fscache_cookie *fscache_alloc_cookie(
> > > >       if (!cookie)
> > > >               return NULL;
> > > >
> > > > +     /* move list_add_tail before any error handling code */
> > > > +     write_lock(&fscache_cookies_lock);
> > > > +     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > > > +     write_unlock(&fscache_cookies_lock);
> > > > +
> > > >       cookie->key_len = index_key_len;
> > > >       cookie->aux_len = aux_data_len;
> > > >
> > > > @@ -186,9 +191,6 @@ struct fscache_cookie *fscache_alloc_cookie(
> > > >        * told it may not wait */
> > > >       INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
> > > >
> > > > -     write_lock(&fscache_cookies_lock);
> > > > -     list_add_tail(&cookie->proc_link, &fscache_cookies);
> > > > -     write_unlock(&fscache_cookies_lock);
> > > >       return cookie;
> > > >
> > > >  nomem:
> > >
> > > Nice catch!
> > >
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >
> > Hi Jeff,
> >
> > fscache_free_cookie also has an issue in cookie->backing_objects, but
> > it does not affect the execution. The reason is in the following:
> >
> > At first, I observed that the cookie->backing_objects in
> > fscache_alloc_cookie is not initialized with INIT_HLIST_HEAD when an
> > error occurs. It may lead to some issues in the fscache_free_cookie,
> > e.g., WARN_ON.
> >
> > Actually, it does not due to the zero initialization of
> > kmem_cache_zalloc before. cookie->backing_objects is already with two
> > null pointers. It does not need INIT_HLIST_HEAD.
> >
> > And in the fscache_free_cookie, it actually does not trigger
> > WARN_ON(!hlist_empty()).
> >
> > So I wonder if we need to explicitly move INIT_HLIST_HEAD before any
> > error handling code.
> >
> >
>
> I don't think so. INIT_HLIST_HEAD just does this:
>
>     #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
>
> ...so I think it's unnecessary in this case, since the thing is
> zalloc'ed (like you said), it's already initialized. Probably we could
> just skip the INIT_HLIST_HEAD call altogether in the
> fscache_cookie_alloc, but David has a pile of patches in flight that
> rework this code substantially, so I wouldn't worry about it at the
> moment.

Sure, sound good.

>
> --
> Jeff Layton <jlayton@kernel.org>
>

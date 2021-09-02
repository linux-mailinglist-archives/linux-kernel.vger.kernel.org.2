Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447F3FF189
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbhIBQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbhIBQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:36:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C9C061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:35:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y6so4709893lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPrsMqCFWN5ib/jexjJbOwaX0GY7GM4LAYtcBkjQs5Q=;
        b=b3xI1nUr2/Mn5lXTe8nymD6u/TZbVZW+KxgxiDD6kyYY168iu2pTlL23fELvbHgCpN
         4Fj+7xzFU3A8C58jpF8+C+JtLfgp1XCOGuw0IiJgEozDRP+l/GRHkybpYixOynp9lv2/
         Y952+XTnIiHmfQ+eXPBncvGvwPdqXLKde1dnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPrsMqCFWN5ib/jexjJbOwaX0GY7GM4LAYtcBkjQs5Q=;
        b=dssIzSueC90x7XoA6TaFUnO2lnq7Ai3Yr9KmgMsktjdVy+NhehxNBLCOaoACiSsMB7
         yQb6qi3piOZehVUP6agc4pvEk+A7HvE8At17fguZ/6cVPCjEoU7hJDuup2DShBPHaBUb
         vxrXCVrgEVQ/Z5hXit+UUBG9iIqDHYAUIWz+y2jWjoywRwXcMglraFcRP5dGV8wiJein
         j1yGhwi0yOI8IZdOMGg/4FnKvHNaN/+W8d0HDR8lySW+E+p7QH34ey2r84ltTSVFrfWZ
         T+GX39/f9pHizKkdxnPb4FvivdjtI7rQ21upu/cAsL4tMD7JkjEWF7/RcrQPdXDTfGUR
         Q5sQ==
X-Gm-Message-State: AOAM532RU/HIVNVFPz+TNYYKCvzAcYBk29+gVK1y75jBPTTZCxqELFY5
        R16pj5PDZWH7YiDwwMQNlu6pNX8RZUGtBNU40Og=
X-Google-Smtp-Source: ABdhPJwlY6mwL/CCSstalAqfmPdey4Y4mSX8e0iYvyqp/xxiHfrxl2iu3eFdT5rbvoOa7mJU2u+PiA==
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr3319512lja.198.1630600543409;
        Thu, 02 Sep 2021 09:35:43 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id bi25sm244338lfb.68.2021.09.02.09.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:35:42 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id k13so5636162lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:35:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr3194130lfp.41.1630600540703;
 Thu, 02 Sep 2021 09:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
In-Reply-To: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 09:35:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiYSSpmgLRaq+AXg5NjCh_02ShSXRxsa8CfoKa0OooEQ@mail.gmail.com>
Message-ID: <CAHk-=wiiYSSpmgLRaq+AXg5NjCh_02ShSXRxsa8CfoKa0OooEQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 5.15
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 6:51 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> The reason this touches so many files is that the ->get_acl() method now
> gets a "bool rcu" argument.  The ->get_acl() API was updated based on
> comments from Al and Linus:
>
>   https://lore.kernel.org/linux-fsdevel/CAJfpeguQxpd6Wgc0Jd3ks77zcsAv_bn0q17L3VNnnmPKu11t8A@mail.gmail.com/

That link might have been good in the individual commit message too,
but I did it in the merge commit instead.

I did notice that we now have a stale comment about ->get_acl() in fs/namei.c:

                acl = get_cached_acl_rcu(inode, ACL_TYPE_ACCESS);
                if (!acl)
                        return -EAGAIN;
                /* no ->get_acl() calls in RCU mode... */
                if (is_uncached_acl(acl))
                        return -ECHILD;

but we actually did the RCU-mode ->get_acl() call already in
get_cached_acl_rcu().

Of course, get_cached_acl_rcu() only does it for ACL_DONT_CACHE, not
for ACL_NOT_CACHED, so RCU mode is still a bit special.

At some point we probably should make get_cached_acl_rcu() do the
right thing for a successful lookup with ACL_NOT_CACHED set too, and
actually install the newly looked-up ACL. But I haven't thought much
about locking (but I think it would be ok, we use "cmpxchg" to update
the cached entry).

This is just a "maybe fixme for the future" note about that comment
and about get_cached_acl_rcu() behavior. I've pulled this, and I think
we're ok, it's just a small oddity.

                  Linus

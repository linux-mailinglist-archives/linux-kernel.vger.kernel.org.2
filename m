Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D9436A57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhJUSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:18:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7991C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:15:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so34800edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9NNEUvBDzAqU5rgSV6dqxVQMOi+8V2iWJVj3aQ3oKY=;
        b=nv9EroJTTxrn/o7mKYWO9w+oiLv84EbZZutE8W8+F9IFgc2IoBCtNgAG8HUSHUcI+X
         VpE29sR4w2taDr21Z35NF+ya8sJ/khziw1/kc+eU6wyGqEyknCKpCi+LnZQ4JIpE1n9d
         DliDZ5aUdqgzUzPt8a7gHTb5pXiRpAOkrudS7vZntoOZdzGTLg5RW3qG6PUJ8uc7i5R2
         Ul1Smvkv+lsf12BZkSq57iy54+ZBm14sl8d1jWLq+hBkSnqXp5S9N767C3CT6hkphtRF
         zadBKAZg1TpnedXoelYngmAlQc45Kiyet27ogqKVxGrbKXRv1zjXxR+DtBSreEpJM8aA
         uxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9NNEUvBDzAqU5rgSV6dqxVQMOi+8V2iWJVj3aQ3oKY=;
        b=FYMtqefX94q9VCJV/s3eRtkwRVnZz/cnc6WBjfx8HQB9qpg9PYpUi1IFcQhd41HsjE
         lqm9w5UUIkuo4jCZPGhokv3mFPU6wWvv0dOyKzkpJVxz2IUZnq9UL1RsO+zIrtzXyKds
         60aRRpWq0nWJGmLP5/1346WGGb5SEDZCr4rTXrZTCLnzDs0Wz1nyGK+UpJnf6VqNW6cH
         PNnp2oMK68mxmWBR2TxokF8ypqV6BDwqAcRB+Bp47m2jzw8t4kcoiosa1yrS7jVDreQG
         l0oYM+N4ZSiCWvAZTRhw+wr1rDm6p2u4xYpGJXASloHVZg4eS66Cg+pymicBXE1xJA5K
         q4Xg==
X-Gm-Message-State: AOAM532CaQldRSa+ZrmepB40xhOdfpC5akK23+n+6DrXA3+TIpwmwUx8
        /tdG+HWxUTU9YeBm1srTiN5FZ5uapVj3xHEHvuc=
X-Google-Smtp-Source: ABdhPJySDQmHjwpv9clbcU76avoNolSyYIlTeXMXkiBpRXvMzcuTtqKZ2cuydVL16LYyfT5n5aCAak6s6Vii721VUos=
X-Received: by 2002:a17:906:3f83:: with SMTP id b3mr9133374ejj.233.1634840150067;
 Thu, 21 Oct 2021 11:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180336.2328086-1-nathan@kernel.org>
In-Reply-To: <20211021180336.2328086-1-nathan@kernel.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 21 Oct 2021 11:15:38 -0700
Message-ID: <CAHbLzkpYgLLrJmeSY5YEJoK4d+pRaotwBVyz9k1b9hY4AmavDw@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_failure: Initialize extra_pins in me_pagecache_clean()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:04 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> mm/memory-failure.c:892:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!mapping) {
>             ^~~~~~~~
> mm/memory-failure.c:915:32: note: uninitialized use occurs here
>         if (has_extra_refcount(ps, p, extra_pins))
>                                       ^~~~~~~~~~
> mm/memory-failure.c:892:2: note: remove the 'if' if its condition is always false
>         if (!mapping) {
>         ^~~~~~~~~~~~~~~
> mm/memory-failure.c:879:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (PageAnon(p)) {
>             ^~~~~~~~~~~
> mm/memory-failure.c:915:32: note: uninitialized use occurs here
>         if (has_extra_refcount(ps, p, extra_pins))
>                                       ^~~~~~~~~~
> mm/memory-failure.c:879:2: note: remove the 'if' if its condition is always false
>         if (PageAnon(p)) {
>         ^~~~~~~~~~~~~~~~~~
> mm/memory-failure.c:871:17: note: initialize the variable 'extra_pins' to silence this warning
>         bool extra_pins;
>                        ^
>                         = 0
> 2 errors generated.
>
> Initialize extra_pins to false so that it is not used uninitialized.
>
> Fixes: d882a43a0011 ("mm: shmem: don't truncate page if memory failure happens")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1487
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> I am aware the fixes tag is not stable. It is there to convey this
> should be squashed into mm-shmem-dont-truncate-page-if-memory-failure-happens.patch.

Thanks for catching this. Acked-by: Yang Shi <shy828301@gmail.com>

>
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3b04f0361a58..dba5f0098165 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -868,7 +868,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  {
>         int ret;
>         struct address_space *mapping;
> -       bool extra_pins;
> +       bool extra_pins = false;
>
>         delete_from_lru_cache(p);
>
> --
> 2.33.1.637.gf443b226ca
>

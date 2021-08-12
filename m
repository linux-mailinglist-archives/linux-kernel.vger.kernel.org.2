Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186BA3EA0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhHLIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:51:08 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:50:42 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so6852478otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFyPNO4ZkizLh3L5gPVy35vzpqSp3wuB2t4x2aRMQPw=;
        b=Dw7WCJKVYgppAHEJ9FQoaU/9bvIu6cF/4LSfy/ttMhKBAoNhFwTPw0t53y7YerEawH
         mBCjRqy55uTCgjD+xFR+HRu+IMueLOqNAFVUA30pc2UD9e9WljLfDvNNImDkvmHhtEXq
         /17Ck0yYL4aMOtXxAnMoMHPNVz+z3HIcmqDoZ9pfI8J9D9PT5wZJV+X0Hh4c9O7XQk0v
         Q4FRqWdIytObCFcQb1zdUXdUK6YIX0T6leyn1aGbYpRvvJNIcR4Cj7ZVcbzep3r7drJo
         dzDTcRcQqHqbEpc9P7eeknis+nDKldFIn2TE6YRuWTTAdz/5JnzLI+Bka0lNgQqXapAB
         Fy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFyPNO4ZkizLh3L5gPVy35vzpqSp3wuB2t4x2aRMQPw=;
        b=rh5NAd/kNC1JF8wjjamNDOjQg/B1TxQsKuegvqjLWGvNEqTD/zQlRRJUv6OxIjpxr8
         iace/iZkQol2rE4VAFThPuMBzCMFRDA0t1SEcQK/h5R2oTBY6osD25CFLcBLOke0Dopv
         Sjgd3nopjB+/0W0P0TpS55WyOYivDNHswDjwGWRInCJ9PGDSyUSbC28A0Y0lU8UKIg53
         RbVYGiEU+WpuyKGEr8dsDf4DpM1nyMiQ3hKFUBPP7+dUwruf0eSOel9rRerL6q95Ifwi
         JVgZBgF9dyY4brY9WN+tidOkEBHuxYhJbChEmXu7MTCb0G3WovPXO+N8efUeLJPlkS/c
         psmg==
X-Gm-Message-State: AOAM532S8cwqC7a8RiBSbeWz/49Dcspn4Xt/QTuJuXuo9PQhWJrvJ3iQ
        rKbci9xRENkB6Bwxflsx/6gQ1HmEjeWV4CdAwC611A==
X-Google-Smtp-Source: ABdhPJysDReP89EMb13h1cgaiQj6lz+h0CzBnsfGhqallZmJIUoyDxnfKrmhk6+UmkuMXENkHCDbCJHccctC237tsrs=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr2619178otq.233.1628758241746;
 Thu, 12 Aug 2021 01:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <da8d30df9206b54be2768b27bb026ec06e4da7a4.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <da8d30df9206b54be2768b27bb026ec06e4da7a4.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:50:30 +0200
Message-ID: <CANpmjNOf=XzX1xhjaz7+SBN2HYq+9jH4EcHi4gfwjSyTa3q00w@mail.gmail.com>
Subject: Re: [PATCH 8/8] kasan: test: avoid corrupting memory in kasan_rcu_uaf
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:34, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> kasan_rcu_uaf() writes to freed memory via kasan_rcu_reclaim(), which is
> only safe with the GENERIC mode (as it uses quarantine). For other modes,
> this test corrupts kernel memory, which might result in a crash.
>
> Turn the write into a read.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index fa73b9df0be4..7ebf433edef3 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -71,7 +71,7 @@ static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
>                                                 struct kasan_rcu_info, rcu);
>
>         kfree(fp);
> -       fp->i = 1;
> +       ((volatile struct kasan_rcu_info *)fp)->i;
>  }
>
>  static noinline void __init kasan_rcu_uaf(void)
> --
> 2.25.1
>

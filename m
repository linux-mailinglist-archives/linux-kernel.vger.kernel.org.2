Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5253DA1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhG2K7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhG2K7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:59:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B8C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:59:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ec13so7091111edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqjLFNVfBDWAnhToFHoZWvbNeERTdn0BoKdbQkjb8Lo=;
        b=eCt1VY/bP2pVbt0ZgN5ZfGDJmAqrjEE+qlEID+dEqfmef5hWpQl6F+yBsIGgGhLyF4
         Bz3jVcRHSsGWSLJi+6x2S2OuO6IP47x123Hk4wxe/7I+X7YvYthgqoJpxMfWqYf9DUW1
         sb7NxXHPLyEX3qVZKjkFmpYk6bq9BGVH4F+IKPqQTnxBuHFOY9xPf+LGAl9SI8WNi8rE
         UpkkbbW4dKfjxBC45JtI8giYqRyKAgR5xUQOnaUh20n9h5wcpm/UfGinIMoBsI+UmqIt
         sJN2/phVXhgVzs06VYNQM+2RAhDVqj4aZurHaXK6Pca8CE2RRyNLiYt8CyJTvlmj4365
         +rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqjLFNVfBDWAnhToFHoZWvbNeERTdn0BoKdbQkjb8Lo=;
        b=MTLSMRYT9U1xbWmhXoTQ3teJeHP3rzvsf4vWtU1v7TB55oSmYoUWvYzMxaGUOl5jMW
         LGQALfh3XLRvon+AtUmVlMIuKG6TNa+F1+qomdudWDc4g2BaxJE0ImOTO48oUw50Un7i
         78BGFG0eE4tgL26izPh06P8Ogs9TQs3M2HeDoBiysNjq3awJ8cZNau9n7pQS8WipqqqK
         r306jHPoc9YtQRM4ZMR327pgnWxZJdlruLRStCtin9hRcP/Un1SFlER8/K7y9W4Cl6Gu
         2DMx7eBOQhU+kERk3DA1fz6Gmn06f9Fd3kQlbfVpvxAolazPYmRsxrjJ7r+AbRsTP2s4
         5CwA==
X-Gm-Message-State: AOAM533Lt2a7d9lTx0zOiTgiyuqhrpKBU+BO+dcn1w+8rli4bQbomO1v
        XE8+0jP/EBtqnL/rDmwLsNWCiorkKcGujXMqUH4HGw==
X-Google-Smtp-Source: ABdhPJxkguyURA9a6iefXWLZvRL5hydiVvuH8w5gi+2Q6zxsNLdJa+ccYesHTZ4iYu+TX9+XAVWGGXim9zt6sfTg0To=
X-Received: by 2002:a05:6402:516f:: with SMTP id d15mr5526812ede.210.1627556353053;
 Thu, 29 Jul 2021 03:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210729093003.146166-1-wangrui@loongson.cn> <20210729095551.GE21151@willie-the-truck>
In-Reply-To: <20210729095551.GE21151@willie-the-truck>
From:   hev <r@hev.cc>
Date:   Thu, 29 Jul 2021 18:58:59 +0800
Message-ID: <CAHirt9j+UJiNpgmeSOMnUnYomOLgi1oD44ZCzEWA9OAzrnAMaw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
To:     Will Deacon <will@kernel.org>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will,

On Thu, Jul 29, 2021 at 5:55 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 29, 2021 at 05:30:03PM +0800, Rui Wang wrote:
> > This patch introduce a new atomic primitive andnot_or:
> >
> >  * atomic_andnot_or
> >  * atomic_fetch_andnot_or
> >  * atomic_fetch_andnot_or_relaxed
> >  * atomic_fetch_andnot_or_acquire
> >  * atomic_fetch_andnot_or_release
> >  * atomic64_andnot_or
> >  * atomic64_fetch_andnot_or
> >  * atomic64_fetch_andnot_or_relaxed
> >  * atomic64_fetch_andnot_or_acquire
> >  * atomic64_fetch_andnot_or_release
> >  * atomic_long_andnot_or
> >  * atomic_long_fetch_andnot_or
> >  * atomic_long_fetch_andnot_or_relaxed
> >  * atomic_long_fetch_andnot_or_acquire
> >  * atomic_long_fetch_andnot_or_release
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > ---
> >  include/asm-generic/atomic-instrumented.h |  72 +++++-
> >  include/asm-generic/atomic-long.h         |  62 ++++-
> >  include/linux/atomic-arch-fallback.h      | 262 +++++++++++++++++++++-
> >  lib/atomic64_test.c                       |  92 ++++----
> >  scripts/atomic/atomics.tbl                |   1 +
> >  scripts/atomic/fallbacks/andnot_or        |  25 +++
> >  6 files changed, 471 insertions(+), 43 deletions(-)
> >  create mode 100755 scripts/atomic/fallbacks/andnot_or
>
> Please see my other comments on the other patches you posted:
>
> https://lore.kernel.org/r/20210729093923.GD21151@willie-the-truck
>
> Overall, I'm not thrilled to bits by extending the atomics API with
> operations that cannot be implemented efficiently on any (?) architectures
> and are only used by the qspinlock slowpath on machines with more than 16K
> CPUs.
>
> I also think we're lacking documentation justifying when you would use this
> new primitive over e.g. a sub-word WRITE_ONCE() on architectures that
> support those, especially for the non-returning variants.
>
> Will

I have tried to explain in another thread. At the beginning, I thought
about implementing xchg_mask for the sub-word xchg, but now I agree
that atomic andnot_or is clearer and more general.

Peter, what do you think?

Regards,
Rui

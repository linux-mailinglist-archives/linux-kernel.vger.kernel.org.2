Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7B36EF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhD2SFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhD2SFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:05:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13DC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:04:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t2-20020a17090a0242b0290155433387beso5325757pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1Oi0kSqm+uivd7+EZZSGI4riQYLG2DblxTrL3C9zjKA=;
        b=PA9OdCNGw/HfjkY+gp6rWkdSLZV1Rf8m25csBA0lc0tV4Y1u566DMGXcNKGBtrIvw2
         6GDwJ5nej2yajcGjO28hpGwyIYoYjMVsCBVioXic2KpK7EYsOd6BEhWDsdF5LwBSXsC7
         bBLkPiytg8EcOqjRbaKJ4Oj0kZIdd3ql9o9PAEBEae/AwUl+Mhh0gemQ8AzONjOrXOLg
         UVnCFknvFd81c9+quhBMiiAuQrd/UMJ5YsFqNwjAWd/rPlsvT63qH1z3r8NoowFRugO1
         iHWYuypsf5cbxuBa8gY0Y9W1QhiQnk+W/ZXGh75cxsUmd0fTDrlBBCODaPCtumZzgSyD
         QdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1Oi0kSqm+uivd7+EZZSGI4riQYLG2DblxTrL3C9zjKA=;
        b=aehAHGVqFHQgkr30b+w/H0scvtDwxxInpu7KQg+D86oP8OrfLruVCTRnhbfVNXBNMj
         d4A7+UEnfKs5J0mm7PLlBBCuOvSWR2nHuhyBq+HUl/Qr59MTsI62uYYhu7RjShhpYl7V
         nJy/4HiP+d8/UiP5u6pVqZoZ3+lF/vGT4UrypxosR/bTKzCZElo1r7/zSe16UKo0u+TP
         EsfF201VnfF6ffMYQ3lsTIJnk53BK3WAWVX2kC2md7J0qLQwFtp60DWSje11yB9cR1RO
         mtTB/N3iWx2XDtnCmkMNXzizAchUjf0t5uU6dUxRfoo7hCrkXxGCcTAFA4PZvh+yF6yc
         UYLA==
X-Gm-Message-State: AOAM530Sgb0wr/xAbyehK2frYkQ9KDoOtLi6/BVUWVuk5+xm6avWOISa
        YMMoMMFheyGiRL5GkdrTiX5A5ZFZ5q/f0A==
X-Google-Smtp-Source: ABdhPJwGf/t92rC1BLW0ndwWKW5edghg2axJUuyA+Xjplec49LQxPU+HynF4ldhOrvN6zsxfycFMeA==
X-Received: by 2002:a17:90a:a413:: with SMTP id y19mr2726186pjp.161.1619719498933;
        Thu, 29 Apr 2021 11:04:58 -0700 (PDT)
Received: from smtpclient.apple ([2600:1012:b045:bfcd:58c5:d3bf:226f:4139])
        by smtp.gmail.com with ESMTPSA id u12sm8428314pji.45.2021.04.29.11.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 11:04:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in __handle_mm_fault().
Date:   Thu, 29 Apr 2021 11:04:56 -0700
Message-Id: <C02655BC-F722-4EAD-B93E-D890A2DEC05A@amacapital.net>
References: <20210429161234.GG1847222@casper.infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20210429161234.GG1847222@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 29, 2021, at 9:12 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Wed, Apr 28, 2021 at 05:05:17PM -0700, Andy Lutomirski wrote:
>>> On Wed, Apr 28, 2021 at 5:02 PM Michel Lespinasse <michel@lespinasse.org=
> wrote:
>>> Thanks Paul for confirming / clarifying this. BTW, it would be good to
>>> add this to the rcu header files, just so people have something to
>>> reference to when they depend on such behavior (like fast GUP
>>> currently does).
>>=20
>> Or, even better, fast GUP could add an explicit RCU read lock.
>>=20
>>>=20
>>> Going back to my patch. I don't need to protect against THP splitting
>>> here, as I'm only handling the small page case. So when
>>> MMU_GATHER_RCU_TABLE_FREE is enabled, I *think* I could get away with
>>> using only an rcu read lock, instead of disabling interrupts which
>>> implicitly creates the rcu read lock. I'm not sure which way to go -
>>> fast GUP always disables interrupts regardless of the
>>> MMU_GATHER_RCU_TABLE_FREE setting, and I think there is a case to be
>>> made for following the fast GUP stes rather than trying to be smarter.
>>=20
>> How about adding some little helpers:
>>=20
>> lockless_page_walk_begin();
>>=20
>> lockless_page_walk_end();
>>=20
>> these turn into RCU read locks if MMU_GATHER_RCU_TABLE_FREE and into
>> irqsave otherwise.  And they're somewhat self-documenting.
>=20
> One of the worst things we can do while holding a spinlock is take a
> cache miss because we then delay for several thousand cycles to wait for
> the cache line.  That gives every other CPU a really long opportunity
> to slam into the spinlock and things go downhill fast at that point.
> We've even seen patches to do things like read A, take lock L, then read
> A to avoid the cache miss while holding the lock.
>=20
> What sort of performance effect would it have to free page tables
> under RCU for all architectures?  It's painful on s390 & powerpc because
> different tables share the same struct page, but I have to believe that's
> a solvable problem.

The IPI locking mechanism is entirely useless on any architecture that wants=
 to do paravirt shootdowns, so this seems like a good strategy to me.=

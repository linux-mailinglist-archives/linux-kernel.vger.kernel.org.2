Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E006A351FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhDAT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhDAT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:27:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86019C02D54B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:59:21 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b10so3226090iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTrV/slVNcOkclb52d6/XH5+RZLu+eLYQgE7tTk9jm8=;
        b=XqoN1J3OfCjIrC0KWqrkgQ4DHvlDvGlYbtGG6DwF8z4jqeqPjQ1wpeF1fBeQsk8Od9
         YkUQRF3ovgwy4aaADuNf66LgpJIfpfyEmaVzlL/9XTx8Z/9sLBkqco+k5KxHi74jEIQZ
         72DMM9iMns8rRBgUeb6W3OyJCjDnuFyIiDThI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTrV/slVNcOkclb52d6/XH5+RZLu+eLYQgE7tTk9jm8=;
        b=SMmat2t0q3c7/3M43o1WFIu574T3Ev9O3MkL91x2ww8PfQUZCVAwGGOw2mERrFwY4l
         6+BcNz7bA26H7WjyMJXjaSItrDU9BqYXAy4MRjS2T8J0cvqHGGFqNPziAXc1TsWHxE3o
         GTkc2eXT8ova9GScc06LbmCQI5IDAiC+MB7U7JmUNyIpX2wVmV5dVdkEtTzEnZga7ZX9
         IMJ+NK39a9HZpARF4uQN0pSKBOKz0prpOkAowNqXIWSy1wQ4rh0ncMAi8h864YS8BMKr
         APm/HK6ns/PW2/8FuA8uOqElQw9U+BEOkdB/03ed4Izu5n+5AQZCBI2HbsBlBnZuaPqi
         kcVQ==
X-Gm-Message-State: AOAM532Pw5QHA+TQfUEKfHjQZRRFv79NHPtyji28CLWBO4s6tFjgSobv
        DkZJQG+QXwG3L9nMBzox5AxwChagSbMwBw==
X-Google-Smtp-Source: ABdhPJwc8Vw9owR1Z3LYnseNY3luK+22Cce2znUaBA3JJLJXCz8eL75Absp2oiR3RAguSgFoLx3iAw==
X-Received: by 2002:a6b:f00a:: with SMTP id w10mr8044450ioc.2.1617303560502;
        Thu, 01 Apr 2021 11:59:20 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id w16sm3138684iod.51.2021.04.01.11.59.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 11:59:19 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id y17so2913348ila.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:59:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:20ee:: with SMTP id q14mr7590690ilv.223.1617303559149;
 Thu, 01 Apr 2021 11:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com>
In-Reply-To: <20210401181741.168763-1-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 11:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
Message-ID: <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
To:     Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Shaohua Li <shli@fb.com>,
        Nadav Amit <namit@vmware.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 11:17 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> We received a report that the copy-on-write issue repored by Jann Horn in
> https://bugs.chromium.org/p/project-zero/issues/detail?id=2045 is still
> reproducible on 4.14 and 4.19 kernels (the first issue with the reproducer
> coded in vmsplice.c).

Gaah.

> I confirmed this and also that the issue was not
> reproducible with 5.10 kernel. I tracked the fix to the following patch
> introduced in 5.9 which changes the do_wp_page() logic:
>
> 09854ba94c6a 'mm: do_wp_page() simplification'

The problem here is that there's a _lot_ more patches than the few you
found that fixed various other cases (THP etc).

> I backported this patch (#2 in the series) along with 2 prerequisite patches
> (#1 and #4) that keep the backports clean and two followup fixes to the main
> patch (#3 and #5). I had to skip the following fix:
>
> feb889fb40fa 'mm: don't put pinned pages into the swap cache'
>
> because it uses page_maybe_dma_pinned() which does not exists in earlier
> kernels. Because pin_user_pages() does not exist there as well, I *think*
> we can safely skip this fix on older kernels, but I would appreciate if
> someone could confirm that claim.

Hmm. I think this means that swap activity can now break the
connection to a GUP page (the whole pre-pinning model), but it
probably isn't a new problem for 4.9/4.19.

I suspect the test there should be something like

        /* Single mapper, more references than us and the map? */
        if (page_mapcount(page) == 1 && page_count(page) > 2)
                goto keep_locked;

in the pre-pinning days.

But I really think that there are a number of other commits you're
missing too, because we had a whole series for THP fixes for the same
exact issue.

Added Peter Xu to the cc, because he probably tracked those issues
better than I did.

So NAK on this for now, I think this limited patch-set likely
introduces more problems than it fixes.

        Linus

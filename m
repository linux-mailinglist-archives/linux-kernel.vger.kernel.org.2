Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7600736F760
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhD3Iuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Iuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:50:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CACC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:50:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b23so26434703lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0yIHgo1JUyr9NoiprUJP0BOnhoVbOctvNZNK5RJx5E=;
        b=Z7RZxT2etLjVangalvPR8VTZoPL4Yz7c4tQX6kYWzzvroScMF6qw2aLTwWOF/LyIzA
         dqT/7Wvgr20rBQd4S9G6DeQCi+Am35QeSZZ9BRMzs3gwR7O6MEKZ+Z43DkpXvg8WdouC
         HS64KBCoWYe6hxBOMzNSKTPOdjcwMuSKVzNEgMDvJtzLmCvbEp80F8SNlxwZfaY1mgc0
         xV5xge1LY3ygi4boxMy3sIRtpR3cCpjv8fCqSfSooiWy8CWzBumX6A1g2R1TemnLyoyK
         UrDZBMFicHO5CCnhLMxq1LmXv/pv2RBLCpxxTZPCYOnN/c6H0tkMZUbt+eZrx5FMJ41K
         EpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0yIHgo1JUyr9NoiprUJP0BOnhoVbOctvNZNK5RJx5E=;
        b=lOQA6yDQYbu1pKHFa/qHfOhzrklGo/YivkhsqDc19uPKYfUhi3zKfJtAvtfZPUD1fj
         25ojQz4absLou7CDqQgYCtx7PDJQLGeZCaNW/XPABkxLP2OAgp2nGsNQGFStAT8EF4Nv
         OscH3B2Xw4ZPvwhkTcW2ObXKmQLHwNP3N0hI84opGddLWcqD9CVbQmk9Ei3y7Ys1282d
         jzPyJz2H6fxE5d+y76NvpzGA2mOpo7jVY+RfbmUmm9Xd4HDOc/t76oiKp6dWVxccxrnE
         k/ayzqgX6j1xtZRzK5mWUQC0i8v9r94ol8zANBlkGPbumlii5MnX6ALgdRBW1MieUzOd
         xU/A==
X-Gm-Message-State: AOAM533xaEnDhbSqmdKAkZ3KKnNKoel9w6NGWEZJy0xZKxbetcxbJUoI
        qGlA9VHOgROvKvraZvMK5VuSYW7AweT8Cz3UG9yjIA==
X-Google-Smtp-Source: ABdhPJyF6NWUq2SZvZcMzxwZ2Gz8DxjsHYrfZeLDmnFFVfT49EUq/IieGHi6uixeynoKgGUmBFU2l91RnMPXabsupFQ=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr2615472lfr.254.1619772601846;
 Fri, 30 Apr 2021 01:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210429152656.4118460-1-qperret@google.com> <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com>
In-Reply-To: <YIu/EjZ8QsEl9sum@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 10:49:50 +0200
Message-ID: <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 at 10:25, Quentin Perret <qperret@google.com> wrote:
>
> On Friday 30 Apr 2021 at 09:45:32 (+0200), Vincent Guittot wrote:
> > On Thu, 29 Apr 2021 at 17:27, Quentin Perret <qperret@google.com> wrote:
> > >
> > > Util-clamp places tasks in different buckets based on their clamp values
> > > for performance reasons. However, the size of buckets is currently
> > > computed using a rounding division, which can lead to an off-by-one
> > > error in some configurations.
> > >
> > > For instance, with 20 buckets, the bucket size will be 1024/20=51. A
> > > task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
> > > correct indexes are in range [0,19], hence leading to an out of bound
> > > memory access.
> > >
> > > Fix the math to compute the bucket size.
> > >
> > > Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> > > Suggested-by: Qais Yousef <qais.yousef@arm.com>
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > >  - replaced the DIV_ROUND_UP(a,b) with a/b+1 (Dietmar)
> >
> > Doesn't this create unfairness between buckets ?
> >
> > If we take your example above of 20 buckets, delta is now 52. Then we
> > expect the last bucket to get the range [972-1024] but values lower
> > than 988 will go in the idx 18.
>
> Well, that's just the limitation of integer arithmetics isn't it?
>
> > And the more bucket you will have, the
> > worse it will be
>
> Sure, but 20 is a hard limit, and if we ever need more than that then
> maybe we should think about getting rid of the buckets altogether.
>
> > Your problem comes from the fact that we use 1025 values instead of
> > 1024.
>
> I don't understand what you mean here. Right now we'll assign bucket id
> 20 for any clamp in the range [1020-1024], so I don't think we can
> special case 1024.

20 buckets is probably not the best example because of the rounding of
the division. With 16 buckets, each bucket should be exactly 64 steps
large except the last one which will have 65 steps because of the
value 1024. With your change, buckets will be 65 large and the last
one will be only 49 large

>
> > Wouldn't it be easier to have a special condition for
> > SCHED_CAPACITY_SCALE value
>
> As per the above, I don't see how that'll work.
>
> Thanks,
> Quentin

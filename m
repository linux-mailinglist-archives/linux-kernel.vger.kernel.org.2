Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6F3AA077
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhFPP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhFPPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:55:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B394C0617AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:52:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b37so4472169ljr.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfGEP5GLXl+ug4Pfo9Y4pYgY96rQW+n2h5icNq/BLuc=;
        b=Fw9GweUOQAfCf+hbHFUW0U0XW2UsK7E2ZrRzXhC9jevWow7LvM3gUL1zefOVYFxQ64
         2+jIg2gJb7hZ3tD0yJKyIXK9qHcUm+4kxUz8bLAAZpA98leVF2lKjbZ5L4rB9CCMMLjM
         DESwEhognjkdJRWqL/hlTB8iwRYp/rGdZwGvKwq/dhX8wfrFtkIz3QVhMVAJWVu/vTKZ
         BfGukdGbv4Ks48c7FYcMz/FVDnMltppcDA0Rs+X1UdG9HOLPZvG8NknZ+2PnK2W6yMLh
         ZWXL0knRUnlihwJ76MFcAYt2ShXm2orBGlwuzF7gKzClwRQY82w/fk40kTC8tH9Cigww
         Ha/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfGEP5GLXl+ug4Pfo9Y4pYgY96rQW+n2h5icNq/BLuc=;
        b=B3bZlTEKPjm5CPKujsVHZd8IDPdwqKEs6CLpgBwsjDiiAKJ3RNLltTGca8FBLDGofz
         OOyseM+M4yPlsbVNBY1dVHWiVkhKYMjVWFZ7fJiG3i3cjp+BSITR9+Jzipi9r0x9xtY4
         RkmIX8KK3lpro+hxxMKSJ7Q+qPvpE/CbLm2Pq5xvBtqehLilcQLUGq8l/XOUcVvPHbC5
         X6d2gu+eASgZmO/EN/r0mrXJE8Ty/NNIeO5JC4mQBI1Fy2piwjFZJCz82FRqeKeQofg5
         6BRexUftAsb6SrDy1qlOzAoebfRwN006vWNU0Yqis6XgQyZFlYfWoF+yppgkpiVXbvkt
         huag==
X-Gm-Message-State: AOAM531w9S0DSoAL1cCZ1aBD2G4KciZL5g3dGdWe2G6WMXHBG78SJh/S
        Xj+NjkghRFdqwWqTC94Gp/UGRS9K7qr6YBj7CYRHvA==
X-Google-Smtp-Source: ABdhPJzV3ifI+viNBsarON2TAu36v+epq1qeZQjDUv0bLsb0yiJBYdb4MRhKvwCYTpZin0c0Ty3/szkVhEI1IE/PTVI=
X-Received: by 2002:a2e:b80f:: with SMTP id u15mr480890ljo.284.1623858756684;
 Wed, 16 Jun 2021 08:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210615111611.GH30378@techsingularity.net> <20210615204228.GB4272@worktop.programming.kicks-ass.net>
In-Reply-To: <20210615204228.GB4272@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Jun 2021 17:52:25 +0200
Message-ID: <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 22:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > This is a partial forward-port of Peter Ziljstra's work first posted
> > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
>
> It's patches 2 and 3 together, right?
>
> > His Signed-off has been removed because it is modified but will be restored
> > if he says it's still ok.
>
> I suppose the SoB will auto-magically re-appear if I apply it :-)
>
> > The patch potentially matters when a socket was multiple LLCs as the
> > maximum search depth is lower. However, some of the test results were
> > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > other results were not dramatically different to other mcahines.
> >
> > Given the nature of the patch, Peter's full series is not being forward
> > ported as each part should stand on its own. Preferably they would be
> > merged at different times to reduce the risk of false bisections.
>
> I'm tempted to give it a go.. anyone object?

Just finished running some tests on my large arm64 system.
Tbench tests are a mixed between small gain and loss

hackbench shows significant changes in both direction
hackbench -g $group

group  tip/sched/core      + this patch
1      13.358(+/- 1.82%)   12.850(+/- 2.21%) +4%
4      4.286(+/- 2.77%)    4.114(+/- 2.25%)  +4%
16     3.175(+/- 0.55%)    3.559(+/- 0.43%)  -12%
32     2.912(+/- 0.79%)    3.165(+/- 0.95%)  -8%
64     2.859(+/- 1.12%)    2.937(+/- 0.91%)  -3%
128    3.092(+/- 4.75%)    3.003(+/-5.18%)   +3%
256    3.233(+/- 3.03%)    2.973(+/- 0.80%)  +8%

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F332DEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEBFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCEBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:05:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 17:05:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 130so401198qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 17:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUEdpwjc2Su9tpo1aoC+ANv42PZu8fYCrhiuo8S1xNA=;
        b=TsQNIxhvoFWfCsYfxiPHMo7LC12G6oW1vlgR9YOR86WHTL8P9T6SVF5DsQ2HhHH79i
         aQxqgoiGlWBBLh3OxCXrurMwZVJ/zy5BZpJ2bKC3r1/mEsbRlNEKvK5z0HXYZjd2vY3I
         OfXm1CTeBSzFyka08g9yWpXSbd+JgtZFwS+Qu5SrV6yfoMfDMfF34snU1oAgABQdVBSB
         VT4aP2Hef4KuWW8x9HCJBoSiT95ZwIzgxnXNKs1ZpkGBmsZnNkxMo7YxPnoKBKuVKjPG
         gMuLxOmQKctFagNk0MwZKTdZIxP62An+FfqaeSVTpLr69+EQ9Qdi5b5kJsqvd6EbzrD/
         2vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUEdpwjc2Su9tpo1aoC+ANv42PZu8fYCrhiuo8S1xNA=;
        b=QueBwDuGpw8JfQeTr9/buMv57XcsoKoUsoqsAVmYXHuoRuNaZuDlSQ8FUZ5Fcxhcop
         ec+/MKi4T3V+SwKhvh0DMGV+kYFcvn4WHAGl+W7nikwJ4wpu3fQOULS8uDrV0B2EJhJR
         1sNHGLdTLKrvixnSDtzHilt/9QQZwzk0RsvPBhBMJzVsakRymBCA94i5ILE2jTWMEW+e
         E51wMcOePAmB6kas6mik6yDOFWaxgFO44M535v+Tn/7vx0eHK13LVaEjnSepY+xHBKIM
         G4Pcx4Qoc6sqdkUjg9ItgkDeZuu3ayS0Gq955pBk4KF9I7i5PxH5zAdKmbt2GGI8ZfhM
         1crw==
X-Gm-Message-State: AOAM532m/mGlwwy0kTRbnubqnqjdFOM7gQWjXzE4tl92WaOBoF1FHhCX
        f4CcbhXV2SRoFa+pl3APSfCNIIRTRRV5dRBA81yOAw==
X-Google-Smtp-Source: ABdhPJw42/HssFweLgeFrpM484Wnrrt2uEEiKTVFS0/p2lX0wWO8F8jRlEKskzq4IO1y71W7Yiszc35WGCxO97jAXzA=
X-Received: by 2002:a37:a647:: with SMTP id p68mr6919823qke.189.1614906302400;
 Thu, 04 Mar 2021 17:05:02 -0800 (PST)
MIME-Version: 1.0
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
 <20210303224653.2579656-1-joshdon@google.com> <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
In-Reply-To: <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 4 Mar 2021 17:04:51 -0800
Message-ID: <CABk29Ns5qu-wm=BqpRa75kvCUeMUF0ozrQr2tbcy2WuSR013JA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Optimize __calc_delta.
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Bill Wendling <morbo@google.com>, sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 9:34 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
>
> Hi Josh, Thanks for helping get this patch across the finish line.
> Would you mind updating the commit message to point to
> https://bugs.llvm.org/show_bug.cgi?id=20197?

Sure thing, just saw that it got marked as a dup.

Peter, since you've already pulled the patch, can you modify the
commit message directly? Nick also recommended dropping the
punctuation in the commit oneline.

> >  #include <linux/binfmts.h>
> > +#include <linux/bitops.h>
>
> This hunk of the patch is curious.  I assume that bitops.h is needed
> for fls(); if so, why not #include it in kernel/sched/fair.c?
> Otherwise this potentially hurts compile time for all TUs that include
> kernel/sched/sched.h.

bitops.h is already included in sched.h via another include, so this
was just meant to make it more explicit. Motivation for putting it
here vs. fair.c was 325ea10c080940.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331CC3763AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhEGK3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhEGK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:29:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 03:28:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w4so10902662ljw.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsqjtUHNibQ89S6ZtyKVUCcEq5CPnNHP1x8J/AjhU/Y=;
        b=jHkUDIpd0jprJjyRyI+D35YAcMHRdGtsBlk/F/Iy2l8OIbW2BC4iUU4QUDR6lVYN6P
         1NN5aZRhbzGBYO9XOGbYne3SWGbvJB63vuz/8B9t7YrxH8E722Wek41l5MRvTAuEvPb4
         uVXdrZ6O3l6cmVSMtlpeQgMsqtLPspoy+3KqzY97DxJDkWcPaeRrSr4B8qiLn7t7hZAO
         awezS2tQV0ZF/nj/cW6GhXhVm52CZ+v9SBjYsBBMT/4PGhhRZTKZ5FLxwQwter52/xON
         C/xNKLjbtThuwn5vJAahi75JYSDsxcpZO4t+4czQe9FCw/i9q4reycBszkhkr7sTHTaO
         WN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsqjtUHNibQ89S6ZtyKVUCcEq5CPnNHP1x8J/AjhU/Y=;
        b=NztVaDZ38UF3QCWjNU17VxDA33E1NCgasPPRe8i5Z7ZyGGNVwVWliNT4xqCv1hSbFZ
         bs8xoPX7tIzGu+boPtWnaN+sMFRLEKQ+mSaGueR8IFZcagWCVkjtpnPrquD/0nYIdD2q
         Z8bq6eXR68MyVZ0K+RcsdnKbITaHaIBpZmlgZeTBHt+5q80d3bycwg3/3uxHEqFRM/TY
         42qL1HKrMqT04NrfFllgecA/TZMIgtp+cyzBGKH+/EWvgindL712VUvJI60uQGFm+1tS
         PdzLH+q2pyxgIirmVqZBjTFkBM2vgNPcM5/LeNA2UE+mLl5/5eFRfnc/Ae/T3XLYL5sd
         94Kw==
X-Gm-Message-State: AOAM5310cd9/NH0CtJrqp4v3XA3Uyzpu98FY8PcAGfeI9FMnjGGezqht
        2nQUgmk7OB6scz0wUmL+FruqgwF+7nzzuTocILM=
X-Google-Smtp-Source: ABdhPJw1L8+WtJ8ntvVbycn6SLYp5lt4pa8qwMckW37xJJZyJd8pyOPHv9QO203KlEmeG4x19wKyxbjiqAHhynr/MzI=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr2809497ljk.420.1620383280159;
 Fri, 07 May 2021 03:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210506110936.8797-1-xuewen.yan94@gmail.com> <20210506122823.GA8671@ubiquitous>
 <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com>
 <20210506162600.GA11916@ubiquitous> <CAB8ipk8MK-j_oigJQoKutRxr22iKvWfDx1MgcSsy4s2=90QaFQ@mail.gmail.com>
 <CAKfTPtDUEwvLXOVcGztGALrUx0dqi=KtT2vAcxK15yQJswyHfA@mail.gmail.com>
In-Reply-To: <CAKfTPtDUEwvLXOVcGztGALrUx0dqi=KtT2vAcxK15yQJswyHfA@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 7 May 2021 18:26:24 +0800
Message-ID: <CAB8ipk-6BV_+qQg_9aoRFA34Ys8x8CB+8SJmGvQXGNoWnXocVw@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for last_enqueued_diff
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 2:53 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 7 May 2021 at 03:36, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > On Fri, May 7, 2021 at 12:26 AM Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> > >
> > > On Thu, May 06, 2021 at 08:46:08PM +0800, Xuewen Yan wrote:
> > > > Hi
> > > > On Thu, May 6, 2021 at 8:28 PM Vincent Donnefort
> > > > <vincent.donnefort@arm.com> wrote:
> > > > >
> > > > > On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> > > > > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > > >
> > > > > > The UTIL_AVG_UNCHANGED flag had been cleared when the task util changed.
> > > > > > And the enqueued is equal to task_util with the flag, so it is better
> > > > > > to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.
> > >
> > > Could we change the description here a bit? I don't think this is accurately
> > > explaning the issue. Would probably be interesting to mention that by not
> > > setting the flag, which is the LSB, we add +1 to the diff. This is therefore
> > > reducing slightly UTIL_EST_MARGIN.
> >
> > ok, If you agree with this patch, I'll change it in V2.
>
> Although the impact is not significant , it's worth having an accurate
> computation. So the patch makes sense to me. Please submit a v2

Okay, I'll submit a v2 later.

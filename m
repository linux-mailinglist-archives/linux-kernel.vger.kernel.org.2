Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E12364FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhDTBSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhDTBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:18:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:17:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so27633865qtx.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rzy4PEIKDTy039Z+rhXU4xvsxp0fgowrXruB/r++wo=;
        b=qy2SFoZkEIbgnFdGlmxkXzCkbWP7fluhME7lA8sR+VEAPp3pmFtPDTLVBB8JmeQB4U
         O56qiYdgKzG7XY4eAOnOyOcsGelqYUGW/e4wpCcz99/Lrbhvf5vJZVkxX1nuQYTS8aSM
         9Uec0c52QyUfX2YUv27DVHcIy2mLAgZAbJsukq1oxcGmTCSJBkHkVZ/fk0SjBtrvvR9a
         Vg8Jr3moYfPKuvf4nHblQCVX+La6MeS+jpj/V2VcZ6rIA1+/kVTnOvDZDtnSbf2+T90s
         LrXWQQwpv0mrZbLLAbIvWOSDjsvwEZizw71tn7vHQEb4B6CvnVyuC6LNEUc2PnOP2v8i
         WMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rzy4PEIKDTy039Z+rhXU4xvsxp0fgowrXruB/r++wo=;
        b=qRsxGEDXhplCsuKI3MaUYbsJmaBuurSPxRSK3q1rXTaYwWYGK/Hvy96vMrhHZqWs4V
         CYbbHWaH/q2LIfdcNKo0IeXNVy8h1kD0GuidZ8HeUSyhXEf+ViBtC0dlF5CGKuY3KVFq
         V+xieycv68Q27VPnoYMeMI6ma+uTVAH3bv2h06TneMeY5MvHGDFhO5wABjmDucaa1QJw
         FEVmc1r9B5eiTLdPIXwS97QqyQrbtcidHAbHPbRytrJy2z6p7YjpMORFzsOuD8wSstEV
         2pOMxR7KDIiCIIXe45v0+21Nzco1M+0a7D3iREWvv/E/5/SRAaO9HdjQul2YeWQ+x7it
         vgtg==
X-Gm-Message-State: AOAM532aGpy8eTOF+5kwhzjFoAhr6HWwmPTZA4XEnAWLy+FkMwxRjl6o
        osstiM/QUqgdjEee0IcW2N+mPDJvbA/+6NPMA4iuSA==
X-Google-Smtp-Source: ABdhPJwP8xmKs53bzdxmhqR9+BUdM+35P+Pwh+04qAJuRLBq2xshYvHtn0XiQQzWNQmUoXv7FTDfRDiqAbEjUep1QeE=
X-Received: by 2002:ac8:5f0a:: with SMTP id x10mr14700479qta.143.1618881465644;
 Mon, 19 Apr 2021 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook> <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
 <YH1pygTubJHh3R9m@slm.duckdns.org>
In-Reply-To: <YH1pygTubJHh3R9m@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 19 Apr 2021 18:17:34 -0700
Message-ID: <CABk29NtahuW6UERvRdK5v8My_MfPsoESDKXUjGdvaQcHOJEMvg@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 2:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Josh, you being on the other Google team, the one that actually uses the
> cgroup interface AFAIU, can you fight the good fight with TJ on this?

A bit of extra context is in
https://lore.kernel.org/lkml/CABk29NtTScu2HO7V9Di+Fh2gv8zu5xiC5iNRwPFCLhpD+DKP0A@mail.gmail.com.

On the management/auditing side, the cgroup interface gives a clear
indication of which tasks share a cookie. It is a bit less attractive
to add a prctl interface for enumerating this.

Also on the management side, I illustrated in the above message how a
thread would potentially group together other threads. One limitation
of the current prctl interface is that the share_{to, from} always
operates on the current thread. Granted we can work around this as
described, and also potentially extend the prctl interface to operate
on two tasks.

So I agree that the cgroup interface here isn't strictly necessary,
though it seems convenient. I will double-check with internal teams
that would be using the interface to see if there are any other
considerations I'm missing.

On Mon, Apr 19, 2021 at 4:30 AM Tejun Heo <tj@kernel.org> wrote:
>
> My suggestion is going ahead with the per-process interface with cgroup
> extension on mind in case actual use cases arise. Also, when planning cgroup
> integration, putting dynamic migration front and center likely isn't a good
> idea.

tasks would not be frequently moved around; I'd expect security
configuration to remain mostly static. Or maybe I'm misunderstanding
your emphasis here?


If you feel the above is not strong enough (ie. there should be a use
case not feasible with prctl), I'd support that we move forward with
the prctl stuff for now, since the cgroup interface is independant.

Thanks,
Josh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F403233E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhBWWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhBWWa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:30:29 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F09C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:29:48 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 81so389520qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf1CiVTxRiLHc6u9dFffl/B6A9OxU94+5fQMt8aSHiQ=;
        b=j3YLbAkkeUM4k5JUJuv1ncXjfeJBhF70Wu+WevNquAGfKJ4iXi+pkO61TOe8ZU/Jq0
         BRsdPJowgYj2pcym8gfG0ajJAov8g47YZZX6aCJ4Y+Xw2lPRY1IbyhJUPoxqy7dh0u/v
         hmeCrTUZeIp8Q4kGCE1RyugQJXRRJMkRe10grOAEC4TbM4u1wBUThjSX+deBkv7+CDHG
         LOo4orQdUjhp3vm5CvLaVx10rwvtI5aJjfpN2iAHCVqEPk5ucpjVuUcdJylQgAba/Rjl
         TvGi/G/ks9UTRk69ghxZS6J1y3Jf/uFurAxVYc82T0+zj/ZbDqZYPdU+59VmV9V3IH/M
         uDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf1CiVTxRiLHc6u9dFffl/B6A9OxU94+5fQMt8aSHiQ=;
        b=bahNIdnoQO3CiFOvoU5KlkPrWL1aH5vFZxMfPyvrv/GfLGtG1fM7CQM2CkiCZeN/+/
         8JaOXPJcBPRxLcRVXmckbXVN3XAnROBCB+mxtrOM9Z8PucUQnPHzCFLt8cfoWO46dcyl
         NFZM5iaXbrGHlhQfbbm+AQOeDFEEvqz0uIfGl3IXF3fIbIPLzQzL/O84+p2eVZLIAQdD
         DfQOcGdeslX/RXMT5/8KLznDitg717Gs2s4GW37ZtW29RJsSyOpE4qkXTxjlDPE+ozwS
         PfLkCHm++Kd0yOyKh1u9000KyTcpu8fCSyRq/oac9huJeJ/CuIUV8qC18YuVPpzWPnE5
         ZgmA==
X-Gm-Message-State: AOAM533SKY6KwfTC5we4SB6Gn8xAmcrixXvGdGpZN3vPLkZHgE0cYTn4
        5otoiVA5DKDxPsb3HP98rU0tdUN0Gax3Pv1xjD6M1g==
X-Google-Smtp-Source: ABdhPJwBchvPlzQBUj8TvUNJkK5VXun6l9xeXp6E8MFZJc1xphcLyLJHwvQyth2hbpH97jfQivWTSNrTtoTaRWAMVwk=
X-Received: by 2002:a05:620a:237:: with SMTP id u23mr27678392qkm.229.1614119388270;
 Tue, 23 Feb 2021 14:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <YC+ZQAwwb4RGgjDf@alley>
 <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
 <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com> <YDUkoTGk2G/GZj8w@alley>
In-Reply-To: <YDUkoTGk2G/GZj8w@alley>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Tue, 23 Feb 2021 14:29:37 -0800
Message-ID: <CAKB3++Yf5cv8shHU0T1nqfNTgbknU1uMu54YXWqNGqXHpa_oAA@mail.gmail.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > which is not cool because it will make the
> > asynchronous effort a no-op. Is there a way we can include caller
> > thread metadata(task_struct pointer?) when it enqueues the work so
> > that the RT worker thread won't preempt the caller thread when that
> > queued work gets scheduled? Probably require the CPU scheduler to poke
> > at the next work...or any other ideas will be very appreciated,
> > thanks!
>
> This sounds like a very strange use case.
> Why is the worker kthread RT when the work can be delayed?
>
> If the kthread has to be RT because of another work then
> your proposal will not work. The delayed processing of
> low priority work might block and delay any pending
> high priority work.
>
> You should consider handling the less important work in a separate
> kthread worker with a lower priority or by the system workqueue.

Just want to clarify that it's not about delayed_work any more. In my
latest question, it's a RT thread with normal work queued and
scheduled to be run immediately. However, I simply don't want the
worker to preempt the thread that queues the work.

It's a high prio work that we don't want other random tasks to preempt
it. Meanwhile, we don't want it to preempt the called thread. In
addition, assume we can't raise the priority of those caller
threads(otherwise I'd be fine with using a workqueue).

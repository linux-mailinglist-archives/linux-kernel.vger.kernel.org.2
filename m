Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5D323990
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhBXJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:36:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhBXJfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:35:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614159266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IB369nwp5DwxTBQfx+mYNcS//1xC7eRg/MH+Z8hl/hQ=;
        b=K0OkMI9Hs2bizmiP2geYKw2ebpXJ7PJakNHPDRdm98hwLB/ynySIDr5dEwzZTje2An5paw
        +YIabbxjb5gqwC6of57yf2ADasBNCaBjwlNWnhKPRU8rIMY1N+WZ4uictp5DACgKC0yTM7
        D4OVDB6/XjGjkI+OlvJCgvUP2k0rmiQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4ECB4AE05;
        Wed, 24 Feb 2021 09:34:26 +0000 (UTC)
Date:   Wed, 24 Feb 2021 10:34:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yiwei Zhang <zzyiwei@android.com>
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
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <YDYdoRwezfVsWS4W@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
 <YC+ZQAwwb4RGgjDf@alley>
 <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
 <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com>
 <YDUkoTGk2G/GZj8w@alley>
 <CAKB3++Yf5cv8shHU0T1nqfNTgbknU1uMu54YXWqNGqXHpa_oAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++Yf5cv8shHU0T1nqfNTgbknU1uMu54YXWqNGqXHpa_oAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-23 14:29:37, Yiwei Zhang wrote:
> > > which is not cool because it will make the
> > > asynchronous effort a no-op. Is there a way we can include caller
> > > thread metadata(task_struct pointer?) when it enqueues the work so
> > > that the RT worker thread won't preempt the caller thread when that
> > > queued work gets scheduled? Probably require the CPU scheduler to poke
> > > at the next work...or any other ideas will be very appreciated,
> > > thanks!
> >
> > This sounds like a very strange use case.
> > Why is the worker kthread RT when the work can be delayed?
> >
> > If the kthread has to be RT because of another work then
> > your proposal will not work. The delayed processing of
> > low priority work might block and delay any pending
> > high priority work.
> >
> > You should consider handling the less important work in a separate
> > kthread worker with a lower priority or by the system workqueue.
> 
> Just want to clarify that it's not about delayed_work any more. In my
> latest question, it's a RT thread with normal work queued and
> scheduled to be run immediately. However, I simply don't want the
> worker to preempt the thread that queues the work.
> 
> It's a high prio work that we don't want other random tasks to preempt
> it. Meanwhile, we don't want it to preempt the called thread. In
> addition, assume we can't raise the priority of those caller
> threads(otherwise I'd be fine with using a workqueue).

Honestly, it sounds weird to me. Either the caller or the
worker has higher priority.

Well, I think that behavior could be achieved by
CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.

Anyway, this is rather a question for scheduler experts.
It is possible that it has some solution. But it is also
possible that it is so specific behavior and it would
complicate the scheduler too much.

Best Regards,
Petr

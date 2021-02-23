Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE8322E07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhBWPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhBWPwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:52:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614095522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIaD7EB0kHwmGhOiSeDJ8cIDAETTm0brCjGJJE6ZqfE=;
        b=QVTmPRd0uKQAjxMjh4WZz3Y+qy331zP61h5CvA4CJm2852odx0I0t+BumHt+fvWxP3+mtu
        SB+vsKC2R7OxI+mB3ezspNiG6mScq2gKKfl7jcEKomqoAutakRMsEHEN2g+c0KnyCkrTPt
        /YfuESyhfzq/ZnhCMBNZVqt5TFIekBA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3243CAC1D;
        Tue, 23 Feb 2021 15:52:02 +0000 (UTC)
Date:   Tue, 23 Feb 2021 16:52:01 +0100
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
Message-ID: <YDUkoTGk2G/GZj8w@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
 <YC+ZQAwwb4RGgjDf@alley>
 <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
 <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-22 16:58:46, Yiwei Zhang wrote:
> Since you awesome guys are here, I do have another kthread related
> question, and hopefully to get some suggestions:
> 
> Below are the conditions:
> 1. The caller threads queuing the work are normal threads(non-RT).
> 2. The worker thread is a realtime kernel thread with relatively high prio.
> 3. We are not allowed to pin caller threads to fixed cpu clusters.
> 
> Sometimes when the CPU is busy, the worker thread starts preempting
> the caller thread,

This works as expected. RT tasks have higher priority than normal tasks.

> which is not cool because it will make the
> asynchronous effort a no-op. Is there a way we can include caller
> thread metadata(task_struct pointer?) when it enqueues the work so
> that the RT worker thread won't preempt the caller thread when that
> queued work gets scheduled? Probably require the CPU scheduler to poke
> at the next work...or any other ideas will be very appreciated,
> thanks!

This sounds like a very strange use case.
Why is the worker kthread RT when the work can be delayed?

If the kthread has to be RT because of another work then
your proposal will not work. The delayed processing of
low priority work might block and delay any pending
high priority work.

You should consider handling the less important work in a separate
kthread worker with a lower priority or by the system workqueue.

Best Regards,
Petr

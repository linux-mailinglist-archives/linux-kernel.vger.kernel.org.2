Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC06331F74C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBSK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:28:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:35430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBSK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:28:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613730434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrvKD8kfwE175v3SQ4Nc2VhvWT7hv0j+jUvXS3qcGeU=;
        b=kmLKHU9TUN5yDXVK/ZhpwePFA+hBeVedIM42xPe1L+1tSyz2E6IlzSycEosa7ygz2NGfcl
        qu6jLmxup5zIQbXEUANlpSTWZ5Z5s2Ffr6/RaFRhOX/m/jCrWrGXf+RRmzHuhEJDDPEA+T
        wNhvC9K0B94QL5tVehViZvsfbxkGfg8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 946F1ACCF;
        Fri, 19 Feb 2021 10:27:14 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:27:13 +0100
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
Message-ID: <YC+SgVZdm5gfSqFg@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
 <20210216091128.GA3973504@infradead.org>
 <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com>
 <YCz6nz4i136z1+H1@alley>
 <CAKB3++b+n=VWuXZqZqyZJvAf1+Wqogvi07L21GqdRwThSRdf2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++b+n=VWuXZqZqyZJvAf1+Wqogvi07L21GqdRwThSRdf2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 22:29:24, Yiwei Zhang wrote:
> > 2. User triggered clean up races with the clean up triggered by
> >   timeout. You try to handle this scenario by this patch.
> Yes, exactly.
> 
> > 3. User does clean up after the clean up has already been done
> >   by the timeout.
> This case is well handled. So only (2) has a potential race.

Just to be sure. Does the user work correctly when the clean up work
is done by the timemout before the user wanted to do the clean up?

> Let me clarify a bit more here. The "clean up" is not the clean up
> when a process tears down, but it's actually a "post-work" to cancel
> out an early "pre-work". The "pre-work" enqueues the delayed "post
> work" for the timeout purpose. That pair of operations can repeatedly
> happen.
> 
> The racing is currently worked around by refcounting the delayed_work
> container, and the later "post-work" will take care of the work
> deallocation.
> 
> I mainly want to reach out to see if we agree that this is a valid API
> to be supported by kthread. Or we extend the existing
> kthread_mod_delayed_work api to take another option to not re-queue if
> the cancel failed.

OK, I could imagine a situation when you want to speed up the delayed
work and avoid this race.

The kthread_worker API has more or less the same semantic as
the workqueue API. It makes it easier to switch between them.

The workqueue API has flush_delayed_work(). It does basically
the same as your code. We should call the function
kthread_worker_flush_delayed_work().

I am personally fine with adding this API. I am going to
comment the original code. Well, there might be a push-back
from other people because there will be no in-tree user.

Best Regards,
Petr

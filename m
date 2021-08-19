Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2323F1DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhHSQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhHSQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629389975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWL9e4xUx30LyDaX3BooFSoTDb4sVbpiLQOzMeuY4Wo=;
        b=IA4TMmY4eu1CW4R83k6hEHWKvk+3dZE0Erg9TL+4vwy9KzVWw+0G/eyH17P049ozqO3HVK
        H7EwLYQlB5QoETf7xGDRxtmSnDQQ5x1NCUNVSMjt8raTYvsZJjYUlcEpZdJSuT9pllgH2i
        Y4Ger5eN1hAmEPa0YyAWxrPuhy8hHsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-50uu4GAaNBuUiXSNkrLcZQ-1; Thu, 19 Aug 2021 12:19:31 -0400
X-MC-Unique: 50uu4GAaNBuUiXSNkrLcZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6596107ACF5;
        Thu, 19 Aug 2021 16:19:29 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D02E46EF4F;
        Thu, 19 Aug 2021 16:19:25 +0000 (UTC)
Date:   Thu, 19 Aug 2021 18:19:22 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: Re: [PATCH] sched: Fix Core-wide rq->lock for uninitialized CPUs
Message-ID: <20210819161922.GA18087@asgard.redhat.com>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com>
 <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
 <20210817231734.GA4449@asgard.redhat.com>
 <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:09:17PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 18, 2021 at 01:17:34AM +0200, Eugene Syromiatnikov wrote:
> > On Tue, Aug 17, 2021 at 05:52:43PM +0200, Peter Zijlstra wrote:
> > > Urgh... lemme guess, your HP BIOS is funny and reports more possible
> > > CPUs than you actually have resulting in cpu_possible_mask !=
> > > cpu_online_mask. Alternatively, you booted with nr_cpus= or something
> > > daft like that.
> > 
> > Yep, it seems to be the case:
> > 
> >     # cat /sys/devices/system/cpu/possible
> >     0-7
> >     # cat /sys/devices/system/cpu/online
> >     0-3
> > 
> 
> I think the below should work... can you please verify?

Yes, it no longer oops'es now, thank you!

    # cat /sys/devices/system/cpu/possible
    0-7
    # cat /sys/devices/system/cpu/online
    0-3
    # ./prctl-sched-core-oops-repro
    Iteration 0 status: 0
    Iteration 1 status: 0
    # ../src/strace -fvq -eprctl,clone,setsid -esignal=none ./prctl-sched-core-oops-repro
    clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f510b1c7890) = 108328
    [pid 108328] setsid()                   = 108328
    [pid 108328] +++ exited with 0 +++
    Iteration 0 status: 0
    prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 108324, 0x2 /* PIDTYPE_PGID */, NULL) = 0
    clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f510b1c7890) = 108329
    [pid 108329] setsid()                   = 108329
    [pid 108329] +++ exited with 0 +++
    Iteration 1 status: 0
    prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 108324, 0x2 /* PIDTYPE_PGID */, NULL) = 0
    +++ exited with 0 +++

> ---
> Subject: sched: Fix Core-wide rq->lock for uninitialized CPUs
> 
> Eugene tripped over the case where rq_lock(), as called in a
> for_each_possible_cpu() loop came apart because rq->core hadn't been
> setup yet.
> 
> This is a somewhat unusual, but valid case.
> 
> Rework things such that rq->core is initialized to point at itself. IOW
> initialize each CPU as a single threaded Core. CPU online will then join
> the new CPU (thread) to an existing Core where needed.
> 
> For completeness sake, have CPU offline fully undo the state so as to
> not presume the topology will match the next time it comes online.
> 
> Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
> Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Eugene Syromiatnikov <esyr@redhat.com>


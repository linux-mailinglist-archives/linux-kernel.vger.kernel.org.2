Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD233D8CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhG1Lpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhG1Lpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:45:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C144860524;
        Wed, 28 Jul 2021 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627472751;
        bh=9LzmloFr9ISei0EYqupkTDZ9dmXO3ySd3AZkPy2LZNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i75TZKM6FRBbzHcUkXzf5AXkbybNzPbqkQTSG4/taGGYEmHjNXk0TG29BP4tne+6p
         5IYKPnLMSHH14Rovl9CEjK8ZmoenHEl85YGXXLVrKG8Lc03eE7bnoZpl4lbQET0d4h
         FwRB7qHHXxPyaUp13ZzksAPjOBk42SL4E6yUqZCnHgvbuIzF3nk0gXjXrDx9bR/lhl
         0kM4x2P7dosfcyKhOi7t6PWl5tNKDfKwUgStwf1Hj8puVOJFg9XYXjbqbGr3kxMu9v
         p4hqJn8VNQf5xjYO/Wu5VtjZf8D2/rPURTbQmzcU0OuPUcCZ3TC6z+F3A18jS4wSxv
         U3qDSSkY6RU7g==
Date:   Wed, 28 Jul 2021 13:45:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210728114548.GA293265@lothringen>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
 <20210727234539.GH283787@lothringen>
 <20210728093707.GA3242@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728093707.GA3242@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 06:37:07AM -0300, Marcelo Tosatti wrote:
> On Wed, Jul 28, 2021 at 01:45:39AM +0200, Frederic Weisbecker wrote:
> > On Tue, Jul 27, 2021 at 11:52:09AM -0300, Marcelo Tosatti wrote:
> > > The meaning of isolated is specified as follows:
> > > 
> > > Isolation features
> > > ==================
> > > 
> > > - prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
> > > features as a return value.
> > > 
> > > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > > the bitmask.
> > > 
> > > - prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
> > > enabled features.
> > 
> > So what are the ISOL_FEATURES here? A mode that we enter such as flush
> > vmstat _everytime_ we resume to userpace after (and including) this prctl() ?
> 
> ISOL_FEATURES is just the "command" type (which you can get and set).
> 
> The bitmask would include ISOL_F_QUIESCE_ON_URET, so:
> 
> - bitmask = ISOL_F_QUIESCE_ON_URET;
> - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> the bitmask.

But does it quiesce once or for every further uret?

> 
> - quiesce_bitmap = prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0)
>   (1)
> 
>   (returns the supported actions to be quiesced).
> 
> - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) _sets_
> the actions to be quiesced (2)
> 
> If an application does not modify "quiesce_bitmask" between 
> points (1) and (2) above, it will enable quiescing of all
> "features" the kernel supports.

I don't get the difference between ISOL_FEATURES and PR_ISOL_QUIESCE_CFG.

> 
> Application can, however, modify quiesce_bitmap to its preference.
> 
> Flushing vmstat _everytime_ you resume to userspace is enabled only
> _after_ prctl(PR_ISOL_ENTER, 0, 0, 0, 0) is performed (which happens 
> only when isolation is fully configured with the PR_ISOL_SET calls).
> OK, will better document that.

Yes please, I'm completely confused :o)

> 
> > If so I'd rather call that ISOL_MODE because feature is too general.
> 
> Well, in the first patchset, there was one "mode" implemented (but
> it was possible to implement different modes in the future).
> 
> This would allow for example easier integration of "full task isolation"
> patchset type of functionality, disallowing syscalls.
> 
> I think we'd like to keep that, so i'll keep the previous distinct modes
> (but allow configuration of individual features on the bitmap).

And I also don't see how such modes differ from configuration of individual
features on the bitmap.

> > > - prctl(PR_ISOL_GET, PR_ISOL_QUIESCE_CFG, 0, 0, 0) returns
> > > the currently enabled actions to be quiesced.
> > > 
> > > #define ISOL_F_QUIESCE_VMSTAT_SYNC      (1<<0)
> > > #define ISOL_F_QUIESCE_NOHZ_FULL        (1<<1)
> > > #define ISOL_F_QUIESCE_DEFER_TLB_FLUSH  (1<<2)
> > 
> > And then PR_ISOL_QUIESCE_CFG is a oneshot operation that applies only upon
> > return to this ctrl, right? If so perhaps this should be called just
> > ISOL_QUIESCE or ISOL_QUIESCE_ONCE or ISOL_REQ ?
> 
> There was no one-shot operation implemented in the first patchset. What
> application would do to achieve that is:
> 
> 1. Configure isolation with PR_ISOL_SET (say configure mode which 
> allows system calls, and when a system call happens, flush all deferred
> actions on return to userspace).
> 
> 2. prctl(PR_ISOL_ENTER, 0, 0, 0, 0) (this actually enables the flushing, 
> and tags the task_struct as isolated). Here we can transfer this information
> from per-task to per-CPU data, for example, to be able to implement 
> other features such as deferred TLB flushing.
> 
> On return from this prctl(), deferrable actions are flushed.
> 
> 3. latency sensitive loop, with no system calls.
> 
> 4. some event which requires system calls is noticed:
>    prctl(PR_ISOL_EXIT, 0, 0, 0, 0)
>    (this would untag task_struct as isolated).
> 
> 5. perform system calls A, B, C, D (with no flushing of vmstat, 
> for example).
> 
> 6. jmp to 2.
> 
> So there is a problem with this logic, which is that one would like
> certain isolation functionality to remain enabled between points 4
> and 6 (for example, blocking CPU hotplug or other blockable activities
> that would cause interruptions).
> 
> One way to achieve this would be to replace PR_ISOL_ENTER/PR_ISOL_EXIT
> with PR_ISOL_ENABLE, which accepts a bitmask:
> 
> 1. Configure isolation with PR_ISOL_SET (say configure mode which 
> allows system calls, and when a system call happens, flush all deferred
> actions on return to userspace).
> 
> 2. enabled_bitmask = ISOL_F_QUIESCE_ON_URET|ISOL_F_BLOCK_INTERRUPTORS;
>    prctl(PR_ISOL_ENABLE, enabled_bitmask, 0, 0, 0)
> 
> On return from this prctl(), deferrable actions are flushed.
> 
> 3. latency sensitive loop, with no system calls.
> 
> 4. some event which requires system calls is noticed:
> 
>    prctl(PR_ISOL_ENABLE, ISOL_F_BLOCK_INTERRUPTORS, 0, 0, 0)
>    (this would clear ISOL_F_QUIESCE_ON_URET, so no flushing
>     is performed on return from system calls).

So PR_ISOL_ENABLE is a way to perform action when some sort of kernel entry
happens. Then we take actions when that happens (signal, warn, etc...).

I guess we'll need to define what kind of kernel entry, and what kind of
response need to happen. Ok that's a whole issue of its own that we'll need
to handle seperately.

Thanks.

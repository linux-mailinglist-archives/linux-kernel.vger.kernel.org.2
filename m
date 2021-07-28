Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408653D8B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhG1J4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231770AbhG1J4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627466193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IONbg/ked4uqfGw9LM42l1vsFw4q6Wlna3+yNQ7ATkI=;
        b=IuO84ZqlethCrFNnifXiWrN1cL5ONZQ7U0AYukn2YHOMQO6gHN7XSuQn2HTjpY6h08A/LC
        K5Fj5zZsX7OHrtHmbowB7LPVoOeiQqPy98gs5UMba8J19TDm6L7csNtgGUV/ykd5fbmf4M
        ISfMC/cZ/Co7+r9mV9EHKhVexNZYXYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-gCVleic_M4OfsYdqgwBdNg-1; Wed, 28 Jul 2021 05:56:31 -0400
X-MC-Unique: gCVleic_M4OfsYdqgwBdNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46F97190A7A1;
        Wed, 28 Jul 2021 09:56:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A77525C1B4;
        Wed, 28 Jul 2021 09:56:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 22AE14172EE3; Wed, 28 Jul 2021 06:37:07 -0300 (-03)
Date:   Wed, 28 Jul 2021 06:37:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210728093707.GA3242@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
 <20210727234539.GH283787@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727234539.GH283787@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:45:39AM +0200, Frederic Weisbecker wrote:
> On Tue, Jul 27, 2021 at 11:52:09AM -0300, Marcelo Tosatti wrote:
> > The meaning of isolated is specified as follows:
> > 
> > Isolation features
> > ==================
> > 
> > - prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
> > features as a return value.
> > 
> > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > the bitmask.
> > 
> > - prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
> > enabled features.
> 
> So what are the ISOL_FEATURES here? A mode that we enter such as flush
> vmstat _everytime_ we resume to userpace after (and including) this prctl() ?

ISOL_FEATURES is just the "command" type (which you can get and set).

The bitmask would include ISOL_F_QUIESCE_ON_URET, so:

- bitmask = ISOL_F_QUIESCE_ON_URET;
- prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
the bitmask.

- quiesce_bitmap = prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0)
  (1)

  (returns the supported actions to be quiesced).

- prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) _sets_
the actions to be quiesced (2)

If an application does not modify "quiesce_bitmask" between 
points (1) and (2) above, it will enable quiescing of all
"features" the kernel supports.

Application can, however, modify quiesce_bitmap to its preference.

Flushing vmstat _everytime_ you resume to userspace is enabled only
_after_ prctl(PR_ISOL_ENTER, 0, 0, 0, 0) is performed (which happens 
only when isolation is fully configured with the PR_ISOL_SET calls).
OK, will better document that.

> If so I'd rather call that ISOL_MODE because feature is too general.

Well, in the first patchset, there was one "mode" implemented (but
it was possible to implement different modes in the future).

This would allow for example easier integration of "full task isolation"
patchset type of functionality, disallowing syscalls.

I think we'd like to keep that, so i'll keep the previous distinct modes
(but allow configuration of individual features on the bitmap).

> > 
> > The supported features are:
> > 
> > ISOL_F_QUIESCE_ON_URET: quiesce deferred actions on return to userspace.
> > ----------------------
> > 
> > Quiescing of different actions can be performed on return to userspace.
> > 
> > - prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0) returns
> > the supported actions to be quiesced.
> > 
> > - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) returns
							
							s/returns/sets/

> > the currently supported actions to be quiesced.
> > 
> > - prctl(PR_ISOL_GET, PR_ISOL_QUIESCE_CFG, 0, 0, 0) returns
> > the currently enabled actions to be quiesced.
> > 
> > #define ISOL_F_QUIESCE_VMSTAT_SYNC      (1<<0)
> > #define ISOL_F_QUIESCE_NOHZ_FULL        (1<<1)
> > #define ISOL_F_QUIESCE_DEFER_TLB_FLUSH  (1<<2)
> 
> And then PR_ISOL_QUIESCE_CFG is a oneshot operation that applies only upon
> return to this ctrl, right? If so perhaps this should be called just
> ISOL_QUIESCE or ISOL_QUIESCE_ONCE or ISOL_REQ ?

There was no one-shot operation implemented in the first patchset. What
application would do to achieve that is:

1. Configure isolation with PR_ISOL_SET (say configure mode which 
allows system calls, and when a system call happens, flush all deferred
actions on return to userspace).

2. prctl(PR_ISOL_ENTER, 0, 0, 0, 0) (this actually enables the flushing, 
and tags the task_struct as isolated). Here we can transfer this information
from per-task to per-CPU data, for example, to be able to implement 
other features such as deferred TLB flushing.

On return from this prctl(), deferrable actions are flushed.

3. latency sensitive loop, with no system calls.

4. some event which requires system calls is noticed:
   prctl(PR_ISOL_EXIT, 0, 0, 0, 0)
   (this would untag task_struct as isolated).

5. perform system calls A, B, C, D (with no flushing of vmstat, 
for example).

6. jmp to 2.

So there is a problem with this logic, which is that one would like
certain isolation functionality to remain enabled between points 4
and 6 (for example, blocking CPU hotplug or other blockable activities
that would cause interruptions).

One way to achieve this would be to replace PR_ISOL_ENTER/PR_ISOL_EXIT
with PR_ISOL_ENABLE, which accepts a bitmask:

1. Configure isolation with PR_ISOL_SET (say configure mode which 
allows system calls, and when a system call happens, flush all deferred
actions on return to userspace).

2. enabled_bitmask = ISOL_F_QUIESCE_ON_URET|ISOL_F_BLOCK_INTERRUPTORS;
   prctl(PR_ISOL_ENABLE, enabled_bitmask, 0, 0, 0)

On return from this prctl(), deferrable actions are flushed.

3. latency sensitive loop, with no system calls.

4. some event which requires system calls is noticed:

   prctl(PR_ISOL_ENABLE, ISOL_F_BLOCK_INTERRUPTORS, 0, 0, 0)
   (this would clear ISOL_F_QUIESCE_ON_URET, so no flushing
    is performed on return from system calls).

5. perform system calls A, B, C, D (with no flushing of vmstat).

6. jmp to 2.

...

On exit: prctl(PR_ISOL_ENABLE, 0, 0, 0, 0)

IOW: the one-shot operation does not allow the application
to inform the kernel when the latency sensitive loop has 
begun or has ended.

> 
> But that's just naming debate because otherwise that prctl layout looks good
> to me.
> 
> Thanks!

Thank you for the input!


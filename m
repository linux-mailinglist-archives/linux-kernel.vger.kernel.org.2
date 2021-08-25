Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694C33F7284
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhHYKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239683AbhHYKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629885756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNQw5M7GXPNq6aXAA7yK5iUMHOIbWCguNiz70Y3FyJs=;
        b=RLDdZUex+GAcw4mPLW05fpJPhciEB5e7ZE2xmUaohhozKutn0AhQeAfDRwXcV6bb0bbAw7
        BP2spp9vqCvatnbUYSDo5uyYAZ2/2g7UBa0EYgxj8a6wDUzzWpCSF6KfDrnjXhka8EA6K+
        Sx6QvwjnZEwa0Tl5pEuloJDLyCv1WMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-ErSM2KAfOY-vjF_cnFabgQ-1; Wed, 25 Aug 2021 06:02:35 -0400
X-MC-Unique: ErSM2KAfOY-vjF_cnFabgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA0D180FCA7;
        Wed, 25 Aug 2021 10:02:33 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CE719C59;
        Wed, 25 Aug 2021 10:02:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3364F416D8BC; Wed, 25 Aug 2021 07:02:21 -0300 (-03)
Date:   Wed, 25 Aug 2021 07:02:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 0/8] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <20210825100221.GB83176@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824152423.300346181@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC Thomas.

On Tue, Aug 24, 2021 at 12:24:23PM -0300, Marcelo Tosatti wrote:
> 
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, add task isolation prctl interface to quiesce
> deferred actions when returning to userspace.
> 
> The patchset is based on ideas and code from the 
> task isolation patchset from Alex Belits:
> https://lwn.net/Articles/816298/
> 
> Please refer to Documentation/userspace-api/task_isolation.rst
> (patch 2) for details.
> 
> Note: the prctl interface is independent of nohz_full=.
> 
> ---------
> 
> v3: 
> 
>  - Split in smaller patches		 (Nitesh Lal).
>  - Misc cleanups			 (Nitesh Lal).
>  - Clarify nohz_full is not a dependency (Nicolas Saenz).
>  - Incorrect values for prctl definitions (kernel robot).
>  - Save configured state, so applications  
>    can activate externally configured
>    task isolation parameters.
>  - Remove "system default" notion (chisol should
>    make it obsolete).
>  - Update documentation: add new section with explanation
>    about configuration/activation and code example.
>  - Update samples.
>  - Report configuration/activation state at
>    /proc/pid/task_isolation.
>  - Condense dirty information of per-CPU vmstats counters 
>    in a bool.
>  - In-kernel KVM support.
>  - Add support to configure inheritance on fork and exec.
> 
> v2:
> 
> - Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).
> 
> - Avoid potential regressions by allowing applications
>   to use ISOL_F_QUIESCE_DEFMASK (whose default value
>   is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).
> 
> v2 can be found at:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=510225
> 
> 
> ---
> 
>  Documentation/userspace-api/task_isolation.rst |  281 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c                             |    3 
>  fs/proc/base.c                                 |   68 +++++++++++++++++++
>  include/linux/sched.h                          |    5 +
>  include/linux/task_isolation.h                 |  131 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vmstat.h                         |   17 ++++
>  include/uapi/linux/prctl.h                     |   27 +++++++
>  init/init_task.c                               |    3 
>  kernel/Makefile                                |    2 
>  kernel/entry/common.c                          |    2 
>  kernel/exit.c                                  |    2 
>  kernel/fork.c                                  |   23 ++++++
>  kernel/sys.c                                   |   26 +++++++
>  kernel/task_isolation.c                        |  315 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/vmstat.c                                    |  167 ++++++++++++++++++++++++++++++++++++------------
>  samples/Kconfig                                |    7 ++
>  samples/Makefile                               |    1 
>  samples/task_isolation/Makefile                |    9 ++
>  samples/task_isolation/task_isol.c             |   83 ++++++++++++++++++++++++
>  samples/task_isolation/task_isol.h             |    9 ++
>  samples/task_isolation/task_isol_userloop.c    |   56 ++++++++++++++++
>  21 files changed, 1194 insertions(+), 43 deletions(-)
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E932E3F61DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhHXPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238431AbhHXPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=EjOVFgcjnAWoEJZJx4PQaCBU4tZk9hsu5u7Pp6chYSM=;
        b=hydGnSqnOzkCJwYvAXKdeVPLc5vA4CnipyTF9L4L4Y80cWuJOR3EJq9Yo7IaCziljdjcz2
        y/zh5kGGBw7PAHxvgvdVq9uTHqIPDmIFkPWDP+tPjkajTqe/HEQxOHLewsxqrwppMU+pPC
        NATC/84fukyRp4+1HTXyNnS8y9/y39k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-26rzmqExNT2vNzqRCYLAOw-1; Tue, 24 Aug 2021 11:42:40 -0400
X-MC-Unique: 26rzmqExNT2vNzqRCYLAOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EBFB801A92;
        Tue, 24 Aug 2021 15:42:39 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E49DF60C5A;
        Tue, 24 Aug 2021 15:42:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 05B12416CE49; Tue, 24 Aug 2021 12:42:15 -0300 (-03)
Message-ID: <20210824152423.300346181@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 24 Aug 2021 12:24:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch V3 0/8] extensible prctl task isolation interface and vmstat sync
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on
the CPU in question.

To fix this, add task isolation prctl interface to quiesce
deferred actions when returning to userspace.

The patchset is based on ideas and code from the 
task isolation patchset from Alex Belits:
https://lwn.net/Articles/816298/

Please refer to Documentation/userspace-api/task_isolation.rst
(patch 2) for details.

Note: the prctl interface is independent of nohz_full=.

---------

v3: 

 - Split in smaller patches		 (Nitesh Lal).
 - Misc cleanups			 (Nitesh Lal).
 - Clarify nohz_full is not a dependency (Nicolas Saenz).
 - Incorrect values for prctl definitions (kernel robot).
 - Save configured state, so applications  
   can activate externally configured
   task isolation parameters.
 - Remove "system default" notion (chisol should
   make it obsolete).
 - Update documentation: add new section with explanation
   about configuration/activation and code example.
 - Update samples.
 - Report configuration/activation state at
   /proc/pid/task_isolation.
 - Condense dirty information of per-CPU vmstats counters 
   in a bool.
 - In-kernel KVM support.
 - Add support to configure inheritance on fork and exec.

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).

- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

v2 can be found at:
https://lore.kernel.org/patchwork/project/lkml/list/?series=510225


---

 Documentation/userspace-api/task_isolation.rst |  281 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                             |    3 
 fs/proc/base.c                                 |   68 +++++++++++++++++++
 include/linux/sched.h                          |    5 +
 include/linux/task_isolation.h                 |  131 ++++++++++++++++++++++++++++++++++++++
 include/linux/vmstat.h                         |   17 ++++
 include/uapi/linux/prctl.h                     |   27 +++++++
 init/init_task.c                               |    3 
 kernel/Makefile                                |    2 
 kernel/entry/common.c                          |    2 
 kernel/exit.c                                  |    2 
 kernel/fork.c                                  |   23 ++++++
 kernel/sys.c                                   |   26 +++++++
 kernel/task_isolation.c                        |  315 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c                                    |  167 ++++++++++++++++++++++++++++++++++++------------
 samples/Kconfig                                |    7 ++
 samples/Makefile                               |    1 
 samples/task_isolation/Makefile                |    9 ++
 samples/task_isolation/task_isol.c             |   83 ++++++++++++++++++++++++
 samples/task_isolation/task_isol.h             |    9 ++
 samples/task_isolation/task_isol_userloop.c    |   56 ++++++++++++++++
 21 files changed, 1194 insertions(+), 43 deletions(-)


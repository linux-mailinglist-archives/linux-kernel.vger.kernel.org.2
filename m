Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A806426CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhJHOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242701AbhJHOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Fy0bDUNVp/rYTHwydb/DdR+7lmJBapcic3IR/jHbV7M=;
        b=gwEQg4qdzPwgt8w6xZ6vpK3KZtzr+eJDVjHL6ouxSLrCnchXkEd65UCaNA0c3/cmcCJo2X
        LqFJ8zev7xyq8rZBcQG55XvBUmRfD3wKxqwXOq2Gl02roSQAOIKVWLHjlNWD/3CynooMsL
        +Htx5l/wy/V8z3wPBh3OeDHS8dnJTp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-rUu_Y8VMMH6FM6i16TMO_g-1; Fri, 08 Oct 2021 10:48:55 -0400
X-MC-Unique: rUu_Y8VMMH6FM6i16TMO_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0D38835DEC;
        Fri,  8 Oct 2021 14:48:53 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE7995DA61;
        Fri,  8 Oct 2021 14:48:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D92554172EF4; Fri,  8 Oct 2021 11:48:13 -0300 (-03)
Message-ID: <20211007192346.731667417@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 16:23:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch v4 0/8] extensible prctl task isolation interface and vmstat sync
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
(patch 1) for details.

Note: the prctl interface is independent of nohz_full=.

---------

v4:
 - Switch to structures for parameters when possible
   (which are more extensible).
 - Switch to CFG_{S,G}ET naming and use drop
   "internal configuration" prctls	      (Frederic Weisbecker).
 - Add summary of terms to documentation      (Frederic Weisbecker).
 - Examples for compute and one-shot modes    (Thomas G/Christoph L).

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

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).

- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

v3 can be found at:
https://lore.kernel.org/lkml/20210824152423.300346181@fuller.cnet/

v2 can be found at:
https://lore.kernel.org/patchwork/project/lkml/list/?series=510225






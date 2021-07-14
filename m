Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E23C9250
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhGNUqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhGNUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626295431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UtmS8ddlNEN27XMcgHjeiB5XpYxF/VSCmeZdVBtFF2g=;
        b=VKwhl0o+U92WP5qHUSOCtzbPRav+iacD/hNY1QZEMbwVzc3GJJsJVsGn8VFYXNsAgWv3+r
        swY/yCvwL/zHReiHLhsrz6P9YYoyF0DkNeLaaBqwaqLnledChQkKBu+se1UFeFet10NTtk
        pFglsD8NdvylS7BiW66Sdm7rSXIgE5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-ajsAB2yvOfq1lurXfcBXBw-1; Wed, 14 Jul 2021 16:43:50 -0400
X-MC-Unique: ajsAB2yvOfq1lurXfcBXBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC0DB8030B0;
        Wed, 14 Jul 2021 20:43:48 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28A8260C5F;
        Wed, 14 Jul 2021 20:43:45 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E86C14172ED4; Wed, 14 Jul 2021 17:43:36 -0300 (-03)
Message-ID: <20210714204205.245522189@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 14 Jul 2021 17:42:05 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>
Subject: [patch 0/5] optionally perform deferred actions on return to userspace (v3)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:


-v3: use optimized percpu accessors for hotpath in
     vmstat.c (Christoph Lameter)
     fix !CONFIG_NUMA compilation breakage (kernel robot)

-v2: fix !CONFIG_SMP breakage (kernel robot)
     switch option to generic "quiesce_on_exit_to_usermode"


Summary of what was discussed on -v1:

1) The additional hooks to performance sensitive callbacks
in mm/vmstat.c are protected by a static key, therefore
workloads which do not enable this should not be impacted.

2) People would prefer the prctl() interface, but as noted
in the option documentation (patch 1), the code added by
this patchset should be reused by the prctl() interface,
and the isolcpus option can then be deprecated.

3) Nobody has any other bright ideas for ways to solve this
that would make this patch series obsolete.

4) The isolcpus= interface should switch to a cpuset based
interface.

---


The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on
the CPU in question.

To fix this, optionally quiesce deferred actions when returning
to userspace, controllable by a new "quiesce_on_exit_to_usermode"
isolcpus flag (default off).

See individual patches for details.





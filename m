Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885E93C28DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGISM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229936AbhGISMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8dzIZ0NGWcvLE911x7l7LrX9eMLcBpxOIY0yPCLQHEw=;
        b=HnS/52+AM/WfvgES8onqL2ih9t40zl2+SNsUytgEfNktznbujzTNYjjvmQXKKWP94UckzO
        0Va0nC2BQWl7x4CKwX7cKQDAjd7wI2QrK1A9Hx4OM4H+QV6v/8JTcLu5/TYtbCOOe/7BJB
        kQY0Ag36rL4a/sutAoph1jelNXPfaoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-WNW_iuT9Ph-fKleZ6RTpiA-1; Fri, 09 Jul 2021 14:09:37 -0400
X-MC-Unique: WNW_iuT9Ph-fKleZ6RTpiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B29C84F20B;
        Fri,  9 Jul 2021 18:09:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D5C9175B9;
        Fri,  9 Jul 2021 18:09:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 44615416D862; Fri,  9 Jul 2021 15:09:28 -0300 (-03)
Message-ID: <20210709173726.457181806@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 14:37:26 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>
Subject: [patch 0/5] optionally perform deferred actions on return to userspace
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

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




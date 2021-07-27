Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C03D737C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhG0KmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236316AbhG0KmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=IT+EQvVl8yyI284zyT3EdvtpKPDR0WHPaXQUKhGJWQ0=;
        b=I3Zh8sathbnXwA2fr/G2rCoDhdYou/OsgQ3ID+0bqTcGdWTkUPCHQgZq2nGa31ZJ1tRr6T
        0qxD7fHFopa2Q6sP4FgVMDHr2eqkyhM6Em03gIIqPCw65a/Spi80bHyv3eMFplXQm712J7
        BEv2I81bmWRYKOgWJjb4+Bxmye8iW/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-XKLOz5qlMkir3K7nAfjHvg-1; Tue, 27 Jul 2021 06:42:07 -0400
X-MC-Unique: XKLOz5qlMkir3K7nAfjHvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD651190D341;
        Tue, 27 Jul 2021 10:42:05 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB56F5C1CF;
        Tue, 27 Jul 2021 10:41:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9AA174172EDE; Tue, 27 Jul 2021 07:41:49 -0300 (-03)
Message-ID: <20210727103803.464432924@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 27 Jul 2021 07:38:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>, Peter Xu <peterx@redhat.com>
Subject: [patch 0/4] prctl task isolation interface and vmstat sync
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

=============================
Task isolation prctl interface
=============================

Set thread isolation mode and parameters, which allows
informing the kernel that application is
executing latency sensitive code (where interruptions
are undesired).

Its composed of 4 prctl commands (passed as arg1 to
prctl):

PR_ISOL_SET:   set isolation parameters for the task

PR_ISOL_GET:   get isolation parameters for the task

PR_ISOL_ENTER: indicate that task should be considered
               isolated from this point on

PR_ISOL_EXIT: indicate that task should not be considered
              isolated from this point on

The isolation parameters and mode are not inherited by
children created by fork(2) and clone(2). The setting is
preserved across execve(2).

The meaning of isolated is specified as follows, when setting arg2 to
PR_ISOL_SET or PR_ISOL_GET, with the following arguments passed as arg3.

Isolation mode (PR_ISOL_MODE):
------------------------------

- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.

- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
  and in case of interruption events, the notifications can be collected
  by BPF programs.
  In this mode, if system calls are performed, deferred actions initiated
  by the system call will be executed before return to userspace.

Other modes, which for example send signals upon interruptions events,
can be implemented.

Example
=======

The ``samples/task_isolation/`` directory contains a sample
application.



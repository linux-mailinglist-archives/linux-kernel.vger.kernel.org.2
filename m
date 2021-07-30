Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32813DBF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhG3UVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231670AbhG3UVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627676458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ifww71qqbDWPoRm6Ao1Apaw8cyeJ69IfiP3f3IU0rww=;
        b=GD5ZL3zhI+xKCKSt0oxAMTY+afY/XuuMmYkiMIf9dOsJlZ4xOfIXXoDA2Mm8NmipniiR8h
        4TOlKlltP5j9j7XnAtuMLuwdrd3GGe52RdZmiXsNbFvna4RqckpTIoU182MT24YZcZjJTk
        IpMoTdv27LA6UcBhB66aVZVzq49m9Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-mOPNXpoWOJqfWwCk_wvrkA-1; Fri, 30 Jul 2021 16:20:57 -0400
X-MC-Unique: mOPNXpoWOJqfWwCk_wvrkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B115E10066E5;
        Fri, 30 Jul 2021 20:20:55 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF24E2C3;
        Fri, 30 Jul 2021 20:20:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7AFBC41752B2; Fri, 30 Jul 2021 17:20:28 -0300 (-03)
Message-ID: <20210730201827.269106165@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 30 Jul 2021 17:18:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch 0/4] extensible prctl task isolation interface and vmstat sync (v2)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

---------

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).

- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).


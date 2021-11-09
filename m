Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442C644B226
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhKIRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233952AbhKIRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636480027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2nn+sZh+z3DAd6lRC0BhDFoNpFBYmNaI4d0rQ5iyEdU=;
        b=jERHqdwoulXWTfIl4w8BQrO9jDKPoEZGGODHJOI4Igj8LupawXiclZkUXFqHXEAk1EugZI
        8XZ0wBiNGQ3hRxh4RJTN+OU34tWP7ULX2vc8lMa2W5GB6rcaLSUBJISZsZ0igwcwkCmcBo
        tWcpJl4tb7nrVDtN9sJGYMD3mfheuXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Xdt07GfsPM6lR_5hF_CImw-1; Tue, 09 Nov 2021 12:47:04 -0500
X-MC-Unique: Xdt07GfsPM6lR_5hF_CImw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBF818799EC;
        Tue,  9 Nov 2021 17:47:02 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4FD167847;
        Tue,  9 Nov 2021 17:46:23 +0000 (UTC)
From:   wander@redhat.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org (open list:TORTURE-TEST MODULES),
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] rcutorture: Avoid soft lockup during cpu stall
Date:   Tue,  9 Nov 2021 14:46:02 -0300
Message-Id: <20211109174602.407644-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

If we use the module stall_cpu option, we may get a soft lockup warning
if we also don't pass the stall_cpu_block option.

We introduce the stall_no_softlockup option to avoid a soft lockup on
cpu stall even if we don't use the stall_cpu_block option.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 40ef5417d954..0a2a9a6533d1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -10,6 +10,7 @@
  * See also:  Documentation/RCU/torture.rst
  */
 
+#include "linux/nmi.h"
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
@@ -109,6 +110,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
+torture_param(bool, stall_no_softlockup, false,
+	     "Avoid softlockup warning during cpu stall.");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stall_gp_kthread, 0,
@@ -2024,6 +2027,8 @@ static int rcu_torture_stall(void *args)
 				    stop_at))
 			if (stall_cpu_block)
 				schedule_timeout_uninterruptible(HZ);
+			else if (stall_no_softlockup)
+				touch_softlockup_watchdog();
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
 		else if (!stall_cpu_block)
-- 
2.27.0


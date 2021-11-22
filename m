Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB8458794
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 02:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKVBES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:04:18 -0500
Received: from esa9.hc324-48.eu.iphmx.com ([207.54.69.27]:29422 "EHLO
        esa9.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhKVBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:04:17 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Nov 2021 20:04:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1637542872; x=1669078872;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=URFbXom1dj7OhCHoaW2n4W+dQGLADUtcgvohhdRZ+cE=;
  b=qbClOBBLyFh1MCs/fFaS/+U5V0PAhJdFbq856oaLBZvEC44Cjq0KnVkR
   McaPyb8pnLb6JvYNoViWQJF/EWtLm/+PSXEofyXAmSBefDgjZeEeVefUD
   qYFyu1A5uTL0Mo7T8S76cm3EDwseVHsSj0G2kMlF06fnHE1mJLTBbFXjs
   c=;
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa9.hc324-48.eu.iphmx.com with ESMTP/TLS; 22 Nov 2021 01:54:01 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw5.muc with ESMTP/TLS;
 22 Nov 2021 01:54:01 +0100
Received: from smucm08j.bmwgroup.net (HELO smucm08j.europe.bmw.corp) ([160.48.96.38])
 by esabb6.muc with ESMTP/TLS; 22 Nov 2021 01:54:01 +0100
Received: from cmucw916504.de-cci.bmwgroup.net (192.168.221.44) by
 smucm08j.europe.bmw.corp (160.48.96.38) with Microsoft SMTP Server (TLS;
 Mon, 22 Nov 2021 01:54:01 +0100
From:   Vladimir Divjak <vladimir.divjak@bmw.de>
To:     <vladimir.divjak@bmw.de>, <oleg@redhat.com>,
        <jnewsome@torproject.org>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>, <asml.silence@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>
Subject: [PATCH] ptrace: exit: re-trigger PTRACE_EVENT_EXIT after coredump finished
Date:   Mon, 22 Nov 2021 01:53:47 +0100
Message-ID: <20211122005347.1467288-1-vladimir.divjak@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCM28M.europe.bmw.corp (160.46.167.39) To
 smucm08j.europe.bmw.corp (160.48.96.38)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-trigger PTRACE_EVENT_EXIT
(if one is requested with PTRACE_SEIZE setting PTRACE_O_TRACEEXIT option)
for a process being core-dumped, after the coredump is finished.

This enables a potential tracer - coredump user mode helper
(or any other tracer started after the coredump was initiated)
to receive the PTRACE_EVENT_EXIT for all threads of the crashing process.

Rationale:

For zapped threads, PTRACE_EVENT_EXIT is triggered early during do_exit(),
before the point at which they sleep, waiting for
coredump to finish - in exit_mm(), and before a potential
coredump user mode helper process is launched.

That makes it impossible for the coredump user mode helper process to
receive PTRACE_EVENT_EXIT events for all threads of the crashing process,
except for the thread handling the core-dump, which will trigger
the PTRACE_EVENT_EXIT after the coredump has been finished.

Signed-off-by: Vladimir Divjak <vladimir.divjak@bmw.de>
---
 kernel/exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..0157507e75a2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -473,6 +473,13 @@ static void exit_mm(void)
 				break;
 			freezable_schedule();
 		}
+		/*
+		 * Re-trigger PTRACE_EVENT_EXIT for a process being core-dumped,
+		 * after the coredump finished (see above).
+		 * This enables the coredump user mode helper to receive PTRACE_EVENT_EXIT
+		 * for each thread of the dying process.
+		 */
+		ptrace_event(PTRACE_EVENT_EXIT, current->exit_code);
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
 	}
-- 
2.25.1


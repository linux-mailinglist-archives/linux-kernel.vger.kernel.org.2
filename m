Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9F43CE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhJ0QMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242917AbhJ0QM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8E860F6F;
        Wed, 27 Oct 2021 16:10:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV2-000xnn-KH;
        Wed, 27 Oct 2021 12:10:00 -0400
Message-ID: <20211027161000.463342789@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/15] test_kprobes: Move it from kernel/ to lib/
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Since config KPROBES_SANITY_TEST is in lib/Kconfig.debug, it is better to
let test_kprobes.c in lib/, just like other similar tests found in lib/.

Link: https://lkml.kernel.org/r/1635213091-24387-4-git-send-email-yangtiezhu@loongson.cn

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/Makefile                | 1 -
 lib/Makefile                   | 1 +
 {kernel => lib}/test_kprobes.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {kernel => lib}/test_kprobes.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..9e4d33dce8a5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -85,7 +85,6 @@ obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKHEADERS) += kheaders.o
 obj-$(CONFIG_SMP) += stop_machine.o
-obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tree.o
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37..864ff515814d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
+obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/kernel/test_kprobes.c b/lib/test_kprobes.c
similarity index 100%
rename from kernel/test_kprobes.c
rename to lib/test_kprobes.c
-- 
2.33.0

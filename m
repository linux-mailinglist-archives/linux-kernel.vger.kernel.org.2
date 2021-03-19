Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED883424E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCSSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925C86198F;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017mD-Kg; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.520578844@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 10/13] ftrace: Fix spelling mistake "disabed" -> "disabled"
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment, fix it.

Link: https://lkml.kernel.org/r/20210311094022.5978-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/kernel/probes/ftrace.c  | 2 +-
 arch/riscv/kernel/probes/ftrace.c | 2 +-
 arch/x86/kernel/kprobes/ftrace.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index ae2b1c7b3b5c..ef2bb9bd9605 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -9,7 +9,7 @@ int arch_check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+/* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index e6372490aa0b..c666e5ecb8da 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -2,7 +2,7 @@
 
 #include <linux/kprobes.h>
 
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+/* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *regs)
 {
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 373e5fa3ce1f..51c7f5271aee 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+/* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-- 
2.30.1



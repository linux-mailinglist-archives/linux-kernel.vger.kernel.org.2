Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D870336F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhCKJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:41:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52087 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhCKJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:40:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKHnq-0003Fh-7B; Thu, 11 Mar 2021 09:40:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix spelling mistake "disabed" -> "disabled"
Date:   Thu, 11 Mar 2021 09:40:22 +0000
Message-Id: <20210311094022.5978-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
index 2dfb33fdac74..17ca5e923bb0 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -2,7 +2,7 @@
 
 #include <linux/kprobes.h>
 
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+/* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
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
2.30.2


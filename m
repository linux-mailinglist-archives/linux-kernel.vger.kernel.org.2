Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB936B2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhDZMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:20:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhDZMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:20:43 -0400
Date:   Mon, 26 Apr 2021 09:01:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619439600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VS6H3nDKc8IgaGilf86Sm9ufKhSwqxIKTRT00ehTZac=;
        b=X8RdaWgMQiElHYFrTwOPdUysdQV79kPvW5e2yYGsTRBX7Q00JOblIQ/VBxdBSuLPKVQMP1
        oDUBh+Q5PY3AXYNgkYjgB9Uyj+vklhzA1ONtDCKKdtSm5PQFs9OXyBePxGk3g4vBYL0WjO
        FJxDuZvFnnjh4eHm9gxpHCeBdqp8BykiLNF0nDjS+i1KzwSCY7VGsoX6fdAkvxBp3s9gNy
        FKQg2gKGtzpQyoSy5MiB20wI2aaFymuq8cnPgbVV1SECIbfGiaKPItcdaqLGdyNdazqTNm
        LJT3rkdti/Zi1r/rPt/IfyuYpzJEee9IAS7rQusXRKTODzjciUs7FH7z5+zOmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619439600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VS6H3nDKc8IgaGilf86Sm9ufKhSwqxIKTRT00ehTZac=;
        b=qdKCCDKsCgtjUQ8VqH8YfQHlVIKMoVFSENtLEwArOxGlME2mePkWIkXXrBoSCI+e7coRGS
        +S9DZd950oUGQ8Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v5.13-rc1
Message-ID: <161942767665.31198.1640456275108441700.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2021-04-26

up to:  97258ce902d1: entry: Fix typos in comments

A trivial cleanup of typo fixes.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      entry: Fix typos in comments


 include/linux/entry-common.h | 4 ++--
 kernel/entry/common.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 883acef895bc..2e2b8d6140ed 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -360,7 +360,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  *
  * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
  * exit_to_user_mode(). This function is preferred unless there is a
- * compelling architectural reason to use the seperate functions.
+ * compelling architectural reason to use the separate functions.
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
@@ -381,7 +381,7 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  * irqentry_exit_to_user_mode - Interrupt exit work
  * @regs:	Pointer to current's pt_regs
  *
- * Invoked with interrupts disbled and fully valid regs. Returns with all
+ * Invoked with interrupts disabled and fully valid regs. Returns with all
  * work handled, interrupts disabled such that the caller can immediately
  * switch to user mode. Called from architecture specific interrupt
  * handling code.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8442e5c9cfa2..8d996dddf8b9 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -341,7 +341,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * Checking for rcu_is_watching() here would prevent the nesting
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
-	 * assume that it is the first interupt and eventually claim
+	 * assume that it is the first interrupt and eventually claim
 	 * quiescent state and end grace periods prematurely.
 	 *
 	 * Unconditionally invoke rcu_irq_enter() so RCU state stays


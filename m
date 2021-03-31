Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92A34FBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhCaIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:45:11 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57624 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCaIpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:45:07 -0400
Received: by sf.home (Postfix, from userid 1000)
        id E54155A22061; Wed, 31 Mar 2021 09:44:56 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-ia64@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>
Subject: [PATCH] ia64: fix user_stack_pointer() for ptrace()
Date:   Wed, 31 Mar 2021 09:44:47 +0100
Message-Id: <20210331084447.2561532-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 has two stacks:
- memory stack (or stack), pointed at by by r12
- register backing store (register stack), pointed at
  ar.bsp/ar.bspstore with complications around dirty
  register frame on CPU.

In https://bugs.gentoo.org/769614 Dmitry noticed that
PTRACE_GET_SYSCALL_INFO returns register stack instead
memory stack.

The bug comes from the fact that user_stack_pointer() and
current_user_stack_pointer() don't return the same register:

  ulong user_stack_pointer(struct pt_regs *regs) { return regs->ar_bspstore; }
  #define current_user_stack_pointer() (current_pt_regs()->r12)

The change gets both back in sync.

I think ptrace(PTRACE_GET_SYSCALL_INFO) is the only affected user
by this bug on ia64.

The change fixes 'rt_sigreturn.gen.test' strace test where
it was observed initially.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Oleg Nesterov <oleg@redhat.com>
CC: linux-ia64@vger.kernel.org
Bug: https://bugs.gentoo.org/769614
Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/include/asm/ptrace.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index b3aa46090101..08179135905c 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -54,8 +54,7 @@
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
-	/* FIXME: should this be bspstore + nr_dirty regs? */
-	return regs->ar_bspstore;
+	return regs->r12;
 }
 
 static inline int is_syscall_success(struct pt_regs *regs)
@@ -79,11 +78,6 @@ static inline long regs_return_value(struct pt_regs *regs)
 	unsigned long __ip = instruction_pointer(regs);			\
 	(__ip & ~3UL) + ((__ip & 3UL) << 2);				\
 })
-/*
- * Why not default?  Because user_stack_pointer() on ia64 gives register
- * stack backing store instead...
- */
-#define current_user_stack_pointer() (current_pt_regs()->r12)
 
   /* given a pointer to a task_struct, return the user's pt_regs */
 # define task_pt_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
-- 
2.31.1


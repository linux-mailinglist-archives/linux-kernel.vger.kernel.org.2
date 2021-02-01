Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048FC30AE61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhBARto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhBARs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=qbmtv5kMxjr5sVto3fd2gMkIfSOM4Z/5T7IHvqF0FVs=;
        b=U+p15RT9XYW10gIpqqSOP7P+AMkFf4uc0UnD8MAY1EKbkhLr356rkuP4gDGFLJ5clSKcQJ
        DZKsys369542jFcm4CNtRB3JpRPEq3vycKJnzzAnOOOKiOcBxGjcgfSJQEEW55CbqpTmG4
        g7kkemttA5+l//WW9gLC8ADyDiHbqsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-DiqtfmT9PfqNxI1CYIRxzA-1; Mon, 01 Feb 2021 12:47:26 -0500
X-MC-Unique: DiqtfmT9PfqNxI1CYIRxzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3936B800D62;
        Mon,  1 Feb 2021 17:47:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54AF56F971;
        Mon,  1 Feb 2021 17:47:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Feb 2021 18:47:24 +0100 (CET)
Date:   Mon, 1 Feb 2021 18:47:16 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v4 4/4] x86: introduce restart_block->arch_data to kill
Message-ID: <20210201174716.GA17898@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201174555.GA17819@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch x86 just saves current_thread_info()->status in the
new restart_block->arch_data field, TS_COMPAT_RESTART can be removed.

Rather than saving "status" we could shift the code from
get_nr_restart_syscall() to arch_set_restart_data() and save the syscall
number in ->arch_data.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/thread_info.h | 12 ++----------
 arch/x86/kernel/signal.c           |  2 +-
 include/linux/restart_block.h      |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 30d1d187019f..06b740bae431 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -217,18 +217,10 @@ static inline int arch_within_stack_frames(const void * const stack,
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
-#define TS_COMPAT_RESTART	0x0008
 
-#define arch_set_restart_data	arch_set_restart_data
+#define arch_set_restart_data(restart)	\
+	do { restart->arch_data = current_thread_info()->status; } while (0)
 
-static inline void arch_set_restart_data(struct restart_block *restart)
-{
-	struct thread_info *ti = current_thread_info();
-	if (ti->status & TS_COMPAT)
-		ti->status |= TS_COMPAT_RESTART;
-	else
-		ti->status &= ~TS_COMPAT_RESTART;
-}
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 6c26d2c3a2e4..f306e85a08a6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -767,7 +767,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
 {
 #ifdef CONFIG_IA32_EMULATION
-	if (current_thread_info()->status & TS_COMPAT_RESTART)
+	if (current->restart_block.arch_data & TS_COMPAT)
 		return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920e9c05..980a65594412 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -23,6 +23,7 @@ enum timespec_type {
  * System call restart block.
  */
 struct restart_block {
+	unsigned long arch_data;
 	long (*fn)(struct restart_block *);
 	union {
 		/* For futex_wait and futex_wait_requeue_pi */
-- 
2.25.1.362.g51ebf55


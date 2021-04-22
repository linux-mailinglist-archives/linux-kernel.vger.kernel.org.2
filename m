Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53345367FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhDVMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhDVMCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F2E061450;
        Thu, 22 Apr 2021 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092927;
        bh=C6y1/7eO/16KsPWRmwyMX9yPizdRZz7an8PRE8nlY2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nwb39BYO3fuNC/SIA+ZOT4unQwGXqx6nELGRvoOHK5LnbZFL36csdnfSirgXSx2y/
         l3bucsLi2Lv6hY18V9aHHP630qPXv/ObY4OZwGnc8bHD7fbxeQg3Pcp+7/6nQIyOAg
         +pBbL0KN5vQt/wgRWYq+5wlVZD+ZVHsTUSmCpM68VYkEPNPxUw6pItr1av2w6q9UjK
         294UPz1edQ5qbOIVs6RQBYWvyjae32T+zNLrKgT+Nt4yHgOt96gaD9ibXZRMCLaVBG
         8UP6QhTOfm1fOpX19P2A+Xj27M4LwWqI6cPgAM6hMdUBHKK6vOQFQdk87uzsvKYkVF
         3lnhL4ELh4DFA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/8] tick/nohz: Evaluate the CPU expression after the static key
Date:   Thu, 22 Apr 2021 14:01:51 +0200
Message-Id: <20210422120158.33629-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
References: <20210422120158.33629-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When tick_nohz_full_cpu() is called with smp_processor_id(), the latter
is unconditionally evaluated whether the static key is on or off. It is
not necessary in the off-case though, so make sure the cpu expression
is executed at the last moment.

Illustrate with the following test function:

	int tick_nohz_test(void)
	{
		return tick_nohz_full_cpu(smp_processor_id());
	}

The resulting code before was:

	mov    %gs:0x7eea92d1(%rip),%eax   # smp_processor_id() fetch
	nopl   0x0(%rax,%rax,1)
	xor    %eax,%eax
	retq
	cmpb   $0x0,0x29d393a(%rip)        # <tick_nohz_full_running>
	je     tick_nohz_test+0x29         # jump to below eax clear
	mov    %eax,%eax
	bt     %rax,0x29d3936(%rip)        # <tick_nohz_full_mask>
	setb   %al
	movzbl %al,%eax
	retq
	xor    %eax,%eax
	retq

Now it becomes:

	nopl   0x0(%rax,%rax,1)
	xor    %eax,%eax
	retq
	cmpb   $0x0,0x29d3871(%rip)        # <tick_nohz_full_running>
	je     tick_nohz_test+0x29         # jump to below eax clear
	mov    %gs:0x7eea91f0(%rip),%eax   # smp_processor_id() fetch, after static key
	mov    %eax,%eax
	bt     %rax,0x29d3866(%rip)        # <tick_nohz_full_mask>
	setb   %al
	movzbl %al,%eax
	retq
	xor    %eax,%eax
	retq

Not-Yet-Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..2258984a0e8a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -185,13 +185,17 @@ static inline bool tick_nohz_full_enabled(void)
 	return tick_nohz_full_running;
 }
 
-static inline bool tick_nohz_full_cpu(int cpu)
-{
-	if (!tick_nohz_full_enabled())
-		return false;
-
-	return cpumask_test_cpu(cpu, tick_nohz_full_mask);
-}
+/*
+ * Check if a CPU is part of the nohz_full subset. Arrange for evaluating
+ * the cpu expression (typically smp_processor_id()) _after_ the static
+ * key.
+ */
+#define tick_nohz_full_cpu(_cpu) ({					\
+	bool __ret = false;						\
+	if (tick_nohz_full_enabled())					\
+		__ret = cpumask_test_cpu((_cpu), tick_nohz_full_mask);	\
+	__ret;								\
+})
 
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
 {
-- 
2.25.1


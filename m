Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6F459199
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhKVPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhKVPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:50:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F15C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:47:18 -0800 (PST)
Date:   Mon, 22 Nov 2021 16:47:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637596035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BEoYoKO1FJBa2ukBy23+bj3uF+7X+WvM0sv+jH9o6GY=;
        b=ZUGKHWh5Cws9FzM8WnZZFWuVIu10DS5k+RyUyJTEhFaLzhPDt5yVuREv+l1mAFo5M7/CEz
        9eDTJWLD6aqbgRfzOys8i6Mzlx6LiHKBTufdSTpRFiXd/qFi+rk0m7aHKUNgl+5CTgE9HI
        rPYlXwLn3O6kCXtmiBCJLh80NdbUqhNVIrnbGZWHZH1Ge8qSRma/zH4+kXdubMD26xHV1H
        3TZ9t7bmyf/7xRdSyObEd/20CemC56TGdkaLf7+Ubav8SH0fcT2KKCyeC5omjwpYBM644D
        /uVPDsWTQmuo1XUEeAL/uLFjyCblJ57kMDNx6JG0kZ8DJp0S/53eBMWD4TtULg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637596035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BEoYoKO1FJBa2ukBy23+bj3uF+7X+WvM0sv+jH9o6GY=;
        b=let+1knIfa2gh2XASxf6daDfL3UJiKCPCwp+ezq0bLm721yygvSfMZN5U8VWQPHhd/OyFg
        AV4vqOpn+gw4mXCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be
 brought up again.
Message-ID: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Longpeng(Mike)" <longpeng2@huawei.com>

A CPU will not show up in virtualized environment which includes an
Enclave. The VM splits its resources into a primary VM and a Enclave
VM. While the Enclave is active, the hypervisor will ignore all requests
to bring up a CPU and this CPU will remain in CPU_UP_PREPARE state.
The kernel will wait up to ten seconds for CPU to show up
(do_boot_cpu()) and then rollback the hotplug state back to
CPUHP_OFFLINE leaving the CPU state in CPU_UP_PREPARE. The CPU state is
set back to CPUHP_TEARDOWN_CPU during the CPU_POST_DEAD stage.

After the Enclave VM terminates, the primary VM can bring up the CPU
again.

Allow to bring up the CPU if it is in the CPU_UP_PREPARE state.

[bigeasy: Rewrite commit description.]

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20210901051143.2752-1-longpeng2@huawei.com
---

For XEN: this changes the behaviour as it allows to invoke
cpu_initialize_context() again should it have have earlier. I *think*
this is okay and would to bring up the CPU again should the memory
allocation in cpu_initialize_context() fail.

 kernel/smpboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f6bc0bc8a2aab..34958d7fe2c1c 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
 		 */
 		return -EAGAIN;
 
+	case CPU_UP_PREPARE:
+		/*
+		 * Timeout while waiting for the CPU to show up. Allow to try
+		 * again later.
+		 */
+		return 0;
+
 	default:
 
 		/* Should not happen.  Famous last words. */
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918EF30A5AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBAKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBAKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C5C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=2smyfKVoai3U4EmpJ8TNJaR4I3J/o5vdDXVNyfOdkuk=; b=Q/lGILmA4B/iex6Ho3mk69LcRX
        g3t2tIIjT/NQrjNbY+SWUtSjFWAnXC2gf6PbHrsUFyAKn7Smke9/RwiRsP/umSM18hb+pYL0er/aj
        X4wl0WLUZlPCyrC7JeKYHFEkCmrhHshxbncn1a/NTGCP9bya4GvFj5Suh2TZwtpwF9+XnfcJ0Lnt7
        Sc0roG4MVt5DRX2P7Rcp+LOapDamBKJyRWIjHBlCoOB/Q+5lII8MdfjIGSkFUr70nWanInkkCSsta
        6OO9hE7gwWjQNQryBF96xzFs1z96T/P6q9n7PYSGIiTUWTDOiQxNH8Z9zZ10o8o+YeMz8ajQwv68d
        FC/aTrBg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6WbL-00Deoy-La; Mon, 01 Feb 2021 10:38:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6WbL-004NPT-5F; Mon, 01 Feb 2021 10:38:35 +0000
From:   David Woodhouse <dwmw@amazon.co.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>, mimoja@amazon.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: [PATCH 2/6] cpu/hotplug: Add dynamic states before CPUHP_BRINGUP_CPU for parallel bringup
Date:   Mon,  1 Feb 2021 10:38:31 +0000
Message-Id: <20210201103835.1043254-2-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201103835.1043254-1-dwmw@amazon.co.uk>
References: <478c56af540eaa47b8f452e51cb0c085f26db738.camel@infradead.org>
 <20210201103835.1043254-1-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the platform registers these states, bring all CPUs to each registered
state in parallel, before the final bringup to CPUHP_BRINGUP_CPU.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/cpuhotplug.h |  2 ++
 kernel/cpu.c               | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0042ef362511..ae07cd1dafe3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -92,6 +92,8 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_PARALLEL_DYN,
+	CPUHP_BP_PARALLEL_DYN_END		= CPUHP_BP_PARALLEL_DYN + 4,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91010e1..11f9504b4845 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1335,6 +1335,24 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
 	unsigned int cpu;
+	int n = setup_max_cpus - num_online_cpus();
+
+	/* ∀ parallel pre-bringup state, bring N CPUs to it */
+	if (n > 0) {
+		enum cpuhp_state st = CPUHP_BP_PARALLEL_DYN;
+
+		while (st <= CPUHP_BP_PARALLEL_DYN_END &&
+		       cpuhp_hp_states[st].name) {
+			int i = n;
+
+			for_each_present_cpu(cpu) {
+				cpu_up(cpu, st);
+				if (!--i)
+					break;
+			}
+			st++;
+		}
+	}
 
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >= setup_max_cpus)
@@ -1702,6 +1720,10 @@ static int cpuhp_reserve_state(enum cpuhp_state state)
 		step = cpuhp_hp_states + CPUHP_BP_PREPARE_DYN;
 		end = CPUHP_BP_PREPARE_DYN_END;
 		break;
+	case CPUHP_BP_PARALLEL_DYN:
+		step = cpuhp_hp_states + CPUHP_BP_PARALLEL_DYN;
+		end = CPUHP_BP_PARALLEL_DYN_END;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1726,14 +1748,15 @@ static int cpuhp_store_callbacks(enum cpuhp_state state, const char *name,
 	/*
 	 * If name is NULL, then the state gets removed.
 	 *
-	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_PREPARE_DYN are handed out on
+	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_xxxxx_DYN are handed out on
 	 * the first allocation from these dynamic ranges, so the removal
 	 * would trigger a new allocation and clear the wrong (already
 	 * empty) state, leaving the callbacks of the to be cleared state
 	 * dangling, which causes wreckage on the next hotplug operation.
 	 */
 	if (name && (state == CPUHP_AP_ONLINE_DYN ||
-		     state == CPUHP_BP_PREPARE_DYN)) {
+		     state == CPUHP_BP_PREPARE_DYN ||
+		     state == CPUHP_BP_PARALLEL_DYN)) {
 		ret = cpuhp_reserve_state(state);
 		if (ret < 0)
 			return ret;
-- 
2.29.2


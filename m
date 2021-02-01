Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0030A5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhBAKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhBAKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF9C061353
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cckpZjyejCCA13sUlZDGZnTckF5vDCuYuXSjmMC9Br0=; b=NXofwusQT4WzM2N/CycgGJKr2B
        tJ5AQlaANw72wb9C9yXyB2oteWCJO3Qr22RkdesOfDZ9kJhswqzkmCoTdUyVbStHMYm6ucaUXgk+u
        HGYaw7AQduI7CJasCQ0zQf/rknStQi+mBk+4IQTOXffF0iZiWNUQuOhbySN1LA27NgzEhE9URG9vB
        3jWxiE4ikLO6w7ekjxOrvsEZpTeth59bFnhJeDjTil/xWkXeuF/9GN5V4MajkcAeqti0Dw0z5NDWf
        a7jAf0Hp0sD3PW4dP101EsuVxtbkjeFXb1Pm3yo4KOXBxXIvmrlwvjK9XlBfCTD72nOFIsHf9cQFx
        iXdRJ88g==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6WbL-00Deow-LX; Mon, 01 Feb 2021 10:38:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6WbL-004NPb-8R; Mon, 01 Feb 2021 10:38:35 +0000
From:   David Woodhouse <dwmw@amazon.co.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>, mimoja@amazon.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: [PATCH 6/6] pre states for x86
Date:   Mon,  1 Feb 2021 10:38:35 +0000
Message-Id: <20210201103835.1043254-6-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201103835.1043254-1-dwmw@amazon.co.uk>
References: <478c56af540eaa47b8f452e51cb0c085f26db738.camel@infradead.org>
 <20210201103835.1043254-1-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utterly broken because the bringup uses global initial_stack and initial_gs
variables, and the TSC sync is similarly hosed (I should probably do one
at a time).

The bringup is going to be the most fun to fix, because the AP coming up
doesn't actually have a lot that it *can* use to disambiguate itself from
the others. Starting them at different locations is mostly a non-starter
as we can only specify a page address under 1MiB and there are only 256
of those even if we could allocate them *all* to start different CPUs.
I think we need to get them to find their own logical CPU# from their
APICID, perhaps by trawling the per_cpu x86_cpu_to_apicid or some other
means, then find their initial stack / %gs from that.

We also need to work out if we can eliminate the real-mode stack for the
trampoline, or do some locking if we really must share it perhaps.
---
 arch/x86/kernel/smpboot.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 649b8236309b..03f63027fdad 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/syscore_ops.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1217,14 +1218,6 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
 
-	ret = do_cpu_up(cpu, tidle);
-	if (ret)
-		return ret;
-
-	ret = do_wait_cpu_initialized(cpu);
-	if (ret)
-		return ret;
-
 	ret = do_wait_cpu_callin(cpu);
 	if (ret)
 		return ret;
@@ -1241,6 +1234,16 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return ret;
 }
 
+int native_cpu_kick(unsigned int cpu)
+{
+	return do_cpu_up(cpu, idle_thread_get(cpu));
+}
+
+int native_cpu_wait_init(unsigned int cpu)
+{
+	return do_wait_cpu_initialized(cpu);
+}
+
 /**
  * arch_disable_smp_support() - disables SMP support for x86 at runtime
  */
@@ -1412,6 +1415,11 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+				  native_cpu_kick, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:wait-init",
+				  native_cpu_wait_init, NULL);
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.29.2


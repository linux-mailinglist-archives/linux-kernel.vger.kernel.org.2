Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE47334103
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCJPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCJPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:01:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE32C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4Qu6L16d5rUeQmlWF3IZnckm+1WxAKwtXBX6+IrqLhA=; b=DO+gREjfYIj0NK+qrKrxgDpwYm
        V4oPcP01AJhCKfJThvH/ae2niEhG0P/amFTll8qFPolCquZ/ofi6AuEz3G7GdcWtxRNjBYIT+1ty7
        n/+wNYBcoMyEdrijYYN2W3fNJVzCKzGp08t8h60rP8j1uV9EzUIXY9uIWo4lXit9EN65pPDm8edb6
        YCbQVnMFLOjISYNm6JKwp4b14SUfPl22u/VEoYDK9qbbgzXSaZWysBWwtJh102F4ZCwMyZnMuOvuM
        hLkpV4b4UZEggdvWqx525YTFwmDis325o2kAj9GMZtnvBNpq9FePFEYJy7u8kVy2QjTn3aMUQK+Nm
        X+CQ8Qtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK0LF-0074ax-LN; Wed, 10 Mar 2021 15:01:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1236E3011F0;
        Wed, 10 Mar 2021 16:01:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F078421ADDC01; Wed, 10 Mar 2021 16:01:40 +0100 (CET)
Message-ID: <20210310150109.045447765@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Mar 2021 15:52:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/3] cpumask: Make cpu_{online,possible,present,active}() inline
References: <20210310145258.899619710@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for addition of another mask. Primarily a code movement to
avoid having to create more #ifdef, but while there, convert
everything with an argument to an inline function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpumask.h |   97 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 31 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -98,37 +98,6 @@ extern struct cpumask __cpu_active_mask;
 
 extern atomic_t __num_online_cpus;
 
-#if NR_CPUS > 1
-/**
- * num_online_cpus() - Read the number of online CPUs
- *
- * Despite the fact that __num_online_cpus is of type atomic_t, this
- * interface gives only a momentary snapshot and is not protected against
- * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
- * region.
- */
-static inline unsigned int num_online_cpus(void)
-{
-	return atomic_read(&__num_online_cpus);
-}
-#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
-#define num_present_cpus()	cpumask_weight(cpu_present_mask)
-#define num_active_cpus()	cpumask_weight(cpu_active_mask)
-#define cpu_online(cpu)		cpumask_test_cpu((cpu), cpu_online_mask)
-#define cpu_possible(cpu)	cpumask_test_cpu((cpu), cpu_possible_mask)
-#define cpu_present(cpu)	cpumask_test_cpu((cpu), cpu_present_mask)
-#define cpu_active(cpu)		cpumask_test_cpu((cpu), cpu_active_mask)
-#else
-#define num_online_cpus()	1U
-#define num_possible_cpus()	1U
-#define num_present_cpus()	1U
-#define num_active_cpus()	1U
-#define cpu_online(cpu)		((cpu) == 0)
-#define cpu_possible(cpu)	((cpu) == 0)
-#define cpu_present(cpu)	((cpu) == 0)
-#define cpu_active(cpu)		((cpu) == 0)
-#endif
-
 extern cpumask_t cpus_booted_once_mask;
 
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
@@ -894,6 +863,72 @@ static inline const struct cpumask *get_
 	return to_cpumask(p);
 }
 
+#if NR_CPUS > 1
+/**
+ * num_online_cpus() - Read the number of online CPUs
+ *
+ * Despite the fact that __num_online_cpus is of type atomic_t, this
+ * interface gives only a momentary snapshot and is not protected against
+ * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
+ * region.
+ */
+static inline unsigned int num_online_cpus(void)
+{
+	return atomic_read(&__num_online_cpus);
+}
+#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+#define num_present_cpus()	cpumask_weight(cpu_present_mask)
+#define num_active_cpus()	cpumask_weight(cpu_active_mask)
+
+static inline bool cpu_online(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_online_mask);
+}
+
+static inline bool cpu_possible(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_possible_mask);
+}
+
+static inline bool cpu_present(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_present_mask);
+}
+
+static inline bool cpu_active(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_active_mask);
+}
+
+#else
+
+#define num_online_cpus()	1U
+#define num_possible_cpus()	1U
+#define num_present_cpus()	1U
+#define num_active_cpus()	1U
+
+static inline bool cpu_online(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_possible(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_present(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_active(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+#endif /* NR_CPUS > 1 */
+
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
 
 #if NR_CPUS <= BITS_PER_LONG



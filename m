Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68D4334105
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhCJPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhCJPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:01:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E264C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=G++WuZlc94CXytRJI/NGHZDhvufz+ulSBA/S3u8lMyA=; b=YXBpvm0Pznr2+boTiwEPbsf6yH
        gngIXUKBkgMqMQ9fCll3HeSWZFDKCP4XjxVLhNKtVtVYXB9EQkuIynsLUUVMcli6psGY60mYqDInD
        sPl9yFR495kxVqTRZ5EHI/eoOpDsfoXBsTmxsOycY+mfq7EGl/1Puyx5psocZTEHAJqU9oaIfisBm
        I+kr/7tVUi0N34jeD7L5NQvRp21igaIEfSCNwQMoRGXWZ8Y7nJ3hib8Hj1aOG/CfLhEUBgcyalfhk
        AXvFqYQMCXC8BAp3dpr44DNtsN79alwkOu9ugjHPx57H3JBr0yZKJaaXJqXhzL3lxTstRfWvKPfr0
        QqRzoYnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK0LF-0074aw-Kr; Wed, 10 Mar 2021 15:01:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3631F3059C0;
        Wed, 10 Mar 2021 16:01:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F2A9A287167A8; Wed, 10 Mar 2021 16:01:40 +0100 (CET)
Message-ID: <20210310150109.151441252@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Mar 2021 15:53:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/3] cpumask: Introduce DYING mask
References: <20210310145258.899619710@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a cpumask that indicates (for each CPU) what direction the
CPU hotplug is currently going. Notably, it tracks rollbacks. Eg. when
an up fails and we do a roll-back down, it will accurately reflect the
direction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpumask.h |   20 ++++++++++++++++++++
 kernel/cpu.c            |    6 ++++++
 2 files changed, 26 insertions(+)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -91,10 +91,12 @@ extern struct cpumask __cpu_possible_mas
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
+extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
+#define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -826,6 +828,14 @@ set_cpu_active(unsigned int cpu, bool ac
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
+static inline void
+set_cpu_dying(unsigned int cpu, bool dying)
+{
+	if (dying)
+		cpumask_set_cpu(cpu, &__cpu_dying_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
+}
 
 /**
  * to_cpumask - convert an NR_CPUS bitmap to a struct cpumask *
@@ -900,6 +910,11 @@ static inline bool cpu_active(unsigned i
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
+static inline bool cpu_dying(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_dying_mask);
+}
+
 #else
 
 #define num_online_cpus()	1U
@@ -927,6 +942,11 @@ static inline bool cpu_active(unsigned i
 	return cpu == 0;
 }
 
+static inline bool cpu_dying(unsigned int cpu)
+{
+	return false;
+}
+
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigne
 	int (*cb)(unsigned int cpu);
 	int ret, cnt;
 
+	if (bringup != !cpu_dying(cpu))
+		set_cpu_dying(cpu, !bringup);
+
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
 		return -EAGAIN;
@@ -2512,6 +2515,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+struct cpumask __cpu_dying_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_dying_mask);
+
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 



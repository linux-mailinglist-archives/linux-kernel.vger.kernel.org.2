Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651FB44B9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhKJBZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhKJBZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:25:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4BC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:22:57 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b68so1090590pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXi0+HXv1ZcM85XLut5g4f5koCKW+8lc/+zDpXbKQKo=;
        b=TpDJ2VhU/wIwYlQhROAYLUqYUm4x2AGB/4Bl8Prtpwzs4s6ee91Zc2s90yfFLrhGuJ
         PYXFF5cE31KgwAR5Os007xTsddj0F863l8MtUC5GNdPppeXOAnb8drPHN37rvtHbYfDD
         U+Kb7F/NpgQ5AgscUEqfD6D6R1OpG6nM2qMlkr6mtdl+eb24IVIdUiIICIutX1tFicbN
         /TPSAFA6A/ea+d07WZUp9TK9Eu8f/a1c0cURXwhzjzIueKGRfD5Xr5f9VcguFiBjErjK
         BlNBXSzmvjjHBNmK6WfuDGCxAmsQnfWXbCtKK+h2f3tndKLNlOOJhMrgAer3CaPPUQJz
         UAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXi0+HXv1ZcM85XLut5g4f5koCKW+8lc/+zDpXbKQKo=;
        b=XCXW5/y9ceoy4esIhL5gqZCgaMWtJcyFJSiDYUxGc2O2WOvHvu7c6mAEKL3o6MwZp+
         M/PRqKr5CfcmViCCbd/wOe3PrrTFagr9SHSwnkcj40Fq7ESYqhiujsjL+UPjD+Pw8jlB
         cBcFadkwvXQvk+MzgGjHPxihS0i34i4io4IOFYBs9S2qUeEHUb02Yl2GafMkiyzSQDIA
         c+5C73JdP80dOES49zRYOXTU7kXcGbI2ODDIWSZIHA69c2hFoVCDbb/80aKqIFKhVYty
         rGyRCc2i0jA/y2YQAhrKW5DMslmK8FWCCSHM0fjspZlwx/OFUFqGmhMFBvm92xDQYS3j
         tIDQ==
X-Gm-Message-State: AOAM532qkvh6az2jUqP1s8o9AGkUX/rpwBXKs/zO00go29w/O7k6cW3E
        mWtaWDjNJH0Ee5sTDzHZO/U=
X-Google-Smtp-Source: ABdhPJzvPNN3hbK+RACQTDwlfzzifuYyyQ02gLDS/4qe1IJmepkk7vy2q/KOvbKSGlDW9/6DJNaMcQ==
X-Received: by 2002:a63:720d:: with SMTP id n13mr9375256pgc.470.1636507377082;
        Tue, 09 Nov 2021 17:22:57 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:362:8fd3:5950:cf6d])
        by smtp.gmail.com with ESMTPSA id h2sm3614037pjk.44.2021.11.09.17.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:22:56 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 2/2] jump_label: refine placement of static_keys
Date:   Tue,  9 Nov 2021 17:09:06 -0800
Message-Id: <20211110010906.1923210-3-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211110010906.1923210-1-eric.dumazet@gmail.com>
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
used for the control path.

Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
Otherwise we place them out of the way to increase data locality.

This patch adds __static_key to centralize this new policy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/kvm/lapic.c       |  4 ++--
 arch/x86/kvm/x86.c         |  2 +-
 include/linux/jump_label.h | 25 +++++++++++++++++--------
 kernel/events/core.c       |  2 +-
 kernel/sched/fair.c        |  2 +-
 net/core/dev.c             |  8 ++++----
 net/netfilter/core.c       |  2 +-
 net/netfilter/x_tables.c   |  2 +-
 8 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d6ac32f3f650c066733ff9afe96ece36bca01523..a4e8ec38cd09aca2969e71242bced1d95e9e9c1f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -91,8 +91,8 @@ static inline int __apic_test_and_clear_vector(int vec, void *bitmap)
 	return __test_and_clear_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
 }
 
-__read_mostly DEFINE_STATIC_KEY_DEFERRED_FALSE(apic_hw_disabled, HZ);
-__read_mostly DEFINE_STATIC_KEY_DEFERRED_FALSE(apic_sw_disabled, HZ);
+DEFINE_STATIC_KEY_DEFERRED_FALSE(apic_hw_disabled, HZ);
+DEFINE_STATIC_KEY_DEFERRED_FALSE(apic_sw_disabled, HZ);
 
 static inline int apic_enabled(struct kvm_lapic *apic)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c1c4e2b05a63abd53e01d0671f740a3b900d98e6..051236fedee39e197d6795fc62bdb29849c7ada2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11204,7 +11204,7 @@ bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu)
 	return (vcpu->arch.apic_base & MSR_IA32_APICBASE_BSP) != 0;
 }
 
-__read_mostly DEFINE_STATIC_KEY_FALSE(kvm_has_noapic_vcpu);
+DEFINE_STATIC_KEY_FALSE(kvm_has_noapic_vcpu);
 EXPORT_SYMBOL_GPL(kvm_has_noapic_vcpu);
 
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 48b9b2a82767d74ec95f102ab1470f5fa79cc97d..13ad61a845a30a91c9f18eabff7ff93cac4028e2 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -106,10 +106,19 @@ struct static_key {
 	};
 };
 
+/*
+ * With CONFIG_JUMP_LABEL, "struct static_key" are not used in fast path.
+ * We can put them in a separate section to increase data locality.
+ */
+#define __static_key __section(".data.unlikely")
+
 #else
 struct static_key {
 	atomic_t enabled;
 };
+
+#define __static_key __read_mostly
+
 #endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
@@ -367,7 +376,7 @@ struct static_key_false {
 #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
 
 #define DEFINE_STATIC_KEY_TRUE(name)	\
-	struct static_key_true name = STATIC_KEY_TRUE_INIT
+	struct static_key_true __static_key name = STATIC_KEY_TRUE_INIT
 
 #define DEFINE_STATIC_KEY_TRUE_RO(name)	\
 	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
@@ -376,7 +385,7 @@ struct static_key_false {
 	extern struct static_key_true name
 
 #define DEFINE_STATIC_KEY_FALSE(name)	\
-	struct static_key_false name = STATIC_KEY_FALSE_INIT
+	struct static_key_false __static_key name = STATIC_KEY_FALSE_INIT
 
 #define DEFINE_STATIC_KEY_FALSE_RO(name)	\
 	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
@@ -384,14 +393,14 @@ struct static_key_false {
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
 
-#define DEFINE_STATIC_KEY_ARRAY_TRUE(name, count)		\
-	struct static_key_true name[count] = {			\
-		[0 ... (count) - 1] = STATIC_KEY_TRUE_INIT,	\
+#define DEFINE_STATIC_KEY_ARRAY_TRUE(name, count)			\
+	struct static_key_true __static_key name[count] = {	\
+		[0 ... (count) - 1] = STATIC_KEY_TRUE_INIT,		\
 	}
 
-#define DEFINE_STATIC_KEY_ARRAY_FALSE(name, count)		\
-	struct static_key_false name[count] = {			\
-		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
+#define DEFINE_STATIC_KEY_ARRAY_FALSE(name, count)			\
+	struct static_key_false __static_key name[count] = {	\
+		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,		\
 	}
 
 #define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2253ea729a2732b0261f32280f77f1d1a2ebefb..5cd140b3a489bb51c2536bd5f869290bf8395e7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9600,7 +9600,7 @@ static int swevent_hlist_get(void)
 	return err;
 }
 
-struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
+struct static_key __static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
 static void sw_perf_event_destroy(struct perf_event *event)
 {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13950beb01a251bfb65bf5b75952e3dea9cbc62b..de9b18a244cadd3b47a2ec4ed4c000a034a7fb96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4586,7 +4586,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 #ifdef CONFIG_CFS_BANDWIDTH
 
 #ifdef CONFIG_JUMP_LABEL
-static struct static_key __cfs_bandwidth_used;
+static struct static_key __static_key __cfs_bandwidth_used;
 
 static inline bool cfs_bandwidth_used(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index edeb811c454e6caf4298aae723237aea2c363c3c..21d53ca2730d1abb5dc3103ccca053e1cdf676b7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2390,8 +2390,8 @@ int netdev_txq_to_tc(struct net_device *dev, unsigned int txq)
 EXPORT_SYMBOL(netdev_txq_to_tc);
 
 #ifdef CONFIG_XPS
-static struct static_key xps_needed __read_mostly;
-static struct static_key xps_rxqs_needed __read_mostly;
+static struct static_key __static_key xps_needed;
+static struct static_key __static_key xps_rxqs_needed;
 static DEFINE_MUTEX(xps_map_mutex);
 #define xmap_dereference(P)		\
 	rcu_dereference_protected((P), lockdep_is_held(&xps_map_mutex))
@@ -4362,9 +4362,9 @@ EXPORT_SYMBOL(rps_sock_flow_table);
 u32 rps_cpu_mask __read_mostly;
 EXPORT_SYMBOL(rps_cpu_mask);
 
-struct static_key_false rps_needed __read_mostly;
+struct static_key_false __static_key rps_needed;
 EXPORT_SYMBOL(rps_needed);
-struct static_key_false rfs_needed __read_mostly;
+struct static_key_false __static_key rfs_needed;
 EXPORT_SYMBOL(rfs_needed);
 
 static struct rps_dev_flow *
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 6dec9cd395f1570c845346b6956ba2586a4235d6..3fd26326a55d95c28ab634eb3caf5a4a851ad20c 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -35,7 +35,7 @@ DEFINE_PER_CPU(bool, nf_skb_duplicated);
 EXPORT_SYMBOL_GPL(nf_skb_duplicated);
 
 #ifdef CONFIG_JUMP_LABEL
-struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
+struct static_key __static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 EXPORT_SYMBOL(nf_hooks_needed);
 #endif
 
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 25524e3933496098f68748286e56839454ee842c..aaf78481b04a0decaa09b03b9f69fa3737740cf4 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1319,7 +1319,7 @@ EXPORT_SYMBOL_GPL(xt_compat_unlock);
 DEFINE_PER_CPU(seqcount_t, xt_recseq);
 EXPORT_PER_CPU_SYMBOL_GPL(xt_recseq);
 
-struct static_key xt_tee_enabled __read_mostly;
+struct static_key __static_key xt_tee_enabled;
 EXPORT_SYMBOL_GPL(xt_tee_enabled);
 
 static int xt_jumpstack_alloc(struct xt_table_info *i)
-- 
2.34.0.rc0.344.g81b53c2807-goog


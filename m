Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06033462B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhCJR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhCJR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:59:08 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:08 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id x9so8246857wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4EIGP2sevMQZpUEhabq0vC76HCNx6QyIyPvKeAoptlw=;
        b=IUQjACmevhkq9a+GZxx+Ua4aB9ez1Bug28fxYTbFk46qxQU32oTjX7DRLGH9l/Il7X
         FqP7G7yyiuLPnHPSwII8NLcc8xT3okF4VsOdVhhzD45KhzQKh06Ri+jitNWpfqbLNjbH
         s7lNBTP16IEnv0g+B92roDljctBUXo4JJN1l3q5jmxXNKvjrw4EX2MUG2YyqiyXTFc0v
         efw7ExzmKbpVMP1Qf7AqwLiKwmBN9zmwUKW/Xurj/d027vYb3d6dQtC+WGD06I7JSB1Y
         AFj0gkGVkEn9NnTYZK0YUmw6ye4NL3Qrs3yQ4hcfmWyjyO/wYe696C31It5TCXguX2XH
         NObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4EIGP2sevMQZpUEhabq0vC76HCNx6QyIyPvKeAoptlw=;
        b=celkuI1fWWavWetUTAOTAoycDN8qA/wc5sKdBFIPrCRxIgqZcFWpeqvhI7BVJ8Lujd
         pN23hrBwzdETxj0eT0hr7f0knDs4a+wYk+5VdK6EZ1fo8awXXDStcs8RxaqHppBiMgS3
         gEzooOIn8OHh7porkCOawwM03788zNkbcW8Qmn5ovA9uAcmEHl1QBHSfAtPfEOLcZhQ1
         1PQLWdQ3xslXabxvRWZzp1Mc0SOUD+2Q2QCJDjb8FA5DFIguPVDmYr9fCsslBXwvdX3x
         8sABxRyrAHB83gI6S3sJYFAys9+eVUXjqo2AS75XLkc1PUcMmy7/8A1E0/RD+RfUTnht
         FuNA==
X-Gm-Message-State: AOAM5305Uh4cqc9ouu44ZxVOi0s9ba7aOq+tOfI0JN750MKb2RetUhL/
        1kA7IIpbyTablNfPFFaaQI9jO4lNQq/g
X-Google-Smtp-Source: ABdhPJxqMXK+TnYtjOGnCmi+0PPkd0E3rU72V4cOYCFhyuU5o0IeGdkRrDs5euTQUF4Pwmy1O7cEd08Y9MWQ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6000:1803:: with SMTP id
 m3mr4806187wrh.50.1615399147126; Wed, 10 Mar 2021 09:59:07 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:50 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-34-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 33/34] KVM: arm64: Disable PMU support in protected mode
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host currently writes directly in EL2 per-CPU data sections from
the PMU code when running in nVHE. In preparation for unmapping the EL2
sections from the host stage 2, disable PMU support in protected mode as
we currently do not have a use-case for it.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/perf.c | 3 ++-
 arch/arm64/kvm/pmu.c  | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 739164324afe..8f860ae56bb7 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -55,7 +55,8 @@ int kvm_perf_init(void)
 	 * hardware performance counters. This could ensure the presence of
 	 * a physical PMU and CONFIG_PERF_EVENT is selected.
 	 */
-	if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
+	if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0
+				       && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
 	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index faf32a44ba04..03a6c1f4a09a 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -33,7 +33,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp_sym(kvm_host_data);
 
-	if (!ctx || !kvm_pmu_switch_needed(attr))
+	if (!kvm_arm_support_pmu_v3() || !ctx || !kvm_pmu_switch_needed(attr))
 		return;
 
 	if (!attr->exclude_host)
@@ -49,7 +49,7 @@ void kvm_clr_pmu_events(u32 clr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp_sym(kvm_host_data);
 
-	if (!ctx)
+	if (!kvm_arm_support_pmu_v3() || !ctx)
 		return;
 
 	ctx->pmu_events.events_host &= ~clr;
@@ -172,7 +172,7 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
 	struct kvm_host_data *host;
 	u32 events_guest, events_host;
 
-	if (!has_vhe())
+	if (!kvm_arm_support_pmu_v3() || !has_vhe())
 		return;
 
 	preempt_disable();
@@ -193,7 +193,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
 	struct kvm_host_data *host;
 	u32 events_guest, events_host;
 
-	if (!has_vhe())
+	if (!kvm_arm_support_pmu_v3() || !has_vhe())
 		return;
 
 	host = this_cpu_ptr_hyp_sym(kvm_host_data);
-- 
2.30.1.766.gb4fecdf3b7-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4733BF03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhCOOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhCOOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DCC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c1so24717039qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B1o/tWAgXq2CfBeEXWR8qd9iUkNYsN5CjCSGu1Kqq9M=;
        b=Gsh/p7xPB2v9i3WlDhDKJaY+9hOm9O1/hIx5RSuUSOaPvst4OfknXDvy8SYoAAHiFJ
         TeXd9Gc77rcQhbG/ULTqknkRlDmp24P0BqIbq8Jdvu12LDhKTm3q4iGpKBqDcxWzDfT/
         UCQhWjLkYiZqIO8RG+jQBIBPCpTutrdw1PjixU/oWh25TL6uzhJ8J+3lLx8H13wKWH5Y
         IICfA5HZm6MT06l8KkXAYNRkl4Mly9I8LgvBn6e1oIk6EDJBkTsGFquYNblY3d5+CJ22
         ArGbyjzUtH/1DSZ0QFxdqD8zf+/ZB0ceLl51gu4AKKi5wOL3TZCMVu8wtlgrE1iaK1Zf
         ovZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B1o/tWAgXq2CfBeEXWR8qd9iUkNYsN5CjCSGu1Kqq9M=;
        b=Kp9r/fB3NqgbUXSKFYyKcBbcmJkgsMs7NaND+b1y6LQwiQuPdEDUsExj6nSlJiz2/g
         bJXotvULeEL+f4gtOw8zNZM9CGkxmZ3Sn0tqjeTuPk95hHKhosukAikOQUva9g1MbCyb
         8jeqexwckkX64RaI2LEivaM154AXBE8L/XZWWc1643ixviR3WO7ePbXpzuieYXosQrVt
         v/PAyc2XOuJaI6rLuWDtdWe3UmKCMO/aSt/GnjoKWp4E9S1TxsW+IvCoBY67VFxUFNlH
         Rf+kQwxH/6V0Rf8e3gZTFOg4bau8rZFhnYUOnXSfm5f5WgIPP9ctQEyHtltwfn3+FhEW
         Iuiw==
X-Gm-Message-State: AOAM532x/vRu3IndC1f8PUcMfLgmeJ+Wah2TkJq8kahNrBoejpO6atUD
        0Zf26ED+YqYc7OTae2HUpN4XStmA+0tu
X-Google-Smtp-Source: ABdhPJyGcwS/l15Ub8Vg+g/i97LVZ10v9mp6j0D99OTYkeQSN6a3xzJ/+4gL5iTk99GPr8X8U6oZXQJY2duZ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:fc06:: with SMTP id
 z6mr10989523qvo.25.1615819012756; Mon, 15 Mar 2021 07:36:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:35 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-36-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 35/36] KVM: arm64: Disable PMU support in protected mode
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
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
2.31.0.rc2.261.g7f71774620-goog


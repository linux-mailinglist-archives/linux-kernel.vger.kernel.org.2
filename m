Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00734196B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCSKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCSKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:03:11 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:11 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t14so4199958wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B1o/tWAgXq2CfBeEXWR8qd9iUkNYsN5CjCSGu1Kqq9M=;
        b=IIpYdevqjuz3Dt+0g749eHxi3/lKZ6lv2eB7vGkp8aylMJTha2kBOFJ33jcWwBBvbL
         fsYtpnkTHIvNCNR0QP/MFIHW12ET3w3p0A83KgJqStIL+kvekjM0pCp9O8inXFXKFaIT
         W89OAcxQWgjL8SdmPz+W5k6C6SUW7hFE6tgaj6uVOMXOFVcl8hiv0SdT9ikV4oEM+SCO
         YAL8MIoUnRpPnSpMyXthiAIg/5Nb5gNforc+Um021Yg3JWTAgOU6VHrt3djShKLi8kvK
         /jtr509scpifThJdhix+/zlgXKjF+OwzpsugsoXeGUIBqsmrbpOlZ3r6Q5y29wyATsd6
         bynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B1o/tWAgXq2CfBeEXWR8qd9iUkNYsN5CjCSGu1Kqq9M=;
        b=KhcN8cqAZmQFknq8NRnVmu+zAGN+Y0Wt0WhNkeXTu1HZs53CCjbsYLXSezCrB312bG
         1rRpPRTd2i7TpZgpzWSDlalea+sFw6BRVZTwt+RhKN122CWqS6GBYps8srrIa3rPBzC2
         m5vctZeDcZTUrH+HQP5LwynsFFwnp3ZosFNiWIRRMxDymxcT+WCfGZPJai2QItD8UZkM
         +BD6FyBsHGDh7W53KWtVuxE/cqRkSeCctRoO24/oApIqsSZtPmih7kPfhqoVsOcLjSOU
         P2cvIroDys2iIGdTQoUfdhVlwfo01FVwh/vEXx6caf/wPRDHM4TKy2AC8pfiP1KugXvE
         BWTw==
X-Gm-Message-State: AOAM532+Pts8OmdHDkNBS3rCj2SPlfvvL2Jq7OSEA1ySwS9mclAmXHJW
        lgap9vv4GQyT15HKl0LIqTSH/pwB/ubt
X-Google-Smtp-Source: ABdhPJzyJ6jBqZnIFYxLIb1hQMYw/VHqB942OhtZTNlNumNwml6dV0RIjHk4MQe4PNbig7/dbzfGrtulqVAG
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:3553:: with SMTP id
 i19mr3005427wmq.1.1616148189759; Fri, 19 Mar 2021 03:03:09 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:45 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-38-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 37/38] KVM: arm64: Disable PMU support in protected mode
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


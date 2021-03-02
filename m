Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2967332A8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbhCBRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384610AbhCBPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:22:43 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A8C0698D3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:17 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m68so1803117qkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HnBOCbV9VZG795nVKhv9+ovMJqzwdkwkno12utvuuaM=;
        b=MKbgEjESvYdThRoEkGC8RJg+Cz2zkWhWnC7wgzpWZoobh8AkycND5mEZtaZxNGp2tA
         qMEecbBNJ3k3ERyG50+v/O8XaK00waLfRVvvbN9E3QmDrCvJ0/93A4GuOQMcQEo8MGCk
         KW1fqTwiueVCj6eHaOhm9O/4JCquufE/tW2kQHZIkPJNvVz4btOdP6ZSAwQe3mnRfPlP
         C8g40caoVrU0GmaEVlnlhp/nXz17sJ/jz1XYk3CXeUoxTeSCsR7/po0Rbj/Hjj2JDVka
         EUIXH/D9Ghscn3/N8tbMa84ZOQHuQsv2ycIjv+zXEQqXRP/n8+aHwHdkJu4dhtp5hMOJ
         onJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HnBOCbV9VZG795nVKhv9+ovMJqzwdkwkno12utvuuaM=;
        b=sD26yTICLhsldXmyGafG7u5L2tGnMJn5vPm9CGIwHpcXk5VIogt5ym9u2IAO4cY03/
         vxoWSIEdMf0fPutNL8FTAk8NR9V9uWGT6NdAE+3HKHty8JcieOulD55YP2kGku3FAFx6
         DmS1pKcTOZFNf91qxXH91Cf7A4s0EktKAlAdYFMYH6xqlkIJKtrokh56V3yXUmGDkHjP
         02zyBljqVHUWIqOzqLykfkqmbZjOS3AKpiuH/3+wKhYgx5I7ghsuw3svtKZn1266+PDw
         jw7gBlCCtxyd8AYB7nFw9bT0MjesSaWEtbjpd/zY5/RtkK6xM1viDwfLpetzNKlXYhKp
         1snA==
X-Gm-Message-State: AOAM5318kVqYc65oZ/EBtpFfYAP4CaQjyVHWpTC+R4mKxuHLhfabb7aK
        td5ML5k6Wm7fHuOj1c75Vr45GPhgmuZM
X-Google-Smtp-Source: ABdhPJxomthrvtGXmLscfNQ4jzi8tGZD1QtytMGc0+RJgY/tfETMl/DO5FUjo9TRqk9VS+/6RprJ6oK1LBhx
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:56e9:: with SMTP id
 cr9mr20353191qvb.4.1614697276369; Tue, 02 Mar 2021 07:01:16 -0800 (PST)
Date:   Tue,  2 Mar 2021 15:00:01 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-32-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 31/32] KVM: arm64: Disable PMU support in protected mode
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host currently writes directly in EL2 per-CPU data sections from
the PMU code when running in nVHE. In preparation for unmapping the EL2
sections from the host stage 2, disable PMU support in protected mode as
we currently do not have a use-case for it.

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


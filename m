Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43434195B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCSKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCSKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:42 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8881C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:41 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id a63so4395535wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MQQAWJNa/5+Ws/h1+nY46N9BdXPhpiMcbi0Tji1hFEY=;
        b=D4UmlRHS0y4x+R9rKJqUcRUzfcgDZJEm3qtCzw6xhI0q7wC9Z7ZlLB/qrYqG4YjQbj
         LLjGnLuPstfxeC5mRqOGKbiOWj6KSx8M5AIAW4uZNi+KmEBgwUJxk653Rrlyazc/ZVee
         THBUJw7yM949Cz+/CTmypmYNwcJyh2H3r0ybsBVkS8JDAb2SeKfUpmXnpwXiYahix9Vp
         FdC7sa4/Hj5scSqO6gQpP6uEQmlYad8Z8v/C3BC2ya6MgXmN64ZZy48jeQ9uR/6qEnAH
         gQ508Zw9N04VeMwuwyWc1shMDrLmKNe35wUDeQ9AFfFQK/SYBDaXjX2U7OsnlI6lU3VD
         TQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MQQAWJNa/5+Ws/h1+nY46N9BdXPhpiMcbi0Tji1hFEY=;
        b=jr2DMevBVRlSyvzpukGnTFHSokaU54brVYy3hIKENqRNynbDK5LUqUQYLqxjagF4sP
         5R45KbI/W6ye2Cf0xQmF1raMnR56q1biBXRyuH/nCpwOhAMThOGq3IHOMCPJYgfwjThm
         FFT287V75oLcvMIjOEDO70y2Ph5TNZoohTumIlPl/RcfdM4q59eOk8O1ipTnDPgpgi/4
         VKI76hnwZ8i4fNLWcVzc9E7qs2RiudJUYjBesnfcIr5nVyZZkvcO4kPu/dgUQjuiHeVd
         LBZIXQlDg+ByIyflsAL4b3GsJZHt58zJL5pYtb+9wMaxecbQX7rjCi4NGH96z7h9SnZQ
         V/MA==
X-Gm-Message-State: AOAM5339pKSCGxq6Bu7DERML2AT8n92zHBARjXjX9U/cG8e2Mhh0NYNn
        ArINTET53vHI+spwXweiN256MUvDEfyq
X-Google-Smtp-Source: ABdhPJxs8VE2EFnokM//O4a9DsMPKRIdgL2WWK/gF84Ol6Mqq3fJTR7ia0eRJFFqL9NbHweQLLfrGvevkHwP
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:400b:: with SMTP id
 n11mr2883266wma.167.1616148160645; Fri, 19 Mar 2021 03:02:40 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:32 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-25-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 24/38] KVM: arm64: Refactor __populate_fault_info()
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

Refactor __populate_fault_info() to introduce __get_fault_info() which
will be used once the host is wrapped in a stage 2.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 28 +++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 1073f176e92c..cdf42e347d3f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -160,18 +160,10 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	return true;
 }
 
-static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
 {
-	u8 ec;
-	u64 esr;
 	u64 hpfar, far;
 
-	esr = vcpu->arch.fault.esr_el2;
-	ec = ESR_ELx_EC(esr);
-
-	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
-		return true;
-
 	far = read_sysreg_el2(SYS_FAR);
 
 	/*
@@ -194,11 +186,25 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 		hpfar = read_sysreg(hpfar_el2);
 	}
 
-	vcpu->arch.fault.far_el2 = far;
-	vcpu->arch.fault.hpfar_el2 = hpfar;
+	fault->far_el2 = far;
+	fault->hpfar_el2 = hpfar;
 	return true;
 }
 
+static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+{
+	u8 ec;
+	u64 esr;
+
+	esr = vcpu->arch.fault.esr_el2;
+	ec = ESR_ELx_EC(esr);
+
+	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
+		return true;
+
+	return __get_fault_info(esr, &vcpu->arch.fault);
+}
+
 static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
 {
 	struct thread_struct *thread;
-- 
2.31.0.rc2.261.g7f71774620-goog


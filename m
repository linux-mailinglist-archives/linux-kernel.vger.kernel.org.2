Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1042C571
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhJMQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhJMQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:46 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DCC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:42 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so2335598wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iQjX5L75EMSut/e9QkKC3PVYtpB1oumW2lPsA0BXgHk=;
        b=mIk1w2jkpInjOJapgg2EiBV4rNZgsgrkxTvKv+siczoD6/bFepkA9l4SOTN6PbyrSN
         dXPXzsv4EPi6k9JSC+NkQy/OdGLmYCDnMOgDmY2x8FF0X86XBBp4Zlcbuy0UoaXz8kNl
         yNBxqZRo1LBPUkBWUDCARpwsXE05CCl0Izy/SIBc7Fjm85eoeEDoAtMV3PNd9rxKM0P0
         Pxw1YjskOHOCj8VoF4X7ujJ2Esn8W3QuG9E1FlEL9i2WuxPaTuGTl/4yWFNdPCfsNl62
         tjkH4AxtP48/1CYZlrScJ0diYkB2Lqr0HocWPwK3xLr8Twzo7r+apNgU2NSKioYMwf5/
         Xg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iQjX5L75EMSut/e9QkKC3PVYtpB1oumW2lPsA0BXgHk=;
        b=Pb3ntKN+ys/frF/fqmoMkS1W2P3AmcqUPKDu/eDlEyLxCVEwCALqG0siyjBnJxT/OH
         dkaNbOZiUGkDleAtlwPOl13I3pHPUkffBD4ocS+94E6mnBVS7ZKapG+5sHDaS7qR6hTc
         jN0rIPUSnNnaWULaktl7VYiN68hNQUlxeV51NWNwrsa+r7vHfTlf8OR/IbD7VpuoxZbH
         GY67/v7crGDj3IZNPY9NQS0syu3OmJoELjWh4YlAFx3Mmoz0Hzp9tuSWByEllqcaOIhp
         uxEiL14j3+HcZiFwA40fICJqNGXVoMCFBmkMizAHH9KU90ZCYhNe/dXgRYEljVOpSqfS
         ZJqQ==
X-Gm-Message-State: AOAM5333uxNLhHCJcYbrdktme8rUvxSW/cxjPc/Y+1Tqk5bgcSQd+Cad
        rCPChEsRlVq5A/nhkBH1egHvWxdtPvDx
X-Google-Smtp-Source: ABdhPJwXfk8TYTriRHD8Ql+PrifVU/oKyaCUyxffX3kvDsKbnn5ZL+GaraV62M5Cs5X0Y7S/AKPg00V749ll
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:6000:2af:: with SMTP id
 l15mr6285646wry.296.1634140721007; Wed, 13 Oct 2021 08:58:41 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:18 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-4-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 03/16] KVM: arm64: Avoid remapping the SVE state in the hyp stage-1
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently map the SVE state into the hypervisor stage-1 on VCPU_RUN,
when the vCPU thread's PID has changed. However, this only needs to be
done during the first VCPU_RUN as the SVE state doesn't depend on
thread-specific data, so move the create_hyp_mapping() call to
kvm_vcpu_first_run_init().

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/arm.c    | 12 ++++++++++++
 arch/arm64/kvm/fpsimd.c | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fe102cd2e518..c33d8c073820 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -618,6 +618,18 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
+	if (vcpu->arch.sve_state) {
+		void *sve_end;
+
+		sve_end = vcpu->arch.sve_state + vcpu_sve_state_size(vcpu);
+
+		ret = create_hyp_mappings(vcpu->arch.sve_state, sve_end,
+					  PAGE_HYP);
+		if (ret)
+			return ret;
+	}
+
+
 	ret = kvm_arm_pmu_v3_enable(vcpu);
 
 	return ret;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 5621020b28de..62c0d78da7be 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -43,17 +43,6 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	if (ret)
 		goto error;
 
-	if (vcpu->arch.sve_state) {
-		void *sve_end;
-
-		sve_end = vcpu->arch.sve_state + vcpu_sve_state_size(vcpu);
-
-		ret = create_hyp_mappings(vcpu->arch.sve_state, sve_end,
-					  PAGE_HYP);
-		if (ret)
-			goto error;
-	}
-
 	vcpu->arch.host_thread_info = kern_hyp_va(ti);
 	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
 error:
-- 
2.33.0.882.g93a45727a2-goog


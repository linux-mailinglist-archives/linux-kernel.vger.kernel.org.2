Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71632E684
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:34:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E3C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:34:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p5so1204128plo.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Agp6V5fskOmV3SgtzOBMqE1Yp83AGfJTjOCO5K//BWc=;
        b=G1gshWZRGz3kizh8dLaYQBWeT1Fu2/1RpD/S1UCrAFg2ezkz6nKcBNHKwaTTjNls0J
         yN4GwWqs9JIzUIwjZ/8/BKeuyVYnXTYoMYbZYKZqUMQGsMLs3G97PcSWbF365D7xm1gD
         /eRUpRC2wT3kYgk/LAEf5MCUSdVXov2QP4kXnVgGWLoBWk8Lq/xDsClEKzBgnhNcv7vZ
         GgjUVLWwF9S6/cInj6uYXPfPo0PhQvooVIP2AWzI5BoLQgy9Io9kaeTZru1nO6+F80eZ
         WrhhdmjDUzwi/2JODd/TRujsJnBfLbJS2ZNgHsZQEgsI5Jz8IYhhZ1v1nHKc/4ASJw5N
         DFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Agp6V5fskOmV3SgtzOBMqE1Yp83AGfJTjOCO5K//BWc=;
        b=QwDuQv49qAG34aExUp+p7b0gmjmVc4nJQsyQIX2/0+LJqwkzwNVFneZ3Gu7IaS8fla
         sFM71XQZRH4WUC2Ss0F2IdRy1HklvOspey0kSSvHIKIGqR3VGsyMAwiLj/1IeQtq67KF
         qdO0weUyugyx7HaaoTivfr4UjnmLNUvBnp5OfXx2VkndxS/D4yCkcFsQVQlZAbPc3u97
         pc+C3Ud2/z1WCdY0BrBPn4kvinGRpRgA2/8rp0jckSTHLGVNDXYlisdBq8FVlqiF21h1
         Xek55n3btXOBegGW9ZZgRPfvl4SW7eIU39wZSVkeRewiPz4rvLY53XPa6B+IEVdM1NEk
         Ft7A==
X-Gm-Message-State: AOAM5302NKpy3/p2nRHBYi8xGTmKpARNNNeNnZrWMfynq2AFCCPsgrYB
        DYwq0WpZRqltkib39+3qZ6g=
X-Google-Smtp-Source: ABdhPJyMqm349OV0JBDmKI2VTt+LSi2BJuMaO76qGV1TYetu0bWPuiEGfD3j7TCLjNy+gErVmDkb2Q==
X-Received: by 2002:a17:902:ecc3:b029:e5:d7cc:2a20 with SMTP id a3-20020a170902ecc3b02900e5d7cc2a20mr8217644plh.11.1614940474934;
        Fri, 05 Mar 2021 02:34:34 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id h27sm2193761pfq.32.2021.03.05.02.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:34:34 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] KVM: arm64: Add big.LITTLE architecture support for vcpu
Date:   Fri,  5 Mar 2021 18:34:25 +0800
Message-Id: <20210305103425.73380-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In big.LITTLE architecture,the application layer calls KVM_ARM_VCPU_INIT
several times.Sometimes the thread will run on the big core, sometimes
will run on the little core.The big core and the little core has always
different cpuid, but the init target is fixed. and that leads to
init->target != phys_target. So modify phys target from the current core
to all cpu online.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 arch/arm64/kvm/arm.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fc4c95dd2d26..f7fe09a5b23e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -983,20 +983,37 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
+static void check_kvm_target_cpu(void *ret)
+{
+	*(int *)ret = kvm_target_cpu();
+}
+
+static int kvm_cpu_online_target(int init_target)
+{
+	int cpu, ret = -1;
+
+	for_each_online_cpu(cpu) {
+		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
+		if (ret == init_target)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			       const struct kvm_vcpu_init *init)
 {
 	unsigned int i, ret;
-	int phys_target = kvm_target_cpu();
 
-	if (init->target != phys_target)
+	if (kvm_cpu_online_target(init->target))
 		return -EINVAL;
 
 	/*
 	 * Secondary and subsequent calls to KVM_ARM_VCPU_INIT must
 	 * use the same target.
 	 */
-	if (vcpu->arch.target != -1 && vcpu->arch.target != init->target)
+	if (vcpu->arch.target != -1 && kvm_cpu_online_target(init->target))
 		return -EINVAL;
 
 	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
@@ -1018,7 +1035,7 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			set_bit(i, vcpu->arch.features);
 	}
 
-	vcpu->arch.target = phys_target;
+	vcpu->arch.target = init->target;
 
 	/* Now we know what it is, we can reset it. */
 	ret = kvm_reset_vcpu(vcpu);
@@ -1815,11 +1832,6 @@ static int init_hyp_mode(void)
 	return err;
 }
 
-static void check_kvm_target_cpu(void *ret)
-{
-	*(int *)ret = kvm_target_cpu();
-}
-
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 {
 	struct kvm_vcpu *vcpu;
-- 
2.29.0


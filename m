Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121334194A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCSKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ev19so14707286qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FHhOKlvH8BUgvSu8w1ogZTH6l5iURXLk02Ie2JUxorI=;
        b=qixyVDp2kzHvkmDWySq9jBUdHw1gl4owgBvaGaZcBZnZJ3t0tbfIPvpnr/l0h2deyl
         2EPkGOTsbSATaWOR5f/vBI+kFfGMcSFOmltFzs6oJl8frXJEaIW57uVoBFzxvj7efpej
         Km7kaJymPI6YHaaotbR7/CKArmpzCXEg7pMb+NNE62MGwntXknqbQwbUqCfwZeVJpOxO
         DGXawS5F6hpYD/m+wgEUgM3jp8DdXp7e4Jdtcs7QpjJM9H5atLC5LViAK6E791VUrkia
         lkGv1U5aVDqEVnL5hIxnUiyIOmLtYxelT+qUAgnrR32tl3EQE5CDB5VPnBGGC++t2uNL
         8iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FHhOKlvH8BUgvSu8w1ogZTH6l5iURXLk02Ie2JUxorI=;
        b=juLvEhmbmUwo/yZxYrbDrV0nIWGoF/NPAYI0pCyzEBHbRkWRAgOaQvqLyedc7svcXX
         KMe3q6jsviYij2SWuGJPR6T+R8iQDTHpIO6L66JJGfubDMr5RHsAB2lgsRPWl5+hcqtQ
         o9IUN53FzTFu+2/ajZRDi/+vAMNYEkaGDP/1MGp0q1lATi3sMhg2wGR8+mWxrnMBRZ5p
         2N0IXdfQ9pLU76P7sfVxPLB0WoOoZJ8T7mzjmsnZnkfuzeY0yLMsmCYtsFzG7ayN6B+V
         CeyqOz1+HSW9gIKncAc7GeUQE1HtN8K0ve/HKLmlM2MCx4q+HsEzDb/AX7FZED8foOn2
         FoKg==
X-Gm-Message-State: AOAM531tmEy72CVYOsI3TYF4GLSkrlyq851dpb5CllFJXabX+QiJ4D+k
        S2uyZh8We4sv3tIPMRaYF2wy6QPyKVMJ
X-Google-Smtp-Source: ABdhPJwIqnMAXTy7s8n+By8NiJmpTPklRN++6V786HQ3MT5zF6JnhYEfpESJplTXQGrKlaX51KwO3bZurPTZ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr8628046qve.8.1616148127254; Fri, 19 Mar 2021 03:02:07 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:16 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-9-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 08/38] KVM: arm64: Make kvm_call_hyp() a function call at Hyp
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

kvm_call_hyp() has some logic to issue a function call or a hypercall
depending on the EL at which the kernel is running. However, all the
code compiled under __KVM_NVHE_HYPERVISOR__ is guaranteed to only run
at EL2 which allows us to simplify.

Add ifdefery to kvm_host.h to simplify kvm_call_hyp() in .hyp.text.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 08f500b2551a..6a2031af9562 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -593,6 +593,7 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 #define kvm_call_hyp_nvhe(f, ...)						\
 	({								\
 		struct arm_smccc_res res;				\
@@ -632,6 +633,11 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 									\
 		ret;							\
 	})
+#else /* __KVM_NVHE_HYPERVISOR__ */
+#define kvm_call_hyp(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_ret(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_nvhe(f, ...) f(__VA_ARGS__)
+#endif /* __KVM_NVHE_HYPERVISOR__ */
 
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
-- 
2.31.0.rc2.261.g7f71774620-goog


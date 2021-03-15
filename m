Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89F333BEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhCOOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbhCOOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:15 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093CC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:58 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f3so15172546wrt.14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+iu0t5BZID9srTWBP+2VrUQDFbl6lTqyuwf0tKjg+JE=;
        b=eCfaDc/7sIi6ERqTbQYAo0T/MGESaou7EUDhXwnQrsDwamnC9YlqfgIGWyi8fqO8yO
         nTiawzHfVoaGMYlQk9s/eR4POgKLB8f5IkHNxi6muO5P+/FDSHukbR3UQzYNUZH+9RNt
         RI0isey48BJvIiy7xK7jk3qVM28DXl+YCeu3jI2fLFYrAWJqy0tzVaTanAh6qbjLcAlw
         eaFZc759FNLxBsxtgNJ4BfAQRFbHA5fOqbOU+BobykofhZI/QjUT3Zm/RCejnFg7Bv28
         MzfvvCmCqN1yIauigRfpZiyXbb/q0yuJN8t/XhF4fSGvwRd53BMDgZoUAxXmwjS03SVW
         XjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+iu0t5BZID9srTWBP+2VrUQDFbl6lTqyuwf0tKjg+JE=;
        b=a2aatiu1c58NSVcufVOcXeUpV3oQZC2idxSDpJ3q8DUniu83XyQecAuzuw9rBHqmol
         icVlg6Xo53j4/tDVFgdFw7q/MdDABIzqhnur+5VpJFhQBNdXIXs8k/TKDCSfVCmo0zt8
         twnv4A4MgtDqiWJSju6c0q7x+3KoXobKDG341/K2rFp8lR5mp7Qim7ztdCSQkBjnmkEx
         CzEVMTjkZtFXmSPHYyrTmrqxIUMPQH3ndrkZboH6wTEWlGM+jWHX/Q6h1dVY3f35slk3
         3KuYV2xi/s2xLt2nezfTL6lDacjcoM9lPhmdi5rvqLWRBOFB2kDoVzqJyAoxS5/NLmWH
         Wqxg==
X-Gm-Message-State: AOAM532vdknTswo5dOIGHklvVaa/KRzk5am0pzN0btyQuR9vSaXnoQXb
        mgFgQSJI+wblHL51XPzESq2Aa9+lAxPy
X-Google-Smtp-Source: ABdhPJxCgwITDTWF8jM+n9TA0U3rRomDUbTmfz8t0MMwY2a20uS8WWMoTr0wvdf1I/4Avmktbd6EQAwHuiCo
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:c20a:: with SMTP id
 s10mr21383wmf.144.1615818957308; Mon, 15 Mar 2021 07:35:57 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:08 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-9-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 08/36] KVM: arm64: Make kvm_call_hyp() a function call at Hyp
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
index 3d10e6527f7d..06ca4828005f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -591,6 +591,7 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 #define kvm_call_hyp_nvhe(f, ...)						\
 	({								\
 		struct arm_smccc_res res;				\
@@ -630,6 +631,11 @@ void kvm_arm_resume_guest(struct kvm *kvm);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585B32A91A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575327AbhCBSLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbhCBP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:22 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D29C061D7C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:25 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so15083262qva.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FQ7gk+4i0GZUVGgKW9zQ6uuaT/h986N5brkzpgihVQ4=;
        b=X/OUs9SG1r0jdb49+8nVXln6PO8Zu5SI0ZdYl8tCmxLjvl2MV2hgALRZh3zow++nD5
         LfYOTe7jubKzAq/fe+4mCbvp1kF7X4I3lzigk2zpB6/taDq/VfhukisnZJlcHe6Cw4or
         Z2DAVqnLaMStLxV/sg78xIsCcf06CcFYlUZgrbGmAtabdpSBs7a/fthy26V76rPX+XbO
         vfOPmxuoz0iynn8DGaZuNQ8aFdVjHcjEpkeI56RfdvgEMwpiAyJrKCIXlq6vGBTzLF1f
         QEby0P939iHyfOgGvqBORuYNyZn81dn4C75IXu/p+aWEWyofsIx6RlVZOzkWwW6/g//M
         vpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FQ7gk+4i0GZUVGgKW9zQ6uuaT/h986N5brkzpgihVQ4=;
        b=Ec4Ht7l597V/kg9BqBxYBwZAnOyhrEkawR1vVePzhmtBcyREWzqgUvvzxLLvAVHKG6
         USPLCHS02XhiC2R1DNxWS97KBQXsx/2xrzlJ77Q0ZrrnT84aWI7S44vkNUyoe4JH6xiy
         fjdot+DbZqRaYiN8vNOQVnm3+SoRAM+AvGRt6Y8MqhtrzR8USXOyUTQ5LbJgXaDQYcrr
         mj91ZW411/G6t1mAdCeYVHFgUfj/+UwYFsxju/u/MABzazjv6ItzNJYaMM153o7i0ym9
         pZX491tIBhoIL8JeVwlws7PdnKqQ7DXKfG0AVWe17CJjjUdjHe4Q4vB/LV2XA64MmswE
         sZIw==
X-Gm-Message-State: AOAM531+ceKxxGuEWBME1StHhlrnuGhDrvcS78cGoMWvjH5v48KJDTAu
        zAMczxCIMByRCtIhGZZ9x855KsvJYS6F
X-Google-Smtp-Source: ABdhPJzhqT1MCWJ5omfxYXzYFsXFvD1UddN55tmUgOSTPj1CkCQRYxZaBVCibdke5an4rJD9Wh3ODO7o5zyX
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:76f:: with SMTP id
 f15mr3892367qvz.56.1614697224470; Tue, 02 Mar 2021 07:00:24 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:38 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-9-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 08/32] KVM: arm64: Make kvm_call_hyp() a function call at Hyp
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
2.30.1.766.gb4fecdf3b7-goog


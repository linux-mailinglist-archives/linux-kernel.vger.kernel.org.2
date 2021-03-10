Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E43345FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCJR61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCJR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:13 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF36C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:13 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j8so1309932wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FQ7gk+4i0GZUVGgKW9zQ6uuaT/h986N5brkzpgihVQ4=;
        b=l2/JAssrCgiSVNWvv4xKwvbtNAJ4uVkYJ8t6QBmtVRzgoG35risu7QZVUsv1ZVEVVc
         d0cu6c8ao+zRESzgSYR0tOiVun97ubBgTvNljNr07rf0ZaBhRxxm3aeL4YQF0lrAWMd3
         J6EHU6UjAWsuDfgdjF2Xy9kBIiLSqFoO/8/8jY1z0jZEnLVRSGHJdrgiLo4rMCXudmEy
         SmGdNMHEAxYX4BQ0m/Q8CpJ8tyO8EwGVTgfToo90g/wP1g66/b1nh7za3kbk5Dbi1OyZ
         cHdkyNd2U0aCwKGZLb5VJukCs5LMD1M2DzqKbuxUNl5vA15jwSiQVnBxV4noRW0uEN6X
         S3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FQ7gk+4i0GZUVGgKW9zQ6uuaT/h986N5brkzpgihVQ4=;
        b=k5uT+H7v8CATmydQwq299GyVJ7QrCTjoiQYUCvMO93hwIVUu/lAca2iiPUiSKQlnKg
         Amwsw9vLprUY4wd8W2NaP58+WzFu8bu5L05pyZ6cJEbNC+EwGTXA7UT1kp+/i1YzXs6q
         uXNmMhq+GIHdchsnumt10Oxm4ndyH6HA818iGye3/+aLQlDGBAUSwklg9vKC5vz9YCXD
         Mx3INFfOBE+vo9gMsXZZFgiQibWK2kUUqiViLnGc0d7nF/1dU8e/2+FIHSjUWIRM3FLO
         WqjOgvc4Mf7nCxRJLvIxVXod0OrVdaqESjAqi2J5hmm8z4Hkli5CRrCB3Nkfep26moFv
         g9kA==
X-Gm-Message-State: AOAM5312nM5w3D1r0+OHaboo85B0djrr/46LFejk6vaBIfRw/VxaNAVZ
        5RZMRefGeSzjADwa9T9rBXf0+USp0UPw
X-Google-Smtp-Source: ABdhPJw1jFJ2uambxxtcgPuAbKpIituWx/uYJZ6wnBrvmsU1lXHbtQHSpkrolAxbBPbUyRL7xj955m5ZQfKl
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1333539wmi.1.1615399091555; Wed, 10 Mar 2021 09:58:11 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:25 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-9-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 08/34] KVM: arm64: Make kvm_call_hyp() a function call at Hyp
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7C44A421
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhKIBn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhKIBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:43:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EAC07926D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:30:55 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so11835861pfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Cek4ungJsGyjoKuyz53izX26dC8LXwab+OTQ+vEEjQA=;
        b=kDnW+htoA3Jr+pOfiv6PMG59PPWkSEcMBpTjhdW/gWwOVTHyvWeJ6ZxkdzUEnQ2e13
         csdKjf4khL85fsMP8GtozP2YO2v53HdkkagcZxfLJIXeHS2tVYH+1pGDUijDbGQVbuXn
         cebZgn907/SQJuQgyDea8xgHro4I6XyS2tBFnO7FDAlgwksCTX2aunHzPTv2VjHbuNY1
         6faXkAXWgvia9hDDdQXY8SUX7pYZzsdBE9vdohVavQTagoRDqV6Ltx48J8qeDJ6SCKQO
         w1ttch14IYyU+giWBQkPseDXOKx5wAGpTg0KQf/liF2jDnY/nka35JxaEDxpl9sWffD2
         3JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Cek4ungJsGyjoKuyz53izX26dC8LXwab+OTQ+vEEjQA=;
        b=AUWBZimwQk70MAv6GP5cMJF1FWwQf7IttZhib3dfzK5BY/VLnT3EYiPl2RQj/492tI
         V3kSOkC0RnEXOXmNNhUG6v9rw7LDujyioyWZNlEdgZ2xzs7LO/QLSFeCGP/Yi7sGqcXl
         uFfAuRsuhm9VDrruoecDvHWs1ksGPA7GExPJxeHtPHyKf2L1s4p2rGW0IQaTLeGviZsU
         meZrxxI4i4iYDQGd4BnC88GbsZg+kRyC3Ht8Lx+1Mt3Tuo3IqiZyetDP6cglUpljqTgS
         Yymaccz7z9kM4pEgmvmMU11J+IP1WgrDnvm1ZqC22/UMl+j1uda7IUNPM240TbohnH6F
         GPdA==
X-Gm-Message-State: AOAM5313rVTb/NZ2LXGKzEhzPcsrzcJW2aKxPpdj/LBkV9BehNdeIw71
        PdBQKVhbKABFlHZ52lfQg/DkJZKI3s4=
X-Google-Smtp-Source: ABdhPJzS59VvxMe/VQxdUCepyufz8RGy7ZdZPt3tuG6Z6rhQZOhNRURdYoCEVjuxE01aOvaPjQ2mlcuUfA8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id
 j5-20020a170902690500b001429e19702emr3815769plk.34.1636421455434; Mon, 08 Nov
 2021 17:30:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 01:30:46 +0000
In-Reply-To: <20211109013047.2041518-1-seanjc@google.com>
Message-Id: <20211109013047.2041518-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211109013047.2041518-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 3/4] KVM: VMX: Macrofy the MSR bitmap getters and setters
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add builder macros to generate the MSR bitmap helpers to reduce the
amount of copy-paste code, especially with respect to all the magic
numbers needed to calc the correct bit location.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 77 ++++++++++--------------------------------
 1 file changed, 17 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d51311fa9ffc..83a14b61c80f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -400,68 +400,25 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
-static inline bool vmx_test_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		return test_bit(msr, msr_bitmap + 0x000 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		return test_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
-	return true;
-}
-
-static inline bool vmx_test_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		return test_bit(msr, msr_bitmap + 0x800 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		return test_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
-	return true;
-}
-
-static inline void vmx_clear_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__clear_bit(msr, msr_bitmap + 0x000 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__clear_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
-}
-
-static inline void vmx_clear_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__clear_bit(msr, msr_bitmap + 0x800 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__clear_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
-}
-
-static inline void vmx_set_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__set_bit(msr, msr_bitmap + 0x000 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__set_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
-}
-
-static inline void vmx_set_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__set_bit(msr, msr_bitmap + 0x800 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__set_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
+#define __BUILD_VMX_MSR_BITMAP_HELPER(rtype, action, bitop, access, base)      \
+static inline rtype vmx_##action##_msr_bitmap_##access(unsigned long *bitmap,  \
+						       u32 msr)		       \
+{									       \
+	int f = sizeof(unsigned long);					       \
+									       \
+	if (msr <= 0x1fff)						       \
+		return bitop##_bit(msr, bitmap + base / f);		       \
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))		       \
+		return bitop##_bit(msr & 0x1fff, bitmap + (base + 0x400) / f); \
+	return (rtype)true;						       \
 }
+#define BUILD_VMX_MSR_BITMAP_HELPERS(ret_type, action, bitop)		       \
+	__BUILD_VMX_MSR_BITMAP_HELPER(ret_type, action, bitop, read,  0x0)     \
+	__BUILD_VMX_MSR_BITMAP_HELPER(ret_type, action, bitop, write, 0x800)
 
+BUILD_VMX_MSR_BITMAP_HELPERS(bool, test, test)
+BUILD_VMX_MSR_BITMAP_HELPERS(void, clear, __clear)
+BUILD_VMX_MSR_BITMAP_HELPERS(void, set, __set)
 
 static inline u8 vmx_get_rvi(void)
 {
-- 
2.34.0.rc0.344.g81b53c2807-goog


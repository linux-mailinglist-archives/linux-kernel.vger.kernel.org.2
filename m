Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F1417C84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbhIXUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbhIXUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:50:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85DC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q18-20020a252a12000000b005b263fcc92eso5012678ybq.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=83IGi32P9CxqLtD2qwPXRfqDcHFBhJwLsoa9sNLwyr8=;
        b=JMoCeW4ZQDN30TEsKayIe0ifFiCiJ2/E4na0teoz6jWmaZG2A7YqKH/mFCsdWLlXfV
         hyB7QOoNwPnlNnUh5jO9iUDrPuln5K4H9GGtXPw26KPzXxI2ciYj3EIv2riFKL6qqkHU
         6bMQKlu6G6YtLBWZ4UKYPRSqorh9sMP7aqDYccHIe7XiajYrUeIydV4MZg367yyiGnUs
         mxQpnLPYfaURXxa1ko89zTzZAQ9Hlc/YkCS6mnVSPX1B1b46j4gCFlEc/TPHCx91jBBQ
         TIrtcqrFXAjXa8r27/QJCe77QH5KX9YzUnXv2Vgq8wgDL0aLq1lFGkg1dgv+77/8arYP
         DbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=83IGi32P9CxqLtD2qwPXRfqDcHFBhJwLsoa9sNLwyr8=;
        b=2BormT0xMieq6wwtdQdIy85ILPteJy7gFx0ShavXnuY0qy84uGV4A4fc+KdvhiZmt0
         SuiYiqv9tMrnWmX21F3L1F5Jx/7KFj3r9FusXrrc39YG9GfY6+nNiI5wkz7VYpcZHDKw
         QCLKAGCpKrvPuocRqrHvQAVIcKTGPMHuPIqFi1lAxEH0XjHbaXw2vkHLsq0ptuU0lYQZ
         kSKBhS1ZO+c2IfW0sDOXiA8HPF0xa5FST1j+2TXUpwOQ8BeKK8vRvNJE2G2b396gfnF8
         /Yo9SrcB029A5O6qEKc0LoSsgPH9DAfjE3P5AneMJ6m29U+L2jdGX+nj4QHC+8syKsmA
         yxAQ==
X-Gm-Message-State: AOAM530vCrcPhgZLkgToSBAvtU/3arlkuP5Rpdj5qQepWnNQodPAkgtE
        XttNQ/JbVUmEEKeHwtXazrSAHkCDChM=
X-Google-Smtp-Source: ABdhPJymfFSZ27nG14kPo4JOgLeCxAaamz9advcsJDFvm/iQ2J8GC2XL/md1yKJm2Pu4jq8r4E4rKxJgu5g=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:4c72:89be:dba3:2bcb])
 (user=seanjc job=sendgmr) by 2002:a05:6902:725:: with SMTP id
 l5mr17058017ybt.178.1632516554256; Fri, 24 Sep 2021 13:49:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 24 Sep 2021 13:49:06 -0700
In-Reply-To: <20210924204907.1111817-1-seanjc@google.com>
Message-Id: <20210924204907.1111817-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210924204907.1111817-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 2/3] KVM: VMX: Macrofy the MSR bitmap getters and setters
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
index 3f9c8548625d..c5735aa8b32c 100644
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
2.33.0.685.g46640cef36-goog


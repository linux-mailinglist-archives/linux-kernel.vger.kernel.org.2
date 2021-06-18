Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A913AD490
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhFRVtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhFRVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:49:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:47:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d12-20020ac8668c0000b0290246e35b30f8so5908549qtp.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=229mnDm6P0b0PXS4C471S6HQyDxSv4bvPmDKNuB7k40=;
        b=aKAShhDSlz34FFmsBMzsWaopNkOIayd5iqC4WyI4nw7EHmyz6gT3UNsYYkA71XKeGs
         HYe325z0spWnArGr1ct0HlvaPXJayYmoz3xEBsLNR2pYu9W5ytLUi3GbsyqNYhhg8FCD
         Kb0ZSi/hLFCt9lXQLZwNJrIiFthTWhjtN8xLE6U8McLD2HTX3ZnPVJOlc6yt4/ltMrLJ
         pxCJi0HXJEepqSOcKixEIappwWajaMiojKxb6YUNU6JblgSinSZlx5p1CKyHSE+IrT0d
         VmEnviQfI4knT2PFN30QysB8oRcrx//+0BzI2VxVhymP1HfHRYD6i2XTIeuYzik0eK+B
         fpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=229mnDm6P0b0PXS4C471S6HQyDxSv4bvPmDKNuB7k40=;
        b=feTlrQEjGqmqWMcnJfaekjaTyRKni+bfEJ22f2HEBJquU1Uv2DadArfvccizadeNVJ
         CYj9MQ3ePHSe+MWajn8mOzyHb4ccR4j41OdbN+Iv9CC2N85ilQyV7k80d3I9R+6kDC2P
         7zHLxGp9XdWgXJmFQp3ZaG6c5l6qUg+adQzeyrle4NKlYVUdVmMZA6mk1B7jzOjaf/7K
         jZdywaMCGuwGD51+rqysEa6CQjC1C8YljiqOse3JQVPAKxWzc3f31s2YXT5uRtD3qkoP
         AqVVEcTLpZ9eQtBcJRPFGwAWa8bJGtUMDQJg5nymw1R++5zSoqunlz0jNwxbGRQCM/J8
         Kv7w==
X-Gm-Message-State: AOAM531g5EmZkIrJYWtY3C9NSf/8Kflh4TEPQebdwoK+/i/UyfDyB+At
        H4CLrf5EyFtwXytYnvqE5g5Q+egyx5c=
X-Google-Smtp-Source: ABdhPJxZL8lxhONicplEpmwS8lyjiTsFH0Vv+IEk6+sMdK7gQPIj8pWgQOmqhB6KusakfNutUaK0t9NtoaI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:d689:126c:66f2:8013])
 (user=seanjc job=sendgmr) by 2002:a25:4048:: with SMTP id n69mr15751195yba.91.1624052821314;
 Fri, 18 Jun 2021 14:47:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 18 Jun 2021 14:46:58 -0700
Message-Id: <20210618214658.2700765-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH] KVM: nVMX: Dynamically compute max VMCS index for vmcs12
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the max VMCS index for vmcs12 by walking the array to find the
actual max index.  Hardcoding the index is prone to bitrot, and the
calculation is only done on KVM bringup (albeit on every CPU, but there
aren't _that_ many null entries in the array).

Fixes: 3c0f99366e34 ("KVM: nVMX: Add a TSC multiplier field in VMCS12")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Note, the vmx test in kvm-unit-tests will still fail using stock QEMU,
as QEMU also hardcodes and overwrites the MSR.  The test passes if I
hack KVM to ignore userspace (it was easier than rebuilding QEMU).

 arch/x86/kvm/vmx/nested.c | 37 +++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmcs.h   |  8 ++++++++
 arch/x86/kvm/vmx/vmcs12.h |  6 ------
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b531e08a095b..183fd9d62fc5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6374,6 +6374,40 @@ void nested_vmx_set_vmcs_shadowing_bitmap(void)
 	}
 }
 
+/*
+ * Indexing into the vmcs12 uses the VMCS encoding rotated left by 6.  Undo
+ * that madness to get the encoding for comparison.
+ */
+#define VMCS12_IDX_TO_ENC(idx) ((u16)(((u16)(idx) >> 6) | ((u16)(idx) << 10)))
+
+static u64 nested_vmx_calc_vmcs_enum_msr(void)
+{
+	/*
+	 * Note these are the so called "index" of the VMCS field encoding, not
+	 * the index into vmcs12.
+	 */
+	unsigned int max_idx, idx;
+	int i;
+
+	/*
+	 * For better or worse, KVM allows VMREAD/VMWRITE to all fields in
+	 * vmcs12, regardless of whether or not the associated feature is
+	 * exposed to L1.  Simply find the field with the highest index.
+	 */
+	max_idx = 0;
+	for (i = 0; i < nr_vmcs12_fields; i++) {
+		/* The vmcs12 table is very, very sparsely populated. */
+		if (!vmcs_field_to_offset_table[i])
+			continue;
+
+		idx = vmcs_field_index(VMCS12_IDX_TO_ENC(i));
+		if (idx > max_idx)
+			max_idx = idx;
+	}
+
+	return (u64)max_idx << VMCS_FIELD_INDEX_SHIFT;
+}
+
 /*
  * nested_vmx_setup_ctls_msrs() sets up variables containing the values to be
  * returned for the various VMX controls MSRs when nested VMX is enabled.
@@ -6619,8 +6653,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
 	rdmsrl(MSR_IA32_VMX_CR0_FIXED1, msrs->cr0_fixed1);
 	rdmsrl(MSR_IA32_VMX_CR4_FIXED1, msrs->cr4_fixed1);
 
-	/* highest index: VMX_PREEMPTION_TIMER_VALUE */
-	msrs->vmcs_enum = VMCS12_MAX_FIELD_INDEX << 1;
+	msrs->vmcs_enum = nested_vmx_calc_vmcs_enum_msr();
 }
 
 void nested_vmx_hardware_unsetup(void)
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 1472c6c376f7..de3b04d4b587 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -164,4 +164,12 @@ static inline int vmcs_field_readonly(unsigned long field)
 	return (((field >> 10) & 0x3) == 1);
 }
 
+#define VMCS_FIELD_INDEX_SHIFT		(1)
+#define VMCS_FIELD_INDEX_MASK		GENMASK(9, 1)
+
+static inline unsigned int vmcs_field_index(unsigned long field)
+{
+	return (field & VMCS_FIELD_INDEX_MASK) >> VMCS_FIELD_INDEX_SHIFT;
+}
+
 #endif /* __KVM_X86_VMX_VMCS_H */
diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index bb81a23afe89..5e0e1b39f495 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -205,12 +205,6 @@ struct __packed vmcs12 {
  */
 #define VMCS12_SIZE		KVM_STATE_NESTED_VMX_VMCS_SIZE
 
-/*
- * VMCS12_MAX_FIELD_INDEX is the highest index value used in any
- * supported VMCS12 field encoding.
- */
-#define VMCS12_MAX_FIELD_INDEX 0x17
-
 /*
  * For save/restore compatibility, the vmcs12 field offsets must not change.
  */
-- 
2.32.0.288.g62a8d224e6-goog


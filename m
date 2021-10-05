Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677A1422AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhJEORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbhJEOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:16:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED28C06136F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:14:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a188-20020a627fc5000000b004446be17615so11149357pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+f6h/X5NIPeStfEfpLAEhC/0Xz4xmxvZvD1XBnS1esg=;
        b=Gxcp9Gzwc/lNaty7s6TDJEDgZ65H1sDm8BcZowlpWcMDIpeGcvJv0a8TQYbF7rXkKw
         Kk9khZ3ADiEuzh9XJLf6RCJrkLDfuOohH1mDhYmKDLm29n23mFPlIuLeSqUhVloklvES
         zsQC0YPpy5fi2EaZAcCs7/+HAhOK79tDnw0KeJHUAk3sxUySvQHZ85znucUs9A23+wNP
         iak/Kw+HVyJgHgds9TNyAFHAXFj+NP4+FzrEmSjG0alX6zRMoMFgtI3AntJOGVhcbNeu
         LwPwarui/C1iA+3pIYndxKeDgGhCNoM7mrLw1wURntRx2x5aXXzqQXJjc18QMwezdCQB
         gj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+f6h/X5NIPeStfEfpLAEhC/0Xz4xmxvZvD1XBnS1esg=;
        b=Q4GBAfXui7avJAMKYwjfPbUzHcmtCbSTwXlGiSflz9y/Knqp3HE9u+AEoybitbvOZQ
         jk9VWaV2w+lhvgpvhTSqDWWmxmjxDzuGa0NfTaablrY+8UNZ9w7shBZ7gAl2Z0cPTVuj
         auiZBLfWxDqoQP6lYVUGCPZ43ojaZd3O7989YuteePY3cfkIl+/DeahK/8BolvV5PGR8
         gpHFQ+R45FGUT7L1pHr5ypOo/fyFTJ0BNGcf3HmgQ8/vDcdSOkbwU1MyedB1HK+VLckU
         nNGko7M/+HeS1FXefbw4iZ9aYvkERN3Qwxa19JEVkpScWUxJcZpR+AgeZd5srccMSK01
         34rg==
X-Gm-Message-State: AOAM531VDdXTGuBxaxSATALOF2WA6k50ALSoKo+qPvhxfMssZnO70rH/
        pGeZjLQnQ7Q1RBoftlBxOrFfF/td/tc=
X-Google-Smtp-Source: ABdhPJxDXErdRZQa2QB8UPrMEyZ1lrAwikd4GlvsAsCthyJfdpiy5SSEH/ULjZ+EDQ0QgbPvKs7WzcdT5ko=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:225f:7216:6111:7f1c])
 (user=pgonda job=sendgmr) by 2002:a17:902:d718:b0:13d:e2ec:1741 with SMTP id
 w24-20020a170902d71800b0013de2ec1741mr5445631ply.38.1633443250229; Tue, 05
 Oct 2021 07:14:10 -0700 (PDT)
Date:   Tue,  5 Oct 2021 07:13:55 -0700
In-Reply-To: <20211005141357.2393627-1-pgonda@google.com>
Message-Id: <20211005141357.2393627-3-pgonda@google.com>
Mime-Version: 1.0
References: <20211005141357.2393627-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 2/4 V9] KVM: SEV: Add support for SEV-ES intra host migration
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SEV-ES to work with intra host migration the VMSAs, GHCB metadata,
and other SEV-ES info needs to be preserved along with the guest's
memory.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/svm/sev.c | 53 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6fc1935b52ea..321b55654f36 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1576,6 +1576,51 @@ static void sev_migrate_from(struct kvm_sev_info *dst,
 	list_replace_init(&src->regions_list, &dst->regions_list);
 }
 
+static int sev_es_migrate_from(struct kvm *dst, struct kvm *src)
+{
+	int i;
+	struct kvm_vcpu *dst_vcpu, *src_vcpu;
+	struct vcpu_svm *dst_svm, *src_svm;
+
+	if (atomic_read(&src->online_vcpus) != atomic_read(&dst->online_vcpus))
+		return -EINVAL;
+
+	kvm_for_each_vcpu(i, src_vcpu, src) {
+		if (!src_vcpu->arch.guest_state_protected)
+			return -EINVAL;
+	}
+
+	kvm_for_each_vcpu(i, src_vcpu, src) {
+		src_svm = to_svm(src_vcpu);
+		dst_vcpu = dst->vcpus[i];
+		dst_vcpu = kvm_get_vcpu(dst, i);
+		dst_svm = to_svm(dst_vcpu);
+
+		/*
+		 * Transfer VMSA and GHCB state to the destination.  Nullify and
+		 * clear source fields as appropriate, the state now belongs to
+		 * the destination.
+		 */
+		dst_vcpu->vcpu_id = src_vcpu->vcpu_id;
+		dst_svm->vmsa = src_svm->vmsa;
+		src_svm->vmsa = NULL;
+		dst_svm->ghcb = src_svm->ghcb;
+		src_svm->ghcb = NULL;
+		dst_svm->vmcb->control.ghcb_gpa = src_svm->vmcb->control.ghcb_gpa;
+		dst_svm->ghcb_sa = src_svm->ghcb_sa;
+		src_svm->ghcb_sa = NULL;
+		dst_svm->ghcb_sa_len = src_svm->ghcb_sa_len;
+		src_svm->ghcb_sa_len = 0;
+		dst_svm->ghcb_sa_sync = src_svm->ghcb_sa_sync;
+		src_svm->ghcb_sa_sync = false;
+		dst_svm->ghcb_sa_free = src_svm->ghcb_sa_free;
+		src_svm->ghcb_sa_free = false;
+	}
+	to_kvm_svm(src)->sev_info.es_active = false;
+
+	return 0;
+}
+
 int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
 {
 	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
@@ -1604,7 +1649,7 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		goto out_fput;
 
-	if (!sev_guest(source_kvm) || sev_es_guest(source_kvm)) {
+	if (!sev_guest(source_kvm)) {
 		ret = -EINVAL;
 		goto out_source;
 	}
@@ -1615,6 +1660,12 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		goto out_source_vcpu;
 
+	if (sev_es_guest(source_kvm)) {
+		ret = sev_es_migrate_from(kvm, source_kvm);
+		if (ret)
+			goto out_source_vcpu;
+	}
+
 	sev_migrate_from(dst_sev, &to_kvm_svm(source_kvm)->sev_info);
 	kvm_for_each_vcpu (i, vcpu, source_kvm) {
 		kvm_vcpu_reset(vcpu, /* init_event= */ false);
-- 
2.33.0.309.g3052b89438-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565A830F5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhBDO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236989AbhBDO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jUr+tmlbfe26lT1HbTjriGoxUIz6fxE/dcDciuB+Ug=;
        b=VvLzoGRETOzp7PaV6lrO04JyqDRf5zTHTYrqWxlRNUVYAT6BW/YtiDoCG9cFvie+fgVPC1
        lxZzXlA/L1PG0OI/PQRJGiQdwykDatxhlV+1H8vi9TjQ/tEqpbfiUaMtmftnPl7pq+2U7j
        3y3+g9ONfhVZJjd1ntOVlGHracmuh8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-sxLL1LtJMmOxE-hTFQGubw-1; Thu, 04 Feb 2021 09:54:35 -0500
X-MC-Unique: sxLL1LtJMmOxE-hTFQGubw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF988030B1;
        Thu,  4 Feb 2021 14:54:34 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D7660BE2;
        Thu,  4 Feb 2021 14:54:34 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH v2 1/2] KVM: x86: reading debug registers cannot fail
Date:   Thu,  4 Feb 2021 09:54:32 -0500
Message-Id: <20210204145433.243806-2-pbonzini@redhat.com>
In-Reply-To: <20210204145433.243806-1-pbonzini@redhat.com>
References: <20210204145433.243806-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_get_dr and emulator_get_dr accept an in-range value for the register
number so they cannot fail.  Change the return type to void.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/kvm_emulate.h      | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 3 +--
 arch/x86/kvm/x86.c              | 9 ++++-----
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 717940e97f66..c6215f62a0f6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1560,7 +1560,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
 int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
-int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val);
+void kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 43c93ffa76ed..0d359115429a 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -205,7 +205,7 @@ struct x86_emulate_ops {
 	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
 	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
-	int (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong *dest);
+	void (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong *dest);
 	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong value);
 	u64 (*get_smbase)(struct x86_emulate_ctxt *ctxt);
 	void (*set_smbase)(struct x86_emulate_ctxt *ctxt, u64 smbase);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 777177ea9a35..049fbbd0aa1a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5142,8 +5142,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	if (exit_qualification & TYPE_MOV_FROM_DR) {
 		unsigned long val;
 
-		if (kvm_get_dr(vcpu, dr, &val))
-			return 1;
+		kvm_get_dr(vcpu, dr, &val);
 		kvm_register_write(vcpu, reg, val);
 	} else
 		if (kvm_set_dr(vcpu, dr, kvm_register_readl(vcpu, reg)))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9f931c63293..dcb67429b75d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1181,7 +1181,7 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 }
 EXPORT_SYMBOL_GPL(kvm_set_dr);
 
-int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
+void kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 {
 	size_t size = ARRAY_SIZE(vcpu->arch.db);
 
@@ -1198,7 +1198,6 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 		*val = vcpu->arch.dr7;
 		break;
 	}
-	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_get_dr);
 
@@ -6610,10 +6609,10 @@ static void emulator_wbinvd(struct x86_emulate_ctxt *ctxt)
 	kvm_emulate_wbinvd_noskip(emul_to_vcpu(ctxt));
 }
 
-static int emulator_get_dr(struct x86_emulate_ctxt *ctxt, int dr,
-			   unsigned long *dest)
+static void emulator_get_dr(struct x86_emulate_ctxt *ctxt, int dr,
+			    unsigned long *dest)
 {
-	return kvm_get_dr(emul_to_vcpu(ctxt), dr, dest);
+	kvm_get_dr(emul_to_vcpu(ctxt), dr, dest);
 }
 
 static int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr,
-- 
2.26.2



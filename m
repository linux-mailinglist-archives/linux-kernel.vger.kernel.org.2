Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A98444A01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKCVCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKCVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:02:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474FC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:59:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so2064872pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xTgBZ3aUkpRjLHk3ctQL2ILDV64FYMM7zW30pwE3cJ4=;
        b=akVDgMvsxMWbhi2B6U5W1JyAWvr80b+nKmtmYh5ddBldjbXn8pnR93MRgqfbl/Yg8u
         h9qAqfO9WuvAoeO2QRYK2BVdYQcVfoswThLyt49bpjeC7pYqDjBgF71Zn02G1HisLjjN
         pnCaK7fwqUKZJjPUqQvM4OqcHWX0E2FXtUwslz/iqo846vesan85vRlxyCWHrVbFaKnf
         T/R9hHv0w09wLdqreki5TMGUZuNnjOBAjQ03xEFl0WI+BzsVz3oCQ1a84UDB8/1zS+kp
         6yeSfBZNhfddafNng5JrMYuXFke4Y0L0BdJYNfbOG9b21DqWNrP/eybE+D14baad7gWw
         biFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xTgBZ3aUkpRjLHk3ctQL2ILDV64FYMM7zW30pwE3cJ4=;
        b=ybNZ/niXjPL4yzgNrTtOZT3ZWorYAffw7Q7M26oa1N4+N+QrK2ECFOPM0TmuKCjqDi
         INsuhvVUGmNMnfAn0zKVr5HzaOANIm72OhaiFqIEMuOC+EBX1leSi9fC7YbZEE5gUFWV
         NM1Y/wHI7oi1AICGE1i1G9z9m3VmzcAYKD0bl2tsfR6QqVDgfSHNn2Nm/DMDhnoCk0Od
         IknVqwArQepeAY6fAkZP81bVjZgffrxrPdS6UEjA6XjAyWPJ9xop7WGTj5MNtDJ2DuPr
         dzGJMdH2nIhfo4NFUpsNgp7dRZAmNCx0BvUHyg0erXnP1z1j7R1PQ2YCyxJPGhKr41JF
         On2A==
X-Gm-Message-State: AOAM530WfBQCNrXbKluFDPlkuz+X3x2z4kj4+Xmnuz1E6aVPhZ0W9lzs
        lUYaMl6o9HPYwON05yQ98b7mE6IiXKP4
X-Google-Smtp-Source: ABdhPJyTV8gcbr2Lf09n0IS6Yj/Yf1afXvJLecmCPatiOLW0UNzAlWHpj7qhGhk6iHCvsNEjw7LRood0Rm14
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:902:6b0c:b0:13f:aaf4:3df3 with SMTP id
 o12-20020a1709026b0c00b0013faaf43df3mr41217391plk.75.1635973172641; Wed, 03
 Nov 2021 13:59:32 -0700 (PDT)
Date:   Wed,  3 Nov 2021 20:59:11 +0000
In-Reply-To: <20211103205911.1253463-1-vipinsh@google.com>
Message-Id: <20211103205911.1253463-3-vipinsh@google.com>
Mime-Version: 1.0
References: <20211103205911.1253463-1-vipinsh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 2/2] KVM: Move INVPCID type check from vmx and svm to the
 common kvm_handle_invpcid()
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle #GP on INVPCID due to an invalid type in the common switch
statement instead of relying on the callers (VMX and SVM) to manually
validate the type.

Unlike INVVPID and INVEPT, INVPCID is not explicitly documented to check
the type before reading the operand from memory, so deferring the
type validity check until after that point is architecturally allowed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 -----
 arch/x86/kvm/vmx/vmx.c | 5 -----
 arch/x86/kvm/x86.c     | 3 ++-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 21bb81710e0f..ccbf96876ec6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3119,11 +3119,6 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	type = svm->vmcb->control.exit_info_2;
 	gva = svm->vmcb->control.exit_info_1;
 
-	if (type > 3) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e41d207e3298..a3bb9854f4d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5505,11 +5505,6 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
-	if (type > 3) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
 	/* According to the Intel instruction reference, the memory operand
 	 * is read even if it isn't needed (e.g., for type==all)
 	 */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac83d873d65b..134585027e92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12443,7 +12443,8 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		return kvm_skip_emulated_instruction(vcpu);
 
 	default:
-		BUG(); /* We have already checked above that type <= 3 */
+		kvm_inject_gp(vcpu, 0);
+		return 1;
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_handle_invpcid);
-- 
2.33.1.1089.g2158813163f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08937D298
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351127AbhELSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241660AbhELQ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B8FE61446;
        Wed, 12 May 2021 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620834897;
        bh=VMYFnsJK3wMja7DJnsSZzJXMs/jaHb+mBoWOaUk4RPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNcMyDExMI4BdCPyBS3RP3YXEkpqotHNwPsWtkH+MlTaooJ29ifTkIXgaO2tQRoa+
         K44Xkzg1PAYmAOSomccKArNui/EEWIEhIYLzaj3U58JpS/gRURwXFCz+sPvNXIEXLS
         i1Ci6b879wwgHxIGetfC4tXh2bQnZuvmRbnNp/X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.12 110/677] KVM: x86: Check CR3 GPA for validity regardless of vCPU mode
Date:   Wed, 12 May 2021 16:42:36 +0200
Message-Id: <20210512144840.873266670@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144837.204217980@linuxfoundation.org>
References: <20210512144837.204217980@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit 886bbcc7a523b8d4fac60f1015d2e0fcad50db82 upstream.

Check CR3 for an invalid GPA even if the vCPU isn't in long mode.  For
bigger emulation flows, notably RSM, the vCPU mode may not be accurate
if CR0/CR4 are loaded after CR3.  For MOV CR3 and similar flows, the
caller is responsible for truncating the value.

Fixes: 660a5d517aaa ("KVM: x86: save/load state on SMM switch")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210422022128.3464144-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1072,10 +1072,15 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, u
 		return 0;
 	}
 
-	if (is_long_mode(vcpu) && kvm_vcpu_is_illegal_gpa(vcpu, cr3))
+	/*
+	 * Do not condition the GPA check on long mode, this helper is used to
+	 * stuff CR3, e.g. for RSM emulation, and there is no guarantee that
+	 * the current vCPU mode is accurate.
+	 */
+	if (kvm_vcpu_is_illegal_gpa(vcpu, cr3))
 		return 1;
-	else if (is_pae_paging(vcpu) &&
-		 !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
+
+	if (is_pae_paging(vcpu) && !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
 		return 1;
 
 	kvm_mmu_new_pgd(vcpu, cr3, skip_tlb_flush, skip_tlb_flush);



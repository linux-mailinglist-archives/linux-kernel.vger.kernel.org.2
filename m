Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19430E832
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBDAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhBDACL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:02:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78BC06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:01:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n81so1494286ybg.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kbECJ51yB90Mpm+amQG+1r2/0hpCKqj/OUqn0H3TWgk=;
        b=tonq77jJEq5KfadmjUp1FxNdkrfBDEoCcDfbDxDMtH8JeXiV0wybfLmJ60pyX6C1a5
         6fiwTAU9fg7tGgvwV4mqkOpre191BMFL2D0kVklaCiMo6KtVDrYcQVS1lShRbihZKRu/
         bhSxzZ9DD62P7ncRF7OV3TdfiQK990/wvpCNTdqb9JbYea7TRnnZUqX9XOO6jf8Al2QY
         4Wand2CzCmxEJ0TPYXF23CQm9XD12WExYhxqSf0lCxqkJ348ebUjDDSSxqJFb/DE1nfd
         4ymbLMZ675fsEMoFccBLVsqVa3BGJBINhymqV4sM5Ffq0p6PMv/p7njFDpoilB1XAWOf
         kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kbECJ51yB90Mpm+amQG+1r2/0hpCKqj/OUqn0H3TWgk=;
        b=ULJK4RVQwSX8E9c2ldE4VR6D/bjQk0VB/ubToKnq2HPjn92JwbPPjBKf/SZVyNO7tI
         Aukahj0DRjG+dXcIcXcr6FLbfcbENqijDjz7tlnRqpCaJMY037Q1kKP0kF/kntqE1TYG
         /EWQLlC67CoowhdPr82UbPr0BV/JrpIWXgU/9PD8iXvVP780XqoU5pGTk+p75sroHN0C
         7kq1TT12m+EYJSBIU+sou1wB3NMcdExEiCvkPqgnYZobIUmGAzJYvGT3D3CjK6Npxtsw
         oRAkpxRZ7ZdBTKJoipIUAfh4ZZr1psxGSibONHQcs+sb4HZNmFRpFdD8KUjyA46225Ql
         SAKg==
X-Gm-Message-State: AOAM530TB3wU8KW8ZNu91HXhemLBDIEjoAPpw4vLbSQLAvoNqtdfO68U
        2hYaK4xDMMAeKE06kBQoeB4H0freimU=
X-Google-Smtp-Source: ABdhPJyB0swS6XZarHCPmv3gUPrNicEPC3aReYqP8MBm8ApkabZlXsWr5U0UlFlK9Blz4/hD+/gZqUwM9iY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
 (user=seanjc job=sendgmr) by 2002:a5b:410:: with SMTP id m16mr8604874ybp.451.1612396890526;
 Wed, 03 Feb 2021 16:01:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Feb 2021 16:01:07 -0800
In-Reply-To: <20210204000117.3303214-1-seanjc@google.com>
Message-Id: <20210204000117.3303214-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210204000117.3303214-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 02/12] KVM: nSVM: Don't strip host's C-bit from guest's CR3
 when reading PDPTRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't clear the SME C-bit when reading a guest PDPTR, as the GPA (CR3) is
in the guest domain.

Barring a bizarre paravirtual use case, this is likely a benign bug.  SME
is not emulated by KVM, loading SEV guest PDPTRs is doomed as KVM can't
use the correct key to read guest memory, and setting guest MAXPHYADDR
higher than the host, i.e. overlapping the C-bit, would cause faults in
the guest.

Note, for SEV guests, stripping the C-bit is technically aligned with CPU
behavior, but for KVM it's the greater of two evils.  Because KVM doesn't
have access to the guest's encryption key, ignoring the C-bit would at
best result in KVM reading garbage.  By keeping the C-bit, KVM will
fail its read (unless userspace creates a memslot with the C-bit set).
The guest will still undoubtedly die, as KVM will use '0' for the PDPTR
value, but that's preferable to interpreting encrypted data as a PDPTR.

Fixes: d0ec49d4de90 ("kvm/x86/svm: Support Secure Memory Encryption within KVM")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1ffb28cfe39d..70c72fe61e02 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -58,7 +58,7 @@ static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
 	u64 pdpte;
 	int ret;
 
-	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(__sme_clr(cr3)), &pdpte,
+	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
 				       offset_in_page(cr3) + index * 8, 8);
 	if (ret)
 		return 0;
-- 
2.30.0.365.g02bc693789-goog


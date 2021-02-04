Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2030E82E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhBDACQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhBDACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:02:09 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BBC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:01:28 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id v1so828482qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xlob3SxVBzuk6VwhTKCHNdeQ5cEpkkL7dVmYnzLmun0=;
        b=pCmvpt0R661t/A0DjVN4wniue+VW7yOO9Lz/O/Xm7JfDLttlBTqYdxSlV4GkuGR9jU
         a9LIq3BEDUe05rDusUEU75qDQiaYVUHS5bzdEMX2FPjZg/CXoLDQt9rij4eoLs7LfDHp
         Ezuk43HAN3Mk/CHRnVJaAezIf+YKeVexCGCml8eMfx+1Q97YlZfVLpzkk8RmoTwuMjfU
         QtfryjianriFO4Q3xaHTUV4y+VfFuhfxjsiC4u2Tk2Sp4SXp/mStsWuD49fY5yi+naxC
         43HAuW+/GDYbShHoazRXNnYzbynTUSSiXnKWWUgeY9sHLK8j+MOEXQrBTX/OCDVzraAz
         LBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xlob3SxVBzuk6VwhTKCHNdeQ5cEpkkL7dVmYnzLmun0=;
        b=IBIfZxQ5OqZS2W3dRf5tXWK6L19jK9E0LJaMW9+27GPBHbKRSzAcGYNF72pe49MOEQ
         tAw2xnCvHVT5pp6KaqXLWs2ujFIlDOcvcydrnNZSyEUkM476Jnk8ySjE7Wuz+EFIB743
         UTw2UMW+Ae5wMGY2dbGOGpueSwae7Bqd2C/3PuNvxSWJ716FTIDkbkUEhrwCA00xY0Ft
         j1JbUWy3MRw+RzBACBmMPA5jRtFK5371DRCDAgEimWM8eszN2wSdNVTRDStgxefpwuJx
         rAyB23FZEMNsKx948C1nvz7bGnW8eoZs7cSDbhrtgE58TsfILallDRtJRGhwCFUSW7v8
         Fklg==
X-Gm-Message-State: AOAM530alLesyo8Zrojh/vW/WhCYHZklsdCrg2NPCSlENnrDX6QB1vnb
        b3kKgl7uiYLyUw6gbWMUeScPHbJ1Kec=
X-Google-Smtp-Source: ABdhPJwbxo0jhQm0FLX75tZWB7FNsV1Ul3pvxTbJF9kRwBzPSD9aQGisdB56VNOpsohROXiIsNxiNEsR3GQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
 (user=seanjc job=sendgmr) by 2002:a0c:c78c:: with SMTP id k12mr5114776qvj.47.1612396888075;
 Wed, 03 Feb 2021 16:01:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Feb 2021 16:01:06 -0800
In-Reply-To: <20210204000117.3303214-1-seanjc@google.com>
Message-Id: <20210204000117.3303214-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210204000117.3303214-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 01/12] KVM: x86: Set so called 'reserved CR3 bits in LM mask'
 at vCPU reset
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

Set cr3_lm_rsvd_bits, which is effectively an invalid GPA mask, at vCPU
reset.  The reserved bits check needs to be done even if userspace never
configures the guest's CPUID model.

Cc: stable@vger.kernel.org
Fixes: 0107973a80ad ("KVM: x86: Introduce cr3_lm_rsvd_bits in kvm_vcpu_arch")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 667d0042d0b7..e6fbf2f574a6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10091,6 +10091,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	fx_init(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
+	vcpu->arch.cr3_lm_rsvd_bits = rsvd_bits(cpuid_maxphyaddr(vcpu), 63);
 
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
-- 
2.30.0.365.g02bc693789-goog


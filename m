Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3536899C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhDWAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbhDWAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:07:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68004C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p9-20020a2574090000b02904e2cb6a90e7so22190482ybc.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=lASHK+mshsNE6LJP7Zp6NlK5R8UQDK0WUI+mht9WyPE=;
        b=nR8t0PkGYw/2A/kvZCxu8TfVsllhGN5jOk7SvtzvsvBN+Tx3hsA3m7H2B/lA9cyoKy
         GMPQqsT8Ufna//5YSSNqhXz7CMeDFiBY6DMf3Mzn6p2FqJLDDEJJ1VbCqnHmj4r95II3
         kFxNHKjI68ahJRvg2xZLwaC3dyAMIqG3aiDKkZLNjbEw1rZzjqpIfnCVM/g2URB4/Gu8
         rUFeGo+YNLUy6UChPG6ksDUtNmFBvbtISKq75LvNpIQQax5aHt0S22AwuUvdVc2xjek+
         n+zW3wej9JKPjp4cQ0mD+CJyYmCeTtlV8S3/lT0Vsl8ZWCawIQl55kAx7/MtuXxOPiKt
         l6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=lASHK+mshsNE6LJP7Zp6NlK5R8UQDK0WUI+mht9WyPE=;
        b=TCMZH5MMN2ZVBFBJhB6uAYGqFLOxFyx7nMCKtuTTpZheCM1B86IiNW8SSVMM0/B8KP
         jA/m/X4CeOjUzJhLEaZUeJUUjGH3m217rzY4Vl0Di/K3HhitU+6EuCfVqGgMgE0Od4uE
         u7crYK8FTXeIOb/gA8zk/T1CW0AuHUq6FlXXpRB1saBQvZySBjangaDlZnvPUom8yW0R
         +xO2DboQbjpHXbApsG5mDjHp+6FgP+kcX3lryjT70D/1PeBtzi0LKdGr0YNkm0PEdd8P
         aJbaQZ5jTyaHSLAWpGSheT+VcXiEOLXKREl8Q01KQK9rukMQLJ1yfudJcpS9xM2QC2oR
         5veg==
X-Gm-Message-State: AOAM531CWZQ9MD6jvrZGiJb5nO0Eny/BsBtQg53hhOUNiSNcfTh/K9l7
        xoRNsqzyzjx8MBYJu4P6PbCtZG44rHY=
X-Google-Smtp-Source: ABdhPJy7d9MnSiTtuKa3JHkCqRIujr96wSnEQOCKmysEuCLbTdPmBdl16HXOQgwFsTodV7qVQbg9XHlS9gA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a5b:611:: with SMTP id d17mr1784818ybq.421.1619136402687;
 Thu, 22 Apr 2021 17:06:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 22 Apr 2021 17:06:34 -0700
In-Reply-To: <20210423000637.3692951-1-seanjc@google.com>
Message-Id: <20210423000637.3692951-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210423000637.3692951-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 1/4] KVM: nVMX: Drop obsolete (and pointless) pdptrs_changed() check
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

Remove the pdptrs_changed() check when loading L2's CR3.  The set of
available registers is always reset when switching VMCSes (see commit
e5d03de5937e, "KVM: nVMX: Reset register cache (available and dirty
masks) on VMCS switch"), thus the "are PDPTRs available" check will
always fail.  And even if it didn't fail, reading guest memory to check
the PDPTRs is just as expensive as reading guest memory to load 'em.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 00339d624c92..eece7fff0441 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1118,11 +1118,9 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
 	 * must not be dereferenced.
 	 */
 	if (!nested_ept && is_pae_paging(vcpu) &&
-	    (cr3 != kvm_read_cr3(vcpu) || pdptrs_changed(vcpu))) {
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))) {
-			*entry_failure_code = ENTRY_FAIL_PDPTE;
-			return -EINVAL;
-		}
+	    CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))) {
+		*entry_failure_code = ENTRY_FAIL_PDPTE;
+		return -EINVAL;
 	}
 
 	/*
-- 
2.31.1.498.g6c1eba8ee3d-goog


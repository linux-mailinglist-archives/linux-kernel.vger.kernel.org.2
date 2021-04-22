Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65E367756
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhDVCWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhDVCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:22:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592CC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l6-20020a5b05860000b02904e88b568042so18246800ybp.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Uj1R8VprO2gM5yhQ4t81phLa7RLpkl0ODVfMpjrgkqY=;
        b=Yy+DVFdlTw9aM63kzi9kxH+PoSHP60EBjg6elE5JzuACffosNEgEqvyAdgz5Ayrcb4
         06oFMFgGTR/OsWrWTSS3Ti/McyLexYEpSsd24tHn4F8fXxCiixBc5TbMSXihtwSbSlhY
         jjj/VMlfS+SHmZ+pxg5GX6iFDTAx0ImDLm8ghIc8XUcCAABgU55TKkwmlesHipKwnztg
         bM6+kYiwC0/0DZv+3ilWx2xXtO6I0YrIY4IWdsc8YPHgb+ngiFSZBQVNpAUwFLCHs+JF
         90Z7gYArMfYoL8ghMlubFK3otqSQS9MgJIh7LXokGYFY7WfQyhu2A1qoVOxRvQ2HSZ68
         bVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Uj1R8VprO2gM5yhQ4t81phLa7RLpkl0ODVfMpjrgkqY=;
        b=ZmwJVK7C3BCm9EFaQlFUqTTNsifVpyMmFfat+E/B8dwmBQ18XDt6KCPHQK9l+smlvA
         1GySNJEf3EXyNjwSUoPmRLL3kN/lyyjgOD+nN+QLXBu0gGkH8X4KYlvfz1Cd3mWSKpay
         5tg9Rn0K3S7OnRK7w3TMbFU4SIqPLD/lfPHj7//cI7V9KXstKpHWinOh3wsgSgBKl7yY
         lCeZRcAZSxF7E6ciombnv67zyCKpP38y3cF5ihF1hmQZJY7XAbVGsCb88d5uRt6EhcG5
         6EeVcmRrb2PYpXq1Tl9UguzgyTX24ENdBmefWXzmZj8XWc2jewYm9742OcvAEflydil/
         asBg==
X-Gm-Message-State: AOAM532KqbgicO8IPCim67uhqyZ/6qM3nnwzA89P13QcEWcLrEmSKFRz
        pSXq+jPcQAB7MDMwrdv/hywTDzBple8=
X-Google-Smtp-Source: ABdhPJwyzZUT8XH+KgxDn0ZjmaqtN8tI1gG/eA2OAPLHcjfMH3kmb4Z1e2oRIfOD1RLf9qGNUh0UIYT0h50=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:b6c5:: with SMTP id f5mr1365721ybm.407.1619058095408;
 Wed, 21 Apr 2021 19:21:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:21:21 -0700
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Message-Id: <20210422022128.3464144-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210422022128.3464144-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 2/9] KVM: x86: Check CR3 GPA for validity regardless of
 vCPU mode
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check CR3 for an invalid GPA even if the vCPU isn't in long mode.  For
bigger emulation flows, notably RSM, the vCPU mode may not be accurate
if CR0/CR4 are loaded after CR3.  For MOV CR3 and similar flows, the
caller is responsible for truncating the value.

Note, SMRAM.CR3 is read-only, so this is mostly a theoretical bug since
KVM will not have stored an illegal CR3 into SMRAM during SMI emulation.

Fixes: 660a5d517aaa ("KVM: x86: save/load state on SMM switch")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9ba6f2d9bcd..63af93211871 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1078,10 +1078,15 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
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
-- 
2.31.1.498.g6c1eba8ee3d-goog


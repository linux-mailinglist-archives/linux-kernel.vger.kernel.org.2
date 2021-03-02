Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07232AD6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837574AbhCBV6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581591AbhCBS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:59:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9AC061A2A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p136so23681048ybc.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VvZxbsS7usA2XSAkfRC0sbz46vD+BnH1u7vFisa6mO0=;
        b=V1nMCm/qEh7jjrjHA5O0Kq+9vwKGhxQ0BuRI1m3H0kbtdE/n3BBMW8oK2oQr9bXjDt
         PlVkbEtvf6X7KthvohEdaYM5+qKB3tfWC2CPgUN7T50xS0/rXXJxB7k4/Gufjj41M4V8
         35IencokX7qCTSsMr9RRQmdZkFBqdMuM6xkHBfy/Am0ikQDoXz19y01yRfgiyvkX2LwS
         jR8faVtHCxd1J/ek0BWuTSFEqB/mNoiCjh8ubc1pSXHPqkkU/gIrMevjKjalqfo97ZkQ
         QFSUYvzLJpV8YpwkK+kdQtAa7LC+ugUgOcaswbEby5TKIM7y31fFovUze0OUkvbQkIE5
         YB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VvZxbsS7usA2XSAkfRC0sbz46vD+BnH1u7vFisa6mO0=;
        b=RIiC1uH0iwwKgn11TyvKK6FacIk+rju9ITL10b6/1bQX8w3e92ftToMe7vNpfapZwV
         ckAD7BfgjzNdGbkCCbUxXy4g1uX959lDjZncNnk88xE/E6rqcpWHfwm2DyvfAAIBoDb/
         vWa8VcP0ZFG2pcF4wylGe1sZQGFR0TFI+VAjXt1s1njuZcZFBpadXLHlXYUf3Ll0POaP
         p9g1O8HfShpyeuZ3v7g+DDK8snq1SAoq6i8H0QP1/7tMVI+bL6Ag7jIWUC2bnrm/p7Co
         /l4nqUYGZuGfZOwgNcTmUlvxq53yJu2gQwKdJ/S7ynhkwPCWxm4wkDDlfb3YKUeEoBMM
         BlNw==
X-Gm-Message-State: AOAM532uPmz2ptkwQbTb7PcFw6y9t3A/Hs+RIulDQxjPjLNXG2RC6VCS
        VbqLarqCh3hP9yqlYa3MAtPkoB9tdZA=
X-Google-Smtp-Source: ABdhPJzA/JVavTc1YLp1/c2Tzi52WiK+H305SJZmZc1wRoh9Mn2md0n0TSnsgq5eJ1jz5pb6Ia41rdwDf0E=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:d843:: with SMTP id p64mr31348287ybg.339.1614710773295;
 Tue, 02 Mar 2021 10:46:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:36 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 11/15] KVM: nVMX: Defer the MMU reload to the normal path on
 an EPTP switch
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer reloading the MMU after a EPTP successful EPTP switch.  The VMFUNC
instruction itself is executed in the previous EPTP context, any side
effects, e.g. updating RIP, should occur in the old context.  Practically
speaking, this bug is benign as VMX doesn't touch the MMU when skipping
an emulated instruction, nor does queuing a single-step #DB.  No other
post-switch side effects exist.

Fixes: 41ab93727467 ("KVM: nVMX: Emulate EPTP switching for the L1 hypervisor")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fdd80dd8e781..81f609886c8b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5473,16 +5473,11 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 		if (!nested_vmx_check_eptp(vcpu, new_eptp))
 			return 1;
 
-		kvm_mmu_unload(vcpu);
 		mmu->ept_ad = accessed_dirty;
 		mmu->mmu_role.base.ad_disabled = !accessed_dirty;
 		vmcs12->ept_pointer = new_eptp;
-		/*
-		 * TODO: Check what's the correct approach in case
-		 * mmu reload fails. Currently, we just let the next
-		 * reload potentially fail
-		 */
-		kvm_mmu_reload(vcpu);
+
+		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 	}
 
 	return 0;
-- 
2.30.1.766.gb4fecdf3b7-goog


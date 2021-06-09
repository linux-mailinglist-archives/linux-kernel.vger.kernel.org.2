Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF73A20E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFIXpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFIXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA80C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:42:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k12-20020a0cfd6c0000b029020df9543019so16755605qvs.14
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zb4BgBHrj3z234wVPkDQ98HLS1UUgQ6DIJZgVdXDBds=;
        b=g/HXga9GcQ4nONrdSa0q1CxhKd1rennpVPxoeipm+a5+/DzEA9X2i5YtsuWEXG25t3
         DnnDVM2jong448xcz0BXsCL7LMlZR+ZRN6Px3RPGIoNK1CyDjsS8Ob1ml/97DORJzTln
         i4ZkNF86Luqpqza7MDEIUFYqLFrF57CK6B8qmjhr+WUmuxF7kYN0qibLRf8EPy2rt2C4
         0T/PJ2PtXbyTfm/VvXdLAjO3iF9WrfEmIQr3qScTeHscTyn5htdTSOm8aWzvu3h3rVEO
         Pg34qcOTy02QviOOM4AXNOzw0FxNF0KvoG8F5ZIIJpjqfuKx6U6x37xYZgH0Mpe33pmo
         GgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zb4BgBHrj3z234wVPkDQ98HLS1UUgQ6DIJZgVdXDBds=;
        b=aT2/2dp1Lz469ig8b50/LM0W1ztab5+MMjfBExoHx0+SuJjKnc3+H+YaVqaqhT6hVz
         N6FsYPPEWmV47ZLPrLzrl7stxX30D7/C/vubhiey9YihuaMl7km24WSEDUQNOYIpAJJb
         wYA6DR+E//SoKqJbkj/9MD/DEPgJpxNjsnVy0SvQDnXlks6Guj7gaNymd1coSRyEO8RI
         k4XJRV5RJYgMG5jW6r/De08L7tHWbvCaJ1Glc/FV/Kaz58B1J87TJDEUGMp1DjA0/Gvj
         +PcTuH/ZOqFE5uZRUqzJlONXh509wH/vX9LM168s6surghVIIm8FGH4b0k2lbUXz8Wcl
         XlXg==
X-Gm-Message-State: AOAM532LcREDRM/7amCJ2VPP3VyFanSJgezj4PtNk60nlLI5muZVZB34
        hChTLYD1fRGnFIa/G3+GaweMFE7WXF4=
X-Google-Smtp-Source: ABdhPJzLiGRqYKhQpiJw4Ox9Mpuyg4GqiBUdrg+GEm8Q6sIJdKTPuIUixfOa55zZay0YzPthMxaoysV9S9E=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8daf:e5e:ae50:4f28])
 (user=seanjc job=sendgmr) by 2002:a0c:ea83:: with SMTP id d3mr2600334qvp.25.1623282169148;
 Wed, 09 Jun 2021 16:42:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 16:42:23 -0700
In-Reply-To: <20210609234235.1244004-1-seanjc@google.com>
Message-Id: <20210609234235.1244004-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210609234235.1244004-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 03/15] KVM: nVMX: Don't clobber nested MMU's A/D status on
 EPTP switch
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bogus logic that incorrectly clobbers the accessed/dirty enabling
status of the nested MMU on an EPTP switch.  When nested EPT is enabled,
walk_mmu points at L2's _legacy_ page tables, not L1's EPT for L2.

This is likely a benign bug, as mmu->ept_ad is never consumed (since the
MMU is not a nested EPT MMU), and stuffing mmu_role.base.ad_disabled will
never propagate into future shadow pages since the nested MMU isn't used
to map anything, just to walk L2's page tables.

Note, KVM also does a full MMU reload, i.e. the guest_mmu will be
recreated using the new EPTP, and thus any change in A/D enabling will be
properly recognized in the relevant MMU.

Fixes: 41ab93727467 ("KVM: nVMX: Emulate EPTP switching for the L1 hypervisor")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c3624109ffeb..e102a5c10a83 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5488,8 +5488,6 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 {
 	u32 index = kvm_rcx_read(vcpu);
 	u64 new_eptp;
-	bool accessed_dirty;
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
 
 	if (!nested_cpu_has_eptp_switching(vmcs12) ||
 	    !nested_cpu_has_ept(vmcs12))
@@ -5498,13 +5496,10 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 	if (index >= VMFUNC_EPTP_ENTRIES)
 		return 1;
 
-
 	if (kvm_vcpu_read_guest_page(vcpu, vmcs12->eptp_list_address >> PAGE_SHIFT,
 				     &new_eptp, index * 8, 8))
 		return 1;
 
-	accessed_dirty = !!(new_eptp & VMX_EPTP_AD_ENABLE_BIT);
-
 	/*
 	 * If the (L2) guest does a vmfunc to the currently
 	 * active ept pointer, we don't have to do anything else
@@ -5513,8 +5508,6 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 		if (!nested_vmx_check_eptp(vcpu, new_eptp))
 			return 1;
 
-		mmu->ept_ad = accessed_dirty;
-		mmu->mmu_role.base.ad_disabled = !accessed_dirty;
 		vmcs12->ept_pointer = new_eptp;
 
 		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
-- 
2.32.0.rc1.229.g3e70b5a671-goog


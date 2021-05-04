Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D396372EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhEDRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhEDRTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:19:05 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:18:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso4023837qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OfxrzbCyayDhIsgc+QsgzNeUTDdIWPqYIy1TjIvLC5Y=;
        b=QJ3Hkp2+Ym0T9YKmjqMWJvgu3kPTtTxOSvakW/z/eVcGcwWHYaOjwvTKYbuvwTfaIF
         qBwf/FVLAnsMogpo9M59vB2p0NsyV4Ho3A1HW2P/t2OxEG/jq4mYRrcyhj0FYG5nzu7T
         FDUlut38RLct/pFsq/vDamxiVrg6s1IQksMtj/5QnP9+OHZ3iOhoz7sN2sptcSpo0Izi
         V16YnJ9OrgXKaz7caMvCC41x4/+ajPUOJXU7tS8c2qbwLlONrJPEct8BUgsovVUTWCDm
         HB0FGx9dHdGIQGcxQ2EnOMoy3ZBUzhdNm6V5zjebIi1o3CHHh9F5vA6o+t/NyRG//dO/
         GlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OfxrzbCyayDhIsgc+QsgzNeUTDdIWPqYIy1TjIvLC5Y=;
        b=mZiXmINaUGQTTcPyC7TGamsy+6JeQl6RovBXADT94ecuC1cPDvfmPK1eWieSJksJZ8
         zdqFmahF5+1nrGqbL/1Vx1g3ZEWRJkEXbqyG98B3NaIHHXYxxMKVItef3ladyxSeh5aG
         hFCleqLeBsZA/pzmcUDxU1x2w0bSpkx8sGv8kDr4JqXoaNibJB13pb/71dH4s8HuzM/n
         dv+E9bFFzJIDs8GkKOyzXFWaNiTYy1mhxcXjxKtamwn/APgdAdz+j/BSqNNVaeMJrdL5
         yK0+xzX/zYcKMKlu/KQVoQTeybijwh1QKE51st+p9hhHvtWcIsmTj7gnaqJJRjQQBJ9u
         /t0w==
X-Gm-Message-State: AOAM531b2zhtYXbqZMYMfiBrNFAFGeEY/cFqvv8VHDvet1dDzF8xhzrS
        LXWVWg6l0cpjNDPkG6xVNy1hfzYBwKQ=
X-Google-Smtp-Source: ABdhPJyOGmfzlqBR28ALLywAnRsDHPLL4pecU+CxalZu57YMVP1A5uIdGv3FvOoGtTUMYKqm6+SYvig3Gws=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a0c:bd2b:: with SMTP id m43mr26873037qvg.52.1620148688313;
 Tue, 04 May 2021 10:18:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 10:17:30 -0700
In-Reply-To: <20210504171734.1434054-1-seanjc@google.com>
Message-Id: <20210504171734.1434054-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 11/15] KVM: VMX: Disable loading of TSX_CTRL MSR the more
 conventional way
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag TSX_CTRL as not needing to be loaded when RTM isn't supported in the
host.  Crushing the write mask to '0' has the same effect, but requires
more mental gymnastics to understand.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4b432d2bbd06..7a53568b34fc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1771,7 +1771,13 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 			   guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDTSCP) ||
 			   guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDPID));
 
-	vmx_setup_uret_msr(vmx, MSR_IA32_TSX_CTRL, true);
+	/*
+	 * hle=0, rtm=0, tsx_ctrl=1 can be found with some combinations of new
+	 * kernel and old userspace.  If those guests run on a tsx=off host, do
+	 * allow guests to use TSX_CTRL, but don't change the value in hardware
+	 * so that TSX remains always disabled.
+	 */
+	vmx_setup_uret_msr(vmx, MSR_IA32_TSX_CTRL, boot_cpu_has(X86_FEATURE_RTM));
 
 	if (cpu_has_vmx_msr_bitmap())
 		vmx_update_msr_bitmap(&vmx->vcpu);
@@ -6919,23 +6925,15 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 		vmx->guest_uret_msrs[i].data = 0;
 		vmx->guest_uret_msrs[i].mask = -1ull;
 	}
-	tsx_ctrl = vmx_find_uret_msr(vmx, MSR_IA32_TSX_CTRL);
-	if (tsx_ctrl) {
+	if (boot_cpu_has(X86_FEATURE_RTM)) {
 		/*
 		 * TSX_CTRL_CPUID_CLEAR is handled in the CPUID interception.
 		 * Keep the host value unchanged to avoid changing CPUID bits
 		 * under the host kernel's feet.
-		 *
-		 * hle=0, rtm=0, tsx_ctrl=1 can be found with some combinations
-		 * of new kernel and old userspace.  If those guests run on a
-		 * tsx=off host, do allow guests to use TSX_CTRL, but do not
-		 * change the value on the host so that TSX remains always
-		 * disabled.
 		 */
-		if (boot_cpu_has(X86_FEATURE_RTM))
+		tsx_ctrl = vmx_find_uret_msr(vmx, MSR_IA32_TSX_CTRL);
+		if (tsx_ctrl)
 			vmx->guest_uret_msrs[i].mask = ~(u64)TSX_CTRL_CPUID_CLEAR;
-		else
-			vmx->guest_uret_msrs[i].mask = 0;
 	}
 
 	err = alloc_loaded_vmcs(&vmx->vmcs01);
-- 
2.31.1.527.g47e6f16901-goog


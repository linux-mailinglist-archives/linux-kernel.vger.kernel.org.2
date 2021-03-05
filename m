Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225AB32F2AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCESfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCESbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:31:45 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC96C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:31:45 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c1so2471776qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Rsbn/HNTRnyhwzeN24lyp/WE9lyzNH62hzhEpuOPsV4=;
        b=dAtMvBa14Eut/SotL7TsMQxj7t6qm67K1MBE0aFLgD4dvMy1D6xhg+EMaRCiPdTU2+
         sv5+o+L0DiSjKn2qIUuT+bkkzHfGr3lZDVdLdQtEg30sXsI70ymiur5/GiOAMamtenFy
         w/zavTYp1m/sPOeZyRv4P70b9Jywhhvaiky+9NVEK3OpDd4DcCxwz2tat+HZ29yLjjFr
         ItWjxfUeEj1GCpiVJ94JOxG7dAXi/vDboav5uQbBR5/8jZkRqMaQ3bFwmdt98D2PVEc5
         9yatRPsnJgyWKz4nABzoL9CHAuEkHVkMFvV9QJIeURc6GlddLtyrn11p/JiDdI9J0Ut0
         2yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Rsbn/HNTRnyhwzeN24lyp/WE9lyzNH62hzhEpuOPsV4=;
        b=o2oC2nzmqm7SWIwKrkZHF1BtdcFj9CHqKK/4rXjRXcqwYncPVPvJymPxgy3W4zpCZ+
         aZVGz1YWgV0/NgvC8LS1plCDeI/qXscPvakfx7KuALbv2BdmKVoSOSDoOH3avJySQwqq
         WX1jnUxbgnjfvi4GzijslZSGk06MGnfqXB+n3O2xHzSofi09s/QNPqijwNSxDTzLRoB5
         iAB7CGhHXM6u0Cvv/dUsmK4IkC8lb4YW25Exx4SP/oVj6p45EIJJxxHNAomzcXt7PUCo
         0EKSS/Esfw9xx0qN4Uco1Dx0ByrnF2Y20GqJAq0tTcEfdWY88omSKBUQu+xytG9BkpAf
         69pw==
X-Gm-Message-State: AOAM533ScB6OCtB8B2GQg+SEujkk/RR6Zt0dE9fdAJjsA91TQi6d7VEY
        kXONsz6RZNE0b8kW3DIxJpp3NhNAZvM=
X-Google-Smtp-Source: ABdhPJyjcCNm7PSQal+eam3lizqLiyYhUUXvYHe2LS3onAtipn2RPNvZoZaLI9usNDeoKN9oVK6KYzpeyZI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:4ae:: with SMTP id
 w14mr10001102qvz.45.1614969104803; Fri, 05 Mar 2021 10:31:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 10:31:19 -0800
In-Reply-To: <20210305183123.3978098-1-seanjc@google.com>
Message-Id: <20210305183123.3978098-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210305183123.3978098-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 07/11] KVM: VMX: Don't invalidate hv_tlb_eptp if the new
 EPTP matches
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Don't invalidate the common EPTP, and thus trigger rechecking of EPTPs
across all vCPUs, if the new EPTP matches the old/common EPTP.  In all
likelihood this is a meaningless optimization, but there are (uncommon)
scenarios where KVM can reload the same EPTP.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2582df5ae64d..cd0d787b0a85 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3117,7 +3117,8 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		if (kvm_x86_ops.tlb_remote_flush) {
 			spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 			to_vmx(vcpu)->ept_pointer = eptp;
-			to_kvm_vmx(kvm)->hv_tlb_eptp = INVALID_PAGE;
+			if (eptp != to_kvm_vmx(kvm)->hv_tlb_eptp)
+				to_kvm_vmx(kvm)->hv_tlb_eptp = INVALID_PAGE;
 			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 		}
 
-- 
2.30.1.766.gb4fecdf3b7-goog


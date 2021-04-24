Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABB369E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbhDXAz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbhDXAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:54:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7FC0612A6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s34-20020a252d620000b02904e34d3a48abso26210516ybe.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=oyVUQsNf2XbjaOTtJporiUactMrDu8dgH9+VujzngIc=;
        b=i2htVs7R+LB4UeHXF7qO4pwcNIptJJ2+4/sMOE4V28rul7Vr3jf37UUAx9N08ahTtq
         v/MjJRGHgVPMSPSz+RTrfc+dZE2UWQOXKgsoSEpipjHh3FjnOeq2mO/KKSIGIL6Bg5Eh
         lyao12REP5QCPRsqu0O1nK4+xpCGupMZ/nNVeIUPYFKZsEnOnm/RbtxufQJB1qn7bSgn
         B4eAqoSQium9JVDnDY6qhcvuedHreP/rTEhJKptxS0eZW0yGjEGagcV9KGujZrC7hfpL
         Bwg4B9+f+OecO3j8HnoT2/K54seMd79FF3Fo0ZEGPG0u1JhGkdht5HrEqj0+NF/TOD+3
         PDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=oyVUQsNf2XbjaOTtJporiUactMrDu8dgH9+VujzngIc=;
        b=chNGcwZmrLbjdcK/Mqe7PSKUbgSVUYHdSO/6X488bD8YYWwi8LbMEDcutExFJPZ5Sd
         9G/xQPl2ZnSPx9CwlRE2LNtghM7jnCLCm/3pzcT3Dy8cRIuM+IdRd5jiavmvUqXPDliQ
         qHqMP9lUkyJw4AIwaShI0JYMC6L7NK/GQ+6oCWyJJbTtVAU14ZOB0gAenYSByqC6HFCc
         YguISEKEHcAZpnZ0eDC+aUDXostMemScrwKsuLcNAN2r4cIUs0JzqFI2Y3LoPsy1/XZR
         e4YzmNyqwQXFdObv7PyWBl7sXWSlNzbPWVgJKk3nbFNq2+60cUfCnb/KCFUYKb62eZmk
         CPKw==
X-Gm-Message-State: AOAM533OoZEVLdXWKteQXBlTHLD+KcF6VKAuyMbVVzxYJqghUA/wzalJ
        qHSMEkNWIDjV4+Ar210eYFA1xpHMFa8=
X-Google-Smtp-Source: ABdhPJzHBq0sbNM2r7DOXFRJi+6RJhB/VG+TDbd1QTSuIvUr1Dy5UE8zNRs1SBS7+weybKMIxtBBMirt5sE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:a265:: with SMTP id b92mr9083215ybi.486.1619225304165;
 Fri, 23 Apr 2021 17:48:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:40 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-39-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 38/43] KVM: VMX: Don't redo x2APIC MSR bitmaps when userspace
 filter is changed
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

Drop an explicit call to update the x2APIC MSRs when the userspace MSR
filter is modified.  The x2APIC MSRs are deliberately exempt from
userspace filtering.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 45a013631f63..beaf9fefddad 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4055,7 +4055,6 @@ static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 	}
 
 	pt_update_intercept_for_msr(vcpu);
-	vmx_update_msr_bitmap_x2apic(vcpu, vmx_msr_bitmap_mode(vcpu));
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
-- 
2.31.1.498.g6c1eba8ee3d-goog


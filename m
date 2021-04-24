Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56F369E31
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhDXAyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbhDXAxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:53:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8AC0612FD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o187-20020a2528c40000b02904e567b4bf7eso26380402ybo.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=TyRU0/tPrLYATGQcgqMekR6RRGDcn8BCsFh+kG7e/tE=;
        b=SMY4s4+fzw/1Y2OOxIguwHavAdi/v6k+lTW8DHAFW/hyqvcd0GNmF7lfKiHO9+Ge3G
         ys7y3WcYFwlVue4WsLYkWnrl+8MRYkTkGgFHNBb9HVsTLY5M9daiCJHmnkCWpJuggoks
         5yh6krar0RFaqT+Csqf/4Wx4prEvk8rWonrW6mbzyQ+pla/t8wr7B87c4p6fhn9At2nt
         ZQvq8CQHkQ2M3lCX7tC/8ysu+Rp75vhqs0H2GFCoXktXEVbWbnhOuaYE2n6nnXRHv2PV
         MCGEiE1OFhcPKQC3YDrbURvs68PdwNqGTXuGITfwnEBHOF9QG9EQbvuveedXXaNp1ThU
         GBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=TyRU0/tPrLYATGQcgqMekR6RRGDcn8BCsFh+kG7e/tE=;
        b=rjBBs9ncoXmPsEklipOLUK6P/WYcL8VoM2PP9jXQ5r5ID8AftriSRCHOgLL9wPGCZt
         1AcevnHDYgXnDHyReCciAVibAirip8H2U/+eURkQY72tSnMrR+XeUfKtUrQv9qB0CQbT
         ezXdMc5bS75KzIP9jfMaSXeK+i9SZvSphXXNM14j8aDIAEeaLr587Q/7mMwRQNkOvHKw
         opvVjXeF0Wdh7ELHm39VtBlmVNeS0bz4R6jn6WehbHP4LDJaRTAYLZzmRDpS4FkMS8gs
         SM99r6KoLsxuTztsBtW7laysQaLvoFNUJL9wDc67H6sUVdwGKnpBaEErGOAXalOCFBZ/
         wHnw==
X-Gm-Message-State: AOAM531f/bFxeljB2Yy7UBBY2l/Mh9Y4RIHVrJbz4bdJDD+1MovMzOER
        7N6tpHfzuqC0gy/1zEKkaJO+OYQffQQ=
X-Google-Smtp-Source: ABdhPJza0fNO9HnQ0aPO3jH9n9Houz3G6gIcPXjHTLM8IC4W4xFSfevYb0Xq8Fxsq9cjUzNMtFJB6ZA38C8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:c444:: with SMTP id u65mr9803926ybf.93.1619225293387;
 Fri, 23 Apr 2021 17:48:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:35 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-34-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 33/43] KVM: VMX: Refresh list of user return MSRs after
 setting guest CPUID
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

After a CPUID update, refresh the list of user return MSRs that are
loaded into hardware when running the vCPU.  This is necessary to handle
the oddball case where userspace exposes X86_FEATURE_RDTSCP to the guest
after the vCPU is running.

Fixes: 0023ef39dc35 ("kvm: vmx: Set IA32_TSC_AUX for legacy mode guests")
Fixes: 4e47c7a6d714 ("KVM: VMX: Add instruction rdtscp support for guest")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bdfb3def8526..57cabef3ffd9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7313,6 +7313,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	/* xsaves_enabled is recomputed in vmx_compute_secondary_exec_control(). */
 	vcpu->arch.xsaves_enabled = false;
 
+	vmx_setup_uret_msrs(vmx);
+
 	if (cpu_has_secondary_exec_ctrls()) {
 		vmx_compute_secondary_exec_control(vmx);
 		vmcs_set_secondary_exec_control(vmx);
-- 
2.31.1.498.g6c1eba8ee3d-goog


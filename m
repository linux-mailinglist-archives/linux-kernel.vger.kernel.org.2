Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388B427550
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbhJIBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhJIBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:03:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16451C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 18:01:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so14750837ybk.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zwQuCdTORRqikJJrq1qC6FroomOZbrYRK1ulZL74DVc=;
        b=VPL6BD8DqplY2SY6r2wwMp6R71favIqg8UbS1freyl6PspIN7PB/XAXbzy7myyu/xy
         oLkUuGIFLCI0PF4R4nzPJ7dlO3VYAc966eOfv5YO3ZIDALOMl+AmWZEPBOnAdaG/jRi1
         cvV6OVK38x0C1lSI/rdvr2DPbRak4pKgdopBBCQyKs7wlCGEdkBA/PCwu1HoXVWv3r2G
         rwikWFuxpvFWMRorFycOR0xRJaCahXeDPl7+jSd8a/ZZOofDzvUergeS/N9oVr2I8i4z
         7f+4M5DoDcsCUfgpK5ztGpsmpVSAZ6zMTwkoMeXsCxRtlKOk1VpiKF3Sr/PMBJm81Wz1
         Vxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zwQuCdTORRqikJJrq1qC6FroomOZbrYRK1ulZL74DVc=;
        b=bjragLBF/SbXQef8JcF9dvo4fWGiauuIimFUvlOpfxcpnPqi1daTCAGmreN7rDTeRZ
         9hTNqhMgPppYKzGqGI6HmQO+97rjAMfSCpKCTQpdeFlZMAoc9Y/FOxEE+ojwuZzoIMMu
         eAHYO4hJYLWfhWivi3pNEaO6BSksJmoBZ0GC/L5Hepl+OOaJiUciXA6oAr0RA17rHXck
         iosQ7iLvF1DpzKuyZfDwidQdm7fRt+noYbFU2gi/FvOuv27hC2XnwT5IowCzSt2bTlsf
         jgUV9tDTMsDEHqfuv8aHMsfTabdMbQbBso4Eza1nI6CMbigYc+PsUKWLRFHWca68g9lo
         E6aA==
X-Gm-Message-State: AOAM530+Af+a75XbDZeVjRCsa4Mn9NU7Jo+ZUvX575Hha9GbRjqyAdlG
        doMdacjov19i8d5xKK9Z7FqW1LOWxGg=
X-Google-Smtp-Source: ABdhPJz/lVm1tAyG2/05wptxlPgGKBEsKfdRlSeu5DeabsGON86LvMzMY5MLwtAV5MJ8M4omaOcOR40MoTA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:5093:: with SMTP id e141mr7043195ybb.171.1633741303350;
 Fri, 08 Oct 2021 18:01:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Oct 2021 18:01:35 -0700
In-Reply-To: <20211009010135.4031460-1-seanjc@google.com>
Message-Id: <20211009010135.4031460-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211009010135.4031460-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 2/2] KVM: x86: Simplify APICv update request logic
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop confusing and flawed code that intentionally sets that per-VM APICv
inhibit mask after sending KVM_REQ_APICV_UPDATE to all vCPUs.  The code
is confusing because it's not obvious that there's no race between a CPU
seeing the request and consuming the new mask.  The code works only
because the request handling path takes the same lock, i.e. responding
vCPUs will be blocked until the full update completes.

The concept is flawed because ordering the mask update after the request
can't be relied upon for correct behavior.  The only guarantee provided
by kvm_make_all_cpus_request() is that all vCPUs exited the guest.  It
does not guarantee all vCPUs are waiting on the lock.  E.g. a VCPU could
be in the process of handling an emulated MMIO APIC access page fault
that occurred before the APICv update was initiated, and thus toggling
and reading the per-VM field would be racy.  If correctness matters, KVM
either needs to use the per-vCPU status (if appropriate), take the lock,
or have some other mechanism that guarantees the per-VM status is correct.

Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4a52a08707de..960c2d196843 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9431,29 +9431,27 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
 
 void __kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 {
-	unsigned long old, new;
+	unsigned long old;
 
 	if (!kvm_x86_ops.check_apicv_inhibit_reasons ||
 	    !static_call(kvm_x86_check_apicv_inhibit_reasons)(bit))
 		return;
 
-	old = new = kvm->arch.apicv_inhibit_reasons;
+	old = kvm->arch.apicv_inhibit_reasons;
 
 	if (activate)
-		__clear_bit(bit, &new);
+		__clear_bit(bit, &kvm->arch.apicv_inhibit_reasons);
 	else
-		__set_bit(bit, &new);
+		__set_bit(bit, &kvm->arch.apicv_inhibit_reasons);
 
-	if (!!old != !!new) {
+	if (!!old != !!kvm->arch.apicv_inhibit_reasons) {
 		trace_kvm_apicv_update_request(activate, bit);
 		kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_UPDATE);
-		kvm->arch.apicv_inhibit_reasons = new;
-		if (new) {
+		if (kvm->arch.apicv_inhibit_reasons) {
 			unsigned long gfn = gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
 			kvm_zap_gfn_range(kvm, gfn, gfn+1);
 		}
-	} else
-		kvm->arch.apicv_inhibit_reasons = new;
+	}
 }
 EXPORT_SYMBOL_GPL(__kvm_request_apicv_update);
 
-- 
2.33.0.882.g93a45727a2-goog


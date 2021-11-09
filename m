Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05744B4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbhKIV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbhKIV4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:56:04 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED094C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:53:17 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so589296pfx.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4VWUXfH3CjByi3EgwaB+7ypH3aB/kvt3/kF51hFEyso=;
        b=MvoaNmozTP2Cj627L0qTpcYWcRxYWMjACzobKA7YJYmycmTszuyv0OoWAIu7799Qzb
         nlUmcp1AKvcJV68hnK4ZVutlUmodTSfpA1DINi9GnX8oMkiOudqyV4Lx3+ItFDiYaBpf
         cEMCH/wAWkZelkd1ta34cGAhXnn0wfyZ3VBVSCPM1yhl8QUSa5ZNemqVn7tymTHyBi2H
         hnJKssTIUG2y6MPowdulCTtcc+5qPcMsYK6txRtCQgRR4GQzZ7OdZDGJd0Fl5Ws5Drhu
         rARFtJB7cUOOf0YQGDmpQt+QyWHE5a9nhAG3VDIXRfk5xdXtWp8sEy9Q+ygcQ4zo0ssI
         wEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4VWUXfH3CjByi3EgwaB+7ypH3aB/kvt3/kF51hFEyso=;
        b=nQuorV+AirtwAmpgP2RIp+rV+9G0vb2IYB6LV53j7WpIv/T3hYgffHMWgLCfapIzyH
         t4r4dNDDJyh3BhkOf2vKGQ1zGpw9uACct/ll5BrOeOoIm9NzSk3Wl+AAZsjSC6dLZLWh
         iguCFNI2EVoQtL5fWFL9rO055izbSiDX6U3MccICGajSD7lp+GFpiBArteYgNzgT3Ud3
         NDwLsmdDuCCTi+Ougl0uAewxwljhaDDdYlTgBgMZQD7Kpj08RYMjkdcFNSiYz7/u3z98
         P+0y3XgqSCB4EzV+/z+21PROWmt8K9Zy5YgVs+6Jj6xnU3nu0xC9PxgI0HO+kmAh49Dr
         8LDQ==
X-Gm-Message-State: AOAM53165ANlYQXqLd589pROXY7tSLGp6R78jhmCSmMxnG88X4k195cr
        LqpfcjT3OQGli1uZHEU8JwYX+f6Z20s=
X-Google-Smtp-Source: ABdhPJwuNBpyfs04S42SDshdWroSGLzOliwChQcrh2/zL77GRL0787iO5Ys8onr8VL7/KkAPLYUIYqXPpF4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1f8a:: with SMTP id
 x10mr11013958pja.215.1636494797388; Tue, 09 Nov 2021 13:53:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 21:50:58 +0000
In-Reply-To: <20211109215101.2211373-1-seanjc@google.com>
Message-Id: <20211109215101.2211373-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211109215101.2211373-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 3/6] KVM: SEV: Set sev_info.active after initial checks in sev_guest_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set sev_info.active during SEV/SEV-ES activation before calling any code
that can potentially consume sev_info.es_active, e.g. set "active" and
"es_active" as a pair immediately after the initial sanity checks.  KVM
generally expects that es_active can be true if and only if active is
true, e.g. sev_asid_new() deliberately avoids sev_es_guest() so that it
doesn't get a false negative.  This will allow WARNing in sev_es_guest()
if the VM is tagged as SEV-ES but not SEV.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6d14e2595c96..a869b11301df 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -229,7 +229,6 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	bool es_active = argp->id == KVM_SEV_ES_INIT;
 	int asid, ret;
 
 	if (kvm->created_vcpus)
@@ -239,7 +238,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (unlikely(sev->active))
 		return ret;
 
-	sev->es_active = es_active;
+	sev->active = true;
+	sev->es_active = argp->id == KVM_SEV_ES_INIT;
 	asid = sev_asid_new(sev);
 	if (asid < 0)
 		goto e_no_asid;
@@ -249,7 +249,6 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (ret)
 		goto e_free;
 
-	sev->active = true;
 	sev->asid = asid;
 	INIT_LIST_HEAD(&sev->regions_list);
 
@@ -260,6 +259,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	sev->asid = 0;
 e_no_asid:
 	sev->es_active = false;
+	sev->active = false;
 	return ret;
 }
 
-- 
2.34.0.rc0.344.g81b53c2807-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F730E839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhBDADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBDACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:02:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A3C0617AA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:01:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7so1574198ybj.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=N+cVTlisb7HGeqiFkTgiq2oBYDM+4NRVXkhEzMWc8HU=;
        b=D+cDoX0CFeijjXjDOMKS1/GeQQ3JfQRkctlHnPNzFIcUiAlceE1gti5gMS5FO38S3f
         9TtpNy1ziIY1Nc9PS21csPZ30J0SZKK9Yya9/iVbpoVHvfswEEJjtYlpBlduh92Kkl3b
         s4aSt1mgSroQ1pjVc05K8Zs0GwG7EkORFwvePnzIwKPSX7RnnA9PZji9ZRxbt8Nip4KI
         FEeXaoYpxWBb7pmxh499IWlIpGE1IXJLIzaX/9pHaYSib4HzufoBViLQlQ2+c8nFsaJH
         +lpuABrinVTd1R69z49otzaoMR0Yx5Uj4s5uis+V9cLoXZPBHX8NkpTVrPDfbfLEarUi
         dS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=N+cVTlisb7HGeqiFkTgiq2oBYDM+4NRVXkhEzMWc8HU=;
        b=HOj5MzzK33n7eGeGKX2NmP6UpwkAJDkowKUV+KMJU9pwgyUTUtXPqFSawbkUkZLVvf
         AxwZ090p77yTkOAu2pm7lMMegceqHtAZq15AFCcHTWUdfXbdTs+TexIjEfnFK+64MTXQ
         VgA6lUDeryF3CkqLit7XYnnNPlnJkzcISgv6vgpvmlT+oLFfTZXmTJ46eahxxGpgY0j/
         d5k3BsVzU06d8aB3RPI6ySjYYndkGo2kiRjJXywVPII/OdOCm2IUQaBgTZEz8LTfk25+
         Zl0lj0Ui5NLMtJWdNFMqEotlP6a8jY40sS9i2XwryGJT61U1zLcPWQKRTLEIxYXoO4QY
         SVNQ==
X-Gm-Message-State: AOAM530QdY78gkKnCvXec+zfxMo2j2Uq2UFJCDyRwHTLivQCqHtwX7HP
        F5Agw79it+ADoEa0W5GSTd2cfK+4+MM=
X-Google-Smtp-Source: ABdhPJzqnVf4CSigFEmz3ocNKb2F5pHtFZSP7dI3TSolRfUl2/D+j8ACOtft1vwnRzJ823gt3rhJYe2+AGA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
 (user=seanjc job=sendgmr) by 2002:a25:bbc1:: with SMTP id c1mr7996046ybk.130.1612396900135;
 Wed, 03 Feb 2021 16:01:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Feb 2021 16:01:11 -0800
In-Reply-To: <20210204000117.3303214-1-seanjc@google.com>
Message-Id: <20210204000117.3303214-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210204000117.3303214-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 06/12] KVM: nSVM: Use common GPA helper to check for illegal CR3
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace an open coded check for an invalid CR3 with its equivalent
helper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 70c72fe61e02..ac662964cee5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -367,7 +367,7 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
 static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_npt)
 {
-	if (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63))
+	if (kvm_vcpu_is_illegal_gpa(vcpu, cr3))
 		return -EINVAL;
 
 	if (!nested_npt && is_pae_paging(vcpu) &&
-- 
2.30.0.365.g02bc693789-goog


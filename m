Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDD34F75B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhCaDTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbhCaDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:19:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC2C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:19:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f75so792084yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VqSy53IyDnNL/CdQDhT4nMQIBeIb4g0Xh5NCqPSTxiY=;
        b=L3vxRku6tHP9GMz0/JT4UHLAicdp9dcZ+g2J1/dysm0wZpJgxaAjfxTZRGvOqRDoJ5
         5GG5sUkB9HTsjhb7ZcW+2cqWXHS02dQP1cU9Jq70424h6LdhCvBWTWi2Qkb61lFbCmHO
         QF6c6Ih9rAr2eQdCd2pJtRZYC0dBaI0kSCdr+sMMgAg5/lzXj6+0d07tR1OA1a34arnU
         0DF79I759sgJdeCnkcU7kKJCHSg3fuFJRaVtnpmrXCuZnuaRW3w4dGNmlSBalHYxoaW9
         BhI2lgbinJfb1IVflxdD8n2URlBSoiGN/Kq7x1JDvwfuCVb0nwKe97+7cLSKniU4BIdS
         E+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VqSy53IyDnNL/CdQDhT4nMQIBeIb4g0Xh5NCqPSTxiY=;
        b=Z40a2QWIPyuwrqY5ust3nhxudzebqqE+wkbXpOWiHVfmnBCTpoimJLIOqMD8mdYzak
         FwXvUCbQL//1PzQjtBuDYBTfaFvISrAoxtsxJFogcKJXwUmmYH5UVJyS0aaamCgkGogR
         Uu9ZRPr0L+GZAMruCsT6KKg7nNwEnzZfORvSTgeTldFSviYLp2MgV779YVucL+LINT1u
         pGowkGrVIOm/JJ8Hql64ftuA7k4S9cfQc2vKz10OuFY56PT/2wzOSM2hs8K5Y8lwWnal
         mryxKcWw+kEZoltbUeGu9G+4CJrnfpkgrAxEwBqX4AQgksdYzOU6wY/lPsMV3BLWqdzf
         zFNw==
X-Gm-Message-State: AOAM5334pJ7jc4CQBTMH24AFgxbBYVfIHMFXn/D5VYn5VsT3Ypxvm87o
        BpnsS9vFkXLl5kUiS8HDoDhERGCtBp8=
X-Google-Smtp-Source: ABdhPJwPfX1ZIe9KPSZ+B/9YfLJdMnVqXzEt0iRHW7WxV7gQCnqgXa6cZFbf1Pufpv66ADvtJZu7i2zqXv8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c6b:5d63:9b3b:4a77])
 (user=seanjc job=sendgmr) by 2002:a25:9ac6:: with SMTP id t6mr1707731ybo.287.1617160784800;
 Tue, 30 Mar 2021 20:19:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Mar 2021 20:19:34 -0700
In-Reply-To: <20210331031936.2495277-1-seanjc@google.com>
Message-Id: <20210331031936.2495277-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210331031936.2495277-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 1/3] KVM: SVM: Use online_vcpus, not created_vcpus, to iterate
 over vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kvm_for_each_vcpu() helper to iterate over vCPUs when encrypting
VMSAs for SEV, which effectively switches to use online_vcpus instead of
created_vcpus.  This fixes a possible null-pointer dereference as
created_vcpus does not guarantee a vCPU exists, since it is updated at
the very beginning of KVM_CREATE_VCPU.  created_vcpus exists to allow the
bulk of vCPU creation to run in parallel, while still correctly
restricting the max number of max vCPUs.

Fixes: ad73109ae7ec ("KVM: SVM: Provide support to launch and run an SEV-ES guest")
Cc: stable@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 83e00e524513..6481d7165701 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -564,6 +564,7 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct sev_data_launch_update_vmsa *vmsa;
+	struct kvm_vcpu *vcpu;
 	int i, ret;
 
 	if (!sev_es_guest(kvm))
@@ -573,8 +574,8 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!vmsa)
 		return -ENOMEM;
 
-	for (i = 0; i < kvm->created_vcpus; i++) {
-		struct vcpu_svm *svm = to_svm(kvm->vcpus[i]);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct vcpu_svm *svm = to_svm(vcpu);
 
 		/* Perform some pre-encryption checks against the VMSA */
 		ret = sev_es_sync_vmsa(svm);
-- 
2.31.0.291.g576ba9dcdaf-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5C3B0C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhFVSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhFVSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:06:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A636C08C5D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p12-20020a0cf68c0000b029027a35feac45so584765qvn.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rUs+966f+CDP8VHde1NoisS+8ww2aUm1j0f8NYlZtqE=;
        b=Fl+C43avI6SiI4WTsJKZYi1XdqV8GHBrHMpvS/ibNPFWN1hA2wusCpPlf5pWbQwNDw
         Psp0XUxCPO55t2Li1b5nvreIrIP93otSJBs8gTJUr+VutLMuOwpKPAtySTDllyGVJT8t
         FPuoLdcXrBl4HE+I6cMmkY1VAuCMPuLr+VsMwb+VN3TZJKgG+35I0R2VXzCnM+mF+Xqe
         6dRRk5DMbiXVc5P3XTcgwYcTKRf62KVxhPyGhVJzGPlqcWvSyZW5Zb76Fw+//rzevQZT
         JAgk7Jn8YrWX9jDpPWk/HwZoi8XH7dWENAAJ5EI8mLPo1PYVDJkNPc0D3IqrgUNcvOnP
         uVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rUs+966f+CDP8VHde1NoisS+8ww2aUm1j0f8NYlZtqE=;
        b=HvVaNOQGs5AmTIo64qJyYiDS9UOQyx7cSorIeeVcTJlbny0LE9ormpGH/2eREOcdez
         OpjKSEagOAy0uV1n5IhTwY0G2BTIjQkDQCllcA30VrBui5K3Z7jBRHNQ07w/35qERplN
         AMVEC8Pvsx8sEB5wvZ3/wC4QQcEKHrUV1KDujGf57Q3/NkdXFyiZITrNEzKRN0CipdBF
         GeC5QGsIZqD7LO0UTXXwCKT8panZQ3zC8Z9rvx4FMgEdzKF1SBPZvKaCCr3KsJ8LYyX6
         sbiHY1zBUqVPsqBDC+Lg4f0cTjXs6Sh+RVMMea7A4tgOaArE9ItjaJoQlplAK48GonbL
         NsXg==
X-Gm-Message-State: AOAM5315D7z3EWi8ywT/zmaU7FMTMwhdBfFolIa5sK6E2NS9ZjuO0R07
        qFbXHdv3Y2EDyz60lPa5PFx/XhQ1oW4=
X-Google-Smtp-Source: ABdhPJwg+s3kNjwriwzqMO3mMxkbDvv/AnG8NwcyEcukQUoufCwMdy4XzMqIuM/miw5QWP8OB3hoX3k4BOs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:c0d7:: with SMTP id c206mr5187941ybf.369.1624384792699;
 Tue, 22 Jun 2021 10:59:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:36 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-52-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 51/54] KVM: x86/mmu: Drop redundant rsvd bits reset for nested NPT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the extra reset of shadow_zero_bits in the nested NPT flow now
that shadow_mmu_init_context computes the correct level for nested NPT.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7849f53fd874..d4969ac98a4b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4693,12 +4693,6 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base);
 
 	shadow_mmu_init_context(vcpu, context, &regs, new_role);
-
-	/*
-	 * Redo the shadow bits, the reset done by shadow_mmu_init_context()
-	 * (above) may use the wrong shadow_root_level.
-	 */
-	reset_shadow_zero_bits_mask(vcpu, context);
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
 
-- 
2.32.0.288.g62a8d224e6-goog


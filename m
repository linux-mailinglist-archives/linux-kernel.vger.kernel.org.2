Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75543369DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbhDXAsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbhDXAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:48:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E8C061345
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so26239649ybq.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Jt+QADH41QWXYhePdcqYrOCInHjfAIgUcTFitJT85II=;
        b=VKCD32tNE1gQlT8ZBHmOFQRMkonRpIDU2w8ZcZmMWG/7LY6e4AiT3pguQltFHx+cnZ
         Q1K5jdZDD7ObiUHwqs3LK8yW6Lm8azAWM8On3E0EOePkJjeVIpQbzl2NYdOA5DtnD0uE
         /tJeuBOOcMgrXvAXgj70Gx2Raox3rxVrhxzxWGsTAydHbW/6kYjdTuiuVSQIZHDBcG7c
         AOHXWD+1aSRrWePdu/il24DPE9Vd7L+uPsF+KwVKzddyZzCGn6HO8wm66J0kx3dIBVHX
         Y3KTVdZKSBede+UunwTlNnFwh9QSaXzNjWKYCayzmuVdBWs22HkiQ5fltixxunX2zl7w
         Zy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Jt+QADH41QWXYhePdcqYrOCInHjfAIgUcTFitJT85II=;
        b=SpMvfQdvpDEjbC6EwfspyAiwg98iIGtLj2bAqhX2bKW35uXejlZXLyJJqu4lSzqy+m
         rZcUS+p7IqHhtVVOW9iGMwCbWejRT033c4a53UT79h9d4kFmQww8UgOdJeuxgXPiNf32
         0Orvr7UB6/ISgLWpJlg2oWUaL/KB7ypTQjaFOk/zHbpUe83VrYAPuIhpA3iKejDuvaMd
         OAXJc/nX2OLaKJiDTSVXGBRbczvEyRjJojY2UHzk5+Ch/vG/GiY+cPaSrDk/LKs8/qoK
         j+H/Q4jhC4bAXFNPG0uY83ZZvFvhIwXit6u0gWnv2KTGWI/LyKKElPMpdQ2nxfnH04JB
         FBXA==
X-Gm-Message-State: AOAM531Ubh41H5zN+/BmeTnJFAKBOUdEjQK6Q0aSEtGqtM8bBTqVcB90
        xZcFaHrh5A6/i76Avun3MdViRaA0rCg=
X-Google-Smtp-Source: ABdhPJwcTnmC6X0oWuujcgYVmlJxsbfvu4nwR2aDmxuh3bzRd3SWRELPe0JgJ/qSwHhiHda4+AZA0+IYfiQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:6f85:: with SMTP id k127mr10032078ybc.270.1619225237656;
 Fri, 23 Apr 2021 17:47:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:10 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 08/43] KVM: SVM: Drop explicit MMU reset at RESET/INIT
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

Drop an explicit MMU reset in SVM's vCPU RESET/INIT flow now that the
common x86 path correctly handles conditional MMU resets, e.g. if INIT
arrives while the vCPU is in 64-bit mode.

This reverts commit ebae871a509d ("kvm: svm: reset mmu on VCPU reset").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d4d7720ce42f..fbea2f45de9a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1216,7 +1216,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	 * It also updates the guest-visible cr0 value.
 	 */
 	svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
-	kvm_mmu_reset_context(vcpu);
 
 	save->cr4 = X86_CR4_PAE;
 
-- 
2.31.1.498.g6c1eba8ee3d-goog


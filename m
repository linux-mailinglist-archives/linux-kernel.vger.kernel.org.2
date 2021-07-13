Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C63C74FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhGMQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhGMQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBBC05BD37
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:35:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so27718800ybc.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=UT/52VUVOqVgs3pMVDFi63r7I/kst4+a2VnG271Mlf0=;
        b=Le2y0L9ajtK20eY1aYFmEMeU71b7R7G6iQZ4oxeoBAmPHNOoz8E3EMTZ23HbdSGHDO
         jzImdMVK1EXYwAnxlbaMGscMlX/RIO4GX4UqguOxBxAPu/uFYM30cPn2W/nb9ZUHGkCH
         nyLjtkAMAbEkcPSHk2wduvqFt3t1IalxUU2JnJSm0lEhKFWNLvD0aJbxpHV8n263yboj
         HToOwsuAE270xHVPtJFw6xiFRIAtkNLZkyK4QDbS9WdmncoUsvf8IG06OrVfRTc44cms
         LNE2gSfPd4mcPTpMLexF8dRc8pLy7Mz4a2K3yxaGbJcjYDJ4U317EktfEzEb4zMcgfT7
         cDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=UT/52VUVOqVgs3pMVDFi63r7I/kst4+a2VnG271Mlf0=;
        b=TT3lvRYQP9XXRMv7QlNyzCImwyK2dHJStzAmU8S4jxfbgyAGWn6bL1elyI92hAGjtx
         iaLzBUbo+upwUBVgF6HtJ63Rl5tNyqdGO6NlLGhaO9YU7+KZDjMWSnFoazs15Gkg6Hfo
         /B7JK51auq6jlgyMK8IHdSOtC5o5u1IKUvEnJN0L8Ymu9TnUu8iwFdQ2yCy9fso4ej9K
         oCys7v6oPwGf3/kP0grmINn9fGyXFIbtkg31G+A+7UdfdyD2HyTj3ltWROB6lg0N7c0A
         dXck3dK4/31eE5ZRNuTvsK+EflcB8K5IQAxlq6+8El2p9Q0H8s2CXM4z/T43lJ2eohBO
         Y+1w==
X-Gm-Message-State: AOAM531yBQKZXmOHNQUYLdP5fvOAe5U26ExjVVqotxAAc1i1QXXtBD7t
        dXEoBeZU4QB0J2ePQCzmYCHUevYLVPk=
X-Google-Smtp-Source: ABdhPJxCevqBpFkZ2lfVrBSpKHEF9/P7qKhBWQULS515DzR83SlveXF4ojqHFpSeq1upJEmA7eXDn7GkQRQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a5b:c0a:: with SMTP id f10mr6638912ybq.9.1626194101487;
 Tue, 13 Jul 2021 09:35:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:23 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-46-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 45/46] KVM: SVM: Drop redundant clearing of
 vcpu->arch.hflags at INIT/RESET
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop redundant clears of vcpu->arch.hflags in init_vmcb() now that
init_vmcb() is invoked only through kvm_vcpu_reset(), which always clears
hflags.  And of course, the second clearing in init_vmcb() was always
redundant.

Suggested-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 285587a7fe80..46d341f57e26 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1177,8 +1177,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	struct vmcb_save_area *save = &svm->vmcb->save;
 
-	vcpu->arch.hflags = 0;
-
 	svm_set_intercept(svm, INTERCEPT_CR0_READ);
 	svm_set_intercept(svm, INTERCEPT_CR3_READ);
 	svm_set_intercept(svm, INTERCEPT_CR4_READ);
@@ -1277,7 +1275,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 
 	svm->nested.vmcb12_gpa = INVALID_GPA;
 	svm->nested.last_vmcb12_gpa = INVALID_GPA;
-	vcpu->arch.hflags = 0;
 
 	if (!kvm_pause_in_guest(vcpu->kvm)) {
 		control->pause_filter_count = pause_filter_count;
-- 
2.32.0.93.g670b81a890-goog


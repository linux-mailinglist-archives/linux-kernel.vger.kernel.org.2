Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2E44B4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbhKIV4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbhKIV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:56:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1EDC06120A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:53:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w13-20020a63934d000000b002a2935891daso264610pgm.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nmV5Ct8WiB83ejR4oRWHL0C3V0MN/442bHV6UJxlGto=;
        b=EJxETT+iLof5kIDdXdjVOObsEbR7a4wOaVMt13mVKu8LYb7Hcw62cWgrWu7R7fQ6cc
         AM5Pxim68aJm4ZpLFUqAPzK9uUHlzNBWl34LR8mQqfxmnRQQXKDFSDFp/0aH/ez4JH9k
         p9hclk1ADt7VIuiA5ODifiM/NwnaTyJ4+7Z4bJ3zw/zzyyntX4RTsPTyp0QRTN9PyuP1
         0Jeqs1hF6b2rksjYkPmDxHj8+Mc3enpU6xX2xoJSKS2U1rGpwLOnwmmKsVgM3yvqxQ4s
         3Kk5dCP+vHGEZJ4dpxDWvQU37Ly4xwBWPBKTKJaL4VW4+A2jPMtlragWC5i4+WEeHcpu
         5Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nmV5Ct8WiB83ejR4oRWHL0C3V0MN/442bHV6UJxlGto=;
        b=cra8ZYt6fxq3SozoC4yMsTQm3eggsqLOQWmwmfw3H9nBIXf82tJSp0PqrBJYzfEalU
         0otSIVXyP5lWuVw5dyif8b0CLcIsPt+RBHdJs0M+7vs2Yma7BlnXiSpS6TO7nXRLPDQX
         7vy/+oEMy/AYTvtyC0ik8EemHQDhArKTurR6ppPrXP4/bN45ljrn/XlB2N3CYbzgWcQM
         T5UXa7S62s89dir5oi8RTNLtOpFSickU6TyKTPp8zXgLNJ9ZRCeiRZTX/5cKpQy1kR8o
         vkXOH8mh9uB6caE1weIi+GansZMrfyiMmhgHabxTRk8U38cP6eUgepMkLNHPQEypxw7I
         IpsA==
X-Gm-Message-State: AOAM530AR2d/F9LXX7rFHNGqvxSocWciwhG8y9L4f4V+dUFEIHWZs1pV
        MpuJeJWnGavmEiksvCfSHcEUvMV/ptI=
X-Google-Smtp-Source: ABdhPJzSI4cvkpcQqO9PTPAyHglxUxxoTQ/CZMc28PcKbV2/H8VR8URLihRjab9bl3oT5MxZVeSxtJLBQdo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f784:b0:141:c9ce:6725 with SMTP id
 q4-20020a170902f78400b00141c9ce6725mr10681361pln.58.1636494802025; Tue, 09
 Nov 2021 13:53:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 21:51:01 +0000
In-Reply-To: <20211109215101.2211373-1-seanjc@google.com>
Message-Id: <20211109215101.2211373-7-seanjc@google.com>
Mime-Version: 1.0
References: <20211109215101.2211373-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 6/6] KVM: SEV: Fix typo in and tweak name of cmd_allowed_from_miror()
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

Rename cmd_allowed_from_miror() => yield is_cmd_allowed_from_mirror() to
fix a typo and to make it obvious that the result is a boolean where
false means "not allowed".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a69dfa0d62aa..2b891509251a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1509,7 +1509,7 @@ static int sev_receive_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return sev_issue_cmd(kvm, SEV_CMD_RECEIVE_FINISH, &data, &argp->error);
 }
 
-static bool cmd_allowed_from_miror(u32 cmd_id)
+static bool is_cmd_allowed_from_mirror(u32 cmd_id)
 {
 	/*
 	 * Allow mirrors VM to call KVM_SEV_LAUNCH_UPDATE_VMSA to enable SEV-ES
@@ -1541,7 +1541,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 
 	/* Only the enc_context_owner handles some memory enc operations. */
 	if (is_mirroring_enc_context(kvm) &&
-	    !cmd_allowed_from_miror(sev_cmd.id)) {
+	    !is_cmd_allowed_from_mirror(sev_cmd.id)) {
 		r = -EINVAL;
 		goto out;
 	}
-- 
2.34.0.rc0.344.g81b53c2807-goog


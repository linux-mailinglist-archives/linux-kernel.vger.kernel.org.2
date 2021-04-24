Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B219B369E12
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbhDXAvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbhDXAty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:49:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DDC061368
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso19458826qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wI67RiHgb1mAzdZjTnzSpZxYjSY4YrR/tb9tPeu38Cg=;
        b=aW61n+hq0gn3dqvDogkL4uQbFlHfCDJDthWQqBqzWoBOtoRVNDw2awJ4DrFmHcobPg
         xVOR6PMq21FfC02u9wL06gdIyWam2QqRaFCZTdDD0GZ8/Ps/mmazUacpzuGS3BobxDPx
         619t5xRMcydgdJ8pxkdgEbdBkozvMhvvG7tBWjOD4DelWGBGMK3jfkHxrI9S/mCK3ZN0
         uQvwGf1dAkmTV08H+SiJeOAFiYMyerfXSgExT33fzj8HNq53K61i/MYZqlYzru+Jn008
         5yvyizifbyzwVeQ/2c2uarNQWheDY2XU9KTn8cKSluDfm6+HZ1HJoKKfDDYZZm4ZARK3
         gcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wI67RiHgb1mAzdZjTnzSpZxYjSY4YrR/tb9tPeu38Cg=;
        b=rC5Qq0uTyqQFkUPGc59jSmU+J8vEaK/5OUw5bDpE4NtbtR7W5E2wSyaTueOe7Let7j
         pWh1QKrgPjeHNyan07mFrfMhN3oU7I+9FB0aRE7mVMNtHC/ndOZ6MYGsZUGb7auQY76v
         uY5d+Tnmqd6PF8ESQLamGEf1LvyB8sIYvid7fm5ETeHmLouGaRt8wehoHitqIZh0EBxc
         cG0aWDat9gux0fBMAbyVYWNGyJANNUAFNQ9LtYpYt00vWoPHw/qcvkwjHeaLByqMfZZo
         mCLYBBCCghP5aDMmH3ryy9F0O8k4xSfqIw+OnC0n2U2v0vJf8miXEZZeWxZDwjCfvPX1
         qOIw==
X-Gm-Message-State: AOAM531YFRr03mlH8+PNKHNG8Y4VCDNWnjx4GUtTdpYiUdqdiqUK99LY
        biupgy+NhQnRAgnOM2Hr+lZnSUEc6L4=
X-Google-Smtp-Source: ABdhPJxirD2wOfuAm1w1ezcPpaIsvw7mKfzfoqHEJkGbN7KbVVp8QL3zCdcms0Ks1wgdpfoxygqu4zKvxSs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:f147:: with SMTP id y7mr7334860qvl.17.1619225263973;
 Fri, 23 Apr 2021 17:47:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:22 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-21-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 20/43] KVM: SVM: Don't bother writing vmcb->save.rip at vCPU RESET/INIT
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

Remove unnecessary initialization of vmcb->save.rip during vCPU RESET/INIT,
as svm_vcpu_run() unconditionally propagates VCPU_REGS_RIP to save.rip.

No true functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5c12ba725186..4ea100c08cb3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1208,8 +1208,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	svm_set_efer(vcpu, 0);
 	save->dr6 = 0xffff0ff0;
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
-	save->rip = 0x0000fff0;
-	vcpu->arch.regs[VCPU_REGS_RIP] = save->rip;
+	vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
 
 	/*
 	 * svm_set_cr0() sets PG and WP and clears NW and CD on save->cr0.
-- 
2.31.1.498.g6c1eba8ee3d-goog


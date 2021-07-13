Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD413C74B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhGMQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhGMQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9639C0613AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j186-20020a25d2c30000b029055ed6ffbea6so20161094ybg.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CzDDt8Xveb+AiWMJHUA0uSHyGS/Vcfc0iWePgVgIMys=;
        b=t/atGzTCApK+WNx7wLzAjU9pLgb4MFOh9aA6d7dCtEFsCMWJxKXU1eUEIbWIQUlpJo
         t+GkqFwH31xp4VkQZZDtPm2SFWkIGwda8iaXl20eWtg+mQqecMO2J5NHpFfpbU8ye7xW
         k8HJEnbn/ILcp7nTdho08R1WmRHOkG1GJt6/o2suwvxDuEXFznyhpEDCNDHIN6+7cN5K
         er0Qt0MDzUOiVsthGvPQVsdzIF4mSdBl/UyLFvIVOBdncApEgqfzyxj/S6hBwUm+aP2E
         CrLITG0nS33ReX4zpN93eCjBWjLWtuu7uiP5lmxJhcYO4SNKsnVNlP9Gmo985EkY13nb
         mboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CzDDt8Xveb+AiWMJHUA0uSHyGS/Vcfc0iWePgVgIMys=;
        b=l2vLirDSJNLp2krS2nx4OUDsvZJjNKFJj6MoyvPf9m50BurkJecd09bTBHk26q7X/w
         G2rd1DO9UD0M4jhTKDpcfYbn9CQRxkgmGTQVW0GKFYqb7l9QKxY3jBamy8BJHRWRhYdv
         mKu3irE7jYQlE0DEGeTcnStbrFGeV0gfJQbcGaAHifRHefuF3wKDmrMDKeoqadaXO/SS
         9Zqp3yK/15Yp1JXtho/lpP+35nVc99QMI93UObzoLkw61eHKVJqph7K6NmX7WlItwQud
         l5BaaEZ6HTxjaVQcgsjDpfDo9m5hWUvP9Y+Y3KnORRlPghVQH+bOSU/lyy8luxgxvtRq
         F8cw==
X-Gm-Message-State: AOAM532G6GI5qoz2GqVwY9hF2uNviBwayPX0Upb+T0tLQuqQCMWj/u6l
        HyhV/Sv1YCP4r5BQ3GhySvLLE81bc5o=
X-Google-Smtp-Source: ABdhPJx78YkFT+MLfyvhOYclBp02FKti+D9w4pPn2xvCBQRgtVqiigGbSW4kQVcEh3McY0+sMGlIfLONp8g=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:8482:: with SMTP id v2mr6838057ybk.214.1626194039015;
 Tue, 13 Jul 2021 09:33:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:51 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 13/46] KVM: x86: Migrate the PIT only if vcpu0 is migrated,
 not any BSP
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

Make vcpu0 the arbitrary owner of the PIT, as was intended when PIT
migration was added by commit 2f5997140f22 ("KVM: migrate PIT timer").
The PIT was unintentionally turned into being owned by the BSP by commit
c5af89b68abb ("KVM: Introduce kvm_vcpu_is_bsp() function."), and was then
unintentionally converted to a shared ownership model when
kvm_vcpu_is_bsp() was modified to check the APIC base MSR instead of
hardcoding vcpu0 as the BSP.

Functionally, this just means the PIT's hrtimer is migrated less often.
The real motivation is to remove the usage of kvm_vcpu_is_bsp(), so that
more legacy/broken crud can be removed in a future patch.

Fixes: 58d269d8cccc ("KVM: x86: BSP in MSR_IA32_APICBASE is writable")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/i8254.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index a6e218c6140d..5a69cce4d72d 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -220,7 +220,8 @@ void __kvm_migrate_pit_timer(struct kvm_vcpu *vcpu)
 	struct kvm_pit *pit = vcpu->kvm->arch.vpit;
 	struct hrtimer *timer;
 
-	if (!kvm_vcpu_is_bsp(vcpu) || !pit)
+	/* Somewhat arbitrarily make vcpu0 the owner of the PIT. */
+	if (vcpu->vcpu_id || !pit)
 		return;
 
 	timer = &pit->pit_state.timer;
-- 
2.32.0.93.g670b81a890-goog


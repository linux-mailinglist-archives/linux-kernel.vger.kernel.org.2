Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520F1369E03
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbhDXAuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbhDXAsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:48:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997AAC06134F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a2587480000b02904e5857564e2so26352852ybn.16
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Xh7m40xB+PCdgjTH1Qjusqokdv3A8hOeLP4wgBd8rCM=;
        b=m7Kced1XGavUVsH0vrTEvI819K22pWwag3mNjA9ln17XpeVzi/Emhgb+nl9PEa8DTb
         83XHT+FntZINsSy1uE1KYCaY6Dw0Pzz0gFBGM19UQmUZv5cRuhDgZiWlP/rrwxvcVmjD
         0Y4MI+GKiP+47Hx5HzzCv5PEiEl/sfX8AZabUAal712dfWW1OxTTyM6zln0adk7XXxGH
         N60rPwv2QYTfJW0jW1XkPo56SiSSPFUo8MhjAf2VqfmbL819kmPm5CQsIL+y18wBoaEi
         Mnq49xnBHPrPjM5whD/7oXi/Jgz79t7XNzI6sovpIPo5IjA/KDjCkzz4QvWfmXMXtJRg
         EeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Xh7m40xB+PCdgjTH1Qjusqokdv3A8hOeLP4wgBd8rCM=;
        b=nj3k0cWoiPYiC7QLB/vaZD6A+EfKoNhfTdWLQbZ/VwKaHnUkidtwPeNoNv7yZzexwx
         d9Fqv4e1Exli+ns+pi8pupT53sVlvkJ+q5MtaNKmHHmqJLnhmVD4QbmtELXTfDmKmOwg
         H98ypGJX93dcXrxuBbRZCvbbvwWApDTCbWpzIyHUK8NvMSWN5oTyhnQJKc9uyndItlJU
         SULC0xaucnFgF9Y/caANRGXBGW32A29Q5OVkOhYCz4rPZJQYsBCVAwxiILdmWwWibmId
         B25a20VV7WvyeCC/mYRV/dwFic7IlGTrNP+comjnoqpoXClqrR3PgH8vtMLuxtU6nDD6
         d4KQ==
X-Gm-Message-State: AOAM531P5Sy7wM95Ssru54g05b3o0ruKwNVnHzYWRbydG/lDVnX6gvU1
        VPBYwwz7y9vEl3S41bfLYhhNLvQhtN8=
X-Google-Smtp-Source: ABdhPJzpXCPqBe2RUCyu8UuGN557NYQlwjPqrZBc2bfEb5qqDYWpd95PoAPObper5Uk5il8kW8NF4wH7iSg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:a067:: with SMTP id x94mr10121340ybh.42.1619225248896;
 Fri, 23 Apr 2021 17:47:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:15 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 13/43] KVM: x86: Migrate the PIT only if vcpu0 is migrated,
 not any BSP
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
2.31.1.498.g6c1eba8ee3d-goog


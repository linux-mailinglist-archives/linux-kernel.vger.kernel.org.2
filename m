Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D03C74F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhGMQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhGMQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CF1C05BD2E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:56 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w13-20020ac843cd0000b0290251f0b91196so8010205qtn.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ruF9NeysJG8YlLwDSa8NGDxOHgaZRuCfs6bt3ZWAhqU=;
        b=q/QtnyQ9oosp7aP3q8zCPx1rbONx4piEuNDTe5YQXzXRg7B3QsfVOcDOUrjXpAfZ80
         rUMkNbVNonq5w6AWR16/QUr487h5VRHwruFBiRrptKAaDx/pT3JeWaWN4clj6AKxK7xC
         r022arb8lhLRWVLSlgIt/w7FQmIElKHrLHkQratxTBJTdeCvMEmwt6ZV+m/3BikSZ5wf
         lxWIf/tGWw2e8h/bCuvjojg6z0dfF9T7gqY0C2T7Ub5Ayp0nNsseS5hyH7MzbMDDrh4S
         1gB7by08qF06UvRUJgS6IXMbGLQbKO4qZCtrmWWFO8R4th4LMvFeOSVW1O6cAGvE8VlR
         nOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ruF9NeysJG8YlLwDSa8NGDxOHgaZRuCfs6bt3ZWAhqU=;
        b=RLjiR0wz4wWUX+ZEKLAdLvqGFgqdldOTqK5SduO5lKslr9Bts+AY98TLcJ4vzS5Y1N
         B262DMeA5nAlDTR3SeKzmH0iQKipvgkR96ED3+VELbL7R1Is8KUYeOkXMCjysyJ5P/3m
         w/kyLr/zW5AyTsjUwUNwwyrYttkdelrd6Q7XIbxXaWAdo/d8LcSRno1iLYn+lNz/cVa3
         Ztkcm5ii6BxsMzvmXWEXx1e3MdDDXXwLCAXzBt27JBVuD2SYtldRFGpy2eZDoMDHwKLu
         vXvGzjANwbBw7N1SAIydoMUJfoDyGMqfaYYUYlquJ3ZS0YQVdw8PjJFqr79D0825nxB0
         TF8Q==
X-Gm-Message-State: AOAM532Gz70mqvTJ7ROkdYG9FX1ePOIp/ESepu6fUGJm6erCjVFJY2ca
        RTPKXul1+uxylwgNqsDoyJKgY6t0ZvI=
X-Google-Smtp-Source: ABdhPJzVU9yW2GAGD/nTjgmJlL07BIkZt8qPLIe2eCv6L8Db/53PtthwwLzzlQYczyhtkjPQksbVWmB+MNI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:4b2:: with SMTP id
 w18mr5659848qvz.5.1626194095368; Tue, 13 Jul 2021 09:34:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:20 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-43-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 42/46] KVM: VMX: Remove redundant write to set vCPU as
 active at RESET/INIT
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

Drop a call to vmx_clear_hlt() during vCPU INIT, the guest's activity
state is unconditionally set to "active" a few lines earlier in
vmx_vcpu_reset().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cdde1dfaa574..4acfb2f450e6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4465,8 +4465,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 
 	vpid_sync_context(vmx->vpid);
-	if (init_event)
-		vmx_clear_hlt(vcpu);
 }
 
 static void vmx_enable_irq_window(struct kvm_vcpu *vcpu)
-- 
2.32.0.93.g670b81a890-goog


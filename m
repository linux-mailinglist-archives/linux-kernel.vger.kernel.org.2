Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24632AD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837566AbhCBV5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581588AbhCBS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:59:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E30C061A2E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so23607463yba.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hUIu7sVBeZPHOKAKqkQEBvI6/Cyva1cSCDUAiAjyS7A=;
        b=U2m54mTmzJt31QJW9BmtK3SiG+FsiHpO3pN2uZt9Mw4OQZ5bvlOnQDJbtecM7GTN30
         nFGCDx0rmiUX+THo6IaqwBTAr4uIgDycnai7BtIkHIveD7iIhDTxrQQatEK/mnedrwR0
         C4Cy+o7VeCgOHBuvDGuGyf/1Il9Zq/BsWpIhq3pTzyqCaWUAcq8PRq/79spzOuiuLgNs
         766OeInO7N3Hv1FTAsGqje1x2GBAuXDbSS4L7AA67n8XoGNTEELiZ6celCpyD26EqiGT
         WbTrJv+R9ITgernzX5ERoc9HPeuiSfFmo+ErL6IFKY9lQ/FHw0V8Z057E7YrfWL777Wf
         TbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hUIu7sVBeZPHOKAKqkQEBvI6/Cyva1cSCDUAiAjyS7A=;
        b=hSllxL7OkV7c+HmL8We6IO0ZRNAmALXOl4nhn43UwiZHIPkEsqWGvDMgd9f8cIp4Kc
         dT9TUE5ZsOe6q30dpEUgGq4X9i5K5SUevo/l4nBw+xM2ptTO/ccIdxLUEbA9OlB1Jbmz
         eI1eTz7Ge0PIA4q3nj86h6XtVK5ixEMSyI1WRSuOVZNnQfgZ5bFRfPUhNzAU4UTpUTQ2
         gbkP+4E8j2hvNB0GSeJhmQHkMwm1xtx8RlFFlpBRAXLrTgnqQ/9xe0yE5PcMVgCU9eaw
         eDg16rawE2S54XFP8ohULfuNpopFoNVMMDi5obxQZRvw6CeD8cHAJoHgN91A0TWtFq3S
         RsQg==
X-Gm-Message-State: AOAM531iQVMbSgGGFmtYBwxpS6EJ6EfI2yPpQBv7OKZVRjgGXDiTz1GY
        9HsMmnPuXJF0+cLetqsR0++cg+p98fM=
X-Google-Smtp-Source: ABdhPJy833CeQjsl9oNWyBsX/oLj6kjISj/tIBT30+qFHWc9PvBK68fihwd+i7l6jp/KwPZoZjK8k+yUeiI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:310b:: with SMTP id x11mr8187618ybx.23.1614710775734;
 Tue, 02 Mar 2021 10:46:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:37 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 12/15] KVM: x86: Defer the MMU unload to the normal path on an
 global INVPCID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer unloading the MMU after a INVPCID until the instruction emulation
has completed, i.e. until after RIP has been updated.

On VMX, this is a benign bug as VMX doesn't touch the MMU when skipping
an emulated instruction.  However, on SVM, if nrip is disabled, the
emulator is used to skip an instruction, which would lead to fireworks
if the emulator were invoked without a valid MMU.

Fixes: eb4b248e152d ("kvm: vmx: Support INVPCID in shadow paging mode")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 828de7d65074..7b0adebec1ef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11531,7 +11531,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 
 		fallthrough;
 	case INVPCID_TYPE_ALL_INCL_GLOBAL:
-		kvm_mmu_unload(vcpu);
+		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
 
 	default:
-- 
2.30.1.766.gb4fecdf3b7-goog


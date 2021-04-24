Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA1369DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbhDXAs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbhDXAr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:47:59 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B6C061342
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a15-20020a05622a02cfb02901b5e54ac2e5so15538268qtx.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JB6oJJbZMgaQnz7sqxcoT6QpJu5P3mbAqjor0BPlckU=;
        b=gawyKmWHr60QBhm0KhMDBJy75XnqknCiP9RfJiC4WSxotL9fml3dncimBkNry5llXI
         GIUHw+eneBqfGoQuUCB2zKZIi4DIN6WjCg78tl7wxvozV/T/ynHsjonDfy5HmUkIpK5p
         Lemt/VPEUSJPXemM8qGHsVc7oTmx3EEbNpXkLltre8r3sxcPi1UnI0IJMHjILIQIEcDd
         w9rp7c/auaOIc9xejwFwnQRk44gB4hJovUgyIgZUlojAXd7sptVvFsgkIw/cZ/+/bvZN
         liEAQakKftCs3ilzhXSrJ7ipScs+kvm+FWY5ondZxDCqvBlsjJ4xzdNvgGiN7kKZObN4
         Nq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JB6oJJbZMgaQnz7sqxcoT6QpJu5P3mbAqjor0BPlckU=;
        b=U3kpnYRW8sYH0tm6imhPtvw20do4g0FNhMGP2n77HrMF7qDe5NRbcacpV7FollmQSZ
         lvFdTpcLKQDAEPRSVCjCsv6NzFRIQCMKupvhaMsz6UkkRxCd0NF3JN18wJFVvW4lIUAt
         ala4cU9Ps2I372TIlW8XcdvO9Grdw37c+/mCppuNb2OzMbT+7f4OmZNzMjcrRbO5R2vb
         dKhk9lN+fxjjrINkzAH3hKtfO/MTidPb0VUuIZNkcsOWFS5hH+HTrfKqQRxCs2WP13sq
         tOUfVH1c9j2IZIxHbXYLVOYlX9rwHTcxzMj7dYiwyD5U0nUnJv2JJal1rGepNreDAAfg
         OkeQ==
X-Gm-Message-State: AOAM533qhMMZG/QC2TrR90f2WnQPOYofzc8DjrbIHSJVH+59Lx9bSkvh
        Vj9In6a2DxC+J33gim/tW61Tleb1nkw=
X-Google-Smtp-Source: ABdhPJylGy/lLogptAm0ek+Ns5KvivhCMZAXT84Fhul4D9tz+Lpeo/wX0Iaqw3kuo7eVq38Tn/AfvbaHqmQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a05:6214:3eb:: with SMTP id
 cf11mr7365067qvb.37.1619225235338; Fri, 23 Apr 2021 17:47:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:09 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 07/43] KVM: VMX: Remove explicit MMU reset in enter_rmode()
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

Drop an explicit MMU reset when entering emulated real mode now that the
vCPU INIT/RESET path correctly handles conditional MMU resets, e.g. if
INIT arrives while the vCPU is in 64-bit mode.

Note, while there are multiple other direct calls to vmx_set_cr0(), i.e.
paths that change CR0 without invoking kvm_post_set_cr0(), only the INIT
emulation can reach enter_rmode().  CLTS emulation only toggles CR.TS,
VM-Exit (and late VM-Fail) emulation cannot architecturally transition to
Real Mode, and VM-Enter to Real Mode is possible if and only if
Unrestricted Guest is enabled (exposed to L1).

This effectively reverts commit 8668a3c468ed ("KVM: VMX: Reset mmu
context when entering real mode")

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9c00d013af59..e90952ca6087 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2960,8 +2960,6 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	fix_rmode_seg(VCPU_SREG_DS, &vmx->rmode.segs[VCPU_SREG_DS]);
 	fix_rmode_seg(VCPU_SREG_GS, &vmx->rmode.segs[VCPU_SREG_GS]);
 	fix_rmode_seg(VCPU_SREG_FS, &vmx->rmode.segs[VCPU_SREG_FS]);
-
-	kvm_mmu_reset_context(vcpu);
 }
 
 int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
-- 
2.31.1.498.g6c1eba8ee3d-goog


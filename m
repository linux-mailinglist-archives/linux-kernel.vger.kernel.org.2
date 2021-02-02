Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8177C30CF21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhBBWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhBBWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:35:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B19C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:34:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c13so25179709ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=7LGHGvABVV/hOzEr/frM8n8zvokdVXHA8iCPP4kDUv4=;
        b=lf5FREXRqgS0lbB4idjJXbZpvN4HjC2s1M3lu3rgAs/mLwLhIl6y/k2g5pIEbI2n6r
         +XDZop1lxnku3Rlk1aF0K7L/sFMb5wSVjTpsxd8+GqrHqLWWzMxSfYIxm7X9lsT0Z+sB
         UmI/NR8IVaY/ur/OXd0g5UHgGesyFI/FcbFwAEOoSugxvCs8cSEvbNlcLhOG1FxgowCb
         oSIQ8alO9+1nzBUykFWmx6RUY4LqMP10+UFe+Em8YPGlrlfGmBVRT/tmMqZsZdy++I9G
         0WhQFI6c4NbDNRH5BAKlzeF+MB0CHlF/VZAy2x2wc7xP1Sz8v0tYLT7MZmKJvsjGoIvc
         YRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=7LGHGvABVV/hOzEr/frM8n8zvokdVXHA8iCPP4kDUv4=;
        b=YbyP7lTPtm/g0a8kqc1qPfmFbV6osuh2sleE4KbvltmZ2uqefDeQT9UfM1QS8fe1+7
         FxUpYRDjGgQhZTwEjCPtIWhj7fofJSPabn1/w1OWxBRSxxXHj8fNeFu2dULM3FyGhckP
         g1PDauoV7Um6+8ElMVxlGdjPcEC19BhByQZsSHwShvkms6KqK9vEPcszXxoe0llAlA+H
         GEBz1ntjP81Bcl7feYFO6MlaAHfPaETQvysgFVJBGY3l4tYwQ+DiRvVMxCbYA8CvhYu/
         T3VrNPu0QsweYUtbe1Lz6fRsCPUs9+dh+OLrM/IA+Wrig5kp7OjwAMYd/rcSPkzPox0f
         t77g==
X-Gm-Message-State: AOAM530bUnlks2rJrd1Ib/OlztgCFyF16xRaN1/oxTXv2dLis6Sl5e/o
        sJ59ot7Xv9kgKKzI5C8XQSzobtcBKzk=
X-Google-Smtp-Source: ABdhPJxpO6ITfmyuFo8ObTMJgNF5wKHYFWmtXQY8xHo3eagkj9Tx2KSZR6I0YF/WkGlcza5jhZTvpHMiBvI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e1bc:da69:2e4b:ce97])
 (user=seanjc job=sendgmr) by 2002:a25:bd51:: with SMTP id p17mr195332ybm.274.1612305259277;
 Tue, 02 Feb 2021 14:34:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Feb 2021 14:34:16 -0800
Message-Id: <20210202223416.2702336-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] KVM: SVM: Use 'unsigned long' for the physical address passed
 to VMSAVE
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Farrah Chen <farrah.chen@intel.com>,
        Danmei Wei <danmei.wei@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an 'unsigned long' instead of 'hpa_t' in the recently added vmsave()
helper, as loading a 64-bit GPR isn't possible in 32-bit mode.  This is
properly reflected in the SVM ISA, which explicitly states that VMSAVE,
VMLOAD, VMRUN, etc... consume rAX based on the effective address size.

Don't bother with a WARN to detect breakage on 32-bit KVM, the VMCB PA is
stored as an 'unsigned long', i.e. the bad address is long since gone.
Not to mention that a 32-bit kernel is completely hosed if alloc_page()
hands out pages in high memory.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Robert Hu <robert.hu@intel.com>
Cc: Farrah Chen <farrah.chen@intel.com>
Cc: Danmei Wei <danmei.wei@intel.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm_ops.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
index 0c8377aee52c..9f007bc8409a 100644
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -51,7 +51,12 @@ static inline void invlpga(unsigned long addr, u32 asid)
 	svm_asm2(invlpga, "c"(asid), "a"(addr));
 }
 
-static inline void vmsave(hpa_t pa)
+/*
+ * Despite being a physical address, the portion of rAX that is consumed by
+ * VMSAVE, VMLOAD, etc... is still controlled by the effective address size,
+ * hence 'unsigned long' instead of 'hpa_t'.
+ */
+static inline void vmsave(unsigned long pa)
 {
 	svm_asm1(vmsave, "a" (pa), "memory");
 }
-- 
2.30.0.365.g02bc693789-goog


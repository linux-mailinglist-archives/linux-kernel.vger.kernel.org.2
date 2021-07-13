Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9E3C74A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhGMQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhGMQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:31 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A1C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:41 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i9-20020ac871c90000b0290252173fe79cso7726217qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=mmLJtuxuRzAHPf02CnAQZUwvZOlodw4FBAs7yXac4yw=;
        b=ackNT3Xf2TczdqhxE47QzxoI8NtDGT1V5X8X1lHIXIgZPFBOiSDIuRAdwH9W955FJR
         ZIEG6OvRQjTHnrJWBqAujpUp7JbA5vwpo3wkFslmC0pJE8AMp56UEiBNMOrCA5bTwdTg
         5EHVEyXFS86ovbnJWweyorLcrMIcWJZWlLR3aBuh/tJi7K2LcHi3pnXUz0OW4aaZBtym
         enEme6MgjIe6hv2yBvojOXwfBmkNIjbYlKQA+xru3klsjLN54FATOWxqm/jaYs2imICI
         bpfi9349CJR7aIpe/xjo+UTaMDvYX8rxcVeIm9FPyTXD2dJaIqxmwv2aTpa1gcjRWp6m
         S9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=mmLJtuxuRzAHPf02CnAQZUwvZOlodw4FBAs7yXac4yw=;
        b=li8HRd/psZyGxyx/3UaHdy9hCTKB63NfsVYyDOIN3RluvqqBVIPV5++d/9+0NDNnrX
         h190Tt1qJGx20GX1toijoaL1h2KSXVT3NnOUqcUInk25TvS/AEJ6HR7BPAtKr208QN6w
         0e9v2Hi4O5QqzwxLmYsL+YGy2ZBPlQZuzXS/D/BCkCMOB8xqGaELRPdQra2TPn0jFF3t
         0KIrP9hfo4yC0EACLTNcKuABcnu0mWGL+gLQ/uzMgYMDwuCE0YxWEJj8riLnqOYTRTlK
         i9RQiDnkFHc5gGv8wKk/LTpXGei8RsWDriti/gA5MfcHgcKtn0AIEP64OA3dlQEDh1zN
         1NeQ==
X-Gm-Message-State: AOAM5331skzViO23AufeiUqt/EaMShfiomHixmBtkurdxhJXBy/IEAfi
        a9FOWopb8roewwyWq7D8WaFhbZXYxIg=
X-Google-Smtp-Source: ABdhPJyyd6AjY4T8NXHb5A8b1AAJZuH1WT8RrMrrbuRr/MnPYhCDMdm2EiTY7UF5eWNcJ+wTouQaor6XU18=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:ca1:: with SMTP id
 s1mr5765426qvs.43.1626194020169; Tue, 13 Jul 2021 09:33:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:41 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 03/46] KVM: SVM: Zero out GDTR.base and IDTR.base on INIT
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

Explicitly set GDTR.base and IDTR.base to zero when intializing the VMCB.
Functionally this only affects INIT, as the bases are implicitly set to
zero on RESET by virtue of the VMCB being zero allocated.

Per AMD's APM, GDTR.base and IDTR.base are zeroed after RESET and INIT.

Fixes: 04d2cc7780d4 ("KVM: Move main vcpu loop into subarch independent code")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 616b9679ddcc..2150642e1bef 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1254,7 +1254,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		SVM_SELECTOR_S_MASK | SVM_SELECTOR_CODE_MASK;
 	save->cs.limit = 0xffff;
 
+	save->gdtr.base = 0;
 	save->gdtr.limit = 0xffff;
+	save->idtr.base = 0;
 	save->idtr.limit = 0xffff;
 
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
-- 
2.32.0.93.g670b81a890-goog


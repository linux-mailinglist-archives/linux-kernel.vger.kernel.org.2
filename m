Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C00367743
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhDVCNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhDVCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19FC061350
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v3-20020a05690204c3b02904e65b70792dso18391986ybs.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zZoTfoM5mk63A68P3JiAw6lVKIlG03B1NHfAfs66rwI=;
        b=AFGRBDLesTLLPBrzlV7iJIrgbqSX8Rc/Br8MF8q5NkMP5ERcneCpEvptZ3lUxlx6t4
         v7Be5BDyZNcIZ4AtzMPRzyCmdBZwK7Ns61AKp7x9GVUeBk7TtQYK20qrcpOwRGCi3Uzy
         4GLn7xlks+QWAIWppHV4iRrUuN6awkSxWK7/6B8oe2pDUGXYeHLmPsDR/YNCLsuyAx+9
         rUFDd/3edRvnr/lyBYsUbpjgnyM3e3efKn5mgorVuA34HpKnt7K7+x6qMCveUp9wZIqY
         S78pK70kHoNz4mlqfd2HnsMGfAO6RLH3OOFmv1hCdam0tO2w/3Bs4/7ZfVj8cBa8kLDD
         SSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zZoTfoM5mk63A68P3JiAw6lVKIlG03B1NHfAfs66rwI=;
        b=g7eyJ1WVbhI+Ld2GLWo4glSeLLdkyEPNgeVAtrnr3avIIxB4TjqYSwT+I//6n/5QHv
         KRkDTcHp2sh5uO5NxLbECDh76v9AaJkTAdOTcaluzbFTFdw+3OKQyMYF9ileKvccLCEF
         5iQlRVKboxMRfA8fbjGFu0m7TDNeC4BQoK/w5whIPdOGdxP0ku7c+fA3uMb0+7cMOUiZ
         UntDwjvBUsJW+7iJ/Z1DsrW0j+gB2Qfpr/KtMac6sxpBIpPzeeUA0+W98A31wPezzpv9
         jvOXcErWKbjiatVLu4YJrwRtNo18gA+JE/ZqJjWaVSkBbZIIQoHp2IIUzmjRW2bsangA
         iO5w==
X-Gm-Message-State: AOAM531HN097brWyCc3FY0/mRTiLHLi+8E4yLOkJ6QpMffZm3weIdGwa
        hh2pYDPq9IlOX9Cm3s+PX8sIBO/Eqas=
X-Google-Smtp-Source: ABdhPJzUK9XtXZPyey6CkU3bFOww9IFwClV7bUIV4WtzD29620xHafjBQiNGSI0VtGdfJ75kJdWFioCCryk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:2443:: with SMTP id k64mr1439744ybk.154.1619057518401;
 Wed, 21 Apr 2021 19:11:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:24 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 14/15] KVM: SVM: Remove an unnecessary prototype
 declaration of sev_flush_asids()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the forward declaration of sev_flush_asids(), which is only a few
lines above the function itself.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4440459cf8e3..5cdfea8b1c47 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -42,7 +42,6 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 #endif /* CONFIG_KVM_AMD_SEV */
 
 static u8 sev_enc_bit;
-static int sev_flush_asids(void);
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
 unsigned int max_sev_asid;
-- 
2.31.1.498.g6c1eba8ee3d-goog


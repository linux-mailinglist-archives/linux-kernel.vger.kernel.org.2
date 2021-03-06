Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18432F7B4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCFCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 21:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCFB7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:59:41 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607AC061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:59:41 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c7so3338909qka.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EaNTtcaGPwfD+VvuXcCpuD7ywnV0eDg95uW62rbzM4A=;
        b=VbAvCNnxOrpQgDgNqdZCbbZakM4DkWtLewiQuIriORQXOPQXa8GlpOSnKcuATHccfx
         NrPffEFxsNsEpf945kX/DxwU1DAvqs2CoRpHAtXfkwCQmgg53jWZnWeq4hOaoI1dgu3h
         ntQuAcpjvLK3XQ5xO4TEd21SOpHEVB7b8ddpkjl0TN2VbC1c/aXJA1u8HWJKST6tWFrU
         Ie2kBOkZZ5dgA7AqdTkaQxSwnPba3VH2hYb66AqjdsYje21JGxrImqKGKRPASo0A9pCn
         owHR1k1Ea6yuY6jcQ1QBwSKIcEAyylM5ZdJoFksRVuAL/1CaK4f1HtTVmdAulQPUOXHm
         3kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EaNTtcaGPwfD+VvuXcCpuD7ywnV0eDg95uW62rbzM4A=;
        b=X4TzzgxtIVu95dEFQHun1p7GeGfK3RWzuL5oDX0wyFY4nVsvXYm1x0OTJ32Ji7DgAq
         rPITl+djpm12DNlsKVVYfM+6FZwEYCLrQmrgCLP2juUEm4a4/TBxz8FUwNJP2K5PFqDw
         VuuGzCKnVseLBTXxxgwYq3XN/lTZgR67jB0qMzD8F6HCv+4UAy5SjutJHBe3V6ls+BgK
         mfuVm0TdpFLB+sOQfHHbPZ+d9ZA3H36yG4j8Jbuk/QzjbY1edtYOsaGaRwluB9KosQeK
         oVXYOBaKuEzc/z8lLI9z9WKjyL20KEwyYyKEu+Tt+dFZNmkTLxfp7xcl6OH+ztIt6JCW
         DNog==
X-Gm-Message-State: AOAM532+4D0AlfGdPm3L9PWCkKKwd78U0h5T82Lao2Mm4GW8rUYdQtxw
        W/jxW4vrDh0sm8ApF0sYX/zlitviNE0=
X-Google-Smtp-Source: ABdhPJzw67+6peb/QWJcovBgcnMAP0xgjdGxtVaYuCp7pkvgXHk3IJLzU1Vg47gzveDVYHUNFEjKmbpZM+k=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
 (user=seanjc job=sendgmr) by 2002:a0c:b7a1:: with SMTP id l33mr11544153qve.17.1614995980607;
 Fri, 05 Mar 2021 17:59:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 17:59:01 -0800
In-Reply-To: <20210306015905.186698-1-seanjc@google.com>
Message-Id: <20210306015905.186698-11-seanjc@google.com>
Mime-Version: 1.0
References: <20210306015905.186698-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 10/14] KVM: SVM: Explicitly check max SEV ASID during sev_hardware_setup()
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

Query max_sev_asid directly after setting it instead of bouncing through
its wrapper, svm_sev_enabled().  Using the wrapper is unnecessary
obfuscation.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bed8fee6c549..63d4f624c742 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1353,8 +1353,7 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-
-	if (!svm_sev_enabled())
+	if (!max_sev_asid)
 		goto out;
 
 	/* Minimum ASID value that should be used for SEV guest */
-- 
2.30.1.766.gb4fecdf3b7-goog


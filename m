Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43B40ECE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhIPVqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhIPVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:46:48 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:45:27 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k1-20020a17090a590100b001971da53970so5961250pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=R5NhbA+pjUVPZNfNHPtaYNtNYTv1h+ja92HfpRStBqA=;
        b=LlzVqBRk9HyqIgkEKwTRdfPTOIlc3qOVXfopYaEeFe9ZewruQYdODOZc8ASQp5OKCr
         Fl7/fBaZ6EHFKNXJ+xM1+VbZvBIswyWIiv0TEV7LOY++QwJvEVoGtioABjNg40Qn3TMA
         unYRCZZpwXzX+cv1A4dD/X6mHRxaNWtuNhCSi55oFbCJsobXuBQEfo5PI0WwyK3cL0a9
         utyujJWR0SBfQ+Pg+0ED6h3oWQP7PTBC6Q/WhqqWFLJLRF+M+Eeqg2JkmSwEqDt9iPtb
         ribrRQ8TyqBF/g79W4DNfjSteKGfhXaqLR/r0oqZsHexVUqAxtuwTNvMRN/a1XIYDPSl
         9bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=R5NhbA+pjUVPZNfNHPtaYNtNYTv1h+ja92HfpRStBqA=;
        b=MKYzyZBI2fskpKtdk6FsGR9OJMvIDfOO44zVIGVUz4w+wQQhj7eoE5nFuE6/K2M8gf
         g7yjkbaAM0CeaLXZ18zLxSnVfaSozNEY9z3FlxvJZcpXtTIGmXK7IlPwI3d4vKzcW2Rv
         W/FwlHPK6zit4tKzPAqVwHC8/9gdOKTHFO5lf8FuPJCxDu/YrPwddkLyJ0oRid27LwdT
         3W74BkYFNiq+iXgyyOHPr9gTqZjocNlsuDVu+43VBXAsIWkPu+x/+fL9Qxa2t2op0Zc7
         V2FWSBerO1j8JSACkuhBEmWldCC2WNvRGKVc1IspsCmiO2Ym+tP5k9J6Ivv5XyRGPinF
         UTSw==
X-Gm-Message-State: AOAM5324Go9v6KNc8jx7M0rvMuFNNjKr5oy0bLgU1XrXQCgCpb6TsOFT
        LVVn0u0Zqyje5XCDrQ4q/4KMrp7JUnIw
X-Google-Smtp-Source: ABdhPJyJ3GLd7Y4KTIshP0TGJLp8e0qxBx7aK4BWozn5MOmt0QCKuiQq7LSf2MbjftzPa+72dT3WDDKPV4P0
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90a:1a52:: with SMTP id
 18mr17365103pjl.43.1631828726904; Thu, 16 Sep 2021 14:45:26 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Thu, 16 Sep 2021 21:45:22 +0000
Message-Id: <20210916214522.1560893-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] KVM: SVM: fix missing sev_decommission() in sev_receive_start()
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, John Allen <john.allen@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DECOMMISSION the current SEV context if binding an ASID fails after
RECEIVE_START. Per AMD's SEV API, RECEIVE_START generates a new guest
context and thus needs to be paired with DECOMMISSION:

AMD SEV API v0.24 Section 1.3.3

  "The RECEIVE_START command is the only command other than the
  LAUNCH_START command that generates a new guest context and guest
  handle."

The missing DECOMMISSION can result in subsequent SEV launch failures due
to insufficient resource. In particular, both LAUNCH_START and
RECEIVE_START command will fail with SEV_RET_RESOURCE_LIMIT error.

Note, LAUNCH_START suffered from the same bug, but was previously fixed by
[1]. However, the same bug could come back to LAUNCH_START if RECEIVE_START
part was not fixed.

So add the sev_decommission() function in sev_receive_start.

[1] commit 934002cd660b ("KVM: SVM: Call SEV Guest Decommission if ASID
			 binding fails").

Cc: Alper Gun <alpergun@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: David Rienjes <rientjes@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vipin Sharma <vipinsh@google.com>

Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Acked-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75e0b21ad07c..55d8b9c933c3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1397,8 +1397,10 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* Bind ASID to this guest */
 	ret = sev_bind_asid(kvm, start.handle, error);
-	if (ret)
+	if (ret) {
+		sev_decommission(start.handle);
 		goto e_free_session;
+	}
 
 	params.handle = start.handle;
 	if (copy_to_user((void __user *)(uintptr_t)argp->data,
-- 
2.33.0.464.g1972c5931b-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71C73759E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhEFR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhEFR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:59:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583BEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 10:58:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a056902070fb02904f8633d41c4so1217513ybt.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ancbaT0mva6sBIo0ZbeTujrtjNlUrJuCzlWUM3NuRWU=;
        b=iBQWdMoEMW3Ix1/ReNy3fOHblCht7nIjAJh+po7T62gIyn+JnfM7W/J3trRS/XlSnb
         0CCFtbs54UnbBNj0FpvqEfUQxdfdgPUz/IWsMZhsuu3qR9PcF2Sx8uKBzP0ThbyjhSOn
         DhlufWaq6xGppWddxvjDYsRu+Dz6KAFUnKs0FPrT6Z6kja8aAnWOW/798NEMAbP7ygg5
         aQZkFYH2d/lzyFoymM9ROM/u8KL5Wp9Mu2ahUM5MR5/o92SaFiytwAY++7U24zuD/DRC
         Tawrzt6QxOBqGT7J+XFFXfKWg4ZfoknNR0aCwsvP91/AL+ORQsxR0Gft/8h42wVzXt0V
         uM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ancbaT0mva6sBIo0ZbeTujrtjNlUrJuCzlWUM3NuRWU=;
        b=NHRf1PZd/4FOpgtGSOi87dtPfS1nXv4pCgD0AromDtZqY9mINZT4/jaOZLQxjfyvN9
         1+nRESE/ffBtD/nehHyLgAOzgv0QoHqCzc2VLDzenYjBm78kyfiBIBVPhEfagUSX3JXi
         nCmJiuYe07TzvD1+qNay4wVbdX6ZKEDd7MPA8kNLprTSvujX1Y2dQa1MT7eInNOnzvc8
         tVqHyrpG51LUbexkphv58bSIa6FYIhxaGsVmZgxAjDGnzPi/S4u2ERgU8as7YbMUy3QI
         BChmONrwdN6Szr9fTZeYqDYHa02Vm6McK+T43QPcpxPewbkPDUsE+TtLJyUCafjAnBF6
         TFhw==
X-Gm-Message-State: AOAM530e2YKlDF1ptEjvGazlD0Gktop+PQZTh5jmHPFSZZbmnifCKKqr
        kLh0+mOepERPmKgxwROlSmN/Dfp4EwM=
X-Google-Smtp-Source: ABdhPJzpNwdgxL8bgvjkEpy2HNyWm/BDq06M8OiZAT5LesPCEyeyB78+drO+mdx0UJf79Yi0C0IvJlCLWSo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:818d:5ca3:d49c:cfc8])
 (user=seanjc job=sendgmr) by 2002:a25:d082:: with SMTP id h124mr7327204ybg.381.1620323913557;
 Thu, 06 May 2021 10:58:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 May 2021 10:58:25 -0700
In-Reply-To: <20210506175826.2166383-1-seanjc@google.com>
Message-Id: <20210506175826.2166383-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210506175826.2166383-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 1/2] KVM: SVM: Return -EFAULT if copy_to_user() for SEV mig
 packet header fails
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steve Rutherford <srutherford@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EFAULT if copy_to_user() fails; if accessing user memory faults,
copy_to_user() returns the number of bytes remaining, not an error code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Steve Rutherford <srutherford@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Fixes: d3d1af85e2c7 ("KVM: SVM: Add KVM_SEND_UPDATE_DATA command")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a9d8d6aafdb8..1f99c240db6d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1303,8 +1303,9 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	}
 
 	/* Copy packet header to userspace. */
-	ret = copy_to_user((void __user *)(uintptr_t)params.hdr_uaddr, hdr,
-				params.hdr_len);
+	if (copy_to_user((void __user *)(uintptr_t)params.hdr_uaddr, hdr,
+			 params.hdr_len))
+		ret = -EFAULT;
 
 e_free_trans_data:
 	kfree(trans_data);
-- 
2.31.1.607.g51e8a6a459-goog


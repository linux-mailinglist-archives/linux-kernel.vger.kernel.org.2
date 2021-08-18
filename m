Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3BC3EFA39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhHRFkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbhHRFjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:39:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B69C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:39:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f10-20020a0ccc8a0000b02903521ac3b9d7so1434089qvl.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Poh4JhZTDJN5s5/LHAgtVCRN1z8C35rutns8va69Gzw=;
        b=elRqnZk9JLKBMjDMEjN5RubMf0U7x6BSkL8NKvX7QI+qo02EpULdtAMpqlPx8Q15+j
         1LfIKimBmlO7mXWLMj7Iwy/7rjJWm0pZFrvrEpKYt8hHZWnyQXnCUc0mFuz3i0T0Ee7M
         EhgmlMsYYlx01f0e9xa3b6Vi9l/5mMvzIdepePyH09pIZeU83KrtgofrXfhA9iSHftsk
         IFc9AE2kL/K7NBTLQfChZeamx2msf0ohKv2gXCvT/aDiaN5RGpJ1ZREUwOsJV/mljfDM
         dC32ivL6eDhMAfE0SyHhAuxfijDdu/69aoum0D3vC2YWo0wwyjXPyr30ZJ0acDlsJRZj
         rifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Poh4JhZTDJN5s5/LHAgtVCRN1z8C35rutns8va69Gzw=;
        b=jnMLE6MlIFAxxpxpJSFmayvN6UkBXkzpvOSmAEchimsThTmOUD+NNNK1iPWF+fR7SO
         YthfyhIsoIG33dJGFCRdQiQ+BXESWT56LCaTtVrX1bbDkfAeiDHGl52g0K47jzHR5NH3
         u2XGwJc0neoDh+QJcN+30I9rXekMBPa97q307MAp1aDhSz6N/lsDZX3A+MF0iRhX7cSO
         ixiea0CUXmTiOjDm/RqwfdHAALwZIsb8BruzhnvexlT4cK13wmrCllzdY4nqnUqg944m
         AFaToZE0YvF6yvdOh6EDSQs+Mpb8dmcq2Nyxo1vhjA3TjhbClqrNy8EuvSPbRYYDbQBe
         O84Q==
X-Gm-Message-State: AOAM530bvaGPwAIWvb+hTYxnRb25XfvSankvNw8eDf3BWTXwL3w0A+5d
        r9Qfh3baAlTmCQCeY8Cob11GzGuT609w
X-Google-Smtp-Source: ABdhPJzYBWw1AWTbiVyVqf2STR+xAiopBUJNUOyE/Qf4xUhET/X7PXLMrT9Jp0FBBUnmPCe3bZ5/2Z1yJ7eA
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:ad4:500d:: with SMTP id
 s13mr7156659qvo.40.1629265158362; Tue, 17 Aug 2021 22:39:18 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Wed, 18 Aug 2021 05:39:06 +0000
In-Reply-To: <20210818053908.1907051-1-mizhang@google.com>
Message-Id: <20210818053908.1907051-3-mizhang@google.com>
Mime-Version: 1.0
References: <20210818053908.1907051-1-mizhang@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 2/4] KVM: SVM: move sev_decommission to psp driver
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ccp/sev-dev.c is part of the software layer in psp that allows KVM to
manage SEV/ES/SNP enabled VMs. Among the APIs exposed in sev-dev, many of
them requires caller (KVM) to understand psp specific data structures. This
often ends up with the fact that KVM has to create its own 'wrapper' API to
make it easy to use. The following is the pattern:

kvm_func(unsigned int handle)
{
	psp_data_structure data;

	data.handle = handle;
	psp_func(&data, NULL);
}

psp_func(psp_data_structure *data, int *error)
{
	sev_do_cmd(data, error);
}

struct psp_data_structure {
	u32 handle;
};

sev_decommission is one example following the above pattern. Since KVM is
the only user for this API and 'handle' is the only data that is meaningful
to KVM, simplify the interface by putting the code from kvm function
sev_decommission into the psp function sev_guest_decomssion.

No functional change intended.

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

Acked-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/sev.c       | 17 +++--------------
 drivers/crypto/ccp/sev-dev.c | 10 ++++++++--
 include/linux/psp-sev.h      |  7 ++++---
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 55d8b9c933c3..b8b26a9c5369 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -198,17 +198,6 @@ static void sev_asid_free(struct kvm_sev_info *sev)
 	sev->misc_cg = NULL;
 }
 
-static void sev_decommission(unsigned int handle)
-{
-	struct sev_data_decommission decommission;
-
-	if (!handle)
-		return;
-
-	decommission.handle = handle;
-	sev_guest_decommission(&decommission, NULL);
-}
-
 static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 {
 	struct sev_data_deactivate deactivate;
@@ -223,7 +212,7 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 	sev_guest_deactivate(&deactivate, NULL);
 	up_read(&sev_deactivate_lock);
 
-	sev_decommission(handle);
+	sev_guest_decommission(handle, NULL);
 }
 
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -349,7 +338,7 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	/* Bind ASID to this guest */
 	ret = sev_bind_asid(kvm, start.handle, error);
 	if (ret) {
-		sev_decommission(start.handle);
+		sev_guest_decommission(start.handle, NULL);
 		goto e_free_session;
 	}
 
@@ -1398,7 +1387,7 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	/* Bind ASID to this guest */
 	ret = sev_bind_asid(kvm, start.handle, error);
 	if (ret) {
-		sev_decommission(start.handle);
+		sev_guest_decommission(start.handle, NULL);
 		goto e_free_session;
 	}
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 91808402e0bf..e2d49bedc0ef 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -903,9 +903,15 @@ int sev_guest_activate(struct sev_data_activate *data, int *error)
 }
 EXPORT_SYMBOL_GPL(sev_guest_activate);
 
-int sev_guest_decommission(struct sev_data_decommission *data, int *error)
+int sev_guest_decommission(unsigned int handle, int *error)
 {
-	return sev_do_cmd(SEV_CMD_DECOMMISSION, data, error);
+	struct sev_data_decommission decommission;
+
+	if (!handle)
+		return -EINVAL;
+
+	decommission.handle = handle;
+	return sev_do_cmd(SEV_CMD_DECOMMISSION, &decommission, error);
 }
 EXPORT_SYMBOL_GPL(sev_guest_decommission);
 
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index d48a7192e881..6c0f2f451c89 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -612,17 +612,18 @@ int sev_guest_df_flush(int *error);
 /**
  * sev_guest_decommission - perform SEV DECOMMISSION command
  *
- * @decommission: sev_data_decommission structure to be processed
+ * @handle: sev_data_decommission structure to be processed
  * @sev_ret: sev command return code
  *
  * Returns:
  * 0 if the sev successfully processed the command
+ * -%EINVAL    if handle is NULL
  * -%ENODEV    if the sev device is not available
  * -%ENOTSUPP  if the sev does not support SEV
  * -%ETIMEDOUT if the sev command timed out
  * -%EIO       if the sev returned a non-zero return code
  */
-int sev_guest_decommission(struct sev_data_decommission *data, int *error);
+int sev_guest_decommission(unsigned int handle, int *error);
 
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 
@@ -637,7 +638,7 @@ static inline int
 sev_guest_deactivate(struct sev_data_deactivate *data, int *error) { return -ENODEV; }
 
 static inline int
-sev_guest_decommission(struct sev_data_decommission *data, int *error) { return -ENODEV; }
+sev_guest_decommission(unsigned int handle, int *error) { return -ENODEV; }
 
 static inline int
 sev_guest_activate(struct sev_data_activate *data, int *error) { return -ENODEV; }
-- 
2.33.0.rc1.237.g0d66db33f3-goog


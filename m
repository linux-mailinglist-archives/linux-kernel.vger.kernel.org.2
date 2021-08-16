Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA83EDE9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhHPUZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhHPUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:25:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F1C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w201-20020a25dfd2000000b00594695384d1so4614695ybg.20
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OaovW+VBocncb082CQVnEflU35hVdinYVYmJKw4413A=;
        b=D7dhyu//8TUnnI0T+zsJwLWKcS8FeoX35kk5eu/gi9PZde3ChNzoygFpGKSrb+4uCK
         PEJKvri5CRU9N0JP4UpBNfF4Tce7WAwrBBdWMWG/1X3+1B3j+/S6DI3ZIgD03AV9Lgnf
         66E5+BuO0+DqPLafB6wT66tITiRTLrjbAjlVhhBLh/F1fhZIRRge06UuLYqQQlaRNDWK
         PxqtqMLBNixDGRTILPE/N3q+6k2KzH/Nnp7zGQNX9BWv2fsLD8FrEhG4FsYQT9Y/F2LR
         PUgIwG/U6/x+TTMcxQujy304/K3IboPGL6AInOHyWFJt83+lsHTjEpT1ywieeC/c38sg
         a8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OaovW+VBocncb082CQVnEflU35hVdinYVYmJKw4413A=;
        b=Zs0HtP++mHuRZPwhyLL83ODSE7ZRHLlN8GxtnfOU+Qtc9AsZwc2wxCaV4CHeLFAHbQ
         qV+wK1xqQUOMXeENv908MiRUkNufzZ5j9fU+mGVnjFMQIRVac7PJHAD0MXzSlP9g3cEi
         x56pOqQuUNoY0RKPJSHLOPRaJJ6UW9cxnprxBqOne4of4vBp+fudzw2JSPgLEHJXrvI/
         xIZEExn7qIog/zttCfS5bZ2yYHoaAb4T2GV5w7DxCYwiA/hqJ2tXqJTw05QCL9gnk/lJ
         4VmSuWq1+IsoTdFu+J7S8YoYUHg1AYTujGsoVsQa4ZrD8b/ge+gJ+x5wVJqrbBMbM/So
         x7lQ==
X-Gm-Message-State: AOAM530PkIvYOZv/b2KiBSSBcUR+jNiCgoLLoDnvYPbkI38tLkV8fSeL
        GaTABFG5vgG/0giWXD/ZE4Z7swwUPE6s
X-Google-Smtp-Source: ABdhPJxIMqz27nTJUgfga7qLDAHIDa6ONMo3oIPLOxj5qe0jtmjpu/OkkRKcFSovMz+qrpB61Jqk6yW6P2dU
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a25:d691:: with SMTP id
 n139mr279100ybg.27.1629145494110; Mon, 16 Aug 2021 13:24:54 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 16 Aug 2021 20:24:40 +0000
In-Reply-To: <20210816202441.4098523-1-mizhang@google.com>
Message-Id: <20210816202441.4098523-3-mizhang@google.com>
Mime-Version: 1.0
References: <20210816202441.4098523-1-mizhang@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 2/3] KVM: SVM: move sev_bind_asid to psp
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

ccp/sev-dev.c is the software layer in psp that allows KVM to manage
SEV/ES/SNP enabled VMs. Since psp API provides only primitive sev command
invocation, KVM has to do extra processing that are specific only to psp
with KVM level wrapper function.

sev_bind_asid is such a KVM function that literally wraps around
sev_guest_activate in psp with extra steps like psp data structure creation
and error processing: invoking sev_guest_decommission on activation
failure.

Adding sev_guest_decommission is essentially required on all sev_bin_asid
call sites. This is error prone and in fact the upstream code in KVM still
have an issue on sev_receive_start where sev_guest_decommission is missing.

Since sev_bind_asid code logic is purely psp specific, putting it into psp
layer should make it more robust, since KVM code does not have to worry
about error handling of asid binding failure.

So replace the KVM pointer in sev_bind_asid with primitive arguments: asid
and handle; slightly change the name to sev_guest_bind_asid make it
consistent with other psp APIs; add the error handling code inside
sev_guest_bind_asid and; put it into the sev-dev.c.

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

Fixes: af43cbbf954b ("KVM: SVM: Add support for KVM_SEV_RECEIVE_START command")
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/sev.c       | 23 ++++-------------------
 drivers/crypto/ccp/sev-dev.c | 15 +++++++++++++++
 include/linux/psp-sev.h      | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6a1faf28d973..2a674acb22ce 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -252,20 +252,6 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
-static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
-{
-	struct sev_data_activate activate;
-	int asid = sev_get_asid(kvm);
-	int ret;
-
-	/* activate ASID on the given handle */
-	activate.handle = handle;
-	activate.asid   = asid;
-	ret = sev_guest_activate(&activate, error);
-
-	return ret;
-}
-
 static int __sev_issue_cmd(int fd, int id, void *data, int *error)
 {
 	struct fd f;
@@ -336,11 +322,9 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free_session;
 
 	/* Bind ASID to this guest */
-	ret = sev_bind_asid(kvm, start.handle, error);
-	if (ret) {
-		sev_guest_decommission(start.handle, NULL);
+	ret = sev_guest_bind_asid(sev_get_asid(kvm), start.handle, error);
+	if (ret)
 		goto e_free_session;
-	}
 
 	/* return handle to userspace */
 	params.handle = start.handle;
@@ -1385,7 +1369,8 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free_session;
 
 	/* Bind ASID to this guest */
-	ret = sev_bind_asid(kvm, start.handle, error);
+	ret = sev_guest_bind_asid(sev_get_asid(kvm), start.handle, error);
+
 	if (ret)
 		goto e_free_session;
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ab9c2c49d612..ef58f007030e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -903,6 +903,21 @@ int sev_guest_activate(struct sev_data_activate *data, int *error)
 }
 EXPORT_SYMBOL_GPL(sev_guest_activate);
 
+int sev_guest_bind_asid(int asid, unsigned int handle, int *error)
+{
+	struct sev_data_activate activate;
+	int ret;
+
+	/* activate ASID on the given handle */
+	activate.handle = handle;
+	activate.asid   = asid;
+	ret = sev_guest_activate(&activate, error);
+	if (ret)
+		sev_guest_decommission(handle, NULL);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sev_guest_bind_asid);
+
 int sev_guest_decommission(unsigned int handle, int *error)
 {
 	struct sev_data_decommission decommission;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 6c0f2f451c89..be50446ff3f1 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -595,6 +595,22 @@ int sev_guest_deactivate(struct sev_data_deactivate *data, int *error);
  */
 int sev_guest_activate(struct sev_data_activate *data, int *error);
 
+/**
+ * sev_guest_bind_asid - bind an ASID with VM and does decommission on failure
+ *
+ * @asid: current ASID of the VM
+ * @handle: handle of the VM to retrieve status
+ * @sev_ret: sev command return code
+ *
+ * Returns:
+ * 0 if the sev successfully processed the command
+ * -%ENODEV    if the sev device is not available
+ * -%ENOTSUPP  if the sev does not support SEV
+ * -%ETIMEDOUT if the sev command timed out
+ * -%EIO       if the sev returned a non-zero return code
+ */
+int sev_guest_bind_asid(int asid, unsigned int handle, int *error);
+
 /**
  * sev_guest_df_flush - perform SEV DF_FLUSH command
  *
@@ -643,6 +659,9 @@ sev_guest_decommission(unsigned int handle, int *error) { return -ENODEV; }
 static inline int
 sev_guest_activate(struct sev_data_activate *data, int *error) { return -ENODEV; }
 
+static inline int
+sev_guest_bind_asid(int asid, unsigned int handle, int *error) { return -ENODEV; }
+
 static inline int sev_guest_df_flush(int *error) { return -ENODEV; }
 
 static inline int
-- 
2.33.0.rc1.237.g0d66db33f3-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2577342AE30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhJLUvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhJLUvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:51:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAFC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:49:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso675777ybb.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5rpbBBxXYnQlKlnVXmOdTaySI3jmj1Cw0Iss9XL2zks=;
        b=gElW6d9WHAnykPbijck4HL/tN67aQq1ATwA2uNw6a4+YIuGWts+7E0vh05z61cOpen
         ocWO3g2vlDUCrV7SZpzAazUrILZBfFLzsObrGmLjJdcFzOohe63yFaq+3qJSII5CDeZ8
         74XVlK69bD82ti2lENcGBd7XppFYIO/7ssq0n7YGxi+IKP2r3lbJL1XmDAGoidHwZbh2
         TpADVVSY/1RGX9IzK92uViQK5PfTX9CoB5x4I0IuG1upGVMHVZKdKXrXWOruTjdE2c2s
         h2WOg6EQh1lrsKvgZtTLxQBG/bltc4+2ynf3/R5RgAta+Eu31hY+nY6MzARw4iTWv92t
         uDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5rpbBBxXYnQlKlnVXmOdTaySI3jmj1Cw0Iss9XL2zks=;
        b=SbVMtpXsAojMVIK+UBo67xvp5yGtqTmiSTwAztk8sbpkz1esE73xN1/WITjc+Cxd5D
         8i4GIHc9JjaH6o0we290WQAuohMFdJIaKjwiEW94bzsbr8kJiULzEc464949xqaDjHNM
         iYFXIVYn5sOavC4jyxOvN4Rv/UnMqc68yvxrbgLBS4C5UG1flIsQ49IbrXZgAzz03swf
         ZkT8vD2Ko4FOSXpkvezrBYO0rCUyqJKE+trJ3IAdGRTbXhJdQgmzQb6voGsXjtg+Wv/o
         gljH2ZLN5GYHOAEceUPuqL/eq/7PLGgWrKXy8j8zyDjx0wIUQgd7qbjKGTgBNS3AAajT
         0s0Q==
X-Gm-Message-State: AOAM532AM2+bE4tDv9s5hw9pKHn5SAH9UKY0JSansn8MccJKKcCFMkC5
        kw4HycZlPH9hDZmRHvkWsleIF6l+9+E=
X-Google-Smtp-Source: ABdhPJx93TFToUDDdvJSQFzb2D1wjxhb26KvL1sSgu9zdjuHkSVDSxSHcaBX9dzwA+fEY/goqYfh89Ub/3I=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:bab5:e2c:2623:d2f8])
 (user=pgonda job=sendgmr) by 2002:a25:a105:: with SMTP id z5mr31004516ybh.247.1634071751188;
 Tue, 12 Oct 2021 13:49:11 -0700 (PDT)
Date:   Tue, 12 Oct 2021 13:48:57 -0700
In-Reply-To: <20211012204858.3614961-1-pgonda@google.com>
Message-Id: <20211012204858.3614961-5-pgonda@google.com>
Mime-Version: 1.0
References: <20211012204858.3614961-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 4/5 V10] selftest: KVM: Add open sev dev helper
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactors out open path support from open_kvm_dev_path_or_exit() and
adds new helper for SEV device path.

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++++++--------
 tools/testing/selftests/kvm/lib/x86_64/svm.c  | 13 ++++++++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 1b3ef5757819..adf4fa274808 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -82,6 +82,7 @@ struct vm_guest_mode_params {
 };
 extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
+int open_path_or_exit(const char *path, int flags);
 int open_kvm_dev_path_or_exit(void);
 int kvm_check_cap(long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index b7531c83b8ae..587fbe408b99 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -46,4 +46,6 @@ static inline bool cpu_has_svm(void)
 	return ecx & CPUID_SVM;
 }
 
+int open_sev_dev_path_or_exit(void);
+
 #endif /* SELFTEST_KVM_SVM_UTILS_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0fe66ca6139a..ea88e6b14670 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -31,6 +31,19 @@ static void *align(void *x, size_t size)
 	return (void *) (((size_t) x + mask) & ~mask);
 }
 
+int open_path_or_exit(const char *path, int flags)
+{
+	int fd;
+
+	fd = open(path, flags);
+	if (fd < 0) {
+		print_skip("%s not available (errno: %d)", path, errno);
+		exit(KSFT_SKIP);
+	}
+
+	return fd;
+}
+
 /*
  * Open KVM_DEV_PATH if available, otherwise exit the entire program.
  *
@@ -42,16 +55,7 @@ static void *align(void *x, size_t size)
  */
 static int _open_kvm_dev_path_or_exit(int flags)
 {
-	int fd;
-
-	fd = open(KVM_DEV_PATH, flags);
-	if (fd < 0) {
-		print_skip("%s not available, is KVM loaded? (errno: %d)",
-			   KVM_DEV_PATH, errno);
-		exit(KSFT_SKIP);
-	}
-
-	return fd;
+	return open_path_or_exit(KVM_DEV_PATH, flags);
 }
 
 int open_kvm_dev_path_or_exit(void)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
index 2ac98d70d02b..14a8618efa9c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
@@ -13,6 +13,8 @@
 #include "processor.h"
 #include "svm_util.h"
 
+#define SEV_DEV_PATH "/dev/sev"
+
 struct gpr64_regs guest_regs;
 u64 rflags;
 
@@ -160,3 +162,14 @@ void nested_svm_check_supported(void)
 		exit(KSFT_SKIP);
 	}
 }
+
+/*
+ * Open SEV_DEV_PATH if available, otherwise exit the entire program.
+ *
+ * Return:
+ *   The opened file descriptor of /dev/sev.
+ */
+int open_sev_dev_path_or_exit(void)
+{
+	return open_path_or_exit(SEV_DEV_PATH, 0);
+}
-- 
2.33.0.882.g93a45727a2-goog


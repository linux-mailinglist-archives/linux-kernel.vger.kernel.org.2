Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5D4369A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhJURsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhJURrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:47:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF3C061224
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:43:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a12-20020a17090aa50cb0290178fef5c227so4195447pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AO7v/MDuuWoYbVonp2h2kWvBn6hjhV7oaHGed9pGpg0=;
        b=l9PcbRMXtQj/cbkkWRNV3ONTYQDnsu7FphYvZJLyITOr41ZIh74mKwOnyKRiJcHDS5
         c4puwpkqkiKcqs4nslw4btPffaNwv0xFwIg97llg8E1fUrpIw2NkEBAGRImUJJh8LWxF
         WB+o3AidFE6MLqE2DliHaLWDwYg9+0ofuBxvXga15B+hV2MuNdkxVRMEc6jLM7/vb5Hr
         GayQ7f65tllXw2mkXY69tPGNdPjJtivnIxtCx3nS7rH7lT8xvZ9oZgOl++fySrvXDWCL
         cij/xbsjjEtUJFmzazf7aAKlWRshNNyGHoVOG2K0qjJ2umq5WlA5Necaxq1uAOWa1SNK
         CvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AO7v/MDuuWoYbVonp2h2kWvBn6hjhV7oaHGed9pGpg0=;
        b=QV7GJumWHGF4VEcqkG6HJhO/ElBF1TYcCipW51YW+CPA2qS0GFTAUPazjISlpkI3Rn
         wXGqtRXTVwecK6Oj2XYm85oxUPpoGkq+vK+ADJNttHg0JpEGs9jfrGCnrh+AEdy9JCbb
         lHzC1LM8VhIjBj0iP2XYTWrXtb93ZcKSZN/PrHEzL2iMBQS2IMpEO+qsmfeAyf+8nU3n
         jCMXWwoNPba5jgs0fnOyhBl18FQbYTSGB54I3uya2IiTXCBdzL2877JHTKHnZ9Zcazig
         p2AnlK8AUd+/hWW7q2y3fV4bQsSyddXrwGgTqoO0VKBjkN9PR2v6mSRMbXVi5PRmxSAf
         BGKQ==
X-Gm-Message-State: AOAM533m39mdlmsTpwu2p5QnoY5gDXAgv9VK0zmrZWOrm5BM7Sl+ktw0
        c9qSUN4C1KRSdu39MjxYeOSvMbqGOrA=
X-Google-Smtp-Source: ABdhPJzZf0VveNt3eEAglzXtq6sfAuFvbVBqwyUIEANnvFi8/WFN4B50S7AI+Eg87cpDRUEd1gfrXtbSCqU=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:da2d:dcb2:6:add9])
 (user=pgonda job=sendgmr) by 2002:a17:902:780f:b0:13a:3a88:f4cb with SMTP id
 p15-20020a170902780f00b0013a3a88f4cbmr6538277pll.68.1634838194102; Thu, 21
 Oct 2021 10:43:14 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:43:02 -0700
In-Reply-To: <20211021174303.385706-1-pgonda@google.com>
Message-Id: <20211021174303.385706-5-pgonda@google.com>
Mime-Version: 1.0
References: <20211021174303.385706-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH V11 4/5] selftest: KVM: Add open sev dev helper
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactors out open path support from open_kvm_dev_path_or_exit() and
adds new helper for SEV device path.

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++++++--------
 tools/testing/selftests/kvm/lib/x86_64/svm.c  | 13 ++++++++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 010b59b13917..368e88305046 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -80,6 +80,7 @@ struct vm_guest_mode_params {
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
index 10a8ed691c66..06a6c04010fb 100644
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
2.33.0.1079.g6e70778dc9-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97284418D58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhI0Awl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhI0Awj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 20:52:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECDC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:51:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e7so16205031pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsdM6aopx9gxxLgRRxYhXTLHWovYEZKaxBqN+pAsLlI=;
        b=iCYCIrYHrbK8cdGtn6MR8fwASSIoV80M93RdizJldcwb0F1vOjxJeH29f4/xfyieDS
         hOrYSxPnhwLJ8ZDSqC9qdnuiQ8Yuvu4/RYvmMRMqra5oAneJoGvmFsmtclMK/RIE8MaY
         cJSKPWqGgl8X6ycl8vhsvvhde25kem3DuC4ZZfvZHcKb3ZFke1656iCbrEeySSAB9E/H
         dAvxN/urxoD4mCaYCcPKGfpQ3EdAT4d0L6DlSZ2bcqCzP/tmp/SG3cV3l+XUJEkFsSdk
         1nuzuYsNzMhN1EIJa/YfLlg/xqrVgNomi5CC3Czb0hM1TIpZ+4sXV+YHDAKiXp25JBoQ
         aQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsdM6aopx9gxxLgRRxYhXTLHWovYEZKaxBqN+pAsLlI=;
        b=5KwdimOrQ1ZGG+Dbf557bGvBsRWz91IVJaFLkhukgE1qNDumEcSpQsOYbziTpfYqbj
         F1PuOhClQhvTJvDAaRaFRmvd44iTaIF8rYU1/Xs2l6BBw70smUC6ArQkymEAccWWHUjg
         G6KJljJRtGuTHkClvnSM4Ek+AsYR2EK/quGAewRb5EuhxTwb9ukh7H69+EIQGio5azrO
         A703zte8ixFk87zwyiKL35d3hnci/XrDYCnYJ3hk/a9sau4jQLEKLpPFF9MzYGcQyoPY
         fJLsFLxPv6k7awRlObqTFPHs+sMvnG6eo8N1pzcZ3bp7S8mBObuCWZQwlvqxSHbsXOHr
         DQWA==
X-Gm-Message-State: AOAM533+TxFKsUr1KNtCqCykmHO1i3SDoqpbxM5ZCyNoo0Jt20ima6aN
        L1QAulI/koD7+kZ9Z5kY6bM=
X-Google-Smtp-Source: ABdhPJw7USP55NiL7P6tGkUgDeqfHmAd76+FYrDcWgcQ/zcLtuw7nL4ClcgEDjGQDUOdgTakIIJCbg==
X-Received: by 2002:a62:8855:0:b0:44b:8cc3:8f6d with SMTP id l82-20020a628855000000b0044b8cc38f6dmr2739498pfd.44.1632703862615;
        Sun, 26 Sep 2021 17:51:02 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i27sm15032280pfq.184.2021.09.26.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:51:02 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Coiby Xu <coxu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH 1/2] kexec, KEYS: make the code in bzImage64_verify_sig public
Date:   Mon, 27 Sep 2021 08:50:03 +0800
Message-Id: <20210927005004.36367-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927005004.36367-1-coiby.xu@gmail.com>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coiby Xu <coxu@redhat.com>

The code in bzImage64_verify_sig could make use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
signed kernel image as PE file. Move it to a public function.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 +------------
 include/linux/kexec.h             |  3 +++
 kernel/kexec_file.c               | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..4136dd3be5a9 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
+	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..d45f32336dbe 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
@@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #ifdef CONFIG_KEXEC_SIG
 int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 				 unsigned long buf_len);
+int arch_kexec_kernel_verify_pe_sig(const char *kernel,
+				    unsigned long kernel_len);
 #endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..85ed6984ad8f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -106,6 +106,21 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 {
 	return kexec_image_verify_sig_default(image, buf, buf_len);
 }
+
+int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
 #endif
 
 /*
-- 
2.33.0


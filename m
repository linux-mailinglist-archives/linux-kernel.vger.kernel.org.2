Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3B42789D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbhJIJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhJIJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633773317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsLPwwfJMvJmM4PrEHlGw5zfIwX7nOgCAknVMv1VPzs=;
        b=NEXTLgI0y7vtsTeay1uW7SR1VRke7VGcK5mx0FYgGeFN8awppoteAjNOZHjuTlal1E3q4B
        s4ByFTmsa2Dj4UdnS+j8m/g5Z+HlAF2EDyMENFfhGlTjAgB624gn8TItc2tLRAjTvMK+h7
        PqmQNUW9ju+8UxLLH9j43tBH9H6epYE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-cdzMUC2fNHu3_86k6goEyw-1; Sat, 09 Oct 2021 05:55:16 -0400
X-MC-Unique: cdzMUC2fNHu3_86k6goEyw-1
Received: by mail-pg1-f200.google.com with SMTP id z19-20020a631913000000b00252ede336caso3282042pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 02:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsLPwwfJMvJmM4PrEHlGw5zfIwX7nOgCAknVMv1VPzs=;
        b=Nq8VEPBHYr6Q6nwzKrZoceXXP0sLI4HkhnnN/z3TTOkzcPSwwVgziPvIbH/xMd4Ekw
         /jR4g3oE7SH0SEuPSmSVY6EzV0ve/330T0pRtsn7JN1MNvjgxi8aB4FQDOw+QgEZ9XoJ
         5aflalhRsFFJ2IQqrW0heB8B80QQwt9v77beA9L5Iukz5T/IDtPJ5VzoCaO6NniejPcv
         DVHpcqo7N9f0Jez1mQtxeaCP90BlCarMb7cjHMsOR2aHh/ezzT6yQ/ftzom0t5IZXu78
         GhA2iXeN8JxF1ExADyThwCfn1580j8o9yqWsb/C/vLL7rDFyKEJTfupAaUOztU62O78q
         cOoA==
X-Gm-Message-State: AOAM530yB2hrw3ObMMiRDfBKXF0LkDd9SZ8tvsueoKL4e/5DP/N9aYoa
        bIJkbvH6zU2hx4wmv+CVYNP1ooIhyaHq5EVG14MQWnybwr29RUwGZFWswRk96zpTaLo9+Awt7Em
        zcrw8kMBFkv1IX/ld3XafTlYv
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr17419762pjb.0.1633773315177;
        Sat, 09 Oct 2021 02:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8syPDNVODcQ5AMjYRz3SYVVr1GIyZ7ZZ6GvjFVwJAP1874M9w4yiCQDFY0ja6waqA6RZSbg==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr17419745pjb.0.1633773315001;
        Sat, 09 Oct 2021 02:55:15 -0700 (PDT)
Received: from localhost ([240e:473:3c30:93d:5429:b8e4:3097:6ec8])
        by smtp.gmail.com with ESMTPSA id d18sm2106657pgk.24.2021.10.09.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 02:55:14 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2 1/2] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Sat,  9 Oct 2021 17:54:57 +0800
Message-Id: <20211009095458.297191-2-coxu@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009095458.297191-1-coxu@redhat.com>
References: <20211009095458.297191-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in bzImage64_verify_sig could make use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
signed kernel image as PE file. Make it generic so both x86_64 and arm64 can 
use it.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 +------------
 include/linux/kexec.h             |  3 +++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 12 deletions(-)

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
index 33400ff051a8..0530275b7aa3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -106,6 +106,23 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 {
 	return kexec_image_verify_sig_default(image, buf, buf_len);
 }
+
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
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
+#endif
 #endif
 
 /*
-- 
2.31.1


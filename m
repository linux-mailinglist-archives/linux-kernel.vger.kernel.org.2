Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6971F43122F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhJRIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231190AbhJRIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634545910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0sNhhBML/EkE8pAk6lfQlw2B0aJ8U2VP3A/HrNdM8g=;
        b=FMFi3xwVubUNC3AbVUOzCc4qVUKBzq5ogc0jXb3D3SDaFc5+zEOA/0KAFFzWPOUZiwhjwT
        zUzdYDIv9UtlfddTJGn1dNtxGqUfWM4CefyWypc3+IN24S8aXhUALRW2HvA/TZZiF/6CPy
        ujdUEzQrg+/kOvnJ+qc28kFq1Fmlly4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ExEPsTRFMF-DT3dqRZ1OBg-1; Mon, 18 Oct 2021 04:31:48 -0400
X-MC-Unique: ExEPsTRFMF-DT3dqRZ1OBg-1
Received: by mail-pl1-f198.google.com with SMTP id m10-20020a1709026bca00b0013f8e975b31so3215777plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0sNhhBML/EkE8pAk6lfQlw2B0aJ8U2VP3A/HrNdM8g=;
        b=Zyd4ldwJ+x0JUL6iP4aBfb9hwpr+8TPSXNKapaSdJ/JK0c3kZGdwMFPxX87IOrHKYP
         Ya8cY3nQhP6sldl02za2vGNmYnzKNrv896pYW0OC3STH3BTG19gn2wvfpVsRDyDz8lXb
         cgv89aw6TjN7sZy1X+rFJzwV75/L/vsx3BM+OrlrZqUxnhUCA9VN4w9wZtZrel7viZu9
         7zBAMxp4BC+laPxZk3ll16VXLZoma+28yGMk7bUoC6iuOaEwOlI/c7MN2ny2/MlRFaK1
         iPFt4ILeZfCLj+59sP2q/ipJjoXQwSkxNLn8NW1Cp5z04Vz1nOyEY2fh2maA5jXfYEL5
         AvdQ==
X-Gm-Message-State: AOAM531u6ugf7D7iM6kk9clm8vGLdEC2U5PCEFMe0fnM1QjU/4Saiw3W
        icfcionmyd1Jsl4MwwMhiGJf2gFsYv0rRlGSWCczdHOwJvdkoOIi/S7rgIWvcdyh0s4USs2PTXk
        bcmA2Hk+CwltOG7kg2JdJM+k/
X-Received: by 2002:a05:6a00:807:b0:44d:90ef:d27d with SMTP id m7-20020a056a00080700b0044d90efd27dmr20954229pfk.16.1634545907327;
        Mon, 18 Oct 2021 01:31:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF+l4ScCod4suOjh5afo+6AWNzYKNtHeoZdwTSWDf8Oy7uBo9wVxJCwTKqdYMonlDkP9Efag==
X-Received: by 2002:a05:6a00:807:b0:44d:90ef:d27d with SMTP id m7-20020a056a00080700b0044d90efd27dmr20954207pfk.16.1634545907124;
        Mon, 18 Oct 2021 01:31:47 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j126sm12578103pfd.113.2021.10.18.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:31:46 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v3 2/3] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Mon, 18 Oct 2021 16:31:36 +0800
Message-Id: <20211018083137.338757-3-coxu@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018083137.338757-1-coxu@redhat.com>
References: <20211018083137.338757-1-coxu@redhat.com>
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
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f73aab3fde33 100644
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
+	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 755fed183224..2fe39e946988 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
@@ -196,6 +197,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel,
+				    unsigned long kernel_len);
+#endif
+#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 42b3ac34e4ee..746d50fd8ebe 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
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
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 		unsigned long buf_len)
 {
-- 
2.31.1


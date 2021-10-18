Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D443122E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhJRId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhJRId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634545906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csQLUtgBqx/5daSsrbY1xfwwRnYytpMxFZ1u3egdn8A=;
        b=LXJ23YMHhVbEkeUaN6BIljfs8jIM/qKMWnHMMhmyljnKEK0HSn/Cb4Odf4i5XqUJVUfkzb
        nocqnscX064mquvpRWlTOZJJMxUWBY209l5A6o3C42OwvWYfQTkYZwK7j1cuFs08PlkmJG
        4/Ot3Mh2P3fwGQYQ9pviHQ1nwN0n12o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-XXaLjw-KMBaO1V0S_USY7A-1; Mon, 18 Oct 2021 04:31:45 -0400
X-MC-Unique: XXaLjw-KMBaO1V0S_USY7A-1
Received: by mail-pj1-f71.google.com with SMTP id nl15-20020a17090b384f00b001a0d49be015so9377324pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csQLUtgBqx/5daSsrbY1xfwwRnYytpMxFZ1u3egdn8A=;
        b=n4Ms9aETHRcQToAvk5Hx5Z1XFLLeqbcy/grQF8XYT6qfcqEgiS2VFVeTmXMBqNVgzH
         ivmg9uD8lgNp9IYYHZpNeUxwsj0vnk7ESKn/G+xpvGFghQUzjn9v22nUbhCxuVvg3dTm
         MOY1RLqveeflcbn4pUd7eKxPCvrDdBpo8obrj8/VFIKcvdikl2vbd+s4DVa6c/10Q5/B
         qoqRjMqFBPvNJ9T5k6+1hupvje2vlK235CNIj2ZlAXELqLPJDLB5CrWm36x+M1b52ZSj
         3aT21Is9MZn8qe0YOit9H7WKY4AT/QGtVu79HOiZQOdhtYJymrSWaUvpFeSLj73VA7fo
         dhPg==
X-Gm-Message-State: AOAM532lffr+W616k0bzd5nb5chQZFUcMtFgMA0VGqSpwmyaueKjefQp
        dKVAj8B/kR7NebnuobJp2UCYOA9bBD2FwkrdKZQyhvSvIGy2bWwZCZdI+bhr6zNsCbcGtcuehYB
        jE09Nga+KNZK7HZiHXQnHeH4b
X-Received: by 2002:a62:6d86:0:b0:448:152d:83a4 with SMTP id i128-20020a626d86000000b00448152d83a4mr27718013pfc.38.1634545904236;
        Mon, 18 Oct 2021 01:31:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn4FXgnyzb3d0WSsDjD/Mru61iAEyKojJxN31Ju5AUtYVebTdKCkuc0TjOokerxjuu5Gk15A==
X-Received: by 2002:a62:6d86:0:b0:448:152d:83a4 with SMTP id i128-20020a626d86000000b00448152d83a4mr27717993pfc.38.1634545903998;
        Mon, 18 Oct 2021 01:31:43 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u4sm2402404pjg.54.2021.10.18.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:31:43 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Mon, 18 Oct 2021 16:31:35 +0800
Message-Id: <20211018083137.338757-2-coxu@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018083137.338757-1-coxu@redhat.com>
References: <20211018083137.338757-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
powerpc: factor out kexec_file_ops functions" allows implementing
the arch-specific implementation of kernel image verification
in kexec_file_ops->verify_sig. Currently, there is no arch-specific
implementation of arch_kexec_kernel_verify_sig. So clean it up.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..755fed183224 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..42b3ac34e4ee 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_SIG
-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
-					  unsigned long buf_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.\n");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(buf, buf_len);
-}
-
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
  * @pi:		Purgatory to be relocated.
@@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+		unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 static int
 kimage_validate_signature(struct kimage *image)
 {
 	int ret;
 
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+	ret = kexec_image_verify_sig(image, image->kernel_buf,
+			image->kernel_buf_len);
 	if (ret) {
 
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-- 
2.31.1


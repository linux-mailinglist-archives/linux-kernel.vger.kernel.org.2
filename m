Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D643F7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhJ2H1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbhJ2H1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635492317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=qt2O9U3eMO+7C/TRuApSCR1kK3UoVf+Q1vRVxCEQCEU=;
        b=FGCcyX3rGhZPW5GheKPOVONzUDeWSDFc23Rtc9ZaUP/VF1Da3kdXe0v3HFutwbeJHBONr5
        /yS8q/hDEud0rBUeusOOZyvPw+W2XgVQTHYWjHSL8OPvgLUKoRKqUqy85tOS5CtOhYpIKD
        38aZsBFxu9DjKdmjnY+OlqHl6YK7Sh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-El-84W2DNM6uxRUujdyEfg-1; Fri, 29 Oct 2021 03:24:55 -0400
X-MC-Unique: El-84W2DNM6uxRUujdyEfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C46B8018AC;
        Fri, 29 Oct 2021 07:24:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8916F5F707;
        Fri, 29 Oct 2021 07:24:51 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] kexec_file: clean up arch_kexec_kernel_image_load
Date:   Fri, 29 Oct 2021 15:24:24 +0800
Message-Id: <20211029072424.9109-4-bhe@redhat.com>
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function arch_kexec_kernel_image_load() has a common weak version which
is a wrapper of kexec_image_load_default() , and has only one arch
dependent version in x86_64. Now the x86_64 dependent function is not
needed any more. So clean it up.

And also rename kexec_image_load_default() to kexec_kernel_image_load() for
better reflecting its functionality.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index dc8b17568784..6339ae7e6e79 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -371,17 +371,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..47b70402c0a4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -186,7 +186,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 /* Architectures may override the below functions */
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
-void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..0f2eed939f1f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -60,7 +60,7 @@ int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+static void *kexec_kernel_image_load(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -71,11 +71,6 @@ static void *kexec_image_load_default(struct kimage *image)
 				 image->cmdline_buf_len);
 }
 
-void * __weak arch_kexec_kernel_image_load(struct kimage *image)
-{
-	return kexec_image_load_default(image);
-}
-
 int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
@@ -279,7 +274,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	ima_add_kexec_buffer(image);
 
 	/* Call arch image load handlers */
-	ldata = arch_kexec_kernel_image_load(image);
+	ldata = kexec_kernel_image_load(image);
 
 	if (IS_ERR(ldata)) {
 		ret = PTR_ERR(ldata);
-- 
2.17.2


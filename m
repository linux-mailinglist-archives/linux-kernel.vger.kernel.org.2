Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBB44263D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhKBD5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232129AbhKBD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635825317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrQHFqOaIMU1aGZWoTgExkk7O3ua1KNPJ05Mw8KBKHc=;
        b=XgxoqBJgqdeEaL6YTxSZbLi+ZXpddOuznBvI7E6tA69kmSvXFPRRUBsp3bpM6sjNfj+Mty
        PqEBz6ll5RUwq+ADdBswWuryMxqfPa/YvkaRBL/adVBpucyZQJv4Ci9PvCFb8tJSKSuomq
        iCx+sCV0vKtD3fxyE3ioB8x6AuV3EUo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-nKn-tjVpOryYVfgtMypbkg-1; Mon, 01 Nov 2021 23:55:16 -0400
X-MC-Unique: nKn-tjVpOryYVfgtMypbkg-1
Received: by mail-pg1-f200.google.com with SMTP id r7-20020a63ce47000000b002a5cadd2f25so9134316pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrQHFqOaIMU1aGZWoTgExkk7O3ua1KNPJ05Mw8KBKHc=;
        b=0rxJEeiOCZQxBp2d4KdXToleW2frEGKFf9aoWnH2ebrDfMVQmkCiMHCxxG73QUC4b3
         OAAhXvlggM4f4R5IgU+W9v6Kk8WtV9v8WDDpI5ZW6cJxou9GcG9ohuPrPsoMzIuq6Jo+
         jIGqh71ML6xN40P2bctuMWmSnj4MQ2eZRxPDs0Tb+z6t7QsfEcnVh/4qgqwydkHUX+lS
         b1NDfOg0kNFTJ4T4Vg9HesXdb01LoPfzw+34HrDzmLnD1SQPcIVsKIAjCpPDpJS2r2WR
         7kXFKPiTXebrCiKOazZoqDVMr7TAPT09mTqTBlDJQzeMvxQ9S3olywOm5qZ+SNuuMdYG
         wGnw==
X-Gm-Message-State: AOAM531YYZdai5pSOJiXG4C2S7wDKdn7PkQs/U1by2guXGenEf8HZbh/
        I+6Vn3ZfZ6EzWNRhEsoUSMiwOuNx0b5ehiS+LTmvNSkZa0lt2Q9h6wAQBk9p9ecm5HK2ZHX+6cR
        uq8H8NNHr9PQY2U4sTWu0tr5O
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr3661849pjb.212.1635825315601;
        Mon, 01 Nov 2021 20:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXiBDCFzpA2RJvNRSsN5wNdAOQuYriKRM+4cmVat5soML4SeeIBr2aHIluOY8bBqktKc+qpg==
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr3661830pjb.212.1635825315396;
        Mon, 01 Nov 2021 20:55:15 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f10sm17000953pfe.82.2021.11.01.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:55:15 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:52:27 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20211102035227.4c4kvqqunpwgcuup@Rk>
References: <20211018083137.338757-1-coxu@redhat.com>
 <20211018083137.338757-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211018083137.338757-2-coxu@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Does this patch and "[PATCH v3 2/3] kexec, KEYS: make the code in
bzImage64_verify_sig generic" look good you?

On Mon, Oct 18, 2021 at 04:31:35PM +0800, Coiby Xu wrote:
>commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
>powerpc: factor out kexec_file_ops functions" allows implementing
>the arch-specific implementation of kernel image verification
>in kexec_file_ops->verify_sig. Currently, there is no arch-specific
>implementation of arch_kexec_kernel_verify_sig. So clean it up.
>
>Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> include/linux/kexec.h |  4 ----
> kernel/kexec_file.c   | 34 +++++++++++++---------------------
> 2 files changed, 13 insertions(+), 25 deletions(-)
>
>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>index 0c994ae37729..755fed183224 100644
>--- a/include/linux/kexec.h
>+++ b/include/linux/kexec.h
>@@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
> 				 const Elf_Shdr *relsec,
> 				 const Elf_Shdr *symtab);
> int arch_kimage_file_post_load_cleanup(struct kimage *image);
>-#ifdef CONFIG_KEXEC_SIG
>-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>-				 unsigned long buf_len);
>-#endif
> int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>
> extern int kexec_add_buffer(struct kexec_buf *kbuf);
>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>index 33400ff051a8..42b3ac34e4ee 100644
>--- a/kernel/kexec_file.c
>+++ b/kernel/kexec_file.c
>@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
> 	return kexec_image_post_load_cleanup_default(image);
> }
>
>-#ifdef CONFIG_KEXEC_SIG
>-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>-					  unsigned long buf_len)
>-{
>-	if (!image->fops || !image->fops->verify_sig) {
>-		pr_debug("kernel loader does not support signature verification.\n");
>-		return -EKEYREJECTED;
>-	}
>-
>-	return image->fops->verify_sig(buf, buf_len);
>-}
>-
>-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>-					unsigned long buf_len)
>-{
>-	return kexec_image_verify_sig_default(image, buf, buf_len);
>-}
>-#endif
>-
> /*
>  * arch_kexec_apply_relocations_add - apply relocations of type RELA
>  * @pi:		Purgatory to be relocated.
>@@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
> }
>
> #ifdef CONFIG_KEXEC_SIG
>+static int kexec_image_verify_sig(struct kimage *image, void *buf,
>+		unsigned long buf_len)
>+{
>+	if (!image->fops || !image->fops->verify_sig) {
>+		pr_debug("kernel loader does not support signature verification.\n");
>+		return -EKEYREJECTED;
>+	}
>+
>+	return image->fops->verify_sig(buf, buf_len);
>+}
>+
> static int
> kimage_validate_signature(struct kimage *image)
> {
> 	int ret;
>
>-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>-					   image->kernel_buf_len);
>+	ret = kexec_image_verify_sig(image, image->kernel_buf,
>+			image->kernel_buf_len);
> 	if (ret) {
>
> 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>-- 
>2.31.1
>

-- 
Best regards,
Coiby


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1D306216
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhA0Rcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhA0Rab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:30:31 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63ADC061788
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:18 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n3so1407699qvf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cfSnNSnfVduFxCPOvWfs9p+QSvXlJihsz/H5U3Y4H1U=;
        b=JSF/HlHCJzShZn7ALunS0BkmdIvbsb31kLfU+RnIPOJjHHHbnPC+hKp5GzFf5aNfG0
         PCnd0hUx8KnQTQJAs7hc3j8UjBo0nhsavr2YgBKj48WT2dlprkP86SX5YogstiQFgEW1
         fQXmcUFNK/whrTvXsAd2ttbgakW8eugEXjKNmuKRJBUbncvkUaYlDCqNXZhKNp4QGgZi
         s9l3aBEqnDiNAea7t1MlSQvIt3uOdGGZZwDbfriUGm56jfCILeRPYfkcC4aBIVfBChfU
         myBdivbvXZCSHraxlvN/kcYnz6cOQzbdEGPqEKU9R4Tk+vISJcmeJUo2Io2EH78AfPDL
         BLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfSnNSnfVduFxCPOvWfs9p+QSvXlJihsz/H5U3Y4H1U=;
        b=qhnaepr5eEtpeYoZAfaFc+EGbaEO3tfDxEtNXdLH51c4SZYJglVjOT7Ue93IPYCDeK
         5SFIulAGdiCg0bD3YG1lfnQ1sGWeEZ5rnmeMuztDu2acdbfzfwt42dibdeB+OjM9Rdo/
         gANQzXh8lF+ZW1g0gzTJghcFzAVAJYi6CMZ0jUQeq73ucy3XRWduW7orUHVYbLezw6Rw
         06wiYym2K8en3FJP765uDKNDI1vcp//TikubVo50zDjSQQiy8EU5IPKSRCG2y5fMoLpc
         zEolFsJmnek/vqCOPC1aq0/bdNfATD/mALkOD1Hl7KgXgDHklIUyjqk3ZgL8Kd3lRLxG
         Gcaw==
X-Gm-Message-State: AOAM530NOYv7Fp3sxuJJ+e/W0abE571tX3E938xSNgUB0ihdzp15heH8
        jaCgUc8LcuH4urH/tPKeK+1ucw==
X-Google-Smtp-Source: ABdhPJwHsa1PlzOcEErpv+fEXO2+H7UWl48S+Yfvc0TUYpC69d2qgqgALhqP+OIOSgJyhuzsv33wBA==
X-Received: by 2002:a0c:99c4:: with SMTP id y4mr11377443qve.9.1611768437920;
        Wed, 27 Jan 2021 09:27:17 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z2sm1728019qtz.71.2021.01.27.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:27:17 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v11 6/6] arm64: kexec: remove head from relocation argument
Date:   Wed, 27 Jan 2021 12:27:06 -0500
Message-Id: <20210127172706.617195-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127172706.617195-1-pasha.tatashin@soleen.com>
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that relocation is done using virtual addresses, reloc_arg->head
is not needed anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 2 --
 arch/arm64/kernel/asm-offsets.c   | 1 -
 arch/arm64/kernel/machine_kexec.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 049cde429b1b..2fa4109bd582 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,7 +97,6 @@ extern const char arm64_kexec_el2_vectors[];
 
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
- * head		kimage->head, allows to traverse through relocation segments.
  * entry_addr	kimage->start, where to jump from relocation function (new
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
@@ -113,7 +112,6 @@ extern const char arm64_kexec_el2_vectors[];
  * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
-	phys_addr_t head;
 	phys_addr_t entry_addr;
 	phys_addr_t kern_arg0;
 	phys_addr_t kern_arg1;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 06278611451d..94f050ad6471 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -153,7 +153,6 @@ int main(void)
   BLANK();
 #endif
 #ifdef CONFIG_KEXEC_CORE
-  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
   DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
   DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 9588c91f67c6..07da8d623d8e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -166,7 +166,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + func_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
-	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 
-- 
2.25.1


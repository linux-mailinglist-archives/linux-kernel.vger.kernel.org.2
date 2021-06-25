Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A658D3B49EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFYVJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFYVJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:09:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B932C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:07:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dae0029e536978a2ce722.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:29e5:3697:8a2c:e722])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29BF11EC05A0;
        Fri, 25 Jun 2021 23:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624655255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4Dhe8/CAj5PZCZSBsa0GRqc4jLrXUf6ZA1ktPfUMj38=;
        b=lVT9Su4T0hg8fFQUfoItYeFKmx9oadggibbEId2g5K1l2AuZ4VZIPX90/9SzKzYficEb75
        l2VkCmuliWIDmQHBmox4EnSBc1hWEUGY40N0CK9lRR3LGqPPy+2zVmx9cn0PaUy3B0bJHj
        UUcArFsd09Oa5xerDOJOiHjttQ34y4c=
Date:   Fri, 25 Jun 2021 23:07:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNZFkG/tuHkwpyug@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
 <YNXkVBcmBvZL7khv@zn.tnic>
 <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
 <YNYJ9vVQPVWqCvVq@zn.tnic>
 <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 01:38:51PM -0700, H. Peter Anvin wrote:
> 64-bit cross build on a 32-bit platform... or Windows.

Meh, nobody cares about those... :)

Hmm, so looking at the PRI* inttypes.h things again, they're C99 and
they kinda look more elegant as they don't make us cast stuff.

So how does that look?

---

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 04c5a44b9682..2582991ba216 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -26,6 +26,9 @@ static struct relocs relocs32;
 #if ELF_BITS == 64
 static struct relocs relocs32neg;
 static struct relocs relocs64;
+#define FMT PRIu64
+#else
+#define FMT PRIu32
 #endif
 
 struct section {
@@ -389,7 +392,7 @@ static void read_ehdr(FILE *fp)
 		Elf_Shdr shdr;
 
 		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
 
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read initial ELF section header: %s\n", strerror(errno));
@@ -412,17 +415,17 @@ static void read_shdrs(FILE *fp)
 
 	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
-		die("Unable to allocate %d section headers\n",
+		die("Unable to allocate %ld section headers\n",
 		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
-		die("Seek to %d failed: %s\n",
-			ehdr.e_shoff, strerror(errno));
+		die("Seek to %" FMT " failed: %s\n",
+		    ehdr.e_shoff, strerror(errno));
 	}
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%d: %s\n",
+			die("Cannot read ELF section headers %d/%ld: %s\n",
 			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
@@ -450,12 +453,12 @@ static void read_strtabs(FILE *fp)
 		}
 		sec->strtab = malloc(sec->shdr.sh_size);
 		if (!sec->strtab) {
-			die("malloc of %d bytes for strtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for strtab failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -475,12 +478,12 @@ static void read_symtabs(FILE *fp)
 		}
 		sec->symtab = malloc(sec->shdr.sh_size);
 		if (!sec->symtab) {
-			die("malloc of %d bytes for symtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for symtab failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -508,12 +511,12 @@ static void read_relocs(FILE *fp)
 		}
 		sec->reltab = malloc(sec->shdr.sh_size);
 		if (!sec->reltab) {
-			die("malloc of %d bytes for relocs failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for relocs failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 43c83c0fd22c..4c49c82446eb 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -17,6 +17,7 @@
 #include <regex.h>
 #include <tools/le_byteshift.h>
 
+__attribute__((__format__(printf, 1, 2)))
 void die(char *fmt, ...) __attribute__((noreturn));
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

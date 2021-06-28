Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B353B60DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhF1Oaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:30:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233920AbhF1O2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:28:19 -0400
Received: from zn.tnic (p200300ec2f0ad700491bef6a2c18e575.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d700:491b:ef6a:2c18:e575])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B237F1EC0473;
        Mon, 28 Jun 2021 16:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624890351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UfotHoXr1MGRstAAk/SsclnC2qgTL5WZjtgDBeEKZ9Y=;
        b=H0L8p74bADoaFQqh5Bs0Sa9tkPZtGAUt099tGAQKW16jlHCamnoNPTM4QaBGcowNPO408r
        ZXTvLgJloHkQVZ63hKGd3gLQd10i/TkZpfUOFmNlDZS9VzmMiKhexTTLRAzMpoXIooiN8x
        Qj/1EFWBumfwusr4xYHdl28RXz6XANc=
Date:   Mon, 28 Jun 2021 16:25:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tools/relocs: Mark die() with the printf function attr
 format
Message-ID: <YNnb6Q4QHtNYC049@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
 <YNXkVBcmBvZL7khv@zn.tnic>
 <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
 <YNYJ9vVQPVWqCvVq@zn.tnic>
 <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
 <YNZFkG/tuHkwpyug@zn.tnic>
 <YNiSyFNbAMVxN6wO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNiSyFNbAMVxN6wO@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 05:01:28PM +0200, Greg Kroah-Hartman wrote:
> This works for me!  It should fix the static checking tool that keeps
> tripping over this pointless warning :)
> 
> Want to turn it into a real patch?

How's that?

---
From: Borislav Petkov <bp@suse.de>

Mark die() as a function which accepts printf-style arguments so that
the compiler can typecheck them against the supplied format string.

Use the C99 inttypes.h format specifiers as relocs.c gets built for both
32- and 64-bit.

Original version of the patch by Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/tools/relocs.c | 37 ++++++++++++++++++++-----------------
 arch/x86/tools/relocs.h |  1 +
 2 files changed, 21 insertions(+), 17 deletions(-)

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
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

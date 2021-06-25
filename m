Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266C3B4558
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhFYOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhFYOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:15:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598CC061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:12:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dae0049fb297996de39ad.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:49fb:2979:96de:39ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E813B1EC0595;
        Fri, 25 Jun 2021 16:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624630363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fH0w06KluhpHxyJhF5il1CGHZj2eD9M/LitHHY//GKQ=;
        b=TKq7F01Tc2vIogaK1X0l3FzrG3qk36r0XQG+wpnSK+YvmGle211A8h5oEll0ZdubSWNhpB
        PhSdqbLnEnMYRyviJEoZZAZcBbkg3hhU4PcnL5+Lne8S5v23ZDy2Y8sKdY5PVDv00hiXT9
        sxKvjVEcE51Eaie3O6PysMJQWsvD8yM=
Date:   Fri, 25 Jun 2021 16:12:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNXkVBcmBvZL7khv@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNXG472lXPHlbuCF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 02:06:59PM +0200, Greg Kroah-Hartman wrote:
> Casting seems to be the only way to make this "quiet" that I can tell.
> 
> Unless someone else has a good idea?

Hmm, so in Documentation/core-api/printk-formats.rst we say that for
printk() with different size types, we should "use a format specifier of
its largest possible type and explicitly cast to it."

And that kinda sounds ok to me because we don't potentially lose through
the casting.

IOW, I guess something like this below.

---
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 04c5a44b9682..42b0f425a2c7 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -389,7 +389,7 @@ static void read_ehdr(FILE *fp)
 		Elf_Shdr shdr;
 
 		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+			die("Seek to %lu failed: %s\n", (unsigned long)ehdr.e_shoff, strerror(errno));
 
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read initial ELF section header: %s\n", strerror(errno));
@@ -412,17 +412,17 @@ static void read_shdrs(FILE *fp)
 
 	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
-		die("Unable to allocate %d section headers\n",
+		die("Unable to allocate %ld section headers\n",
 		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
-		die("Seek to %d failed: %s\n",
-			ehdr.e_shoff, strerror(errno));
+		die("Seek to %lu failed: %s\n",
+		    (unsigned long)ehdr.e_shoff, strerror(errno));
 	}
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%d: %s\n",
+			die("Cannot read ELF section headers %d/%ld: %s\n",
 			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
@@ -450,12 +450,12 @@ static void read_strtabs(FILE *fp)
 		}
 		sec->strtab = malloc(sec->shdr.sh_size);
 		if (!sec->strtab) {
-			die("malloc of %d bytes for strtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %lu bytes for strtab failed\n",
+			    (unsigned long)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %lu failed: %s\n",
+			    (unsigned long)sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -475,12 +475,12 @@ static void read_symtabs(FILE *fp)
 		}
 		sec->symtab = malloc(sec->shdr.sh_size);
 		if (!sec->symtab) {
-			die("malloc of %d bytes for symtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %lu bytes for symtab failed\n",
+			    (unsigned long)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %lu failed: %s\n",
+			    (unsigned long)sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -508,12 +508,12 @@ static void read_relocs(FILE *fp)
 		}
 		sec->reltab = malloc(sec->shdr.sh_size);
 		if (!sec->reltab) {
-			die("malloc of %d bytes for relocs failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %lu bytes for relocs failed\n",
+			    (unsigned long)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %lu failed: %s\n",
+			    (unsigned long)sec->shdr.sh_offset, strerror(errno));
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

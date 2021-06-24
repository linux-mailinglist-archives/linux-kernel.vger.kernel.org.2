Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C8E3B2E42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFXMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhFXMAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226FE613C5;
        Thu, 24 Jun 2021 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624535885;
        bh=VMvWr4CWUeUypgeQjMjeAJKBkk2iEANHdzbPXAoA3e4=;
        h=Date:From:To:Cc:Subject:From;
        b=Rbcgo6sJVSPRg0DTMN5zDYgZHMWWpea/iLctuxe9gdutHfzGoRCidzCdkUGTVOWr/
         6f1lQ0t/aj7t0/9s75ZRS4YLn2/sZ5ouvwYWYHRG3PIXxENQF4CfbOn8fBHPFXI8Pv
         vrtV9SIn5p2FO12FrH9ERSqOqiq4hMOGyXPzFb6Y=
Date:   Thu, 24 Jun 2021 13:58:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNRzSy3NuwBDYWwr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of printf "mismatches" in the use of die() in
x86/tools/relocs.c.  Fix them up and add the printf attribute to the
reloc.h header file to prevent them from ever coming back.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/tools/relocs.c | 21 +++++++++++----------
 arch/x86/tools/relocs.h |  1 +
 2 files changed, 12 insertions(+), 10 deletions(-)

Originally sent back in Feb, but it seems to have been missed:
	https://lore.kernel.org/r/20210227095356.603513-1-gregkh@linuxfoundation.org


diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..c3105a8c6cde 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -389,7 +389,8 @@ static void read_ehdr(FILE *fp)
 		Elf_Shdr shdr;
 
 		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+			die("Seek to %d failed: %s\n",
+			    (int)ehdr.e_shoff, strerror(errno));
 
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read initial ELF section header: %s\n", strerror(errno));
@@ -412,17 +413,17 @@ static void read_shdrs(FILE *fp)
 
 	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
-		die("Unable to allocate %d section headers\n",
+		die("Unable to allocate %ld section headers\n",
 		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
 		die("Seek to %d failed: %s\n",
-			ehdr.e_shoff, strerror(errno));
+			(int)ehdr.e_shoff, strerror(errno));
 	}
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%d: %s\n",
+			die("Cannot read ELF section headers %d/%ld: %s\n",
 			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
@@ -451,11 +452,11 @@ static void read_strtabs(FILE *fp)
 		sec->strtab = malloc(sec->shdr.sh_size);
 		if (!sec->strtab) {
 			die("malloc of %d bytes for strtab failed\n",
-				sec->shdr.sh_size);
+				(int)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
 			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+				(int)sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -476,11 +477,11 @@ static void read_symtabs(FILE *fp)
 		sec->symtab = malloc(sec->shdr.sh_size);
 		if (!sec->symtab) {
 			die("malloc of %d bytes for symtab failed\n",
-				sec->shdr.sh_size);
+				(int)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
 			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+				(int)sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -509,11 +510,11 @@ static void read_relocs(FILE *fp)
 		sec->reltab = malloc(sec->shdr.sh_size);
 		if (!sec->reltab) {
 			die("malloc of %d bytes for relocs failed\n",
-				sec->shdr.sh_size);
+				(int)sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
 			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+				(int)sec->shdr.sh_offset, strerror(errno));
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
2.30.1


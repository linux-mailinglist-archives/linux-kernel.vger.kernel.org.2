Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB444F31C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhKMMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhKMMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:44:19 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C0C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:27 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q124so23578514oig.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSfIOglWz9pr//EwjQ0vQkhjya/qOXeZVMUtT+Y8e24=;
        b=OVQgMdPYK+be8w3QdElxh3zlHDocHZL1b7gwLlay1HpP26szLNTNBRo+UtU91xd53k
         LNbeon7FnIuUu3ijoBIRV4WodPcIx/UgEC4tx0RIbqiOflPePG4BBCcC3J1b5glh4aZW
         FLz5ofM7Ne9gWLtVeI1Rpt51D33jJVXOEVEXi9KPsTTTLRtgC/HIvBtQOL9PXjvO+jlK
         KgOhGAMCtbBO0Jo4DgXz/kNhu9oizxaehl7f+3HHY843oIHb87DDxqJbP4uW7BEGUgaV
         VHEcBHOxs+2WUVJ0mXIaTogKMFwkk88OqETwatvX0/rJKnmH4Gb66TfiJtRjQAX56dqd
         9kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSfIOglWz9pr//EwjQ0vQkhjya/qOXeZVMUtT+Y8e24=;
        b=BCJPzhMSMoqXRcRB4dz2nvegTBLFygQJmj0MMvlWURVqfEQVUTiI3kBJa8MrxSaYKc
         lQ5Q3lFU5t6v7pY9T8MoL+yBkSX8s0L4PxhvyqLVfwZeEuK9mSdRw7YRGUzSS8cLpWPA
         iX7zgCcBfSOKcCRSwR0aPWu2bO4L0xSd7+DKpCGYPhhorzdF/cyHAYIoik3nkP9DWIRo
         Gg+pgiVQ8b5sYbmvJtwWmjoJSXcQcO2icHMliBaeax129ErJ/ImA0kejQd6c0R+jYHvu
         1/GUqetf7GJCd48mXUWyBQ7SHSv+o/e2/KRHHz2ovI/bykHp9Fp0uIRqr+xOl3UVgzYC
         moeg==
X-Gm-Message-State: AOAM533vIbwOMpkWRpM1gfdBF5chdRPzc7bmk1rWEOtCs3PBch68XmIo
        F2goQXGIxof/faS4UeHklWMW3poJhA==
X-Google-Smtp-Source: ABdhPJz/aQ7g6R9kk1tZnkUYw6n03c3M6DOGLdUCFyEYXSz4dlLQV5J1AzopeVhpuVXEW0TZAzgDBg==
X-Received: by 2002:a05:6808:1686:: with SMTP id bb6mr19391648oib.40.1636807286601;
        Sat, 13 Nov 2021 04:41:26 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id x8sm1796675otg.31.2021.11.13.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:41:26 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/3] x86/relocs: Make absolute percpu relocations conditional
Date:   Sat, 13 Nov 2021 07:40:34 -0500
Message-Id: <20211113124035.9180-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211113124035.9180-1-brgerst@gmail.com>
References: <20211113124035.9180-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                  |  4 ++++
 arch/x86/boot/compressed/Makefile |  3 ++-
 arch/x86/tools/relocs.c           |  4 ++--
 arch/x86/tools/relocs.h           |  4 ++--
 arch/x86/tools/relocs_common.c    | 11 ++++++++---
 init/Kconfig                      |  1 -
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8268910e09cd..832a6626df72 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -402,6 +402,10 @@ config STACKPROTECTOR_FIXED
 	depends on X86_64 && STACKPROTECTOR
 	default y if !$(cc-option,-mstack-protector-guard-reg=gs)
 
+config X86_ABSOLUTE_PERCPU
+	def_bool X86_64 && SMP
+	select KALLSYMS_ABSOLUTE_PERCPU
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..ff493f262f2a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,8 +112,9 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 
 CMD_RELOCS = arch/x86/tools/relocs
+relocs-flags-$(CONFIG_X86_ABSOLUTE_PERCPU) += --absolute-percpu
 quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
+      cmd_relocs = $(CMD_RELOCS) $(relocs-flags-y) $< > $@;$(CMD_RELOCS) --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux FORCE
 	$(call if_changed,relocs)
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3f5d39768287..bad375444cee 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -1166,7 +1166,7 @@ static void print_reloc_info(void)
 
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
-	     int show_reloc_info)
+	     int show_reloc_info, int absolute_percpu)
 {
 	regex_init(use_real_mode);
 	read_ehdr(fp);
@@ -1174,7 +1174,7 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
-	if (ELF_BITS == 64)
+	if (ELF_BITS == 64 && absolute_percpu)
 		percpu_init();
 	if (show_absolute_syms) {
 		print_absolute_symbols();
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 4c49c82446eb..dcf323f6102f 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -32,8 +32,8 @@ enum symtype {
 
 void process_32(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int absolute_percpu);
 void process_64(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int absolute_percpu);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index 6634352a20bc..aa5fdea1e87a 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -19,7 +19,7 @@ static void usage(void)
 int main(int argc, char **argv)
 {
 	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
-	int as_text, use_real_mode;
+	int as_text, use_real_mode, absolute_percpu;
 	const char *fname;
 	FILE *fp;
 	int i;
@@ -30,6 +30,7 @@ int main(int argc, char **argv)
 	show_reloc_info = 0;
 	as_text = 0;
 	use_real_mode = 0;
+	absolute_percpu = 0;
 	fname = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -54,6 +55,10 @@ int main(int argc, char **argv)
 				use_real_mode = 1;
 				continue;
 			}
+			if (strcmp(arg, "--absolute-percpu") == 0) {
+				absolute_percpu = 1;
+				continue;
+			}
 		}
 		else if (!fname) {
 			fname = arg;
@@ -75,11 +80,11 @@ int main(int argc, char **argv)
 	if (e_ident[EI_CLASS] == ELFCLASS64)
 		process_64(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, absolute_percpu);
 	else
 		process_32(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, absolute_percpu);
 	fclose(fp);
 	return 0;
 }
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..f8da0e5b7663 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,7 +1716,6 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
 
 config KALLSYMS_BASE_RELATIVE
 	bool
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFE353304
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhDCHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhDCHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:48:23 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AFBC0613E6;
        Sat,  3 Apr 2021 00:48:18 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id A18425A22061; Sat,  3 Apr 2021 08:48:10 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: module: fix symbolizer crash on fdescr
Date:   Sat,  3 Apr 2021 08:48:03 +0100
Message-Id: <20210403074803.3309096-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed failure as a crash on ia64 when tried to symbolize all
backtraces collected by page_owner=on:

    $ cat /sys/kernel/debug/page_owner
    <oops>

    CPU: 1 PID: 2074 Comm: cat Not tainted 5.12.0-rc4 #226
    Hardware name: hp server rx3600, BIOS 04.03 04/08/2008
    ip is at dereference_module_function_descriptor+0x41/0x100

Crash happens at dereference_module_function_descriptor() due to
use-after-free when dereferencing ".opd" section header.

All section headers are already freed after module is laoded
successfully.

To keep symbolizer working the change stores ".opd" address
and size after module is relocated to a new place and before
section headers are discarded.

To make similar errors less obscure module_finalize() now
zeroes out all variables relevant to module loading only.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/include/asm/module.h |  6 +++++-
 arch/ia64/kernel/module.c      | 29 +++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/module.h b/arch/ia64/include/asm/module.h
index 5a29652e6def..7271b9c5fc76 100644
--- a/arch/ia64/include/asm/module.h
+++ b/arch/ia64/include/asm/module.h
@@ -14,16 +14,20 @@
 struct elf64_shdr;			/* forward declration */
 
 struct mod_arch_specific {
+	/* Used only at module load time. */
 	struct elf64_shdr *core_plt;	/* core PLT section */
 	struct elf64_shdr *init_plt;	/* init PLT section */
 	struct elf64_shdr *got;		/* global offset table */
 	struct elf64_shdr *opd;		/* official procedure descriptors */
 	struct elf64_shdr *unwind;	/* unwind-table section */
 	unsigned long gp;		/* global-pointer for module */
+	unsigned int next_got_entry;	/* index of next available got entry */
 
+	/* Used at module run and cleanup time. */
 	void *core_unw_table;		/* core unwind-table cookie returned by unwinder */
 	void *init_unw_table;		/* init unwind-table cookie returned by unwinder */
-	unsigned int next_got_entry;	/* index of next available got entry */
+	void *opd_addr;			/* symbolize uses .opd to get to actual function */
+	unsigned long opd_size;
 };
 
 #define ARCH_SHF_SMALL	SHF_IA_64_SHORT
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 00a496cb346f..f3385fe6e37e 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -905,9 +905,31 @@ register_unwind_table (struct module *mod)
 int
 module_finalize (const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
 {
+	struct mod_arch_specific *mas = &mod->arch;
+
 	DEBUGP("%s: init: entry=%p\n", __func__, mod->init);
-	if (mod->arch.unwind)
+	if (mas->unwind)
 		register_unwind_table(mod);
+
+	/*
+	 * ".opd" was already relocated to the final destination. Store
+	 * it's address for use in symbolizer.
+	 */
+	mas->opd_addr = (void *)mas->opd->sh_addr;
+	mas->opd_size = mas->opd->sh_size;
+
+	/*
+	 * Module relocation was already done at this point. Section
+	 * headers are about to be deleted. Wipe out load-time context.
+	 */
+	mas->core_plt = NULL;
+	mas->init_plt = NULL;
+	mas->got = NULL;
+	mas->opd = NULL;
+	mas->unwind = NULL;
+	mas->gp = 0;
+	mas->next_got_entry = 0;
+
 	return 0;
 }
 
@@ -926,10 +948,9 @@ module_arch_cleanup (struct module *mod)
 
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 {
-	Elf64_Shdr *opd = mod->arch.opd;
+	struct mod_arch_specific *mas = &mod->arch;
 
-	if (ptr < (void *)opd->sh_addr ||
-			ptr >= (void *)(opd->sh_addr + opd->sh_size))
+	if (ptr < mas->opd_addr || ptr >= mas->opd_addr + mas->opd_size)
 		return ptr;
 
 	return dereference_function_descriptor(ptr);
-- 
2.31.1


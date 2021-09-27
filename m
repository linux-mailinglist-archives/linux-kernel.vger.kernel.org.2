Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111BC419189
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhI0Jce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhI0Jcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DEDF61157;
        Mon, 27 Sep 2021 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632735055;
        bh=SpD5MQjYgRZDyirCrnqSk5UkaFWh5mnr66dYafDackM=;
        h=From:To:Cc:Subject:Date:From;
        b=oiB1iRxEqwf+jF5IaT7UAWEEyLXXV3BYVVu0lxkpCgdpoKcWSzGvnZrAZIAlPgSTS
         dJFhO5w6I8+WdFhM6rAgxjE1eRPrE24dgB5JRe7kMxs/yq/jtnFq4xoaMhoqDd96nf
         cSV1G9uc0KvB97d1UtM6mLVZ7wWv8Wse6NEa5QdvqzotgGttJMUz9hoGc0U96U6p7E
         7kViN61i32rGewpA+V3K1+33PnMXbV1Hcbx3PlYYilHxawa5RK2BosfEs9nWJsqnZM
         iYpdT0siNTlr67acArPZfxLr3eIhmKlinzo3UcSMOnIkWXz4s7FYQA66/dZfKXpMFN
         Y4rykroaLZylw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix non-converging vmlinux link
Date:   Mon, 27 Sep 2021 11:30:11 +0200
Message-Id: <20210927093043.380604-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

When the size of the vmlinux file is just below 64MB, the kernel
may fail to link with lld, producing output such as

ld.lld: error: assignment to symbol init_pg_end does not converge
ld.lld: error: assignment to symbol __pecoff_data_size does not converge

Change the INIT_DIR_SIZE definition to include init_pg_dir
to get a stable size calculation.

Arnd did the original report and analysis, but Ard figured what
to do about and wrote the changes to the code.

Link: https://github.com/ClangBuiltLinux/linux/issues/1219
Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Ard, I had this in my randconfig tree with comment "Ard will
submit this with a proper changelog", but it seems we both forgot
about it, or maybe there was something wrong with it in the
end.

While looking for randconfig -Werror warnings in mainline I came
across it again and can confirm that this patch (or something like
it) is still needed. Let me know if you are happy with this version
or if you have a better description for it. I unfortunately forgot
the details of how this works.
---
 arch/arm64/include/asm/kernel-pgtable.h | 2 +-
 arch/arm64/kernel/head.S                | 5 ++---
 arch/arm64/kernel/vmlinux.lds.S         | 3 +++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 96dc0f7da258..5c622c18280a 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -86,7 +86,7 @@
 			+ EARLY_PGDS((vstart), (vend)) 	/* each PGDIR needs a next level page table */	\
 			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
 			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
-#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end))
+#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, init_pg_dir))
 #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
 /* Initial memory map size */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 17962452e31d..2c3011660e48 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -366,10 +366,9 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
-	adrp	x6, _end			// runtime __pa(_end)
 	adrp	x3, _text			// runtime __pa(_text)
-	sub	x6, x6, x3			// _end - _text
-	add	x6, x6, x5			// runtime __va(_end)
+	sub	x6, x0, x3			// init_pg_dir - _text
+	add	x6, x6, x5			// runtime __va(init_pg_dir)
 
 	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f6b1a88245db..4792ddd1ae73 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -287,6 +287,9 @@ SECTIONS
 	BSS_SECTION(SBSS_ALIGN, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
+
+	/* ----- kernel virtual mapping ends here ---- */
+
 	init_pg_dir = .;
 	. += INIT_DIR_SIZE;
 	init_pg_end = .;
-- 
2.29.2


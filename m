Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB24B447F12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhKHLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:45:16 -0500
Received: from foss.arm.com ([217.140.110.172]:49366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239303AbhKHLpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:45:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A67C2B;
        Mon,  8 Nov 2021 03:42:31 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1B3D3F800;
        Mon,  8 Nov 2021 03:42:29 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] scripts/sorttable: Unify arm64 & x86 sort functions
Date:   Mon,  8 Nov 2021 11:42:20 +0000
Message-Id: <20211108114220.32796-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format of the arm64 and x86 exception table entries is essentially
the same as of commits:

  46d28947d9876fc0 ("x86/extable: Rework the exception table mechanics")
  d6e2cc5647753825 ("arm64: extable: add `type` and `data` fields")

Both use a 12-byte entry consisting of two 32-bit relative offsets and
32 bits of (absolute) data, and their sort functions are identical aside
from commentary, with arm64 saying:

   /* Don't touch the fixup type or data */

... and x86 saying:

  /* Don't touch the fixup type */

Unify the two behind a common sort_relative_table_with_data() function,
retaining the arm64 commentary.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 scripts/sorttable.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index b7c2ad71f9cf..ca9db62bf766 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -231,7 +231,7 @@ static void sort_relative_table(char *extab_image, int image_size)
 	}
 }
 
-static void arm64_sort_relative_table(char *extab_image, int image_size)
+static void sort_relative_table_with_data(char *extab_image, int image_size)
 {
 	int i = 0;
 
@@ -259,34 +259,6 @@ static void arm64_sort_relative_table(char *extab_image, int image_size)
 	}
 }
 
-static void x86_sort_relative_table(char *extab_image, int image_size)
-{
-	int i = 0;
-
-	while (i < image_size) {
-		uint32_t *loc = (uint32_t *)(extab_image + i);
-
-		w(r(loc) + i, loc);
-		w(r(loc + 1) + i + 4, loc + 1);
-		/* Don't touch the fixup type */
-
-		i += sizeof(uint32_t) * 3;
-	}
-
-	qsort(extab_image, image_size / 12, 12, compare_relative_table);
-
-	i = 0;
-	while (i < image_size) {
-		uint32_t *loc = (uint32_t *)(extab_image + i);
-
-		w(r(loc) - i, loc);
-		w(r(loc + 1) - (i + 4), loc + 1);
-		/* Don't touch the fixup type */
-
-		i += sizeof(uint32_t) * 3;
-	}
-}
-
 static void s390_sort_relative_table(char *extab_image, int image_size)
 {
 	int i;
@@ -364,15 +336,13 @@ static int do_file(char const *const fname, void *addr)
 
 	switch (r2(&ehdr->e_machine)) {
 	case EM_386:
+	case EM_AARCH64:
 	case EM_X86_64:
-		custom_sort = x86_sort_relative_table;
+		custom_sort = sort_relative_table_with_data;
 		break;
 	case EM_S390:
 		custom_sort = s390_sort_relative_table;
 		break;
-	case EM_AARCH64:
-		custom_sort = arm64_sort_relative_table;
-		break;
 	case EM_PARISC:
 	case EM_PPC:
 	case EM_PPC64:
-- 
2.11.0


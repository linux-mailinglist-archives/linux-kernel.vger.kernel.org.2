Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31B3413B29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhIUUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233942AbhIUUUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE6B60EFF;
        Tue, 21 Sep 2021 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632255515;
        bh=EmEce8xEvkne8kSGvU6PQeWU4jkLv8xqRMb6teYSXMs=;
        h=From:To:Cc:Subject:Date:From;
        b=lAGORjBiBXR8ZKsDwksEUwyz0UrJM+xi1OMGRRcnRt2nqzk7ui6u5Zqyysu5rHyXM
         NYPUvFoZu4NN8pyYaFVzqD1LXVI12gmDoj6Z9xkyPWYVZYOZc/i1zNGUuHJcnp9AKy
         E0M4ME91UZnBYN7rEgjM2m8xB0BZGiMNfzZdKD+dfzxpHrACZoMnw+sJMshMtaza6a
         uNfqT1OXihIzm5QGNWcIiWOkCRdinRT3yskudDO+FuVPkc7vNFOyreUgQJ6550UXe0
         rhjfzmmSGMs2UeEZqil1UjVEweclg6mrreW01rCxpZhVuv3p1/jyRsaDLKb40h5Ym4
         3McR48kF+dljQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] mm: debug_vm_pgtable: Don't use __P000 directly
Date:   Wed, 22 Sep 2021 04:18:15 +0800
Message-Id: <20210921201815.284412-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The __Pxxx/__Sxxx macros are only for init protection_map[]. All
usage of them in linux should come from protection_map array.

Becasue a lot of architectures would re-initilize protection_map[]
array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.

Using __P000 maybe won't cause bug because hw would deny access
with PROT_NONE permission, but it's not rigorous.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/debug_vm_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1403639302e4..a6ebbf6e53dd 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1104,13 +1104,13 @@ static int __init init_args(struct pgtable_debug_args *args)
 	/*
 	 * Initialize the debugging data.
 	 *
-	 * __P000 (or even __S000) will help create page table entries with
+	 * __P000 (protection_map[0]) will help create page table entries with
 	 * PROT_NONE permission as required for pxx_protnone_tests().
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
 	args->page_prot          = vm_get_page_prot(VMFLAGS);
-	args->page_prot_none     = __P000;
+	args->page_prot_none     = protection_map[0];
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
 	args->pmd_pfn            = ULONG_MAX;
-- 
2.25.1


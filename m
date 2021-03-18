Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42A434097B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhCRQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:00:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhCRQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:00:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMv3z-0004rh-J8; Thu, 18 Mar 2021 15:59:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/vmalloc: fix read of uninitialized pointer area
Date:   Thu, 18 Mar 2021 15:59:55 +0000
Message-Id: <20210318155955.18220-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a corner case where the sanity check of variable size fails
and branches to label fail and shift can be less than PAGE_SHIFT
causing area to never be assigned. This was picked up by static
analysis as follows:

    1. var_decl: Declaring variable area without initializer.
       struct vm_struct *area;

   ...

    2. Condition !size, taking true branch.
       if (!size || (size >> PAGE_SHIFT) > totalram_pages())
    3. Jumping to label fail.
               goto fail;

    ...

    4. Condition shift > 12, taking false branch.
	fail:
		if (shift > PAGE_SHIFT) {
			shift = PAGE_SHIFT;
			align = real_align;
			size = real_size;
			goto again;
		}

     Uninitialized pointer read (UNINIT)
     5. uninit_use: Using uninitialized value area.
 		if (!area) {
			...
		}

Fix this by setting area to NULL to avoid the uninitialized read
of area.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: 92db9fec381b ("mm/vmalloc: hugepage vmalloc mappings")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 96444d64129a..4b415b4bb7ae 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2888,8 +2888,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
 
-	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
+	if (!size || (size >> PAGE_SHIFT) > totalram_pages()) {
+		area = NULL;
 		goto fail;
+	}
 
 	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP) &&
 			arch_vmap_pmd_supported(prot)) {
-- 
2.30.2


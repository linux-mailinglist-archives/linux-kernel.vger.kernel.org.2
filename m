Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6B42B604
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhJMFuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhJMFuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA7960241;
        Wed, 13 Oct 2021 05:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634104082;
        bh=mdVw099jB84PTiR0YrwKOQUKSbZlwv5o94JdBfjiwck=;
        h=From:To:Cc:Subject:Date:From;
        b=p+3Z5JkcODT2tpRoY9rCTjOSo1IFtXswsiLfemZuKWI4JB4lsfHuk1/6y1PLrj7le
         PpI0Yb0yT5VqxSZG38cr9l0+F9u90/Nl5OsTORTkUn2Pq8wh25Jq0vLBsw6CW/rbEa
         3GIQxI/a2oCBmXLpqgACC3ShQ7XCa0venwO71f+tH6gpL91QUlS8zDW+rJFAFl+hJf
         Se9w3RMJ/sK0NAYCSmZdLZj8ipBCNlWonu+WBfx4Gw7svakpUzdr5eNFJBc1lR9AiM
         hlzZDMmF30oeTkd3m3Lk1bpBWk7Veopfg9Gu8IjOiOYGBlX+rumNyatYwEbyTR9FZy
         7BAitRCA6fHZw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memblock: exclude NOMAP regions from kmemleak
Date:   Wed, 13 Oct 2021 08:47:56 +0300
Message-Id: <20211013054756.12177-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Vladimir Zapolskiy reports:

commit a7259df76702 ("memblock: make memblock_find_in_range method private")
invokes a kernel panic while running kmemleak on OF platforms with nomaped
regions:

  Unable to handle kernel paging request at virtual address fff000021e00000
  [...]
    scan_block+0x64/0x170
    scan_gray_list+0xe8/0x17c
    kmemleak_scan+0x270/0x514
    kmemleak_write+0x34c/0x4ac

Indeed, NOMAP regions don't have linear map entries so an attempt to scan
these areas would fault.

Prevent such faults by excluding NOMAP regions from kmemleak.

Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 mm/memblock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..5c3503c98b2f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -936,7 +936,12 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+
+	if (!ret)
+		kmemleak_free_part_phys(base, size);
+
+	return ret;
 }
 
 /**

base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0A3CB2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhGPGmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235112AbhGPGme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:42:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526A261289;
        Fri, 16 Jul 2021 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626417579;
        bh=11TCU5jro/rETFD7x4RyMNK3OjzGaz7mWqbuZLRasKs=;
        h=From:To:Cc:Subject:Date:From;
        b=HaCt9LZZ8ebNKoCHskt2hgHInznNqGEnZZkZO6GBGO0CFiKBYuBmcSPodNuXWBnD8
         3LLW4WyOdKfKPB4x5cIsMyCnVLslwy0Rt96XvTOkacnKosZmpzYi5U/qfZqMH0Qi+9
         GfX55SxrphZHQPM6+D8tt0SEkqLVlbR3FlvfvO/eEgpodXDPk8NKHYsfQ1As+FNRKO
         1UF9+i0DIiX/eggGviiSYs2XjR7CyoiCc4OGJj/A/StGcK3LFsol6QIiW5MWECQ+Hk
         5IKhRugNjeS/AHCnRfjU0nyLKWnZbldUDzlPfe8EUQEbgFPLVPxTXI05CVQGs/qQ9G
         B6pCOPEo5JgfA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/secretmem: wire up ->set_page_dirty
Date:   Fri, 16 Jul 2021 09:39:33 +0300
Message-Id: <20210716063933.31633-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Make secretmem up to date with the changes done in commit 0af573780b0b
("mm: require ->set_page_dirty to be explicitly wired up") so that
unconditional call to this method won't cause crashes.

Fixes: 0af573780b0b ("mm: require ->set_page_dirty to be explicitly wired up")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index f77d25467a14..030f02ddc7c1 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -152,6 +152,7 @@ static void secretmem_freepage(struct page *page)
 }
 
 const struct address_space_operations secretmem_aops = {
+	.set_page_dirty	= __set_page_dirty_no_writeback,
 	.freepage	= secretmem_freepage,
 	.migratepage	= secretmem_migratepage,
 	.isolate_page	= secretmem_isolate_page,

base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.28.0


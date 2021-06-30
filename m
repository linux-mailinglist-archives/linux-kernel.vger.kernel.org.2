Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F179E3B7DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhF3HPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhF3HOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E83961C8D;
        Wed, 30 Jun 2021 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625037146;
        bh=UYXA0kQV/AwFpjI1/LxwK1KTy94Uxqh1rAP3oKcin5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew/tukz+Z7GwlvQVFx7D/8kpQR7lebc9n3EiMj4QhF14U1zai38mvLjCr2Vy/RyTc
         YLtrZ+zFteQ0ZArsndyKDFuldXfWEYyEVz++jNr8622DIWCGRww+9k40E1qIrz7dWv
         T/bLBeh2gICo9HPMQR9vg/Xxt+QDBsgkxqXlT8XjEpfXWI6DFtG+3qUoqX1ipAoLbX
         AWQkdHuaA2zt88oS2H5MCIK4uo1UhElfVljNlYT+Ml5rl7c4F5O2RECVuGfqS9tzKv
         U5ztTH6hmM2uUMj/98xA1WQ+9DeXAr2Q57bEa93MhvvaIH6vkCEHVhplMTfX+0WDix
         5/RdkymPa1sBA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 3/4] memblock: ensure there is no overflow in memblock_overlaps_region()
Date:   Wed, 30 Jun 2021 10:12:10 +0300
Message-Id: <20210630071211.21011-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210630071211.21011-1-rppt@kernel.org>
References: <20210630071211.21011-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There maybe an overflow in memblock_overlaps_region() if it is called with
base and size such that

	base + size > PHYS_ADDR_MAX

Make sure that memblock_overlaps_region() caps the size to prevent such
overflow and remove now duplicated call to memblock_cap_size() from
memblock_is_region_reserved().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 2e25d69739e0..67e0e24f8cc9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -182,6 +182,8 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 {
 	unsigned long i;
 
+	memblock_cap_size(base, &size);
+
 	for (i = 0; i < type->cnt; i++)
 		if (memblock_addrs_overlap(base, size, type->regions[i].base,
 					   type->regions[i].size))
@@ -1794,7 +1796,6 @@ bool __init_memblock memblock_is_region_memory(phys_addr_t base, phys_addr_t siz
  */
 bool __init_memblock memblock_is_region_reserved(phys_addr_t base, phys_addr_t size)
 {
-	memblock_cap_size(base, &size);
 	return memblock_overlaps_region(&memblock.reserved, base, size);
 }
 
-- 
2.28.0


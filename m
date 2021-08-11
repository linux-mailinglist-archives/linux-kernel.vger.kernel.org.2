Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D323E8CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhHKIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbhHKIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:55:46 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF95C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:55:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:438:1ff1:1071:f524])
        by albert.telenet-ops.be with bizsmtp
        id g8vL250031gJxCh068vLJa; Wed, 11 Aug 2021 10:55:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk1A-001yjD-03; Wed, 11 Aug 2021 10:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk19-0059Gs-IB; Wed, 11 Aug 2021 10:55:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] memblock: Check memory add/cap ordering
Date:   Wed, 11 Aug 2021 10:55:18 +0200
Message-Id: <aabc5bad008d49f07d542815c6c8d28ec90bb09e.1628672091.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For memblock_cap_memory_range() to work properly, it should be called
after memory is detected and added to memblock with memblock_add() or
memblock_add_node().  If memblock_cap_memory_range() would be called
before memory is registered, we may silently corrupt memory later
because the crash kernel will see all memory as available.

Print a warning and bail out if ordering is not satisfied.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/memblock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 57a9849a5d820c34..e2ca8ddc8ebebf4e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1685,6 +1685,11 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 	if (!size)
 		return;
 
+	if (memblock.memory.cnt <= 1) {
+		pr_warn("%s: No memory registered yet\n", __func__);
+		return;
+	}
+
 	ret = memblock_isolate_range(&memblock.memory, base, size,
 						&start_rgn, &end_rgn);
 	if (ret)
-- 
2.25.1


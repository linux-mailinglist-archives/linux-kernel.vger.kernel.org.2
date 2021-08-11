Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF82B3E8CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhHKIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhHKIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:55:05 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73BCC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:54:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:438:1ff1:1071:f524])
        by laurent.telenet-ops.be with bizsmtp
        id g8uf2500p1gJxCh018ufmu; Wed, 11 Aug 2021 10:54:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk0V-001yim-KC; Wed, 11 Aug 2021 10:54:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk0U-0059DD-WD; Wed, 11 Aug 2021 10:54:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] memblock: Add missing debug code to memblock_add_node()
Date:   Wed, 11 Aug 2021 10:54:36 +0200
Message-Id: <c45e5218b6fcf0e3aeb63d9a9d9792addae0bb7a.1628672041.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other memblock APIs built on top of memblock_add_range() contain
debug code to print their parameters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/memblock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index de7b553baa50004c..57a9849a5d820c34 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -665,6 +665,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
 				       int nid)
 {
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] nid=%d %pS\n", __func__,
+		     &base, &end, nid, (void *)_RET_IP_);
+
 	return memblock_add_range(&memblock.memory, base, size, nid, 0);
 }
 
-- 
2.25.1


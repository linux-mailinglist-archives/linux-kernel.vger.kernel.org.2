Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F37369B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbhDWUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhDWUlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E44C6144A;
        Fri, 23 Apr 2021 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619210432;
        bh=4OdlFAyziLmFURb5zD0N+vh/EJd+/8tzsrqf/l0h2x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKjOCEa21cu8AXJMeMJ4IybCQfi8j5faBazCqxOJSRT5/2T7dHfh99S0BRBEoILoe
         DZpPGTpXMMvmfYogpSfjoHMFhib/2NdUgJMRmIHite9bMaUxeMtD69b4pUDK0BHPh+
         CMN2W3WzJaaplpNgR2M5LHdO0T3C5HUP7MB+ltosT5VXITklh/hGAMM1hGRB0MWMF8
         dvv/ko9vsNuJAKnmBzW6CjZ74sOI5ZSjLPa25Sf/34gFBdQI7dNorn/yqIxwhUEn5m
         jlbVMnHPFuf2fml6liupwwrbDh1yQZwVDjnC7UR5V+QvZ9G0xLmyqovX+AuTq5E8fV
         PTuvrVCCd52ow==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm/mmzone.h: simplify is_highmem_idx()
Date:   Fri, 23 Apr 2021 23:38:11 +0300
Message-Id: <20210423203811.1247508-3-rppt@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423203811.1247508-1-rppt@kernel.org>
References: <20210423203811.1247508-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There is a lot of historical ifdefery in is_highmem_idx() and its helper
zone_movable_is_highmem() that was required because of two different paths
for nodes and zones initialization that were selected at compile time.

Until commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP
option") the movable_zone variable was only available for configurations
that had CONFIG_HAVE_MEMBLOCK_NODE_MAP enabled so the test in
zone_movable_is_highmem() used that variable only for such configurations.
For other configurations the test checked if the index of ZONE_MOVABLE was
greater by 1 than the index of ZONE_HIGMEM and then movable zone was
considered a highmem zone. Needless to say, ZONE_MOVABLE - 1 equals
ZONE_HIGMEM by definition when CONFIG_HIGHMEM=y.

Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
made movable_zone variable always available. Since this variable is set to
ZONE_HIGHMEM if CONFIG_HIGHMEM is enabled and highmem zone is populated, it
is enough to check whether

	zone_idx == ZONE_MOVABLE && movable_zone == ZONE_HIGMEM

to test if zone index points to a highmem zone.

Remove zone_movable_is_highmem() that is not used anywhere except
is_highmem_idx() and use the test above in is_highmem_idx() instead.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mmzone.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3b2205741048..6a1ac643b65e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -968,22 +968,11 @@ static inline void zone_set_nid(struct zone *zone, int nid) {}
 
 extern int movable_zone;
 
-#ifdef CONFIG_HIGHMEM
-static inline int zone_movable_is_highmem(void)
-{
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	return movable_zone == ZONE_HIGHMEM;
-#else
-	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;
-#endif
-}
-#endif
-
 static inline int is_highmem_idx(enum zone_type idx)
 {
 #ifdef CONFIG_HIGHMEM
 	return (idx == ZONE_HIGHMEM ||
-		(idx == ZONE_MOVABLE && zone_movable_is_highmem()));
+		(idx == ZONE_MOVABLE && movable_zone == ZONE_HIGHMEM));
 #else
 	return 0;
 #endif
-- 
2.29.2


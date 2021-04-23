Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0E369B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbhDWUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWUlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11AE1613C1;
        Fri, 23 Apr 2021 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619210429;
        bh=KyPSNr9yTjqsJUynAaPagNgn1DGc+4b1wUhmWv8oVmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOnL9h0lBE7kzt4TmeczV0HoUBrNGOw7wgc2xkVA/iS1yyL+858t6TYfdekM1LCoK
         EWYBkM34aFGMYjHuJ1kZezmgUMN7iFHXJj+A8c0d6vJfA68hqvSYrrIZkY5r1M5MCk
         2b/R5Bemh6HIKoo9EOBCS6pspa3effVtgcrjCwYOsZKry2442OqlOJO0Jt9+/mOMHn
         Tt1Gpw6lpinMczIluFp5AYSTYjslAT57ivVWSq5/VU98IrOwZU1ANkvxe+4YdS4eG/
         3C2Ciq48SgHkjM+4w6flLqQynzBite4KzlcaDaqu0NVqajrPzmezufm2+9NWfsr1R2
         53CFa+vGL8BXA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] mm/mmzone.h: fix existing kernel-doc comments and link them to core-api
Date:   Fri, 23 Apr 2021 23:38:10 +0300
Message-Id: <20210423203811.1247508-2-rppt@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423203811.1247508-1-rppt@kernel.org>
References: <20210423203811.1247508-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are a couple of kernel-doc comments in include/linux/mmzone.h but
they have minor formatting issues that would cause kernel-doc warnings.

Fix the formatting of those comments, add missing Return: descriptions and
link include/linux/mmzone.h to Documentation/core-api/mm-api.rst

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/core-api/mm-api.rst |  2 ++
 include/linux/mmzone.h            | 43 +++++++++++++++++--------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 201b5423303b..3079af5a2404 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -92,3 +92,5 @@ More Memory Management Functions
    :export:
 
 .. kernel-doc:: mm/page_alloc.c
+
+.. kernel-doc:: include/linux/mmzone.h
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..3b2205741048 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -993,7 +993,8 @@ static inline int is_highmem_idx(enum zone_type idx)
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
  *              to ZONE_{DMA/NORMAL/HIGHMEM/etc} in general code to a minimum.
- * @zone - pointer to struct zone variable
+ * @zone: pointer to struct zone variable
+ * Return: 1 for a highmem zone, 0 otherwise
  */
 static inline int is_highmem(struct zone *zone)
 {
@@ -1044,7 +1045,7 @@ extern struct zone *next_zone(struct zone *zone);
 
 /**
  * for_each_online_pgdat - helper macro to iterate over all online nodes
- * @pgdat - pointer to a pg_data_t variable
+ * @pgdat: pointer to a pg_data_t variable
  */
 #define for_each_online_pgdat(pgdat)			\
 	for (pgdat = first_online_pgdat();		\
@@ -1052,7 +1053,7 @@ extern struct zone *next_zone(struct zone *zone);
 	     pgdat = next_online_pgdat(pgdat))
 /**
  * for_each_zone - helper macro to iterate over all memory zones
- * @zone - pointer to struct zone variable
+ * @zone: pointer to struct zone variable
  *
  * The user only needs to declare the zone variable, for_each_zone
  * fills it in.
@@ -1091,15 +1092,18 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 
 /**
  * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
- * @z - The cursor used as a starting point for the search
- * @highest_zoneidx - The zone index of the highest zone to return
- * @nodes - An optional nodemask to filter the zonelist with
+ * @z: The cursor used as a starting point for the search
+ * @highest_zoneidx: The zone index of the highest zone to return
+ * @nodes: An optional nodemask to filter the zonelist with
  *
  * This function returns the next zone at or below a given zone index that is
  * within the allowed nodemask using a cursor as the starting point for the
  * search. The zoneref returned is a cursor that represents the current zone
  * being examined. It should be advanced by one before calling
  * next_zones_zonelist again.
+ *
+ * Return: the next zone at or below highest_zoneidx within the allowed
+ * nodemask using a cursor within a zonelist as a starting point
  */
 static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
@@ -1112,10 +1116,9 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 
 /**
  * first_zones_zonelist - Returns the first zone at or below highest_zoneidx within the allowed nodemask in a zonelist
- * @zonelist - The zonelist to search for a suitable zone
- * @highest_zoneidx - The zone index of the highest zone to return
- * @nodes - An optional nodemask to filter the zonelist with
- * @return - Zoneref pointer for the first suitable zone found (see below)
+ * @zonelist: The zonelist to search for a suitable zone
+ * @highest_zoneidx: The zone index of the highest zone to return
+ * @nodes: An optional nodemask to filter the zonelist with
  *
  * This function returns the first zone at or below a given zone index that is
  * within the allowed nodemask. The zoneref returned is a cursor that can be
@@ -1125,6 +1128,8 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
  * When no eligible zone is found, zoneref->zone is NULL (zoneref itself is
  * never NULL). This may happen either genuinely, or due to concurrent nodemask
  * update due to cpuset modification.
+ *
+ * Return: Zoneref pointer for the first suitable zone found
  */
 static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 					enum zone_type highest_zoneidx,
@@ -1136,11 +1141,11 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 
 /**
  * for_each_zone_zonelist_nodemask - helper macro to iterate over valid zones in a zonelist at or below a given zone index and within a nodemask
- * @zone - The current zone in the iterator
- * @z - The current pointer within zonelist->_zonerefs being iterated
- * @zlist - The zonelist being iterated
- * @highidx - The zone index of the highest zone to return
- * @nodemask - Nodemask allowed by the allocator
+ * @zone: The current zone in the iterator
+ * @z: The current pointer within zonelist->_zonerefs being iterated
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone to return
+ * @nodemask: Nodemask allowed by the allocator
  *
  * This iterator iterates though all zones at or below a given zone index and
  * within a given nodemask
@@ -1160,10 +1165,10 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 
 /**
  * for_each_zone_zonelist - helper macro to iterate over valid zones in a zonelist at or below a given zone index
- * @zone - The current zone in the iterator
- * @z - The current pointer within zonelist->zones being iterated
- * @zlist - The zonelist being iterated
- * @highidx - The zone index of the highest zone to return
+ * @zone: The current zone in the iterator
+ * @z: The current pointer within zonelist->zones being iterated
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone to return
  *
  * This iterator iterates though all zones at or below a given zone index.
  */
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84336B4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhDZOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZOUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:20:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7ED6101B;
        Mon, 26 Apr 2021 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619446779;
        bh=gbCHMFayl7FIh+k6q0qOkvb7oF7cv38ocoW0qdNw21c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNB/lyyTXccQuh0JDzzaMG3hxvsYl6i24fw5YRJvHK3lcMiLjqoelV9LWIJGPdckP
         Apg9kMNZTYdUegIAuFMtL5rNffxkDRoOUxA0wBvPMGdeUu9B/I09A8emWQlHYMFYqU
         CopX5YPskG2i/RloQpIFSvORYw+IbvjTVDl1p7FEWnu3Ms0pS0p+qcYuPJtGMxC/HB
         EaNh1V2+eDI2sYigVhqV7hbbt/NpKGRvxXJHq+xFZcZvzwqWJmMhi0G7aUDjYGb0XI
         5gJh+vJWgYNydkt0Xg+DyAD1lYFiEEY3LLpG7TxGLbeNdpEKptNSDN/W2H5JVzezTI
         tzXXVNJD1bYvA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm/mmzone.h: fix existing kernel-doc comments and link them to core-api
Date:   Mon, 26 Apr 2021 17:19:26 +0300
Message-Id: <20210426141927.1314326-2-rppt@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210426141927.1314326-1-rppt@kernel.org>
References: <20210426141927.1314326-1-rppt@kernel.org>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/core-api/mm-api.rst |  1 +
 include/linux/mmzone.h            | 43 +++++++++++++++++--------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 34f46df91a8b..a42f9baddfbf 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -97,3 +97,4 @@ More Memory Management Functions
    :internal:
 .. kernel-doc:: include/linux/mm.h
    :internal:
+.. kernel-doc:: include/linux/mmzone.h
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 965a0cd5eac1..0d53eba1c383 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1007,7 +1007,8 @@ static inline int is_highmem_idx(enum zone_type idx)
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
  *              to ZONE_{DMA/NORMAL/HIGHMEM/etc} in general code to a minimum.
- * @zone - pointer to struct zone variable
+ * @zone: pointer to struct zone variable
+ * Return: 1 for a highmem zone, 0 otherwise
  */
 static inline int is_highmem(struct zone *zone)
 {
@@ -1058,7 +1059,7 @@ extern struct zone *next_zone(struct zone *zone);
 
 /**
  * for_each_online_pgdat - helper macro to iterate over all online nodes
- * @pgdat - pointer to a pg_data_t variable
+ * @pgdat: pointer to a pg_data_t variable
  */
 #define for_each_online_pgdat(pgdat)			\
 	for (pgdat = first_online_pgdat();		\
@@ -1066,7 +1067,7 @@ extern struct zone *next_zone(struct zone *zone);
 	     pgdat = next_online_pgdat(pgdat))
 /**
  * for_each_zone - helper macro to iterate over all memory zones
- * @zone - pointer to struct zone variable
+ * @zone: pointer to struct zone variable
  *
  * The user only needs to declare the zone variable, for_each_zone
  * fills it in.
@@ -1105,15 +1106,18 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 
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
@@ -1126,10 +1130,9 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 
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
@@ -1139,6 +1142,8 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
  * When no eligible zone is found, zoneref->zone is NULL (zoneref itself is
  * never NULL). This may happen either genuinely, or due to concurrent nodemask
  * update due to cpuset modification.
+ *
+ * Return: Zoneref pointer for the first suitable zone found
  */
 static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 					enum zone_type highest_zoneidx,
@@ -1150,11 +1155,11 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 
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
@@ -1174,10 +1179,10 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 
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


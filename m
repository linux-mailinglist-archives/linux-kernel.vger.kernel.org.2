Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4126305C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbhA0MvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:51:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:41758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237322AbhA0MtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:49:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 135C3AC4F;
        Wed, 27 Jan 2021 12:48:13 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm, slub: remove slub_memcg_sysfs boot param and CONFIG_SLUB_MEMCG_SYSFS_ON
Date:   Wed, 27 Jan 2021 13:47:45 +0100
Message-Id: <20210127124745.7928-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot param and config determine the value of memcg_sysfs_enabled, which is
unused since commit 10befea91b61 ("mm: memcg/slab: use a single set of
kmem_caches for all allocations") as there are no per-memcg kmem caches
anymore.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 --------
 init/Kconfig                                    | 14 --------------
 mm/slub.c                                       | 16 ----------------
 3 files changed, 38 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f4497faef266..7dc351da0005 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4892,14 +4892,6 @@
 			last alloc / free. For more information see
 			Documentation/vm/slub.rst.
 
-	slub_memcg_sysfs=	[MM, SLUB]
-			Determines whether to enable sysfs directories for
-			memory cgroup sub-caches. 1 to enable, 0 to disable.
-			The default is determined by CONFIG_SLUB_MEMCG_SYSFS_ON.
-			Enabling this can lead to a very high number of	debug
-			directories and files being created under
-			/sys/kernel/slub.
-
 	slub_max_order= [MM, SLUB]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
diff --git a/init/Kconfig b/init/Kconfig
index e4e2932da237..af454a51f3c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1851,20 +1851,6 @@ config SLUB_DEBUG
 	  SLUB sysfs support. /sys/slab will not exist and there will be
 	  no support for cache validation etc.
 
-config SLUB_MEMCG_SYSFS_ON
-	default n
-	bool "Enable memcg SLUB sysfs support by default" if EXPERT
-	depends on SLUB && SYSFS && MEMCG
-	help
-	  SLUB creates a directory under /sys/kernel/slab for each
-	  allocation cache to host info and debug files. If memory
-	  cgroup is enabled, each cache can have per memory cgroup
-	  caches. SLUB can create the same sysfs directories for these
-	  caches under /sys/kernel/slab/CACHE/cgroup but it can lead
-	  to a very high number of debug files being created. This is
-	  controlled by slub_memcg_sysfs boot parameter and this
-	  config option determines the parameter's default value.
-
 config COMPAT_BRK
 	bool "Disable heap randomization"
 	default y
diff --git a/mm/slub.c b/mm/slub.c
index 1b5148747c64..88782727412c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5040,22 +5040,6 @@ enum slab_stat_type {
 #define SO_OBJECTS	(1 << SL_OBJECTS)
 #define SO_TOTAL	(1 << SL_TOTAL)
 
-#ifdef CONFIG_MEMCG
-static bool memcg_sysfs_enabled = IS_ENABLED(CONFIG_SLUB_MEMCG_SYSFS_ON);
-
-static int __init setup_slub_memcg_sysfs(char *str)
-{
-	int v;
-
-	if (get_option(&str, &v) > 0)
-		memcg_sysfs_enabled = v;
-
-	return 1;
-}
-
-__setup("slub_memcg_sysfs=", setup_slub_memcg_sysfs);
-#endif
-
 static ssize_t show_slab_objects(struct kmem_cache *s,
 				 char *buf, unsigned long flags)
 {
-- 
2.30.0


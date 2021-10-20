Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2B4354C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhJTUvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:51:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:61472 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJTUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:51:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228752477"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="228752477"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 13:48:56 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="444513628"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 13:48:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] io-mapping: remove fallback for writecombine
Date:   Wed, 20 Oct 2021 13:48:38 -0700
Message-Id: <20211020204838.1142908-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fallback was introduced in commit 80c33624e472 ("io-mapping: Fixup
for different names of writecombine") to fix the build on microblaze.

5 years later, it seems all archs now provide a pgprot_writecombine(),
so just remove the other possible fallbacks. For microblaze,
pgprot_writecombine() is available since commit 97ccedd793ac
("microblaze: Provide pgprot_device/writecombine macros for nommu").

This is build-tested on microblaze with the following hack to always
build mm/io-mapping.o and without diying on a x86-only macro
(_PAGE_CACHE_MASK)

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: linux-mm@kvack.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/io-mapping.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index e9743cfd8585..66a774d2710e 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -132,13 +132,7 @@ io_mapping_init_wc(struct io_mapping *iomap,
 
 	iomap->base = base;
 	iomap->size = size;
-#if defined(pgprot_noncached_wc) /* archs can't agree on a name ... */
-	iomap->prot = pgprot_noncached_wc(PAGE_KERNEL);
-#elif defined(pgprot_writecombine)
 	iomap->prot = pgprot_writecombine(PAGE_KERNEL);
-#else
-	iomap->prot = pgprot_noncached(PAGE_KERNEL);
-#endif
 
 	return iomap;
 }
-- 
2.33.1


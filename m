Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2968738A025
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhETIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:50:41 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:60289 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhETIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:50:36 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id DD09D1A4E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:49:13 +0100 (IST)
Received: (qmail 5792 invoked from network); 20 May 2021 08:49:13 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 20 May 2021 08:49:13 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 05/14] mm/early_ioremap: Add prototype for early_memremap_pgprot_adjust
Date:   Thu, 20 May 2021 09:48:00 +0100
Message-Id: <20210520084809.8576-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for mm/early_ioremap.c

mm/early_ioremap.c:34:24: warning: no previous prototype for ‘early_memremap_pgprot_adjust’ [-Wmissing-prototypes]
 pgprot_t __init __weak early_memremap_pgprot_adjust(resource_size_t phys_addr,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

The weak functions that can be overridden by architectures are
declared in include/asm-generic/early_ioremap.h so add the prototype
there. The asm/fixmap.h header is need for pgprot_t.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/asm-generic/early_ioremap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index 9def22e6e2b3..022f8f908b42 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -3,6 +3,7 @@
 #define _ASM_EARLY_IOREMAP_H_
 
 #include <linux/types.h>
+#include <asm/fixmap.h>
 
 /*
  * early_ioremap() and early_iounmap() are for temporary early boot-time
@@ -19,6 +20,14 @@ extern void *early_memremap_prot(resource_size_t phys_addr,
 extern void early_iounmap(void __iomem *addr, unsigned long size);
 extern void early_memunmap(void *addr, unsigned long size);
 
+/*
+ * Weak function called by early_memremap and early_memremap_ro. It does
+ * nothing, but architectures may provide their own version to handle
+ * memory encryption.
+ */
+extern pgprot_t early_memremap_pgprot_adjust(resource_size_t phys_addr,
+					    unsigned long size, pgprot_t prot);
+
 /*
  * Weak function called by early_ioremap_reset(). It does nothing, but
  * architectures may provide their own version to do any needed cleanups.
-- 
2.26.2


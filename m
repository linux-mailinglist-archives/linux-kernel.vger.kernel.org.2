Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FC3775FB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEIJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhEIJMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:12:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 951C06140B;
        Sun,  9 May 2021 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620551472;
        bh=4WEVhLSVp2dKbLOmxraeBWdH+1tEbp0pxIaZ2+hE7gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2+C0pA1EXBspa8UlnFMm9PT3dx5nP5aJ1ThNRXY+FHNVRZDb1dHErShAy6lqFh57
         BrUESGLEHge/J4sLCcAIgtbbYOJrayu69L0q6PuzPRHANZnaaN8EaO4H6sz+2FwIZ+
         xxntpPWUJ6KTtHtmCdoSNUKFVwBSLhCDD4xTS7CZGTglZZPs+kpb7/zxwgbvH5Zg2w
         JduA7kWTxKrUYoisigCYiX6XMnCyDvvV8V54yVD4hRZ4ww30i/CE9sMJ5uh3olpUZd
         dpWR6z9r3p2GYQby3vxNmEvZie7roeCXG5s4/aVb2sQg6MaC9JVOcxq/ZptHEP5F69
         1yo2uPWLkW/zQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] openrisc: mm/init.c: remove unused memblock_region variable in map_ram()
Date:   Sun,  9 May 2021 12:11:02 +0300
Message-Id: <20210509091103.7985-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210509091103.7985-1-rppt@kernel.org>
References: <20210509091103.7985-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Kernel test robot reports:

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/openrisc/mm/init.c:125:10: warning: Uninitialized variable: region [uninitvar]
            region->base, region->base + region->size);
            ^

Replace usage of memblock_region fields with 'start' and 'end' variables
that are initialized in for_each_mem_range() and remove the declaration of
region.

Fixes: b10d6bca8720 ("arch, drivers: replace for_each_membock() with for_each_mem_range()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/mm/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index bf9b2310fc93..f3fa02b8838a 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -75,7 +75,6 @@ static void __init map_ram(void)
 	/* These mark extents of read-only kernel pages...
 	 * ...from vmlinux.lds.S
 	 */
-	struct memblock_region *region;
 
 	v = PAGE_OFFSET;
 
@@ -121,7 +120,7 @@ static void __init map_ram(void)
 		}
 
 		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
-		       region->base, region->base + region->size);
+		       start, end);
 	}
 }
 
-- 
2.28.0


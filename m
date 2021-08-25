Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ACC3F7491
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhHYLtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhHYLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:49:22 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA940C06179A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:48:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91f7:1ea1:147b:586f])
        by laurent.telenet-ops.be with bizsmtp
        id lnoX2500234CCxU01noXjY; Wed, 25 Aug 2021 13:48:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-005kYT-OX; Wed, 25 Aug 2021 13:48:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-00DDKU-7r; Wed, 25 Aug 2021 13:48:30 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms@verge.net.au>,
        Tony Luck <tony.luck@intel.com>, Jay Lan <jlan@sgi.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ia64: Make num_rsvd_regions static
Date:   Wed, 25 Aug 2021 13:48:29 +0200
Message-Id: <a377b5437e3e9da93d02f996fe06a2b956cb0990.1629884459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1629884459.git.geert+renesas@glider.be>
References: <cover.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f62800992e5917f2 ("ia64: switch to NO_BOOTMEM") removed the last
user of num_rsvd_regions outside arch/ia64/kernel/setup.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/ia64/include/asm/meminit.h | 1 -
 arch/ia64/kernel/setup.c        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/include/asm/meminit.h b/arch/ia64/include/asm/meminit.h
index 2738f62b5f989492..f1d5bf2ba847a135 100644
--- a/arch/ia64/include/asm/meminit.h
+++ b/arch/ia64/include/asm/meminit.h
@@ -29,7 +29,6 @@ struct rsvd_region {
 };
 
 extern struct rsvd_region rsvd_region[IA64_MAX_RSVD_REGIONS + 1];
-extern int num_rsvd_regions;
 
 extern void find_memory (void);
 extern void reserve_memory (void);
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5e6ee8939092a2df..31fb84de2d21469a 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -131,7 +131,7 @@ unsigned long ia64_cache_stride_shift = ~0;
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */
 struct rsvd_region rsvd_region[IA64_MAX_RSVD_REGIONS + 1] __initdata;
-int num_rsvd_regions __initdata;
+static int num_rsvd_regions __initdata;
 
 
 /*
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520DD3F7493
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbhHYLte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbhHYLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:49:22 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500FC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:48:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91f7:1ea1:147b:586f])
        by albert.telenet-ops.be with bizsmtp
        id lnoX2500234CCxU06noXv4; Wed, 25 Aug 2021 13:48:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-005kYR-RZ; Wed, 25 Aug 2021 13:48:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIrOQ-00DDKF-6M; Wed, 25 Aug 2021 13:48:30 +0200
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
Subject: [PATCH 1/3] ia64: Fix #endif comment for reserve_elfcorehdr()
Date:   Wed, 25 Aug 2021 13:48:27 +0200
Message-Id: <77b4c0648f200cab7e1c2c5171c06763e09362aa.1629884459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1629884459.git.geert+renesas@glider.be>
References: <cover.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of reserve_elfcorehdr() depends on CONFIG_CRASH_DUMP, not
CONFIG_PROC_VMCORE.

Fixes: d9a9855d0b06ca6d ("always reserve elfcore header memory in crash kernel")
Fixes: 17c1f07ed70afa4f ("[IA64] Reserve elfcorehdr memory in CONFIG_CRASH_DUMP")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/ia64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index dd595fbd800651fe..fbd931f1eb270d98 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -546,7 +546,7 @@ int __init reserve_elfcorehdr(u64 *start, u64 *end)
 	return 0;
 }
 
-#endif /* CONFIG_PROC_VMCORE */
+#endif /* CONFIG_CRASH_DUMP */
 
 void __init
 setup_arch (char **cmdline_p)
-- 
2.25.1


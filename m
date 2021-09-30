Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7341D209
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbhI3D72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:59:28 -0400
Received: from m97136.mail.qiye.163.com ([220.181.97.136]:20750 "EHLO
        m97136.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348004AbhI3D71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:59:27 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 23:59:27 EDT
Received: from localhost.localdomain (unknown [58.56.27.130])
        by smtp2 (Coremail) with SMTP id iOCowAD3WgVbNFVhNQyaAw--.22799S2;
        Thu, 30 Sep 2021 11:51:56 +0800 (CST)
From:   Shi Lei <shi_lei@massclouds.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shi Lei <shi_lei@massclouds.com>
Subject: [PATCH] mm: remove useless lines in enable_cpucache()
Date:   Thu, 30 Sep 2021 11:48:45 +0800
Message-Id: <20210930034845.2539-1-shi_lei@massclouds.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: iOCowAD3WgVbNFVhNQyaAw--.22799S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUBwF4DUUUU
X-Originating-IP: [58.56.27.130]
X-CM-SenderInfo: pvklsz1hl6ztxvvfz0xxgvhudrp/1tbiVRweT1f4pxhyDAAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These lines are useless, so remove them.

Signed-off-by: Shi Lei <shi_lei@massclouds.com>
---
 mm/slab.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 4d826394ffcb..01775fe0e002 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3900,8 +3900,6 @@ static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
 	if (err)
 		goto end;
 
-	if (limit && shared && batchcount)
-		goto skip_setup;
 	/*
 	 * The head array serves three purposes:
 	 * - create a LIFO ordering, i.e. return objects that are cache-warm
@@ -3944,7 +3942,6 @@ static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
 		limit = 32;
 #endif
 	batchcount = (limit + 1) / 2;
-skip_setup:
 	err = do_tune_cpucache(cachep, limit, batchcount, shared, gfp);
 end:
 	if (err)
-- 
2.25.1


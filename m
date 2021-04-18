Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8133635E5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhDROfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 10:35:09 -0400
Received: from mout01.posteo.de ([185.67.36.65]:48219 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhDROfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 10:35:03 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 790D324002A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 16:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618756472; bh=6thETMQGh49GaIIDorZhPjhkpw8s8DkGoYxt2KGTNJs=;
        h=From:To:Cc:Subject:Date:From;
        b=HuZKdXOIJm5aM6l/agjb7y4y8M75UHTrW7MclLEsaaRJL2qxxm7kB8vdDA/gXfF+A
         +qN8YtkqQNsmJQ68ujAI1+R2/qPdwqlAQDiXzWTh6tm7ru4uM3qC3XssaK3fVKa7nc
         H7C95zHEpy0SLKH3Fi8Sr4j4kNKdzApkN4l1r7ckCL8tQ1XRkhzhEklt6hHhIElNfL
         eDgORgozZ4byTHGBWnvXz1kbW3hXYFvlrKk8n7cE2KJlnwT8AIuDAWD+NpRsaKs8Og
         1u/JTHPdMCqCp+muy9POvJ1lfNVuHnJXnOR7SOWJH/s74+EsMFuZQJZrqx/qqY4p3C
         VsQM1LV3UrrGA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNXX767qBz6tmP;
        Sun, 18 Apr 2021 16:34:31 +0200 (CEST)
From:   Alexander Egorenkov <egorenar-dev@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Egorenkov <egorenar-dev@posteo.net>
Subject: [PATCH 2/2] lib: scatterlist: Fix incorrect SG offset in sg_split_phys()
Date:   Sun, 18 Apr 2021 14:34:25 +0000
Message-Id: <20210418143425.22944-2-egorenar-dev@posteo.net>
In-Reply-To: <20210418143425.22944-1-egorenar-dev@posteo.net>
References: <20210418143425.22944-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg_split_phys() incorrectly resets the offset of all split SGLs but the
first one to 0. This is wrong because one of the original SGLs might have
the offset != 0.

Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
---
 lib/sg_split.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index 0920affd12ee..4e91547a898d 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -89,8 +89,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 			if (!j) {
 				out_sg->offset += split->skip_sg0;
 				out_sg->length -= split->skip_sg0;
-			} else {
-				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
 			if (IS_ENABLED(CONFIG_NEED_SG_DMA_LENGTH))
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3636344C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhDRIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 04:15:18 -0400
Received: from mout02.posteo.de ([185.67.36.66]:49089 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDRIPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 04:15:17 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 39AB72400FC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618733688; bh=bl3UDLdYZz9aw9ENMX943zhNbIJ/5yxXivl5iyw3ZD0=;
        h=From:To:Cc:Subject:Date:From;
        b=A+Zt2Fuk5LF5fw+rAkqkvR/UB1b3pe0/28xjKx6YFAsbXYGRXemgVOk8UF3BLggV8
         Jn6wnyerU4XMzF98GVqAHL8hKjxWyVjQ9eoNtt1vFa6H6evoV/NFYudnP+1iYcga9H
         H1Wvwe6uvMKxujWuIdzy03+p8iUP4riPnVVB7HOlB0ijzEHqjjAMvT0K7H48Nk14o6
         nNEU43KXa56GQFSjoc0YIKh30mF4VkmQ0rqw9POMNB3pYfhfhhVrOyjXE4/sc1L8bn
         GjW40OQ9McKGuSdw27JKrTkXzaKq2PscZcjs1aCrTuvJ2bd8D4u3IB8nOFAJi4dXU6
         3RsvzkV9tYCig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNN5z5jgjz9rxH;
        Sun, 18 Apr 2021 10:14:47 +0200 (CEST)
From:   Alexander Egorenkov <egorenar-dev@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Egorenkov <egorenar-dev@posteo.net>
Subject: [PATCH 1/1] lib: scatterlist: Fix SGL length in sg_split() if !CONFIG_NEED_SG_DMA_LENGTH
Date:   Sun, 18 Apr 2021 08:14:41 +0000
Message-Id: <20210418081441.5040-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_NEED_SG_DMA_LENGTH is NOT enabled then sg_dma_len() is an alias
for the length field in a SGL. In that case sg_split() wrongly resets
the length of split SGLs to zero after it was set correctly before.

Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
---
 lib/sg_split.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index 60a0babebf2e..3d9b32084d78 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -92,7 +92,8 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
-			sg_dma_len(out_sg) = 0;
+			if (IS_ENABLED(CONFIG_NEED_SG_DMA_LENGTH))
+				sg_dma_len(out_sg) = 0;
 			in_sg = sg_next(in_sg);
 		}
 		out_sg[-1].length = split->length_last_sg;
-- 
2.31.1


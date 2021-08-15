Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DC3EC6D9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 05:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhHODWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 23:22:04 -0400
Received: from m12-18.163.com ([220.181.12.18]:35553 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhHODWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VqxE2
        6W/p5gCQWidblx3vz+89p1P5HiPYzrdJ0nbxBE=; b=S80Oe940LIyxapOnaphhI
        EZ1sIvz3l410AHZItzifJ83PQkslK0BrFRNsA+TGSjsqk7/00Yo57BLyTibwftg+
        EXCkh5a/YYgRh17y8UMql1U3Bg97LyZ/9NpfdVE0c19Tj7/zQrwnEYeyuHmQIXu2
        U4UPk3bvSJDnV2NrET2Z1E=
Received: from ubuntu.localdomain (unknown [183.220.91.139])
        by smtp14 (Coremail) with SMTP id EsCowADX3Qn1hxhh2Jihzw--.61169S2;
        Sun, 15 Aug 2021 11:20:21 +0800 (CST)
From:   Junhua Huang <junhuahuangdream@163.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: [PATCH] percpu: remove the unnecessary operation for bitmaps in finding suitable region
Date:   Sat, 14 Aug 2021 20:20:18 -0700
Message-Id: <20210815032018.192334-1-junhuahuangdream@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADX3Qn1hxhh2Jihzw--.61169S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWDJw4UWry8uw4fZry7Wrg_yoW8Jr48pr
        W5WFyDKr1DAw43u3WktwnrXr15uwn8tw4rCw45Gr9xZ3ZxC345WFW0gw4Yga4xCasxur1a
        vw4DWFy7JayUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2WlkUUUUU=
X-Originating-IP: [183.220.91.139]
X-CM-SenderInfo: xmxqx3pdkxt05jguvtrp6rljoofrz/1tbipRbvZVUMf9Wd1wAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhua Huang <huang.junhua@zte.com.cn>

We use pcpu_next_fit_region to find the next fit region for alloc. Once
return, the region fit the request and then break the loop, or get the
next start offset from pcpu_is_populated. So there is no necessary to
add bits to bit_off. At the same time, bits will set 0 in 
pcpu_next_fit_region each time, so I think it is unnecessary to 
set bits zero in pcpu_for_each_fit_region loops.

Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
---
 mm/percpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7f2e0151c4e2..ec7a5d10f6c9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -489,7 +489,6 @@ static void pcpu_next_fit_region(struct pcpu_chunk *chunk, int alloc_bits,
 	for (pcpu_next_fit_region((chunk), (alloc_bits), (align), &(bit_off), \
 				  &(bits));				      \
 	     (bit_off) < pcpu_chunk_map_bits((chunk));			      \
-	     (bit_off) += (bits),					      \
 	     pcpu_next_fit_region((chunk), (alloc_bits), (align), &(bit_off), \
 				  &(bits)))
 
@@ -1126,7 +1125,6 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
 			break;
 
 		bit_off = next_off;
-		bits = 0;
 	}
 
 	if (bit_off == pcpu_chunk_map_bits(chunk))
-- 
2.25.1



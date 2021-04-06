Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5669354AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbhDFCHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:07:24 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:37448 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhDFCHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:07:16 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 1361lcVE002641; Tue, 6 Apr 2021 10:47:39 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1361lEZu007326; Tue, 6 Apr 2021 10:47:15 +0900
X-Iguazu-Qid: 2wGrVoOlx8DnQbNBFY
X-Iguazu-QSIG: v=2; s=0; t=1617673634; q=2wGrVoOlx8DnQbNBFY; m=cxnfJ9M8PQa+u2t3Lsdd5XtJDQNRyDNPmrSjk1uyn14=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1110) id 1361lCF1023749
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 6 Apr 2021 10:47:13 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B48231000A4;
        Tue,  6 Apr 2021 10:47:12 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1361lC8k012997;
        Tue, 6 Apr 2021 10:47:12 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Fix corner case in bad block table handling.
Date:   Tue,  6 Apr 2021 10:47:08 +0900
X-TSB-HOP: ON
Message-Id: <774a92693f311e7de01e5935e720a179fb1b2468.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Doyle, Patrick" <pdoyle@irobot.com>

In the unlikely event that both blocks 10 and 11 are marked as bad (on a
32 bit machine), then the process of marking block 10 as bad stomps on
cached entry for block 11.  There are (of course) other examples.

Signed-off-by: Patrick Doyle <pdoyle@irobot.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/bbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 044adf913854..64af6898131d 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -123,7 +123,7 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
 		unsigned int rbits = bits_per_block + offs - BITS_PER_LONG;
 
 		pos[1] &= ~GENMASK(rbits - 1, 0);
-		pos[1] |= val >> rbits;
+		pos[1] |= val >> (bits_per_block - rbits);
 	}
 
 	return 0;
-- 
2.25.1


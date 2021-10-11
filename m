Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8569428C65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhJKLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:55:24 -0400
Received: from first.geanix.com ([116.203.34.67]:37364 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236303AbhJKLzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:55:18 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 1407DC3DB1;
        Mon, 11 Oct 2021 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633953197; bh=34RYAExQV2GpY9VYCNMKcw7k5EiKJcu+XcF5wGblsM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cLbnL/2oqSJXV6k+rEsBn8xJ6hh2Uy0h9AV9bhlXm1qH4AVfcRSAwGvYc1YbKpZ9f
         GzxqKaLnTvcKgrnZasC/r54GYgLLJw5lk26xT/SzqdPUEDK649rqdbLu+R3JYUMgbX
         +1tjer7lxABiiU8+xKDkE3QKxaY3INCKEPQmpclczGta4CsMidBH+7Jx+SamO5MSZV
         6ZUYirx6U3cwvs1dUFU/xGXC2avs2hq8iUhXhsiZzfLXowdb3vr4RsYLhG6F6i+Vug
         Tdl4G4HBuhPY01882a2GJJZeI5uz9obr9uwFpzrhGioz/0Ld5bXFjrRugPFySy8Rqp
         Qu8CydY3xxLpw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mtd: mtdconcat: add suspend lock handling
Date:   Mon, 11 Oct 2021 13:52:53 +0200
Message-Id: <20211011115253.38497-4-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011115253.38497-1-sean@geanix.com>
References: <20211011115253.38497-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new suspend lock handling for this special case for concatenated
MTD devices.

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdconcat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..c497c851481f 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -561,25 +561,32 @@ static void concat_sync(struct mtd_info *mtd)
 
 static int concat_suspend(struct mtd_info *mtd)
 {
+	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, rc = 0;
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		if ((rc = mtd_suspend(subdev)) < 0)
+
+		down_write(&master->master.suspend_lock);
+		if ((rc = __mtd_suspend(subdev)) < 0)
 			return rc;
+		up_write(&master->master.suspend_lock);
 	}
 	return rc;
 }
 
 static void concat_resume(struct mtd_info *mtd)
 {
+	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i;
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		mtd_resume(subdev);
+		down_write(&master->master.suspend_lock);
+		__mtd_resume(subdev);
+		up_write(&master->master.suspend_lock);
 	}
 }
 
-- 
2.33.0


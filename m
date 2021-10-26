Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDA43ABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhJZF6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:58:32 -0400
Received: from first.geanix.com ([116.203.34.67]:37414 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235129AbhJZF60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:58:26 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 5D079D6F80;
        Tue, 26 Oct 2021 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635227761; bh=daO+Y1OCTBro/SQlNmjckPsesZNNVg/tJVluOHMiVlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fPOBQdCNaJcwengLung002AYFTMtVsphCyan6o4Rvjm3Fn4ekyCuKUHBNG2Vzd1TO
         KdreS5OqEPQ6FceS+o/Pf2yG1JRXyH2LYnWCA2uREKNKAB95Q6dE/VO9uJsZyNI/XL
         jT8tObXx6hZ2FCeJk9kyuz+xayWwZmxtEr+OyidPsDwno2rd5Q5wsfyH81u+QEZ9Qd
         KV36msQefe5oft5ywL4jC/T19gGU8g2mgesy3ntWrgJLV1zRa6dtMC8XV48NGY9TJr
         fYsjpJbVF+UCnX33fIJ8dIQALRwkjeN66S/NXml6jmPkKR/S9o5bG+0CZE0GqVIGgI
         j2ifxd7+hw5UA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] mtd: mtdconcat: don't use mtd_{suspend,resume}()
Date:   Tue, 26 Oct 2021 07:55:49 +0200
Message-Id: <20211026055551.3053598-3-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026055551.3053598-1-sean@geanix.com>
References: <20211026055551.3053598-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

The MTD suspend logic will soon be adjusted to automatically wait for
device wake-up before issuing IOs. In order to do that a new read-write
lock will be added and taken in write-mode in the
mtd_{suspend,resume}() path. Since mtdconcat.c itself is an MTD device,
calling mtd_suspend/resume() on subdevices from the mtdconcat
->_{suspend,resume}() hook will lead to a nested lock, which lockdep
will complain about if we don't add a proper annotation. Let's keep
things simple and replace those mtd_{suspend,resume}(subdev) calls by
subdev->_{suspend,resume}() ones to avoid this situation.

Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdconcat.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..f4a4274489b4 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -566,9 +566,15 @@ static int concat_suspend(struct mtd_info *mtd)
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		if ((rc = mtd_suspend(subdev)) < 0)
+		/*
+		 * Call the MTD hook directly to avoid a nested lock
+		 * on ->suspend_lock.
+		 */
+		rc = subdev->_suspend ? subdev->_suspend(subdev) : 0;
+		if (rc < 0)
 			return rc;
 	}
+
 	return rc;
 }
 
@@ -579,7 +585,12 @@ static void concat_resume(struct mtd_info *mtd)
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		mtd_resume(subdev);
+		/*
+		 * Call the MTD hook directly to avoid a nested lock
+		 * on ->resume_lock.
+		 */
+		if (subdev->_resume)
+			subdev->_resume(subdev);
 	}
 }
 
-- 
2.33.0


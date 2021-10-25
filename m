Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D73439256
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhJYJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:30:24 -0400
Received: from first.geanix.com ([116.203.34.67]:37402 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232525AbhJYJaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:30:22 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id CD15ED6811;
        Mon, 25 Oct 2021 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635154079; bh=gGr8jzmjUcZKYNrVgYoe5GuAvsXat5tgwVgjB7wXR6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q709du2aze/uTVPXnsMvZM7LWjRZuG7YfwXT8JsG7eLrnBxuRGlFYJYu513TVVzbP
         EyRdy0axPPRUHISfVdqD5yNbK0DG65Wasvn+xOYFgnGGoNeM/BSlmRilRz76vz/b5j
         TKiIfVG7+sbC2FgsiFhEPz+LtA4ywQJFkFbovIu1oP489L6DYlrbzgnRdFCNZQ15do
         1l0GujEnmHlZw35uGfKxqwFn0AF/D6S5iF8+zLVzHhc5ukVJc3XblKLnHAVF1R7xZ6
         lJplD+5xKISE0usxn4uJ/8GXQuCEFrL7TBiPbRspMoRI15PAABmvzzNxitP5IwMQIz
         7CXBNCVW4v8iA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] mtd: mtdconcat: add suspend lock handling
Date:   Mon, 25 Oct 2021 11:27:50 +0200
Message-Id: <20211025092752.2824678-3-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025092752.2824678-1-sean@geanix.com>
References: <20211025092752.2824678-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MTD hooks to control suspend/resume of MTD devices.
concat_{suspend,resume} will be called from mtd_{suspend,resume},
which already have taken the suspend/resume lock.
It's safe to proceed with calling MTD device hooks directly from here.

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdconcat.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..37532f529820 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -566,9 +566,15 @@ static int concat_suspend(struct mtd_info *mtd)
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		if ((rc = mtd_suspend(subdev)) < 0)
+		/*
+		 * Call MTD hook directly from here,
+		 * mtd_suspend() have the suspend/resume lock.
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
+		 * Call MTD hook directly from here,
+		 * mtd_resume() have the suspend/resume lock.
+		 */
+		if (subdev->_resume)
+			subdev->_resume(subdev);
 	}
 }
 
-- 
2.33.0


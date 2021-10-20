Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2C434735
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJTIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:48:04 -0400
Received: from first.geanix.com ([116.203.34.67]:37392 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJTIr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:47:59 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 78DA5C7EC7;
        Wed, 20 Oct 2021 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634719543; bh=i/8+adCTB/1ZY8UzLuJ8XezBVVwGeL0INtp1R95tHKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NB3xri6B/AeZ8R2UuxkpLkaqp9aASu4mLmRDqZjFzNy2vR3adoreX2oMxtv/vFZa3
         0NPVRfxL+8A5RWZMNmcNV2q/oORfUrYoPVbyEQdgbWQYIjyD/yDhTM+1ny5bj6kPd2
         RDuRNp+UxHXBxWKeAZuM53uAzM36HtQhk1CWFTwjFU9TswGBtIhtnRTWvcmUqZsF+4
         GgRvM8IHJdNX4lQtxZrI6yIVbcMNeWdIdDvB2YDoBK/4kFYufFde96afFKhmoetMQ0
         SRISQw6B8ZTOe2vgX+aCzqcd55r2+pFdiFP2jOBlwOL2TKMsfTB4iCDTBk2iRoxjGE
         dt3x86RIvf1jw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mtd: mtdconcat: add suspend lock handling
Date:   Wed, 20 Oct 2021 10:45:34 +0200
Message-Id: <20211020084534.2472305-5-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020084534.2472305-1-sean@geanix.com>
References: <20211020084534.2472305-1-sean@geanix.com>
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

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdconcat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..1ec36890118f 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -566,9 +566,11 @@ static int concat_suspend(struct mtd_info *mtd)
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		if ((rc = mtd_suspend(subdev)) < 0)
+		rc = subdev->_suspend ? subdev->_suspend(subdev) : 0;
+		if (rc < 0)
 			return rc;
 	}
+
 	return rc;
 }
 
@@ -579,7 +581,8 @@ static void concat_resume(struct mtd_info *mtd)
 
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
-		mtd_resume(subdev);
+		if (subdev->_resume)
+			subdev->_resume(subdev);
 	}
 }
 
-- 
2.33.0


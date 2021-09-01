Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D53FE46C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbhIAVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbhIAVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:02:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DAC0613C1;
        Wed,  1 Sep 2021 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o2jFAXs2S20ugcqcgWqTKDs1dtJRAdxtjSIxmQce0yE=; b=dbtMU/12XHhPiB9HTZczz4LIbL
        /SGIKdCY+MBcFiD6mSeE2V0upDnAm0UTQt69AsWTcGeJPTyukWEtJzB+8dKexiUmI6K+N0ZvKWbdJ
        VccAlCXnv79qwvdgVpOHFZlxYmCySO1bBcO5FC20wsXdFFrVWqISnO8yNKqMTttDTypOPmbpA+lnr
        7yGKtvOKhzeSvCksN8fjFTeu1vXblO9nV8CW4WTdSdvPZ4lAJvZosM5WETwI/JVjVXymr6V9JI4dV
        b0sWE7OTUZY6z39q2bMgKPla8ajMRMcIgtJqWHuAe96VaI+ewqEYt5IhI+bazR2V87pIsp4nnEkeC
        En+/5xnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLXLR-007LWF-Ik; Wed, 01 Sep 2021 21:00:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 06/10] block/rsxx: add error handling support for add_disk()
Date:   Wed,  1 Sep 2021 14:00:24 -0700
Message-Id: <20210901210028.1750956-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901210028.1750956-1-mcgrof@kernel.org>
References: <20210901210028.1750956-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/rsxx/core.c |  4 +++-
 drivers/block/rsxx/dev.c  | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 83636714b8d7..8d9d69f5dfbc 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -935,7 +935,9 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 			card->size8 = 0;
 	}
 
-	rsxx_attach_dev(card);
+	st = rsxx_attach_dev(card);
+	if (st)
+		goto failed_create_dev;
 
 	/************* Setup Debugfs *************/
 	rsxx_debugfs_dev_new(card);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 1cc40b0ea761..b2d3ac3efce2 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -192,6 +192,8 @@ static bool rsxx_discard_supported(struct rsxx_cardinfo *card)
 
 int rsxx_attach_dev(struct rsxx_cardinfo *card)
 {
+	int err = 0;
+
 	mutex_lock(&card->dev_lock);
 
 	/* The block device requires the stripe size from the config. */
@@ -200,13 +202,17 @@ int rsxx_attach_dev(struct rsxx_cardinfo *card)
 			set_capacity(card->gendisk, card->size8 >> 9);
 		else
 			set_capacity(card->gendisk, 0);
-		device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
-		card->bdev_attached = 1;
+		err = device_add_disk(CARD_TO_DEV(card), card->gendisk, NULL);
+		if (err == 0)
+			card->bdev_attached = 1;
 	}
 
 	mutex_unlock(&card->dev_lock);
 
-	return 0;
+	if (err)
+		blk_cleanup_disk(card->gendisk);
+
+	return err;
 }
 
 void rsxx_detach_dev(struct rsxx_cardinfo *card)
-- 
2.30.2


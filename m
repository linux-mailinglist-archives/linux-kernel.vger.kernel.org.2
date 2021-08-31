Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F53FBEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhH3WL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbhH3WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE12C061575;
        Mon, 30 Aug 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=36SL0wDTuPKE88DN3bn6CHYvWFCssDMr/vLYk5vdXW4=; b=D2xTVTYV2/R0+e0G3GBfPfTMt2
        pw0sjSo97A8CT8qrUzQncZ508kfl1FcrxxX7NqSCPiVpNc1urI85Aym19fKi4B+xU+rV/2W3mQRvn
        OMmfbKN3nrAbpu0u3DDkuz4eSf6ClexUSd1HCAdJvzn/d8EaYTFbzfxji/DrDgvlZCT6QVu5lFCmM
        J+BXc/Trv1LW6U/mp716JwXzWAr4jqAbZrp1uM2lFHhhgfyqI5gNmHn5Dv8XgVew/ug388mgNVyyX
        gJYDBofc36tTUcxbJv839KQ/+v6JOI+1ovoWL6muc3pmz5SZKnzX1JRjL70si8oz258csqk/fLfJO
        gK7mFADg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000khS-17; Mon, 30 Aug 2021 22:10:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/15] n64cart: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 15:09:52 -0700
Message-Id: <20210830221000.179369-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
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
 drivers/block/n64cart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index c84be0028f63..1ba9137bdf30 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -117,6 +117,7 @@ static const struct block_device_operations n64cart_fops = {
 static int __init n64cart_probe(struct platform_device *pdev)
 {
 	struct gendisk *disk;
+	int err = -ENOMEM;
 
 	if (!start || !size) {
 		pr_err("start or size not specified\n");
@@ -134,7 +135,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 
 	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
-		return -ENOMEM;
+		goto out;
 
 	disk->first_minor = 0;
 	disk->flags = GENHD_FL_NO_PART_SCAN;
@@ -149,11 +150,18 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	blk_queue_physical_block_size(disk->queue, 4096);
 	blk_queue_logical_block_size(disk->queue, 4096);
 
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	pr_info("n64cart: %u kb disk\n", size / 1024);
 
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
+out:
+	return err;
 }
 
 static struct platform_driver n64cart_driver = {
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC13A3FBECF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhH3WLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhH3WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897FC061764;
        Mon, 30 Aug 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7HsBSAXvJVS50Uiqx29feEn9n8Si95gNmRNJecp6B2Q=; b=mSF5r29tfSMKUWONsx179gSu0r
        M1xmckDH/qoh81+f3S3vMM4EHa0fATzfytamvVBWhjaLhEhroLxB8pnbJ9igoM5nVy2Ll1vce3kIx
        xcg0FA2XirwpoimM7PWuxVVHOb8p78DYKw4quq2gZmy93qIJhUTbpH9Auv60SWejq4+HEgy3b4Sz4
        NRIh+6b0303K/M1XfiKceRT0h4lTraDDt6shhtJpXL4qDX4Wlqy7wshSZ/qHToczowtsHOjmqxTB8
        NOChV7ODbBu5KBSm7mikoxYVD6n9vChTHz6H1kqo5+T7CH3LUzQGbHyhPZ4yzyR0Bfsq9vlx6+5KG
        /OTw4j7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000kha-5l; Mon, 30 Aug 2021 22:10:08 +0000
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/15] pf: cleanup initialization
Date:   Mon, 30 Aug 2021 15:09:55 -0700
Message-Id: <20210830221000.179369-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Refactor the pf initialization to have a dedicated helper to initialize
a single disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pf.c | 223 +++++++++++++++++---------------------
 1 file changed, 99 insertions(+), 124 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index d5b9c88ba76f..f471d48a87bc 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -214,7 +214,6 @@ static int pf_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static void pf_release(struct gendisk *disk, fmode_t mode);
 
-static int pf_detect(void);
 static void do_pf_read(void);
 static void do_pf_read_start(void);
 static void do_pf_write(void);
@@ -285,45 +284,6 @@ static const struct blk_mq_ops pf_mq_ops = {
 	.queue_rq	= pf_queue_rq,
 };
 
-static void __init pf_init_units(void)
-{
-	struct pf_unit *pf;
-	int unit;
-
-	pf_drive_count = 0;
-	for (unit = 0, pf = units; unit < PF_UNITS; unit++, pf++) {
-		struct gendisk *disk;
-
-		if (blk_mq_alloc_sq_tag_set(&pf->tag_set, &pf_mq_ops, 1,
-				BLK_MQ_F_SHOULD_MERGE))
-			continue;
-
-		disk = blk_mq_alloc_disk(&pf->tag_set, pf);
-		if (IS_ERR(disk)) {
-			blk_mq_free_tag_set(&pf->tag_set);
-			continue;
-		}
-
-		INIT_LIST_HEAD(&pf->rq_list);
-		blk_queue_max_segments(disk->queue, cluster);
-		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
-		pf->disk = disk;
-		pf->pi = &pf->pia;
-		pf->media_status = PF_NM;
-		pf->drive = (*drives[unit])[D_SLV];
-		pf->lun = (*drives[unit])[D_LUN];
-		snprintf(pf->name, PF_NAMELEN, "%s%d", name, unit);
-		disk->major = major;
-		disk->first_minor = unit;
-		disk->minors = 1;
-		strcpy(disk->disk_name, pf->name);
-		disk->fops = &pf_fops;
-		disk->events = DISK_EVENT_MEDIA_CHANGE;
-		if (!(*drives[unit])[D_PRT])
-			pf_drive_count++;
-	}
-}
-
 static int pf_open(struct block_device *bdev, fmode_t mode)
 {
 	struct pf_unit *pf = bdev->bd_disk->private_data;
@@ -718,59 +678,6 @@ static int pf_probe(struct pf_unit *pf)
 	return -1;
 }
 
-static int pf_detect(void)
-{
-	struct pf_unit *pf = units;
-	int k, unit;
-
-	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
-	       name, name, PF_VERSION, major, cluster, nice);
-
-	par_drv = pi_register_driver(name);
-	if (!par_drv) {
-		pr_err("failed to register %s driver\n", name);
-		return -1;
-	}
-	k = 0;
-	if (pf_drive_count == 0) {
-		if (pi_init(pf->pi, 1, -1, -1, -1, -1, -1, pf_scratch, PI_PF,
-			    verbose, pf->name)) {
-			if (!pf_probe(pf) && pf->disk) {
-				pf->present = 1;
-				k++;
-			} else
-				pi_release(pf->pi);
-		}
-
-	} else
-		for (unit = 0; unit < PF_UNITS; unit++, pf++) {
-			int *conf = *drives[unit];
-			if (!conf[D_PRT])
-				continue;
-			if (pi_init(pf->pi, 0, conf[D_PRT], conf[D_MOD],
-				    conf[D_UNI], conf[D_PRO], conf[D_DLY],
-				    pf_scratch, PI_PF, verbose, pf->name)) {
-				if (pf->disk && !pf_probe(pf)) {
-					pf->present = 1;
-					k++;
-				} else
-					pi_release(pf->pi);
-			}
-		}
-	if (k)
-		return 0;
-
-	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->disk)
-			continue;
-		blk_cleanup_disk(pf->disk);
-		blk_mq_free_tag_set(&pf->tag_set);
-	}
-	pi_unregister_driver(par_drv);
-	return -1;
-}
-
 /* The i/o request engine */
 
 static int pf_start(struct pf_unit *pf, int cmd, int b, int c)
@@ -1014,61 +921,129 @@ static void do_pf_write_done(void)
 	next_request(0);
 }
 
+static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
+		int mode, int unit, int protocol, int delay, int ms)
+{
+	struct gendisk *disk;
+	int ret;
+
+	ret = blk_mq_alloc_sq_tag_set(&pf->tag_set, &pf_mq_ops, 1,
+				      BLK_MQ_F_SHOULD_MERGE);
+	if (ret)
+		return ret;
+
+	disk = blk_mq_alloc_disk(&pf->tag_set, pf);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		goto out_free_tag_set;
+	}
+	disk->major = major;
+	disk->first_minor = pf - units;
+	disk->minors = 1;
+	strcpy(disk->disk_name, pf->name);
+	disk->fops = &pf_fops;
+	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	disk->private_data = pf;
+
+	blk_queue_max_segments(disk->queue, cluster);
+	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
+
+	INIT_LIST_HEAD(&pf->rq_list);
+	pf->disk = disk;
+	pf->pi = &pf->pia;
+	pf->media_status = PF_NM;
+	pf->drive = (*drives[disk->first_minor])[D_SLV];
+	pf->lun = (*drives[disk->first_minor])[D_LUN];
+	snprintf(pf->name, PF_NAMELEN, "%s%d", name, disk->first_minor);
+
+	if (!pi_init(pf->pi, autoprobe, port, mode, unit, protocol, delay,
+			pf_scratch, PI_PF, verbose, pf->name))
+		goto out_free_disk;
+	if (pf_probe(pf))
+		goto out_pi_release;
+
+	add_disk(disk);
+	pf->present = 1;
+	return 0;
+
+out_pi_release:
+	pi_release(pf->pi);
+out_free_disk:
+	blk_cleanup_disk(pf->disk);
+out_free_tag_set:
+	blk_mq_free_tag_set(&pf->tag_set);
+	return ret;
+}
+
 static int __init pf_init(void)
 {				/* preliminary initialisation */
 	struct pf_unit *pf;
-	int unit;
+	int found = 0, unit;
 
 	if (disable)
 		return -EINVAL;
 
-	pf_init_units();
+	if (register_blkdev(major, name))
+		return -EBUSY;
 
-	if (pf_detect())
-		return -ENODEV;
-	pf_busy = 0;
+	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
+	       name, name, PF_VERSION, major, cluster, nice);
 
-	if (register_blkdev(major, name)) {
-		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-			if (!pf->disk)
-				continue;
-			blk_cleanup_queue(pf->disk->queue);
-			blk_mq_free_tag_set(&pf->tag_set);
-			put_disk(pf->disk);
-		}
-		return -EBUSY;
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		goto out_unregister_blkdev;
 	}
 
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		struct gendisk *disk = pf->disk;
+	for (unit = 0; unit < PF_UNITS; unit++) {
+		if (!(*drives[unit])[D_PRT])
+			pf_drive_count++;
+	}
 
-		if (!pf->present)
-			continue;
-		disk->private_data = pf;
-		add_disk(disk);
+	pf = units;
+	if (pf_drive_count == 0) {
+		if (pf_init_unit(pf, 1, -1, -1, -1, -1, -1, verbose))
+			found++;
+	} else {
+		for (unit = 0; unit < PF_UNITS; unit++, pf++) {
+			int *conf = *drives[unit];
+			if (!conf[D_PRT])
+				continue;
+			if (pf_init_unit(pf, 0, conf[D_PRT], conf[D_MOD],
+				    conf[D_UNI], conf[D_PRO], conf[D_DLY],
+				    verbose))
+				found++;
+		}
+	}
+	if (!found) {
+		printk("%s: No ATAPI disk detected\n", name);
+		goto out_unregister_pi_driver;
 	}
+	pf_busy = 0;
 	return 0;
+
+out_unregister_pi_driver:
+	pi_unregister_driver(par_drv);
+out_unregister_blkdev:
+	unregister_blkdev(major, name);
+	return -ENODEV;
 }
 
 static void __exit pf_exit(void)
 {
 	struct pf_unit *pf;
 	int unit;
-	unregister_blkdev(major, name);
+
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->disk)
+		if (!pf->present)
 			continue;
-
-		if (pf->present)
-			del_gendisk(pf->disk);
-
-		blk_cleanup_queue(pf->disk->queue);
+		del_gendisk(pf->disk);
+		blk_cleanup_disk(pf->disk);
 		blk_mq_free_tag_set(&pf->tag_set);
-		put_disk(pf->disk);
-
-		if (pf->present)
-			pi_release(pf->pi);
+		pi_release(pf->pi);
 	}
+
+	unregister_blkdev(major, name);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.30.2


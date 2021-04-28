Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5236D19E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhD1F32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1F31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:29:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ABC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:28:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k134-20020a25248c0000b02904edb2914343so12566752ybk.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fx7vPqk/u89PVg1T4cJ8wHcLfNDs90uQPpODd7f8SmI=;
        b=WI/UfsWtCK2MyrZgzlYnMET5R+hL1DkqbfeRyxi+2yNGTOplf7gIiZ+KXxP4KwoDT5
         iXUzZEY+AevdWksG/0UWjiC3AnkZ0wRKE7Lb7urhi1/b/wDQaLkJD4llZQH4geQILdBe
         T5Y0nep3OZVSzpjd3jelbK+TkYeFiPiUnpNP9a1RkxDMY4z8O5fUKjAX2eQPvN053uMG
         QqE4V2pCyuqcT6COgnx4npbKTo/uqNGCq2hhwHWEbOUhZJ6VWW40bQhju8k5jXXwnENa
         ryE6QMOIUFU/5TnWwY9GKL7H3uuprsGSakQb4RQeDmSdSeTCm63ibeZwjlCGD1D6byaL
         Y+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fx7vPqk/u89PVg1T4cJ8wHcLfNDs90uQPpODd7f8SmI=;
        b=NwzyneVDyoQYV+PqLejwgMqjMV3yu/flv4ycyvOA441CiU9TGIReTLnlOLBw3Mk6iE
         /7hP8MJUZhOrrq4EF9dUGgjj3GWlhVflTK8LVpeDGtCcdpt3EczqoKb4l9GZeOB98lHh
         nwcuR5qeoRAuRHdha/aIMOQLd7sK3JFBhnbyBqR+U67MFmxiHABmxnL3JY7LtYB6Nk4t
         OZkVOcOOj/8zFv4Cfdkya7w7YX0FlfIdnJs4nfFHakyu40M/GAaGPOvOIRb5ex1uxIxE
         rwI8h3SC3udC45WycA1yypO74u3rL+818ObZ1QApvZu+Rj2Baye8PsSq8hqY1/tQG6/G
         WzUg==
X-Gm-Message-State: AOAM531tCyNL+LVbfukZr0eScsXfpySSWS9PJDJtULY13UCNIHBXsbGM
        msHwytKpnXuIHcdmpmZHlgSK76hc1w==
X-Google-Smtp-Source: ABdhPJwLCfun3+Cpls2Ncq0PflIJ5DGzWXDHMSBpoht8YFI4VKrO3BWrLCODE/Aaub22hLjkZM7MGpVKKQ==
X-Received: from peanut.svl.corp.google.com ([2620:15c:2c5:1:db71:d573:45a1:86c9])
 (user=awill job=sendgmr) by 2002:a25:ab83:: with SMTP id v3mr8868507ybi.400.1619587722204;
 Tue, 27 Apr 2021 22:28:42 -0700 (PDT)
Date:   Tue, 27 Apr 2021 22:27:25 -0700
Message-Id: <20210428052725.530939-1-awill@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 1/3] mtd: spi-nor: Export SFDP access to sysfs
From:   Alexander Williams <awill@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Michael Walle <michael@walle.cc>, Pratyush Yadav <p.yadav@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Williams <awill@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to specify a technology-specific attribute_group, and
expose the SFDP through spi-nor's private group. This enables user space
to have full access to the contents of the SFDP, so all information is
available without regard for whether the kernel supports parsing it.

Signed-off-by: Alexander Williams <awill@google.com>
---
 drivers/mtd/mtdcore.c      | 17 ++++++++++++++++-
 drivers/mtd/spi-nor/core.c | 39 ++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  2 ++
 drivers/mtd/spi-nor/sfdp.c | 10 ++++++++--
 drivers/mtd/spi-nor/sfdp.h |  2 ++
 include/linux/mtd/mtd.h    |  1 +
 6 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9aaeadd53eb4..65dc956e7d47 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -667,10 +667,20 @@ int add_mtd_device(struct mtd_info *mtd)
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
 	of_node_get(mtd_get_of_node(mtd));
-	error = device_register(&mtd->dev);
+	device_initialize(&mtd->dev);
+	dev_set_uevent_suppress(&mtd->dev, 1);
+	error = device_add(&mtd->dev);
 	if (error)
 		goto fail_added;
 
+	if (master->priv_attr_group) {
+		error = devm_device_add_group(&mtd->dev, master->priv_attr_group);
+		WARN_ON(error);
+		error = 0;
+	}
+	dev_set_uevent_suppress(&mtd->dev, 0);
+	kobject_uevent(&mtd->dev.kobj, KOBJ_ADD);
+
 	/* Add the nvmem provider */
 	error = mtd_nvmem_add(mtd);
 	if (error)
@@ -719,6 +729,7 @@ int del_mtd_device(struct mtd_info *mtd)
 {
 	int ret;
 	struct mtd_notifier *not;
+	struct mtd_info *master = mtd_get_master(mtd);
 
 	mutex_lock(&mtd_table_mutex);
 
@@ -743,6 +754,10 @@ int del_mtd_device(struct mtd_info *mtd)
 		if (mtd->nvmem)
 			nvmem_unregister(mtd->nvmem);
 
+		if (master->priv_attr_group) {
+			devm_device_remove_group(&mtd->dev,
+						 master->priv_attr_group);
+		}
 		device_unregister(&mtd->dev);
 
 		idr_remove(&mtd_idr, mtd->index);
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bd2c7717eb10..1eec1ce44882 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3058,6 +3058,44 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	return info;
 }
 
+static ssize_t sfdp_read(struct file *file, struct kobject *kobj,
+			 struct bin_attribute *attr, char *buf, loff_t offset,
+			 size_t len)
+{
+	int ret;
+	struct spi_nor *nor;
+	struct device *dev = kobj_to_dev(kobj);
+	struct mtd_info *mtd = container_of(dev, struct mtd_info, dev);
+
+	mtd = mtd_get_master(mtd);
+	nor = mtd_to_spi_nor(mtd);
+
+	if (nor->params->sfdp_size == 0)
+		return 0;
+
+	if (nor->info->flags & SPI_NOR_SKIP_SFDP)
+		return -EOPNOTSUPP;
+
+	len = min_t(size_t, len, nor->params->sfdp_size - offset);
+	ret = spi_nor_read_sfdp_dma_unsafe(nor, offset, len, buf);
+
+	if (ret)
+		return ret;
+	return len;
+}
+
+static BIN_ATTR_RO(sfdp, 0);
+
+static struct bin_attribute *spi_nor_bin_attrs[] = {
+	&bin_attr_sfdp,
+	NULL,
+};
+
+static struct attribute_group spi_nor_group = {
+	.name		= "spi-nor",
+	.bin_attrs	= spi_nor_bin_attrs,
+};
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -3122,6 +3160,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!mtd->name)
 		mtd->name = dev_name(dev);
 	mtd->priv = nor;
+	mtd->priv_attr_group = &spi_nor_group;
 	mtd->type = MTD_NORFLASH;
 	mtd->writesize = nor->params->writesize;
 	mtd->flags = MTD_CAP_NORFLASH;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 28a2e0be97a3..18e27725fafb 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -240,6 +240,7 @@ struct spi_nor_otp {
  * @rdsr_dummy:		dummy cycles needed for Read Status Register command.
  * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
  *			command.
+ * @sfdp_size		discovered size of the SFDP.
  * @hwcaps:		describes the read and page program hardware
  *			capabilities.
  * @reads:		read capabilities ordered by priority: the higher index
@@ -268,6 +269,7 @@ struct spi_nor_flash_parameter {
 	u32				page_size;
 	u8				rdsr_dummy;
 	u8				rdsr_addr_nbytes;
+	u32				sfdp_size;
 
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 23c28e91f698..221c7dc1aee1 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -210,8 +210,8 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
  * Return: -ENOMEM if kmalloc() fails, the return code of spi_nor_read_sfdp()
  *          otherwise.
  */
-static int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr,
-					size_t len, void *buf)
+int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr, size_t len,
+				 void *buf)
 {
 	void *dma_safe_buf;
 	int ret;
@@ -1247,6 +1247,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	struct device *dev = nor->dev;
 	size_t psize;
 	int i, err;
+	u32 param_limit;
 
 	/* Get the SFDP header. */
 	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sizeof(header), &header);
@@ -1266,6 +1267,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	if (SFDP_PARAM_HEADER_ID(bfpt_header) != SFDP_BFPT_ID ||
 	    bfpt_header->major != SFDP_JESD216_MAJOR)
 		return -EINVAL;
+	nor->params->sfdp_size = sizeof(header);
 
 	/*
 	 * Allocate memory then read all parameter headers with a single
@@ -1299,6 +1301,10 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	 */
 	for (i = 0; i < header.nph; i++) {
 		param_header = &param_headers[i];
+		param_limit = SFDP_PARAM_HEADER_PTP(param_header)
+				+ param_header->length * 4;
+		nor->params->sfdp_size = max(param_limit,
+					     nor->params->sfdp_size);
 
 		if (SFDP_PARAM_HEADER_ID(param_header) == SFDP_BFPT_ID &&
 		    param_header->major == SFDP_JESD216_MAJOR &&
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index bbf80d2990ab..17548b320397 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -108,5 +108,7 @@ struct sfdp_parameter_header {
 };
 
 int spi_nor_parse_sfdp(struct spi_nor *nor);
+int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr, size_t len,
+				 void *buf);
 
 #endif /* __LINUX_MTD_SFDP_H */
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index a89955f3cbc8..2ef1f7e2db76 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -374,6 +374,7 @@ struct mtd_info {
 	int subpage_sft;
 
 	void *priv;
+	struct attribute_group *priv_attr_group;
 
 	struct module *owner;
 	struct device dev;
-- 
2.31.1.527.g47e6f16901-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1E366BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbhDUNIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240871AbhDUNFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1D4F61452;
        Wed, 21 Apr 2021 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010321;
        bh=24xhrEebHpUi4UWGihTxBLzHznoCUsddkzAlZucDGdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCqfQQ6qGQqdGOFAveY6RZiA7aQDvnPYWPYrYpFKUQrG0ploT893PPfGeEGS5Cst8
         zalAN1IzexDfyNcRfsBGdOji34EObfakcpWSdCwt9nu9ByUFAqMVx3jTbtWgM/K1GQ
         2a1I1Iu15wnhsiW6Fsmtav81oZ9agZa+DcGy//Gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 093/190] Revert "iio: hmc5843: fix potential NULL pointer dereferences"
Date:   Wed, 21 Apr 2021 14:59:28 +0200
Message-Id: <20210421130105.1226686-94-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 536cc27deade8f1ec3c1beefa60d5fbe0f6fcb28.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/hmc5843_i2c.c | 7 +------
 drivers/iio/magnetometer/hmc5843_spi.c | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 67fe657fdb3e..9a4491233d08 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -55,13 +55,8 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
-	struct regmap *regmap = devm_regmap_init_i2c(cli,
-			&hmc5843_i2c_regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
 	return hmc5843_common_probe(&cli->dev,
-			regmap,
+			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
 			id->driver_data, id->name);
 }
 
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index d827554c346e..58bdbc7257ec 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -55,7 +55,6 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
 static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
-	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	spi->mode = SPI_MODE_3;
@@ -65,12 +64,8 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	regmap = devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
 	return hmc5843_common_probe(&spi->dev,
-			regmap,
+			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
 			id->driver_data, id->name);
 }
 
-- 
2.31.1


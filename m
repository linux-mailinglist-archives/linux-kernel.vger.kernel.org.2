Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD10414CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhIVPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhIVPK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD39F60F9D;
        Wed, 22 Sep 2021 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632323339;
        bh=IFueKkEMB+2QOI7mYJnYfbnOCGcDlxZ3ht+ed5A/wDY=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9jZTSOk8GtPs3710TW9n6r/W+kfRCXr52AJ/OMLPGr8xeWhwBk+nYoid/K7hkl7Y
         Nw2tTYsRWK77euZn3H9dcKso9jLgnYw63k8PLIxpafw+OuGv/ZlfNaqCEQQlS6XSHX
         11EA4eSCbnz2RFmoCbZatH8IOFfuDD7Vv6yZ7zAh0DdQyDCTeVg3kCZoy/Tbwm+VP5
         iYtMrM8FUyHcRJCHJvPNPW0bTcl1fV9UFEHXucAtWXCKYMOQAL0eo+ceVhVrYMQzjQ
         OK9B8hX3PFft6He9JV1uMgf2qKx09TdzaIa9JUp638jvuY/Go9AX/Z23g89OlBpYCR
         eD+PC6HPh2+pg==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] mfd: sprd: Add SPI device ID table
Date:   Wed, 22 Sep 2021 16:08:12 +0100
Message-Id: <20210922150812.27516-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; h=from:subject; bh=IFueKkEMB+2QOI7mYJnYfbnOCGcDlxZ3ht+ed5A/wDY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhS0a3tY+WWfjh/WZ2c3VsL+gqQlG/r72wF81L0jvb GJWxL0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUtGtwAKCRAk1otyXVSH0FMEB/ 9iPer33x0paP+JcLam4RGjWeH1gwr2Y3rJs8dVyHzLND9Ig9/Mf8l+gQC8Fpis9SHwsjy8xJIphXvT N9oDVEOngAF8Tqdr7yaf1l67j2qoMu1xPESsZvJlxZqIqnqT4EZqKF7RQvSX055qgAXerhMal1EiJ0 Vvgl5MFWYCDelDXJs0c8so5IgGlkdmvuXbtzhg4/btWDeRGsx3zj9kg5z/dRHn7cLLtnAqLnEQ6mz8 yrROsILXJko6IGC9JMg9EQ5CUYSdk1Rj1QdCHdxdM6mm4TsfooarD+PalJA6fim+rmAE5K1zJRLKaR x5FWfOzx2NRb5405f159TGveGi0ebw
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding a SPI device ID table.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/sprd-sc27xx-spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 6b7956604a0f..8b3ed5a0a524 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -230,6 +230,12 @@ static int sprd_pmic_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
+static const struct spi_device_id sprd_pmic_spi_ids[] = {
+	{ .name = "sc2371", .driver_data = (unsigned long)&sc2731_data },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
+
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
 	{},
@@ -243,6 +249,7 @@ static struct spi_driver sprd_pmic_driver = {
 		.pm = &sprd_pmic_pm_ops,
 	},
 	.probe = sprd_pmic_probe,
+	.id_table = sprd_pmic_spi_ids,
 };
 
 static int __init sprd_pmic_init(void)
-- 
2.20.1


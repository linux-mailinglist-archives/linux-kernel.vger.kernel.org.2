Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE584176E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbhIXOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346875AbhIXOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12CEA6124C;
        Fri, 24 Sep 2021 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632494082;
        bh=tNTn5doza/MUdcrkZfi+2yHcLPGWqgBaaU9JXVCX+w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrdWZEtZxqPuqIrluFt6CqvqQgRahy7fW8july0DatZyqR0LnJoY1WGTbzcxsf7c6
         Yy+WU18J9Tu7atSCiArEOm9NneswHeckRKURboFws90VFQ0gwfriPiS7nAgDzPQwtJ
         9UDtvSJjJDd9lFuIbGu3xNtuR8M6PpKLnJ7qabpWsHelwcnJoM36k3r6ZaPjTFRJCp
         jVFITiP1+mnEk0AY6nT1ogqvRHxfc4sG5YyUBSW9BrEfPqv0zZUYQjuJOuxMwEdyHF
         SCq/Omvq0zbLjEOoTh+udNlyXWng/vpA9L33lKwNWw8CGlnFQAjZzJeVVqX2Rdvfjh
         OY7c+I9iuSNRA==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 3/3] mfd: sprd: Add SPI device ID table
Date:   Fri, 24 Sep 2021 15:33:47 +0100
Message-Id: <20210924143347.14721-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924143347.14721-1-broonie@kernel.org>
References: <20210924143347.14721-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; h=from:subject; bh=tNTn5doza/MUdcrkZfi+2yHcLPGWqgBaaU9JXVCX+w0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTeHJWem47OHdKBk/9sQCTVZL/frMHOo2EeSf0C/w i2y++TSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYU3hyQAKCRAk1otyXVSH0NfkB/ 48o4NzbbA6qL14s8AtcLPGxHWIqLibqU8BQ2rzJ8cys3qGAhiY/dHLbjk3jTb4aWMX71eUnNI7RNmm 3367tWANXCIAQ20UzrzWMs3LLanm3cu8Fze81wNwKanB+fCtYFQYIJ/gEOMXNiAt2p/gUecNbCdeJD f9jw4/jR5yKowy8BFims88f8Im7cnqGPVdncIAdMVqDi+LCAn3n9RdU9HuHL/6gMJ23KzafNosBRu0 hjjkJPNLNOWHZCEPICBYL9VBAMA9wTo/GpRU5eLB+d5Fl1GaKQup1KvXYO0gipqI+LS//Ahtk205Ta pdXjaiD54cdrYVkqt+BrNoLZubduVH
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
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 6b7956604a0f..d2d4c4b2087f 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -230,6 +230,12 @@ static int sprd_pmic_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
+static const struct spi_device_id sprd_pmic_spi_ids[] = {
+	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
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


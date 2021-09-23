Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14A141662C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhIWTtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243036AbhIWTtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A5B561241;
        Thu, 23 Sep 2021 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426471;
        bh=tNTn5doza/MUdcrkZfi+2yHcLPGWqgBaaU9JXVCX+w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T79cfkC+jgWtws/ibKWvyyFLP76A9LztI4MwaI70DYfUCSlvmWn9AyHc0z8oikruB
         vl0nBne1JkORynttFeO/GBt0Ha3WyoCwSUFeceZ/wCkfyrYb+mZZ2dIhIhVC14px72
         D88pjUWEowNVXpq3MYXt8EcMRuvWLJphNLTJbdE0N3zgnn2yQEIDM6o8kX0YUYsP32
         D6/4t+e3sN9S8kBkzfd+wxPyehEHfS24WUAnMqhf+kyi8nfkPJQnR4bPnV33cJRyE8
         mpOda0XbXGO+l4J5oG/e+3jEu8lhId58SC5YzEXQ+e13rBWbq0f3sNpXYmVngnfAn4
         dI5D+Dlb9RtCw==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v1 4/4] mfd: sprd: Add SPI device ID table
Date:   Thu, 23 Sep 2021 20:46:45 +0100
Message-Id: <20210923194645.53046-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923194645.53046-1-broonie@kernel.org>
References: <20210923194645.53046-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; h=from:subject; bh=tNTn5doza/MUdcrkZfi+2yHcLPGWqgBaaU9JXVCX+w0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNmjWem47OHdKBk/9sQCTVZL/frMHOo2EeSf0C/w i2y++TSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZowAKCRAk1otyXVSH0IgzB/ 4k6+iQV6CTTWX+qHzuooCTxENzid1K+9ZAAVACkDTbkx9BOfDaFpJJ6hTUmgFt0UeA/Nh0h5t9V5Ix YQjRXEYUFJBdZjmoK9dORmN0rZSLvrivjAL4xmBOS7aWxtg5vlZrfibu1UxAjRtlaxemklZqxon0UO VJN5+8ye+gQ9kJ1NO38f3Key7/+rP/+HpVyBlUNvRQqZOVdruleakBm7UqqqGmpF9Us9u5AvF/CiUy MLZ37lDQaPFtGgV5HrsxTnxvFNaWpjwnAZa1BlNEQFtEMW5fmXCtn+Xhyjk2BHvhhcojh6bFxPX/8K pF3lcoPfN24b1M2rMMqXIvIaCRDYYu
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


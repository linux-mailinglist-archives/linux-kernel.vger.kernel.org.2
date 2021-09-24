Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6313D4176E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346851AbhIXOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346827AbhIXOgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 080A36124F;
        Fri, 24 Sep 2021 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632494077;
        bh=6fsFE3qESzJsB94f3sBMq4fzMOeEYgAy1pgai51I4D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFD2EGZbfRR3WYNV8hnBFk7+w7ZmfH94Ksk+srKhQyXOOCTwE4hLPwnjD1EWnMDbc
         J8gfd47p7NkitBF3m1EWR9sWpFS601lPLkiIwkuItSDTODx6E3W2IauytohSSJB51p
         tS5dVNtBPNYb4cU/Kvknmq4N98HgQaNxQl5l71p7GjSu+USopJFjhTfh0C0L8eYerE
         JY6tc3kfaT8SHuKk15R/R+8cci9kbg0Wrk/htVqngvbGizICcEnAhbs8Yw0GGQK+TX
         t4DhkDM/VFF215uAxum0CQ3vfvQwM+hyWmV4iLFlb6nBBrDxwLjWZLjSt6+e3p8NiJ
         n1ha6lbqoK35w==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH v2 1/3] mfd: altr_a10sr: Add SPI device ID table
Date:   Fri, 24 Sep 2021 15:33:45 +0100
Message-Id: <20210924143347.14721-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924143347.14721-1-broonie@kernel.org>
References: <20210924143347.14721-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; h=from:subject; bh=6fsFE3qESzJsB94f3sBMq4fzMOeEYgAy1pgai51I4D4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTeHIyN6Ws6lys8/PwH31ycQLeBMzfkRWHP0eHy0y e3eKVFGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYU3hyAAKCRAk1otyXVSH0HZxB/ 9FC3EvwVs9DfqxlhUkUAjt53NQJl6IhYP0cPixzA5hy7BiSg2/UOCi10M/CDoK9FlONej8oezqOho2 vjBDuv+84X8vvqc4cE3HkjIOKyMFAejoAS7NNKVOiIu6s+jH1WPmv55sBrwUhzAIKHTXzQ4rFpoXS1 lRL1lppDrnXSLFhphdeAiASoKh1S5iceuiqjRYmm/HV0w7wuTb7skiKLb+zCQfQqTH5YEJT5Tcbllo 1GUC+D9IlN5JC0JkmEPOQturOpAE7ImKK5eJRA4iEz54E+NYjtQaoZheC25hVqMdDl8LxW3EgAfFzK xc/SIYTYK1ea6xDGQVMPwoMkXcKH1H
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
Cc: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/mfd/altera-a10sr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index a3bf64f9afd1..6d04fdd09ca2 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -150,6 +150,13 @@ static const struct of_device_id altr_a10sr_spi_of_match[] = {
 	{ .compatible = "altr,a10sr" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, altr_a10sr_spi_of_match);
+
+static const struct spi_device_id altr_a10sr_spi_ids[] = {
+	{ .name = "a10sr" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, altr_a10sr_spi_ids);
 
 static struct spi_driver altr_a10sr_spi_driver = {
 	.probe = altr_a10sr_spi_probe,
@@ -157,5 +164,6 @@ static struct spi_driver altr_a10sr_spi_driver = {
 		.name = "altr_a10sr",
 		.of_match_table = of_match_ptr(altr_a10sr_spi_of_match),
 	},
+	.id_table = altr_a10sr_spi_ids,
 };
 builtin_driver(altr_a10sr_spi_driver, spi_register_driver)
-- 
2.20.1


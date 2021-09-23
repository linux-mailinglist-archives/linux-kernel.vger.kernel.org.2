Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3A416628
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbhIWTtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242976AbhIWTtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 847966124B;
        Thu, 23 Sep 2021 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426463;
        bh=6fsFE3qESzJsB94f3sBMq4fzMOeEYgAy1pgai51I4D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmJKCD4mfB+MnDtk1PQ+K0y/NpRrNd4mVQsI8MKbYX9hp8lui4+HsrIqO9pffhFJv
         UhbYaXxv+m39AQmcQ1J3lI/1xQz/9wrTfPGnXB20/ehe4+vqwtbu43mKFfIsGbfYOi
         WUT5fse7stJDSCPrMd1jEBsKm153NMC3MZK4am9yI5bjSQMIaiovdBTdS6yIpOWCIR
         c3NK2ADscLGhv3CBsNsJaQvynGCg0EXOySQI4a3GlYjdBcvTmNWRXLdPLluGQDB+uQ
         Lw7trOq3eLlNauZn2P21WrEYxs97NaEoC8iT+b232zJLnJtxIxTRkbiKLWixhA6yOd
         JHkM6hk1zJl6A==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH v1 1/4] mfd: altr_a10sr: Add SPI device ID table
Date:   Thu, 23 Sep 2021 20:46:42 +0100
Message-Id: <20210923194645.53046-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923194645.53046-1-broonie@kernel.org>
References: <20210923194645.53046-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; h=from:subject; bh=6fsFE3qESzJsB94f3sBMq4fzMOeEYgAy1pgai51I4D4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNmhyN6Ws6lys8/PwH31ycQLeBMzfkRWHP0eHy0y e3eKVFGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZoQAKCRAk1otyXVSH0GfFB/ 4yHIIPJDN+k8Yz0snED23pTskHlfrNLDuMsFjJsjWwiqzdTD7ZG+EGYdd9rqcbY1tmF85jtMyCbJ1I ZAEdiVBBRyySb71y677Jpy43Sh/gYS14gnd/gxxRbkwRxNhiFVkv5oqEsj1qmN8ZZcBUGsmTB14RXK gKu6+QR+Aa2ATnibyjazkdQ2JawIty4wE1oxpb+v2AKJ3x1/gzuGnGg0GQNz5fNrbdjjvdQihmTRmP mHICY+5mD0yXRaVeYcH6zMLoYyaH+et1k4YJPri/LzOVURAPtRcf92lYRqnlwgjZjhcTZcdGJ8m2ja ytSUVtt80Zmw8Xrz7zXUrCR7N5YcaU
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


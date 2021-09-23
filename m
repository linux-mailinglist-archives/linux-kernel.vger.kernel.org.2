Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917D41662B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbhIWTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243014AbhIWTtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1332461241;
        Thu, 23 Sep 2021 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426468;
        bh=Wro8HRfNaaUv8dn7lEX+7BJqhSnnwHjfP70AyIyKW6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dh0ym9/3YMwx+NUfn2vuTTD3kJAJ/8yW2KeBlylJSh3/dIA9LZf7hu5B7JRmGNUnm
         ZcafgvOwNXpokYzor1m1YphL1ZnqFCvsDR5ri5chfOJNwLqCt19PPsGUKDYN5g0Z5Y
         IOg0rIq41y4HUlJgCuzphW1NDbW7yxb7+/jeVru43R0n1vIdnevLNxhv8JhH3CYDjJ
         6ntA0W2Pmo0YE9aLEUFBPa/wroGkuH0inV/vmMefdAPOX9C9+P+glpwHv6yqkv1Iv2
         tBq+f2ruxmGwq/JMmPBSUGxQK69Pw6mP2zsm8tON9ObODnxthxJ+EuM5W0viRn8Mdt
         285DmmDqa/KIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] mfd: cpcap: Add SPI device ID table
Date:   Thu, 23 Sep 2021 20:46:44 +0100
Message-Id: <20210923194645.53046-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923194645.53046-1-broonie@kernel.org>
References: <20210923194645.53046-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=Wro8HRfNaaUv8dn7lEX+7BJqhSnnwHjfP70AyIyKW6I=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNmjoZA8LDI9qdZbdHv2MJq17MrUaXrtk+qDzen0 6ff99PWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZowAKCRAk1otyXVSH0NBKB/ wLW5rVKUfhgVhxRkmBdZJX/VVVLcZuhnSNrepHsrNSO+bg0xyORQ0DS6nUABkZI52vEZJbbh4VJc7l t3sAaKgc4+kS4bg4IzFSthuW/rr8Lh8FSFN+XgPUnWxiXQ9FgfCyjnYSb8Tq8FACnV5/y/oiAV7f+d 4Fx7UnP8xmUwDmeN/ahvPRvXkr2NcC75rPXULKybouqFCCrI9ylEsAtti+d4vMJ62uBJel3uATm6Jt K+8Irwc4UFjI43RJLXC1a+2K6dCDw16+iT8EO90DLctOguNt7VFCGUyERWL29fDK2mSvrXtLn7WFMh nKLM7ol8Ra/pxJ49lwWBF+0DhggmdY
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
 drivers/mfd/motorola-cpcap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 6fb206da2729..265464b5d7cc 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -202,6 +202,13 @@ static const struct of_device_id cpcap_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
 
+static const struct spi_device_id cpcap_spi_ids[] = {
+	{ .name = "cpcap", },
+	{ .name = "6556002", },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
+
 static const struct regmap_config cpcap_regmap_config = {
 	.reg_bits = 16,
 	.reg_stride = 4,
@@ -342,6 +349,7 @@ static struct spi_driver cpcap_driver = {
 		.pm = &cpcap_pm,
 	},
 	.probe = cpcap_probe,
+	.id_table = cpcap_spi_ids,
 };
 module_spi_driver(cpcap_driver);
 
-- 
2.20.1


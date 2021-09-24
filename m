Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFA4176E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbhIXOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346814AbhIXOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86D276127A;
        Fri, 24 Sep 2021 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632494080;
        bh=Wro8HRfNaaUv8dn7lEX+7BJqhSnnwHjfP70AyIyKW6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+VT43reiCT5taF7ZCHadiV7x2xXcBtN8WvvXWyRVdsyl1nwNpva8QKNoiiplAvG8
         CI3xfM9vxqJq9OiNPADK/QNd/J4kamdx0Neu2vGZrD6vi5JCW/IWLaCzK0SoqfSfmO
         r+LAxTw2hwiQ4nb9u5MvRNYeO0LAsbe33+J0oCAMmTvTQggJAge7z2bA76P6vJL07z
         cUArGIKq55yfvx0gm+wy2M+b/7El7e1u7ku5qkgvnmfw8UoZBIpsEuANkYkZk+vfjC
         MrL8GxM4IQtojCmLzKBFxfDUP7hNkbZUU5iO3e3yK999GQDxax4m4acfPJxtzVFStQ
         51HtmhdVFsWtg==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] mfd: cpcap: Add SPI device ID table
Date:   Fri, 24 Sep 2021 15:33:46 +0100
Message-Id: <20210924143347.14721-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924143347.14721-1-broonie@kernel.org>
References: <20210924143347.14721-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=Wro8HRfNaaUv8dn7lEX+7BJqhSnnwHjfP70AyIyKW6I=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTeHIoZA8LDI9qdZbdHv2MJq17MrUaXrtk+qDzen0 6ff99PWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYU3hyAAKCRAk1otyXVSH0PVSB/ 9JoMLZANlSLBzauWyzz2MCTq3DSzjJzz3sZF5ZndCXh+efGkRRW46E3cQImKgeXInph4DYHrcjcFJd VRos38n6vBE0Oi6Vof+7mCzbhFWmtHJVJj8rQsokueQoFbQilxCY7I6vD+grG1Ey1uy+c+8hzojo7m 5U1mHFgehz1B1a+Ws7h2Eixzxvk8Iv3DYni7HUN/xsw35aVw36Fbijadpe7QeNUCXjOZuXNrn99Azk 3KLMr5DOCpKmKQkYA57WgGmG2TjIUdDoujkGr/p731oEgCpQMbwcTMC4bpF7gWgMD1jWQ0KuS9CSDQ Pc/rhXlkzJQaeA4m0ZQ5GWDEV5VVGu
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


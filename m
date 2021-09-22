Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5441500E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhIVSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237039AbhIVSnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11FA610D1;
        Wed, 22 Sep 2021 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632336094;
        bh=ePNZgkAh7yJD7xgSpgg9t9byItKmYv2zs2wtmnpehPo=;
        h=From:To:Cc:Subject:Date:From;
        b=BIQZrvBwhveYE5wvOiVznYTiMOqgBAyMxWNepeNCKyjxooDUrlqh8rMlnuZBAB8nt
         CzE1QPqP7HB/yKglnfCrOAnzgypa3fKrS3eQ1a++u6JEenfb4CNafQ+OZgU2lFGoHl
         Qb1X3xtadfQncqHcaQLv58JwePczCAbS/j6MQHS2jk7FM4lSxgl7tOqLAfWG8Bd6+W
         5/He9wEuA3l9JjZzHqQ9duoWdPz3arw28mue9pnhZAjgIpJIsf8q6sgvsZyGLedGUn
         jTtGDI4/9tzuiAtcVo1ZQLCHcJE01lUKHVkFl7mwFJa3OvlhkEGT5bp1AD3uH5tBC5
         ZdIRxj6NbcslA==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] eeprom: 93xx46: Add SPI device ID table
Date:   Wed, 22 Sep 2021 19:40:48 +0100
Message-Id: <20210922184048.34770-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; h=from:subject; bh=ePNZgkAh7yJD7xgSpgg9t9byItKmYv2zs2wtmnpehPo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhS3ZhxGor71z3pVLgP3MnobWHbFFCJ1ObsHwGmLGY kFeziaqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUt2YQAKCRAk1otyXVSH0LUKB/ 9s9iiidbToJrzCGY9/QUR6Oay73GcYaLhCExD4JlYT2vWgTltOeaDYHM/QHpVrAzdfr/7AMqU0McNH u4tcK6xKAJQK+6hgUhZs7cOgrw1L6w3Zi0ZTofPJgBpuZPQjvMqgROnQxS766cgkTOu0l1MaG48irZ nd0INztJx++MP1i+TR1XDU/ffyO73idd3Nm9nhf6b6Bet3iykQ7mUkDXbvW3PPzSuId3rSdgr8t8i9 ACZrzsvHLLsBWGpMwnP8dtS05jKsn238PTm7AFlRw7/NmGO5xpMDiVV+RrYHF3BZeCC4hEjLcB+uH4 mFErFeWIwOR2IFi1BkCys1u8hClFXF
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
 drivers/misc/eeprom/eeprom_93xx46.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 29d8971ec558..660ee924f8b1 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -406,6 +406,23 @@ static const struct of_device_id eeprom_93xx46_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);
 
+static const struct spi_device_id eeprom_93xx46_spi_ids[] = {
+	{ .name = "eeprom-93xx46",
+	  .driver_data = (kernel_ulong_t)&at93c46_data, },
+	{ .name = "at93c46",
+	  .driver_data = (kernel_ulong_t)&at93c46_data, },
+	{ .name = "at93c46d",
+	  .driver_data = (kernel_ulong_t)&atmel_at93c46d_data, },
+	{ .name = "at93c56",
+	  .driver_data = (kernel_ulong_t)&at93c56_data, },
+	{ .name = "at93c66",
+	  .driver_data = (kernel_ulong_t)&at93c66_data, },
+	{ .name = "93lc46b",
+	  .driver_data = (kernel_ulong_t)&microchip_93lc46b_data, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);
+
 static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 {
 	const struct of_device_id *of_id =
@@ -555,6 +572,7 @@ static struct spi_driver eeprom_93xx46_driver = {
 	},
 	.probe		= eeprom_93xx46_probe,
 	.remove		= eeprom_93xx46_remove,
+	.id_table	= eeprom_93xx46_spi_ids,
 };
 
 module_spi_driver(eeprom_93xx46_driver);
-- 
2.20.1


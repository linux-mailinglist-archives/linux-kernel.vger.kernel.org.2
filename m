Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9741645A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbhIWR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233669AbhIWR1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:27:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8208161090;
        Thu, 23 Sep 2021 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632417940;
        bh=iH1WZKYB5nl+u17U5tboZL+YnRdFI42sn/d58orX49Y=;
        h=From:To:Cc:Subject:Date:From;
        b=rv3o9dTbbAywi+gKF2YHgsIdGF1rIWVf2C1aGfzWyMVV7IP/WsjjPzXtxe+uB6ZdK
         yv//fquK4+NBSk+05Sn4UhRcjLCE849IeV23b98M5+ybcGl91iA86OcnJL/afs4K+t
         CbVWUOI2XWOhMailnobfV8wYJbcF0C7nfoGW+p1f+LowkLClzdYdrrEr9wUDsCmsdB
         LOGAIxcLLZm038lMVuOqLWRkBbol3KViFcEUpkIJYYkDgObwpTXq39QAvX4WwUKx0u
         f6YJEblPnq5Ura8usfBcCwssHQHCsb0YFaeLSKUpfGASAsfWxOXxmv7FraBvmlR1iA
         7yF5w0MVjiXMg==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] eeprom: at25: Add SPI ID table
Date:   Thu, 23 Sep 2021 18:24:53 +0100
Message-Id: <20210923172453.4921-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; h=from:subject; bh=iH1WZKYB5nl+u17U5tboZL+YnRdFI42sn/d58orX49Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTLgHd5nxoCbeSDnMsFrhgklWsfg0BMoOaKtl/Y2L 4ONJU5SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUy4BwAKCRAk1otyXVSH0CVfB/ 4tiNcxJAXy6hvu0gEaH5xYOy5MJUm3e5qYZIJ/CNZ8DBD03pWMnMEEScQ2X7d3vJMYdGOpYdVtaI5k oSndIzradWJJWQrohQXUF13LzpOD/N3tpGLpM0CS7tbdL7Q8SPKy1rwYTeg6lMS3JnF3DYo2+MzaeK qR45XpzBJjzVv0c+ay+8TBqMYGL3fgWi3GZrfz5G9vWXUlcOO67RtD1kAcdQLzPk2vcDRNFTfAARQt 7GmvqWqJe8WpbK5SeLmcGApyEEYIdHeqJxAl3cbPnHlJYS21mDVyipBHb/RU882nVDq2/5+DpOZNb/ 5/eQI+0Js6TPn3hoFFMcT8lw0q8WiX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding an id_table listing the
SPI IDs for everything.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/misc/eeprom/at25.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 4d09b672ac3c..632325474233 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -366,6 +366,13 @@ static const struct of_device_id at25_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at25_of_match);
 
+static const struct spi_device_id at25_spi_ids[] = {
+	{ .name = "at25",},
+	{ .name = "fm25",},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, at25_spi_ids);
+
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
@@ -491,6 +498,7 @@ static struct spi_driver at25_driver = {
 		.dev_groups	= sernum_groups,
 	},
 	.probe		= at25_probe,
+	.id_table	= at25_spi_ids,
 };
 
 module_spi_driver(at25_driver);
-- 
2.20.1


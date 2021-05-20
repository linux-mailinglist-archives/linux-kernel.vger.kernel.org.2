Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2540389D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhETFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:48:52 -0400
Received: from router.aksignal.cz ([62.44.4.214]:55490 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhETFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:48:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id E595645C45;
        Thu, 20 May 2021 07:47:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 39S4qji96cs0; Thu, 20 May 2021 07:47:22 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id DF68645C49;
        Thu, 20 May 2021 07:47:18 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v4 4/4] nvmem: eeprom: at25: export FRAM serial num
Date:   Thu, 20 May 2021 07:47:14 +0200
Message-Id: <20210520054714.8736-5-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports serial number of FRAM in sysfs file named "sernum".
Formatted in hex, each byte separated by space.
Example:
$ cat /sys/class/spi_master/spi0/spi0.0/sernum
a4 36 44 f2 ae 6c 00 00

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: no change here
v3: resend and added more recipients
v4: resend
---
 drivers/misc/eeprom/at25.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 4f6e983c278b..b2cffeb3af2c 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -38,6 +38,7 @@ struct at25_data {
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
 	int has_sernum;
+	char *sernum;
 };

 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -172,6 +173,19 @@ static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
 	return status;
 }

+static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct at25_data *at25;
+	int i;
+
+	at25 = dev_get_drvdata(dev);
+	for (i = 0; i < FM25_SN_LEN; i++)
+		buf += sprintf(buf, "%02x ", at25->sernum[i]);
+	sprintf(--buf, "\n");
+	return (3 * i);
+}
+static DEVICE_ATTR_RO(sernum);
+
 static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at25_data *at25 = priv;
@@ -427,8 +441,13 @@ static int at25_probe(struct spi_device *spi)
 		else
 			at25->chip.flags |= EE_ADDR2;

-		if (id[8])
+		if (id[8]) {
 			at25->has_sernum = 1;
+			at25->sernum = kzalloc(FM25_SN_LEN, GFP_KERNEL);
+			if (!at25->sernum)
+				return -ENOMEM;
+			fm25_aux_read(at25, at25->sernum, FM25_RDSN, FM25_SN_LEN);
+		}
 		else
 			at25->has_sernum = 0;

@@ -467,6 +486,13 @@ static int at25_probe(struct spi_device *spi)
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);

+	/* Export the FM25 serial number */
+	if (at25->has_sernum) {
+		err = device_create_file(&spi->dev, &dev_attr_sernum);
+		if (err)
+			return err;
+	}
+
 	dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
 		 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
 		 (chip.byte_len < 1024) ? "Byte" : "KByte",
--
2.25.1


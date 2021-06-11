Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A523A3B60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFKF3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:29:10 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41506 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhFKF27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:28:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 0912D44421;
        Fri, 11 Jun 2021 07:27:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id QzMiNkoiH-65; Fri, 11 Jun 2021 07:26:59 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id B805144437;
        Fri, 11 Jun 2021 07:26:56 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v9 4/5] nvmem: eeprom: at25: export FRAM serial num
Date:   Fri, 11 Jun 2021 07:26:51 +0200
Message-Id: <20210611052652.7894-5-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports serial number of FRAM in sysfs file named "sernum".
Formatted in hex, each byte separated by space.
Example:
$ cat /sys/class/spi_master/spi0/spi0.0/sernum
ef cd ab 89 67 45 23 01

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: no change here
v3: resend and added more recipients
v4: resend
v5: reworked up on Greg comments: no spaces in string, sysfs done correctly
v6: no change here
v7: moved FM25_SN_LEN, static array, used sysfs_emit, DEVICE_ATTR_RO
v8: clarify sysfs_emit format
v9: sizeof parentheses, export with spaces MSB first
---
 drivers/misc/eeprom/at25.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index e59b6852816d..19280e9f118d 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -31,6 +31,7 @@
  *   AT25M02, AT25128B
  */
 
+#define	FM25_SN_LEN	8		/* serial number length */
 struct at25_data {
 	struct spi_device	*spi;
 	struct mutex		lock;
@@ -38,6 +39,7 @@ struct at25_data {
 	unsigned		addrlen;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
+	u8 sernum[FM25_SN_LEN];
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -171,6 +173,21 @@ static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
 	return status;
 }
 
+static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct at25_data *at25;
+
+	at25 = dev_get_drvdata(dev);
+	return sysfs_emit(buf, "%*ph\n", sizeof(at25->sernum), at25->sernum);
+}
+static DEVICE_ATTR_RO(sernum);
+
+static struct attribute *sernum_attrs[] = {
+	&dev_attr_sernum.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sernum);
+
 static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at25_data *at25 = priv;
@@ -359,6 +376,8 @@ static int at25_probe(struct spi_device *spi)
 	int			err;
 	int			sr;
 	u8 id[FM25_ID_LEN];
+	u8 sernum[FM25_SN_LEN];
+	int i;
 	const struct of_device_id *match;
 	int is_fram = 0;
 
@@ -415,6 +434,13 @@ static int at25_probe(struct spi_device *spi)
 		else
 			at25->chip.flags |= EE_ADDR2;
 
+		if (id[8]) {
+			fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
+			/* swap byte order */
+			for (i = 0; i < FM25_SN_LEN; i++)
+				at25->sernum[i] = sernum[FM25_SN_LEN - 1 - i];
+		}
+
 		at25->chip.page_size = PAGE_SIZE;
 		strncpy(at25->chip.name, "fm25", sizeof(at25->chip.name));
 	}
@@ -465,6 +491,7 @@ static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.of_match_table = at25_of_match,
+		.dev_groups	= sernum_groups,
 	},
 	.probe		= at25_probe,
 };
-- 
2.25.1


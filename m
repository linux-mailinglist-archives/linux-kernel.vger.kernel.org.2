Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58CE39DC53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFGM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:28:51 -0400
Received: from router.aksignal.cz ([62.44.4.214]:45936 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFGM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:28:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 1D98048119;
        Mon,  7 Jun 2021 14:26:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id ATvTfuF5cDQC; Mon,  7 Jun 2021 14:26:53 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 63A384811D;
        Mon,  7 Jun 2021 14:26:46 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
Date:   Mon,  7 Jun 2021 14:26:39 +0200
Message-Id: <20210607122640.143582-5-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports serial number of FRAM in sysfs file named "sernum".
Formatted in hex, each byte separated by space.
Example:
$ cat /sys/class/spi_master/spi0/spi0.0/sernum
0000a43644f2ae6c

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: no change here
v3: resend and added more recipients
v4: resend
v5: reworked up on Greg comments: no spaces in string, sysfs done correctly
v6: no change here
v7: moved FM25_SN_LEN, static array, used sysfs_emit, DEVICE_ATTR_RO
---
 drivers/misc/eeprom/at25.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 3b7ffef1f0d7..a28dfd7e1798 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -31,6 +31,7 @@
  *   AT25M02, AT25128B
  */
 
+#define	FM25_SN_LEN	8		/* serial number length */
 struct at25_data {
 	struct spi_device	*spi;
 	struct mutex		lock;
@@ -39,6 +40,7 @@ struct at25_data {
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
 	int has_sernum;
+	u8 sernum[FM25_SN_LEN];
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -172,6 +174,21 @@ static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
 	return status;
 }
 
+static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct at25_data *at25;
+
+	at25 = dev_get_drvdata(dev);
+	return sysfs_emit(buf, "%016llx\n", *(unsigned long long *)at25->sernum);
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
@@ -416,8 +433,10 @@ static int at25_probe(struct spi_device *spi)
 		else
 			at25->chip.flags |= EE_ADDR2;
 
-		if (id[8])
+		if (id[8]) {
 			at25->has_sernum = 1;
+			fm25_aux_read(at25, at25->sernum, FM25_RDSN, FM25_SN_LEN);
+		}
 		else
 			at25->has_sernum = 0;
 
@@ -471,6 +490,7 @@ static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.of_match_table = at25_of_match,
+		.dev_groups	= sernum_groups,
 	},
 	.probe		= at25_probe,
 };
-- 
2.25.1


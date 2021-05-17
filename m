Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED95A383B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbhEQRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243616AbhEQRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:35:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A8C061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j12so5133642pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpbIQzkfbixUlRA8bBdjOWnojgoIaGzYZDD6NB2StNA=;
        b=MErJUk2YilS2O5yCjGNY6zmAVy9t/FQHdD0Xejlb7DqIpgjNxQXe3sTk/OKiVmFY8t
         ZgaPVZJdyqYWE3NjyOvl7/1XqmCEvTXHW9qYV/a/UR/e3cpvVLneACsj5K+g1cJI+Bb/
         Vg54Jzmlf26YCbFHoR0PiwwnbaH+rnXoet6VmWt9No6pEg4tSb0DL1Mky6pQJE+IAwVS
         qxlo8/IB5cz8cxgjJvlK6V8fOz6ozZ25+DBMdcNPLZEZZxsRFQauK7oI5VOl7YkvGMcW
         JRvWolWc1BDAeSF5t1hHCwFxDvzw2Sa4ibJKkwFMCMfiwHdCQxxbZ607ZvGS+7wwWYXj
         6fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpbIQzkfbixUlRA8bBdjOWnojgoIaGzYZDD6NB2StNA=;
        b=NtAY47u6d1Evv/0UA9SdDBx5qkBIKY169sENZXqZKDKmZtf8iaCOklJ1us4KVmnW6I
         mxRRYoSLFPwjWmgHbmTAY3m/vYHbym29ZtXXZCR88YfoTg9cOfs1uiVyVWp4Bz6CkhEr
         Dws6Majp6HWrSVVBF3T5jwDQIdHFX1LgP9Rw7ablrPomAImTefj+AYsIICM7Rpaz6nv9
         6hAXfnJmnvuYaJFBbFnRbOCHUM4KERUo3yzS2cu9Itm4Vw1dg3+1ECmVYh4bX+Hux96s
         4+tq12BXMzz5ImDnD8TjlQtBjEYDcsEDCqk4R1+lrrnpc6umNI3d+EbJlhdZ5tvtjSik
         SpFQ==
X-Gm-Message-State: AOAM531sljIbsTG8hZ5nBUWf/4bXXZFi6l1vIzWrKqrVrM0RowZ7LPw+
        Pn8sfkzLgZifvmpURmcN2io=
X-Google-Smtp-Source: ABdhPJyCPxqBfiTeb2OagfXjAVy6G3QWCkLAQzqLlg7mSqih2gisSpcxbFjEb90UGLEPw3XVw8RVcg==
X-Received: by 2002:a63:4559:: with SMTP id u25mr641581pgk.93.1621272832364;
        Mon, 17 May 2021 10:33:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:52 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 10/10] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Tue, 18 May 2021 01:33:14 +0800
Message-Id: <20210517173314.140912-11-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Merge different sub-devices I2C read/write functions into one Regmap,
because PMIC and LDO part need CRC bits for access protection.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig       |   1 +
 drivers/mfd/mt6360-core.c | 203 +++++++++++++++++++++++++++++++++-----
 2 files changed, 181 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..143715e22ca2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -902,6 +902,7 @@ config MFD_MT6360
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select CRC8
 	depends on I2C
 	help
 	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index a4c705c8dd68..e628953548ce 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -63,6 +63,18 @@ struct mt6360_ddata {
 
 #define MT6360_CRC8_POLYNOMIAL		0x7
 
+#define MT6360_CRC_I2C_ADDR_SIZE	1
+#define MT6360_CRC_REG_ADDR_SIZE	1
+/* prealloca read size = i2c device addr + i2c reg addr + val ... + crc8 */
+#define MT6360_ALLOC_READ_SIZE(_size)	(_size + 3)
+/* prealloca write size = i2c device addr + i2c reg addr + val ... + crc8 + dummy byte */
+#define MT6360_ALLOC_WRITE_SIZE(_size)	(_size + 4)
+#define MT6360_CRC_PREDATA_OFFSET	(MT6360_CRC_I2C_ADDR_SIZE + MT6360_CRC_REG_ADDR_SIZE)
+#define MT6360_CRC_CRC8_SIZE		1
+#define MT6360_CRC_DUMMY_BYTE_SIZE	1
+#define MT6360_REGMAP_REG_BYTE_SIZE	2
+#define I2C_ADDR_XLATE_8BIT(_addr, _rw)	(((_addr & 0x7F) << 1) + _rw)
+
 /* reg 0 -> 0 ~ 7 */
 #define MT6360_CHG_TREG_EVT		4
 #define MT6360_CHG_AICR_EVT		5
@@ -267,12 +279,6 @@ static const struct regmap_irq_chip mt6360_irq_chip = {
 	.use_ack = true,
 };
 
-static const struct regmap_config mt6360_pmu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = MT6360_PMU_MAXREG,
-};
-
 static const struct resource mt6360_adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
 };
@@ -359,10 +365,160 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 }
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-	MT6360_PMU_SLAVEID,
+	MT6360_TCPC_SLAVEID,
 	MT6360_PMIC_SLAVEID,
 	MT6360_LDO_SLAVEID,
-	MT6360_TCPC_SLAVEID,
+	MT6360_PMU_SLAVEID,
+};
+
+static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
+{
+	/* Address is already in encoded [5:0] */
+	*addr &= MT6360_ADDRESS_MASK;
+
+	switch (rw_size) {
+	case 1:
+		*addr |= MT6360_DATA_SIZE_1_BYTE;
+		break;
+	case 2:
+		*addr |= MT6360_DATA_SIZE_2_BYTES;
+		break;
+	case 3:
+		*addr |= MT6360_DATA_SIZE_3_BYTES;
+		break;
+	case 4:
+		*addr |= MT6360_DATA_SIZE_4_BYTES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
+			      void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)reg;
+	u8 reg_addr = *(u8 *)(reg + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	int buf_len = MT6360_ALLOC_READ_SIZE(val_size);
+	int read_size = val_size;
+	u8 crc;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
+		if (ret < 0)
+			return ret;
+		read_size += MT6360_CRC_CRC8_SIZE;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_READ);
+	buf[1] = reg_addr;
+
+	ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size,
+					    buf + MT6360_CRC_PREDATA_OFFSET);
+	if (ret < 0)
+		goto out;
+	else if (ret != read_size) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (crc_needed) {
+		crc = crc8(ddata->crc8_tbl, buf, val_size + MT6360_CRC_PREDATA_OFFSET, 0);
+		if (crc != buf[val_size + MT6360_CRC_PREDATA_OFFSET]) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	memcpy(val, buf + MT6360_CRC_PREDATA_OFFSET, val_size);
+out:
+	kfree(buf);
+	return (ret < 0) ? ret : 0;
+}
+
+static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)val;
+	u8 reg_addr = *(u8 *)(val + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	int buf_len = MT6360_ALLOC_WRITE_SIZE(val_size);
+	int write_size = val_size - MT6360_REGMAP_REG_BYTE_SIZE;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size - MT6360_REGMAP_REG_BYTE_SIZE);
+		if (ret < 0)
+			return ret;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_WRITE);
+	buf[1] = reg_addr;
+	memcpy(buf + MT6360_CRC_PREDATA_OFFSET, val + MT6360_REGMAP_REG_BYTE_SIZE, write_size);
+
+	if (crc_needed) {
+		buf[val_size] = crc8(ddata->crc8_tbl, buf, val_size, 0);
+		write_size += (MT6360_CRC_CRC8_SIZE + MT6360_CRC_DUMMY_BYTE_SIZE);
+	}
+
+	ret = i2c_smbus_write_i2c_block_data(i2c, reg_addr, write_size,
+					     buf + MT6360_CRC_PREDATA_OFFSET);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_bus mt6360_regmap_bus = {
+	.read		= mt6360_regmap_read,
+	.write		= mt6360_regmap_write,
+
+	/* Due to PMIC and LDO CRC access size limit */
+	.max_raw_read	= 4,
+	.max_raw_write	= 4,
+};
+
+static bool mt6360_is_readwrite_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MT6360_REG_TCPCSTART ... MT6360_REG_TCPCEND:
+		fallthrough;
+	case MT6360_REG_PMICSTART ... MT6360_REG_PMICEND:
+		fallthrough;
+	case MT6360_REG_LDOSTART ... MT6360_REG_LDOEND:
+		fallthrough;
+	case MT6360_REG_PMUSTART ... MT6360_REG_PMUEND:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config mt6360_regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= 8,
+	.reg_format_endian	= REGMAP_ENDIAN_BIG,
+	.max_register		= MT6360_REG_PMUEND,
+	.writeable_reg		= mt6360_is_readwrite_reg,
+	.readable_reg		= mt6360_is_readwrite_reg,
 };
 
 static int mt6360_probe(struct i2c_client *client)
@@ -377,7 +533,22 @@ static int mt6360_probe(struct i2c_client *client)
 	ddata->dev = &client->dev;
 	i2c_set_clientdata(client, ddata);
 
-	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	for (i = 0; i < MT6360_SLAVE_MAX - 1; i++) {
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+							  client->adapter,
+							  mt6360_slave_addr[i]);
+		if (IS_ERR(ddata->i2c[i])) {
+			dev_err(&client->dev,
+				"Failed to get new dummy I2C device for address 0x%x",
+				mt6360_slave_addr[i]);
+			return PTR_ERR(ddata->i2c[i]);
+		}
+	}
+	ddata->i2c[MT6360_SLAVE_MAX - 1] = client;
+
+	crc8_populate_msb(ddata->crc8_tbl, MT6360_CRC8_POLYNOMIAL);
+	ddata->regmap = devm_regmap_init(ddata->dev, &mt6360_regmap_bus, ddata,
+					 &mt6360_regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
 		return PTR_ERR(ddata->regmap);
@@ -395,20 +566,6 @@ static int mt6360_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ddata->i2c[0] = client;
-	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
-							client->adapter,
-							mt6360_slave_addr[i]);
-		if (IS_ERR(ddata->i2c[i])) {
-			dev_err(&client->dev,
-				"Failed to get new dummy I2C device for address 0x%x",
-				mt6360_slave_addr[i]);
-			return PTR_ERR(ddata->i2c[i]);
-		}
-		i2c_set_clientdata(ddata->i2c[i], ddata);
-	}
-
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
 				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
 				   0, regmap_irq_get_domain(ddata->irq_data));
-- 
2.25.1


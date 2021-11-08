Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C089449B86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhKHSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhKHSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:19:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C0C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:16:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o17so1581991qtk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpTqRwsl5N8HDJPao89PDMQwyOdkk8Pyj5oDHvhtU8Q=;
        b=v61NbS6vGIzMCmff/XzXFnMfa8gO7JyIJBYAtOE0I1jpTiFcIniZv5tf4r+VHOOcBk
         cdZba46PzU3v1F8FDEQrNszOWI9ipttIT+T10TvJPX3ramxmzFYDJsqDp3+WwqBL0ELp
         7IRm4vfyAXYX42GMdqkO4TaI7lkaZ50rwfvund9Je/ZOAbdFL1SYzN1TWBDyiRpmIamc
         /PHnW34kJnCnyZyOPi0h8SSvf4hOJooepAg2nBXMGIbXhdL1dynA7Gt4ZhCQanhwj2v5
         zX3DM9v+FOP42RtpxBEBsQ/bDp+V6CkeUw6DvhQbDx+cb9JCqI9DlVSywPxw95c8F+je
         tw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpTqRwsl5N8HDJPao89PDMQwyOdkk8Pyj5oDHvhtU8Q=;
        b=W1IlmqjUpV0Ar38/RYexxcalWyCE8i2ndunOR1U/zKNwg4KgU/WPyR0JzZ6qJiEoGo
         gL1ORcNZcgV/xKshEBUqNyDDsoAZhYOa+kfeo39xg1kRYoQtjHxQkbjdl0R6/45RLcG2
         BLP8cPujm6ImlPS1Kaut4hMkcRUfxX1kTcwFGwpffH0UFERpb3FAwin0ce3PR09Qsi3x
         4/muX3nJSIlCEvT3L4GGkbYaBBWfGb5/fJFAuwV9yS4bbeErTiVkbfJrUF3KcNhQSvZY
         gco5nxmsv59YKGa8d1urouVcUcSQKOoULiP+6PX9eje7SckoD8CDZYrxiL7IJreymnXI
         Ehlw==
X-Gm-Message-State: AOAM533QIR9l5KQv3JsE70OxnJiKZNh2rJDvy7yCjs1KfMwtn+MuclXX
        ClsNaFAIDp23MHxWwwVq3BnLBw==
X-Google-Smtp-Source: ABdhPJz+cTXM0s+iiK1He8woMMpJXUeWn4sDL4Oi2/eV9pMs63FebOnxwtboHqfgTXTAkpQCARfcVA==
X-Received: by 2002:a05:622a:1d5:: with SMTP id t21mr1622135qtw.382.1636395393007;
        Mon, 08 Nov 2021 10:16:33 -0800 (PST)
Received: from maple.netwinder.org (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id m7sm6454244qkn.93.2021.11.08.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:16:32 -0800 (PST)
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jiri.prchal@aksignal.cz,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2] nvmem: eeprom: at25: fix FRAM byte_len
Date:   Mon,  8 Nov 2021 13:16:27 -0500
Message-Id: <20211108181627.645638-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028134922.3965612-1-ralph.siemsen@linaro.org>
References: <20211028134922.3965612-1-ralph.siemsen@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fd307a4ad332 ("nvmem: prepare basics for FRAM support") added
support for FRAM devices such as the Cypress FM25V. During testing, it
was found that the FRAM detects properly, however reads and writes fail.
Upon further investigation, two problem were found in at25_probe() routine.

1) In the case of an FRAM device without platform data, eg.
       fram == true && spi->dev.platform_data == NULL
the stack local variable "struct spi_eeprom chip" is not initialized
fully, prior to being copied into at25->chip. The chip.flags field in
particular can cause problems.

2) The byte_len of FRAM is computed from its ID register, and is stored
into the stack local "struct spi_eeprom chip" structure. This happens
after the same structure has been copied into at25->chip. As a result,
at25->chip.byte_len does not contain the correct length of the device.
In turn this can cause checks at beginning of at25_ee_read() to fail
(or equally, it could allow reads beyond the end of the device length).

Fix both of these issues by eliminating the on-stack struct spi_eeprom.
Instead use the one inside at25_data structure, which starts of zeroed.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
V1 -> V2: refactor to eliminate on-stack copy of "chip" structure

 drivers/misc/eeprom/at25.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 632325474233..b38978a3b3ff 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -376,7 +376,6 @@ MODULE_DEVICE_TABLE(spi, at25_spi_ids);
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
-	struct spi_eeprom	chip;
 	int			err;
 	int			sr;
 	u8 id[FM25_ID_LEN];
@@ -389,15 +388,18 @@ static int at25_probe(struct spi_device *spi)
 	if (match && !strcmp(match->compatible, "cypress,fm25"))
 		is_fram = 1;
 
+	at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
+	if (!at25)
+		return -ENOMEM;
+
 	/* Chip description */
-	if (!spi->dev.platform_data) {
-		if (!is_fram) {
-			err = at25_fw_to_chip(&spi->dev, &chip);
-			if (err)
-				return err;
-		}
-	} else
-		chip = *(struct spi_eeprom *)spi->dev.platform_data;
+	if (spi->dev.platform_data) {
+		memcpy(&at25->chip, spi->dev.platform_data, sizeof(at25->chip));
+	} else if (!is_fram) {
+		err = at25_fw_to_chip(&spi->dev, &at25->chip);
+		if (err)
+			return err;
+	}
 
 	/* Ping the chip ... the status register is pretty portable,
 	 * unlike probing manufacturer IDs.  We do expect that system
@@ -409,12 +411,7 @@ static int at25_probe(struct spi_device *spi)
 		return -ENXIO;
 	}
 
-	at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
-	if (!at25)
-		return -ENOMEM;
-
 	mutex_init(&at25->lock);
-	at25->chip = chip;
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
 
@@ -431,7 +428,7 @@ static int at25_probe(struct spi_device *spi)
 			dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
 			return -ENODEV;
 		}
-		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+		at25->chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
 
 		if (at25->chip.byte_len > 64 * 1024)
 			at25->chip.flags |= EE_ADDR3;
@@ -464,7 +461,7 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.type = is_fram ? NVMEM_TYPE_FRAM : NVMEM_TYPE_EEPROM;
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
-	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
+	at25->nvmem_config.read_only = at25->chip.flags & EE_READONLY;
 	at25->nvmem_config.root_only = true;
 	at25->nvmem_config.owner = THIS_MODULE;
 	at25->nvmem_config.compat = true;
@@ -474,17 +471,18 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.priv = at25;
 	at25->nvmem_config.stride = 1;
 	at25->nvmem_config.word_size = 1;
-	at25->nvmem_config.size = chip.byte_len;
+	at25->nvmem_config.size = at25->chip.byte_len;
 
 	at25->nvmem = devm_nvmem_register(&spi->dev, &at25->nvmem_config);
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);
 
 	dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
-		 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
-		 (chip.byte_len < 1024) ? "Byte" : "KByte",
+		 (at25->chip.byte_len < 1024) ?
+			at25->chip.byte_len : (at25->chip.byte_len / 1024),
+		 (at25->chip.byte_len < 1024) ? "Byte" : "KByte",
 		 at25->chip.name, is_fram ? "fram" : "eeprom",
-		 (chip.flags & EE_READONLY) ? " (readonly)" : "",
+		 (at25->chip.flags & EE_READONLY) ? " (readonly)" : "",
 		 at25->chip.page_size);
 	return 0;
 }
-- 
2.25.1


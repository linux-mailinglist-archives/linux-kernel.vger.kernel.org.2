Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7640A43E297
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJ1Nwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhJ1NwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:52:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0CC061226
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:49:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r2so4458891qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TNHT+XtxGt7Pj6EGkbe6GYkL2KA5e1SLKKvZ3jL2xI=;
        b=xRnfJxaZc7aaNs28zpMGTlD47tit7ezTMQ7BEqowby/aaxFKyHBZ7/Db6QAVeAaDX8
         2IdtKheBIvHiDWAutYV8L6yUtP4Ka5Xq5ufKUsMw14tZlaLfrHs2g0qkqdtmoIu4LlF4
         zCH2hig2L1aEAOod68nV9G7fqRzGtK/lwlc5Iav8u1IGjyyutP9gJqg8pFvCz1z62xwD
         I3f+91mxSWY/6DJOATv15LoUab6yqiYIxFsJtshHOGdAwjQMpprE2g9rQlrSo5BdvnrW
         jowyveYNJnufSkXqxUNYAUJt55JxmFUunXSXKtSuQHGmICJMB9BNgBBMLODmv4igB/N1
         GA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TNHT+XtxGt7Pj6EGkbe6GYkL2KA5e1SLKKvZ3jL2xI=;
        b=W4JiVBbQTp4QiKF7eabg7WUqj0sAMGhuHSM78/+lxoShe3rW2ZxTHUzy0JyNpJc0Cy
         jVs83PLZYPW6+eYyBuIVWILnrg58uIpx8qnKSzkUNqNB3EMN3vI97DrHdFnrSG1fnUHI
         TOiAzrh7um2KTU7PC0kmL0QX8rjeCcnba1pVs52RQwkihsr8RSLcbcRlkkJIfjK9WjCT
         EPiB8Ci/fRU1efbaE583JaEAJStY+J/jV6YKub6akPPxx8oR147ZHW0izd2vn1pDXDgh
         mG5SMbT0xbhbJCng1hPQDveeB4E+GHERFPtv54mrmxMWDdvUtlfaxM8qCOTQZDN+zfXM
         dlMA==
X-Gm-Message-State: AOAM532dkgGlpgBPInDwDTzA3yI2c3N1JKlgOoImlYiObBohXD7lx/OL
        ITlz4WMF7gknlXJaf2D8q0zuog==
X-Google-Smtp-Source: ABdhPJyWwoEESZiwcY8pdh9ik191tsPt10istWMC3Sqfb2ydRk3fkWizMfSy5eEOix/CUayxY/HDdA==
X-Received: by 2002:ac8:7fd5:: with SMTP id b21mr4836172qtk.101.1635428984736;
        Thu, 28 Oct 2021 06:49:44 -0700 (PDT)
Received: from maple.netwinder.org (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id h20sm2071219qtx.10.2021.10.28.06.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:49:44 -0700 (PDT)
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jiri.prchal@aksignal.cz,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH] nvmem: eeprom: at25: fix byte_len for FRAM
Date:   Thu, 28 Oct 2021 09:49:22 -0400
Message-Id: <20211028134922.3965612-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
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
the stack local variable "struct spi_eeprom chip" is never initialized.
This structure is copied into at25->chip, which is used subsequently.
Fix this by an explicit memset(), similar to existing at25_fw_to_chip().

2) The size of FRAM is computed from its ID register, and is stored into
the stack local "struct spi_eeprom chip" structure. This happens after
the same structure has been copied into at25->chip. As a result,
at25->chip.byte_len does not contain the correct length of the device.
In turn this can cause checks at beginning of at25_ee_read() to fail
(or equally, it could allow reads beyond the end of the device length).

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/misc/eeprom/at25.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 632325474233..65cfb10fa0b7 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -395,6 +395,8 @@ static int at25_probe(struct spi_device *spi)
 			err = at25_fw_to_chip(&spi->dev, &chip);
 			if (err)
 				return err;
+		} else {
+			memset(&chip, 0, sizeof(chip));
 		}
 	} else
 		chip = *(struct spi_eeprom *)spi->dev.platform_data;
@@ -432,6 +434,7 @@ static int at25_probe(struct spi_device *spi)
 			return -ENODEV;
 		}
 		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+		at25->chip.byte_len = chip.byte_len;
 
 		if (at25->chip.byte_len > 64 * 1024)
 			at25->chip.flags |= EE_ADDR3;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550F0356129
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbhDGB7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbhDGB7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:59:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C839C06174A;
        Tue,  6 Apr 2021 18:59:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p10so3409474pld.0;
        Tue, 06 Apr 2021 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+oS/s6zW1zzjEa2tq0vPHSf5k7qMGZTKryan1c3vFA=;
        b=ctZzWAUIeCXVkTfht43D5UEIYDM+5noNEL8bgX4jKfX+fftg4hOdYxF+DVtybUaSIj
         uaA4CZJA4zNdaXX8i9DFzPWleDWTS4SIrOVVTJwV1EkDlzFfybyZyEsZlfgbWliooh0t
         Y4kYQ1WpitTJp1857C785YjdTP/MHAnKGibqKLCnNJkj/5gMoD3clzPA2e5/o2zCYEo/
         hBFa+8GZY2nU2HQuq+MSv9DTbX8eGQs+X2zr155bLlwxBKNOVQmkiDSXU7Wt9dn0D70J
         VNfVFv5D/kRxUe0gF0tFR94GD7BeYIf3v6r91VNrNht0XLX3FXJcyDaz27LyHaJlteQ1
         BatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+oS/s6zW1zzjEa2tq0vPHSf5k7qMGZTKryan1c3vFA=;
        b=tPNhJuaWmBiChjc2JHsFx6Cx6Q/+HdceYDrRjf3dox0JlFMk5BRTI8zLGSA4kIjs2a
         pYoJ3maz1r/QZTd2SvvH8cTw3jndW4+PyNaNBAYQfa50xq1IG6shppUq44XubZiYU/vx
         iASZNhQYS/wQVCly4O4iYbUpUCP4dHzJcuoIQf6scdUoKmuOOyRHZq7CZqcykP0XD8BA
         LETagnP+1d6sLWC4ZgvZ7SaAKq7XwpaPS50QqDuAAzsYrDvf8Xq5trqAk0jJg9wl3QIM
         B6uuHIPCgIRCwI4vWy9M2glGPvrbb6tPb4MgKU9Cd298MksDSROpScGkYBr2bhs7mKxy
         IMuA==
X-Gm-Message-State: AOAM53124Rz1oSpjjPdSdpfSCShwaygWZ9tSvySU6R/xiOzFjpBSfJda
        88iGqJh8cHWamNRpW1quVsM=
X-Google-Smtp-Source: ABdhPJx2D85iEB7l6n84BmvOUeiGDNuspqlO7d17nsRhOxWac63+pAVxqwdHP1mXEzhR4u+tH7KaHw==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id y5-20020a170902d645b02900e8ec90d097mr996545plh.47.1617760755315;
        Tue, 06 Apr 2021 18:59:15 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id b186sm19987693pfb.170.2021.04.06.18.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 18:59:14 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Renius.Chen@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH] mmc: sdhci-pci-gli: Improve L1 entry delay to increase battery life
Date:   Wed,  7 Apr 2021 10:02:11 +0800
Message-Id: <20210407020211.5989-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Although there is the best performance at the maximum delay.
Change the value to 20us in order to have better power consumption.
This change may reduce the maximum performance by 10%.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4a0f69b97a78..3b0a049d4124 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -90,7 +90,7 @@
 
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
+#define   GLI_9763E_CFG2_L1DLY_MID 0x50
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -802,8 +802,8 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
 	value &= ~GLI_9763E_CFG2_L1DLY;
-	/* set ASPM L1 entry delay to 260us */
-	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
+	/* set ASPM L1 entry delay to 20us */
+	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
-- 
2.30.0


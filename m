Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B571D32BF1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577805AbhCCSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359729AbhCCOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37697C0613BE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so23992899wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzboMeGsvBVDTSqmL3mV6e6l8GqozBpIfKeksb4g5kA=;
        b=YHkspBQQ+39QTR0mZ+hTCWl23QI8cmDaM7sJJmbKHgwkIQAxZ/6CixJ0LpZxwmvMl/
         0lv4xqrrilnI9Zxl5fJShO5FDsLSm7Pqy89cFahNAgLa/jofVwDJTigG21l7oRmakU/M
         WGUTwTe3rmkRA4vpHd0uoP1vc7QVibqNs4D+N/8IXqCxtmmq5AIl6Bd9TPPAiNB2T17d
         EIk8E8mfieDFe+WtTAqwV5E6CYWYgQtUUOJcR8YWUvE/1fsYvprFTSvOqAkhBFJ5/AKk
         rDRjfKHIEVM/HRDTAmcHDRU/gR9/WNqbHD062ac17p5A/oK+1MvwBHRDguT5KS107CQO
         2jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzboMeGsvBVDTSqmL3mV6e6l8GqozBpIfKeksb4g5kA=;
        b=LiwLEXjYND4zCoQ8R5PsnlVnHqqMR9p8Nq3jlCVl7UD/UPnfuKb9kQ12Y9wV4mznPv
         OnTlcsLtFSvktDPPkfvdgyzhBBHA/Ba/uO/dXyhegjeX6GWSpF+G6kt2qjs1SDx9gIq2
         hspmciMkF2OD0YknJOrEcnfQHowzaHFU7o6uDRJ8fmB4jv4crDAXTxwTcDvFHhMFTFUW
         hkyMQTuoaCL/MGvSPE8ewVObuUeeoQi1clcPnCeQaUiproVgN5kacuYuqkiATLlCGIhF
         1IZm+s4tkoIvhR3VzCxtkPdk3loJOBYkQn5Dplo5VYff8YLROnBjl7P09AtCC+V5EROs
         9S7Q==
X-Gm-Message-State: AOAM532m38i/dtprrs30DYuKjY4jar1rFCAZ5PkdUfHLXQ8zG6Z1K4w/
        g/3fKOOvVHpfpddo4cVWPewWdw==
X-Google-Smtp-Source: ABdhPJw8noLs57ZQV8IKy3ecX1MyBIzUpkPiAEVpk3Q6N3xq05oll6q3quvNKVy+57RMtglsew1LQQ==
X-Received: by 2002:adf:c101:: with SMTP id r1mr27901802wre.38.1614782859933;
        Wed, 03 Mar 2021 06:47:39 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 22/30] scsi: pm8001: pm80xx_hwi: Fix a bunch of doc-rotted function headers
Date:   Wed,  3 Mar 2021 14:46:23 +0000
Message-Id: <20210303144631.3175331-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm80xx_hwi.c:1427: warning: expecting prototype for pm8001_chip_init(). Prototype was for pm80xx_chip_init() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:1584: warning: expecting prototype for pm8001_chip_soft_rst(). Prototype was for pm80xx_chip_soft_rst() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:1711: warning: expecting prototype for pm8001_chip_interrupt_enable(). Prototype was for pm80xx_chip_intx_interrupt_enable() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:1722: warning: expecting prototype for pm8001_chip_intx_interrupt_disable(). Prototype was for pm80xx_chip_intx_interrupt_disable() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:1733: warning: expecting prototype for pm8001_chip_interrupt_enable(). Prototype was for pm80xx_chip_interrupt_enable() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:1752: warning: expecting prototype for pm8001_chip_interrupt_disable(). Prototype was for pm80xx_chip_interrupt_disable() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:4192: warning: expecting prototype for pm8001_chip_smp_req(). Prototype was for pm80xx_chip_smp_req() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:4775: warning: expecting prototype for pm8001_chip_phy_stop_req(). Prototype was for pm80xx_chip_phy_stop_req() instead
 drivers/scsi/pm8001/pm80xx_hwi.c:4907: warning: expecting prototype for pm8001_chip_isr(). Prototype was for pm80xx_chip_isr() instead

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 84315560e8e1a..74ed072209f47 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1420,7 +1420,7 @@ static int pm80xx_encrypt_update(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_init - the main init function that initialize whole PM8001 chip.
+ * pm80xx_chip_init - the main init function that initialize whole PM8001 chip.
  * @pm8001_ha: our hba card information
  */
 static int pm80xx_chip_init(struct pm8001_hba_info *pm8001_ha)
@@ -1574,7 +1574,7 @@ pm80xx_fatal_errors(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_soft_rst - soft reset the PM8001 chip, so that the clear all
+ * pm80xx_chip_soft_rst - soft reset the PM8001 chip, so that the clear all
  * the FW register status to the originated status.
  * @pm8001_ha: our hba card information
  */
@@ -1703,7 +1703,7 @@ static void pm80xx_hw_chip_rst(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
+ * pm80xx_chip_intx_interrupt_enable - enable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  */
 static void
@@ -1714,7 +1714,7 @@ pm80xx_chip_intx_interrupt_enable(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_intx_interrupt_disable- disable PM8001 chip interrupt
+ * pm80xx_chip_intx_interrupt_disable - disable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  */
 static void
@@ -1724,7 +1724,7 @@ pm80xx_chip_intx_interrupt_disable(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
+ * pm80xx_chip_interrupt_enable - enable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  * @vec: interrupt number to enable
  */
@@ -1743,7 +1743,7 @@ pm80xx_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 }
 
 /**
- * pm8001_chip_interrupt_disable- disable PM8001 chip interrupt
+ * pm80xx_chip_interrupt_disable - disable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  * @vec: interrupt number to disable
  */
@@ -4183,7 +4183,7 @@ static void build_smp_cmd(u32 deviceID, __le32 hTag,
 }
 
 /**
- * pm8001_chip_smp_req - send a SMP task to FW
+ * pm80xx_chip_smp_req - send a SMP task to FW
  * @pm8001_ha: our hba card information.
  * @ccb: the ccb information this request used.
  */
@@ -4766,7 +4766,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 }
 
 /**
- * pm8001_chip_phy_stop_req - start phy via PHY_STOP COMMAND
+ * pm80xx_chip_phy_stop_req - start phy via PHY_STOP COMMAND
  * @pm8001_ha: our hba card information.
  * @phy_id: the phy id which we wanted to start up.
  */
@@ -4898,7 +4898,7 @@ static u32 pm80xx_chip_is_our_interrupt(struct pm8001_hba_info *pm8001_ha)
 }
 
 /**
- * pm8001_chip_isr - PM8001 isr handler.
+ * pm80xx_chip_isr - PM8001 isr handler.
  * @pm8001_ha: our hba card information.
  * @vec: irq number.
  */
-- 
2.27.0


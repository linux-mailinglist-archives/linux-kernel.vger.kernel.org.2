Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5F32BF25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577884AbhCCSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359646AbhCCOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39DC0613B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e23so5395172wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZLBI/8SqO3lQnkC11OaIHS0M/CameoMxsEwafnsB1c=;
        b=sV0WJ5awppAN6jeDvroI2TUJPkOXgTrWX5NupraTKExh6YFI7ps6gOgZAKZ9PMBR3C
         6A+S+kKhkHNj3O/BwjvwukRsBxHH00pwRuqAb9rfA7npMqIhVuVTi9hUIBx4679upMva
         1QKIGrinWSdP08ex0VNEAtfkzjK5acsN9tOd+SyuTycvsTUszESnVVgWwQB22ty0ClPr
         ccyw6AG4M8EafLYlPyjWwFzzw4UEQwoknxE13W9ggiT3TCheOJm5MSBoZnnJF1FuFJx+
         XgKggaTJ5yx5b1fXfN1ofpPTiCvKnrhNbTKUKwT/yLNt/pXZUmrtG1FEeMJ62HyZ72de
         SwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZLBI/8SqO3lQnkC11OaIHS0M/CameoMxsEwafnsB1c=;
        b=HfKvmXP95nnfWknrK1rwsGAmq0DV5jnifuMmNJOM4nabPQAE9jbIWPmsFXm0SHBt1k
         BKf/3QO4xOq6/X8PWhQPP2DikZAm+OrN/SnUM6rjfzq9OwlMJ0L4oljw0jWzhw3dPGjs
         oFRK52gLT9cVjGH2dG9z5mPeWQve4EmVYd7E5RYCSHvzybiQJ5XFxXngp7A5sFwgLOSG
         4tMGPZfd5YXwkK6tzYHE5+nVoTkXb1V/CcW1zZTAQp9WE9Kl/7Fe9Lysz/WvYWcc/MeB
         AzseY3pJhEqYTwQ8YbT6+0fFNucLdcOI5tKyByJPZgUd1ztYTyUdwRATUmbeI5O9z5hq
         mDXQ==
X-Gm-Message-State: AOAM5326ae56tjQ7SPxPYrEXJmtcn8J6jn3o1G//Bhim8nWhLB1r6tNS
        lrs2K5HDf0R4mSml1X8QlXiPgw==
X-Google-Smtp-Source: ABdhPJwe8JD1NLxuRyWvUDwBYH+oG7tZAH6fZ5CsYEXhUT3tkZWH8K+UTsMamm4CoavJaq0kgLGmUA==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr9232298wmb.53.1614782845136;
        Wed, 03 Mar 2021 06:47:25 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 18/30] scsi: pm8001: pm8001_hwi: Fix some misnamed function descriptions
Date:   Wed,  3 Mar 2021 14:46:19 +0000
Message-Id: <20210303144631.3175331-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm8001_hwi.c:1183: warning: expecting prototype for pm8001_chip_interrupt_enable(). Prototype was for pm8001_chip_intx_interrupt_enable() instead
 drivers/scsi/pm8001/pm8001_hwi.c:1257: warning: expecting prototype for pm8001_chip_intx_interrupt_disable(). Prototype was for pm8001_chip_interrupt_disable() instead
 drivers/scsi/pm8001/pm8001_hwi.c:3235: warning: expecting prototype for asd_get_attached_sas_addr(). Prototype was for pm8001_get_attached_sas_addr() instead
 drivers/scsi/pm8001/pm8001_hwi.c:3555: warning: expecting prototype for fw_flash_update_resp(). Prototype was for pm8001_mpi_fw_flash_update_resp() instead

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 49bf2f70a470e..6b600e33e9e8d 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1175,7 +1175,7 @@ void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
 
 #ifndef PM8001_USE_MSIX
 /**
- * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
+ * pm8001_chip_intx_interrupt_enable - enable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  */
 static void
@@ -1248,7 +1248,7 @@ pm8001_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 }
 
 /**
- * pm8001_chip_intx_interrupt_disable- disable PM8001 chip interrupt
+ * pm8001_chip_interrupt_disable - disable PM8001 chip interrupt
  * @pm8001_ha: our hba card information
  * @vec: unused
  */
@@ -3219,7 +3219,7 @@ void pm8001_get_lrate_mode(struct pm8001_phy *phy, u8 link_rate)
 }
 
 /**
- * asd_get_attached_sas_addr -- extract/generate attached SAS address
+ * pm8001_get_attached_sas_addr - extract/generate attached SAS address
  * @phy: pointer to asd_phy
  * @sas_addr: pointer to buffer where the SAS address is to be written
  *
@@ -3546,7 +3546,7 @@ int pm8001_mpi_dereg_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 }
 
 /**
- * fw_flash_update_resp - Response from FW for flash update command.
+ * pm8001_mpi_fw_flash_update_resp - Response from FW for flash update command.
  * @pm8001_ha: our hba card information
  * @piomb: IO message buffer
  */
-- 
2.27.0


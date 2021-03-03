Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1C32BEFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576858AbhCCRrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244181AbhCCOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E420C0613EE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n22so5407579wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nK4eefo6NrFTl4crSl1/DHJIw7UTb4L0OHxeSI3Uc2E=;
        b=ML8ij0NytYJdYa1UhFHNKItuAT7SeWi4ZjzKZ0lUoHQamtkkVYhMwjU9x0r0j5nBI5
         O08WuH9ercltleOgu7V92WnWMunllo5s4r9gedetm3BRxkMWRRPJKR8nb5a7YdnWGDVF
         vb73w39mKLlaeYHr7hAAx46giWMELjHP2vf9qTpwBZUabhLhUHmfqJM1nL45R2OE7GhE
         XXp+NoL8fu8iNML10qDc42jkuzWvhhKWn901TJWhVY6HDZPDNM2ZlSEeQQn7qfX7WUuH
         FghJDjqoVbUVhK9345mMChpriaCPV7mqBWMVB6mHKixI1Pxn+n3/wjXBoHNnpSHjPvAt
         7Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nK4eefo6NrFTl4crSl1/DHJIw7UTb4L0OHxeSI3Uc2E=;
        b=cBuFmWKF1H8cb9wW3lMqn27kOq+TnSrywta5KKqZRuIzCt7pFM2vXTwsjI7dBDTNtN
         bjMwRvEeaQOiVdEdTc1Mdph+iPh89B/fAVEciLx/A/JXUDginbY9J60pjdXmqGr9unBg
         KsQt2bGkIhSq+1CqnuKWbK9T3D5byp5VSRMVdSLhwpvAAJlIgZFdYsFpGvQgSbEQSrrx
         xGCGRlvQG+Bg17bWQpnfHjyxpQAd5igTRCUqtYnKyEHzBTK+7+kfz6guOhU7gT7NzMTC
         qG/d5mshs+79f2GnPQAF0pImrgmmgGmSFOQE2zoqFXCFDvOOodDOKl6Bb7d8+fxTrmu/
         yTuQ==
X-Gm-Message-State: AOAM5321BALeM+1GR8+yLKRPF3KCxhiIKHxN1RuR6ZTfEzQYPV9iG9NP
        TRfo6YrYx2uyk29z79GGl4e5wh8pK2YODg==
X-Google-Smtp-Source: ABdhPJz3HUn1iV4Mr3ACScTkwR7ze/a6od0APWdQI8cJupILZPBEJcNfDu4EJ/WCQKO9jNkbxq8r2g==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr9171547wmc.13.1614782811891;
        Wed, 03 Mar 2021 06:46:51 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kumar Santhanam <AnandKumar.Santhanam@pmcs.com>,
        Sangeetha Gnanasekaran <Sangeetha.Gnanasekaran@pmcs.com>,
        Nikith Ganigarakoppal <Nikith.Ganigarakoppal@pmcs.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 08/30] scsi: pm8001: pm8001_init: Provide function name and fix a misspelling
Date:   Wed,  3 Mar 2021 14:46:09 +0000
Message-Id: <20210303144631.3175331-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm8001_init.c:192: warning: expecting prototype for tasklet for 64 msi(). Prototype was for pm8001_tasklet() instead
 drivers/scsi/pm8001/pm8001_init.c:872: warning: expecting prototype for pm8001_set_phy_settings_ven_117c_12Gb(). Prototype was for pm8001_set_phy_settings_ven_117c_12G() instead

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kumar Santhanam <AnandKumar.Santhanam@pmcs.com>
Cc: Sangeetha Gnanasekaran <Sangeetha.Gnanasekaran@pmcs.com>
Cc: Nikith Ganigarakoppal <Nikith.Ganigarakoppal@pmcs.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index bd626ef876dac..bbb6b23aa6b1c 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -184,7 +184,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
 #ifdef PM8001_USE_TASKLET
 
 /**
- * tasklet for 64 msi-x interrupt handler
+ * pm8001_tasklet() - tasklet for 64 msi-x interrupt handler
  * @opaque: the passed general host adapter struct
  * Note: pm8001_tasklet is common for pm8001 & pm80xx
  */
@@ -864,7 +864,7 @@ void pm8001_get_phy_mask(struct pm8001_hba_info *pm8001_ha, int *phymask)
 }
 
 /**
- * pm8001_set_phy_settings_ven_117c_12Gb : Configure ATTO 12Gb PHY settings
+ * pm8001_set_phy_settings_ven_117c_12G() : Configure ATTO 12Gb PHY settings
  * @pm8001_ha : our adapter
  */
 static
-- 
2.27.0


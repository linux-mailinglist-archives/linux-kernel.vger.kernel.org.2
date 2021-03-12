Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613AD33891A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhCLJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhCLJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09008C061765
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v4so1396565wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hb0h53+N/nT00wb74f1MjjQ1bTOb0RVG4vqVQWcHEZE=;
        b=P9B9CY2lD1RdF3q6iypPdFIU6at6cohz33wf9IqIkmzQbrlSn4Fsuw17QK/UZKPAhP
         ASbDjeI+KkpcxYf6NDz/oTk3ICjql66swpNRESmOpxbPMuWlaY9vIvCZbYJpJHtEcTUn
         rXaHQ9sCz9SbTNaRUSJUPM0GG9XAU7z7IogPGxd9zELtdCTZ05IkfZRHSCThYER5NGqU
         Ho2/dJngFDhZJkpI9IoHP/P2HYJKSQmGBKRigNKIaYQ83WnLkrBBRzK9vk16ektyswNM
         pix6qOdIdeav+F255QcqumBdOHkhJ81O3iJqZfADq/2Xhp1zi868k8/RN+SiALY0FMej
         h6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hb0h53+N/nT00wb74f1MjjQ1bTOb0RVG4vqVQWcHEZE=;
        b=Rb4G28TXTyXSAnffPJ/Zt170PxBbyPj3mvGJcftDwoZkwCHBfMg7+6FJGG9599upd8
         6PELN+fauo1toQTHFBKgY0w+t1Gx7neNE/m+7qhqDYrYqAzD6TCVkyVYMC+cfAixVExA
         AHfx1ZDD8j5IxJ1TD6MP5a/xAdnBpmb1V0mmg1s0LIM9P/+Sv/kAA8j4gqvrhy9b1nKt
         Q+ZDSHRGRTXDZFK5PXyAdPM5hFxH2tE+xDBDtMBHqqrqLzA5u/79meMbpt/iHWIzzamL
         QalLEUWoFLAFFjrt96rwfcZshGkkVC5Iqzj2t3CJZCTHuqigtalspyEM3BvueEraR0O5
         /sgw==
X-Gm-Message-State: AOAM532oNgQyTxRw7ujYxI+wAxW1TeSkqN6io4LUEog1rXDtMKM1AI5X
        dN1tSjWh575tdBKeEDn+9+gwzQ==
X-Google-Smtp-Source: ABdhPJw9hVpTqUn8hfq8z50GtH+UEJaYIa62uf4N+tcmdzYne1haCmli1AcNq2/MJJLn7bCD7XfTow==
X-Received: by 2002:a05:6000:245:: with SMTP id m5mr13372111wrz.284.1615542485738;
        Fri, 12 Mar 2021 01:48:05 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 16/30] scsi: ufs: cdns-pltfrm: Supply function names for headers
Date:   Fri, 12 Mar 2021 09:47:24 +0000
Message-Id: <20210312094738.2207817-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/ufs/cdns-pltfrm.c:109: warning: expecting prototype for Sets HCLKDIV register value based on the core_clk(). Prototype was for cdns_ufs_set_hclkdiv() instead
 drivers/scsi/ufs/cdns-pltfrm.c:144: warning: wrong kernel-doc identifier on line:
 drivers/scsi/ufs/cdns-pltfrm.c:160: warning: wrong kernel-doc identifier on line:
 drivers/scsi/ufs/cdns-pltfrm.c:176: warning: wrong kernel-doc identifier on line:

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Jan Kotas <jank@cadence.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ufs/cdns-pltfrm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 149391faa19c1..13d92043e13b0 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -100,6 +100,7 @@ static void cdns_ufs_set_l4_attr(struct ufs_hba *hba)
 }
 
 /**
+ * cdns_ufs_set_hclkdiv()
  * Sets HCLKDIV register value based on the core_clk
  * @hba: host controller instance
  *
@@ -141,6 +142,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 }
 
 /**
+ * cdns_ufs_hce_enable_notify()
  * Called before and after HCE enable bit is set.
  * @hba: host controller instance
  * @status: notify stage (pre, post change)
@@ -157,6 +159,7 @@ static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
 }
 
 /**
+ * cdns_ufs_hibern8_notify()
  * Called around hibern8 enter/exit.
  * @hba: host controller instance
  * @cmd: UIC Command
@@ -173,6 +176,7 @@ static void cdns_ufs_hibern8_notify(struct ufs_hba *hba, enum uic_cmd_dme cmd,
 }
 
 /**
+ * cdns_ufs_link_startup_notify()
  * Called before and after Link startup is carried out.
  * @hba: host controller instance
  * @status: notify stage (pre, post change)
-- 
2.27.0


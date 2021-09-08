Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1A40419E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhIHXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbhIHXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:11:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34552C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 16:10:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b6so5573061wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bck3GxM/smuWPP1BN2oyn2huDSeUCK8vvjWeb+leiQk=;
        b=OJ6wttDqNyKkGNxg8MNgwxQayIgUMQxKm+MI/X5bR0AFTYdkt7jVJlOy5sGCnvtwGV
         A9Ae2BqXvcCFLpQnWknKXzjC5WGbjCFOv361MK2YVo+UNg9UcQwN5SAHLRroth6X3UOm
         aWHA1Kjgv3PaVBuUvpmff28lPiZvPJXiaXYpz9r2KZIhZfbDjzmpj3Hl3vS1nX089eNS
         /MoorYx8g6mF7GQBiduC2jSlWm3SD/j9mk1KMMU3II6vhOKLyTFa07wOfS6q1y4IlcLP
         QN0VkTEk842XxXzV3qvUHqSnWhT+ekkzK0vkPUq7AHSGYlXDv4DJhp2FeE888RgGthEa
         vx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bck3GxM/smuWPP1BN2oyn2huDSeUCK8vvjWeb+leiQk=;
        b=5nQCLoOsgwuhB20f0NB79w1TTAzBECicR3L3YnNLlQYTIrPRSpfqLY6lU/TfBD9+Bk
         ad/gGpAa/41aH4+s5gWSjm2/PZj3PfWzDddsI5KIA2/nHVGt6bui01dub5/rcJKcu5l4
         FqTaGRmFdkdmZ11/2oEFgXR5JnMO14acQb1Kd65Mv+Srarvd1X7bM/tA9Wezgt9YE3gi
         7lxsiDSWn9wAtzlBHsOG2Wuy8vpQufhCSck+b8jqWhWBTSUwMhCos3sVBaeXpc3NFPU8
         tTBt7nre008SyPQfvsM1/GexvDCdSxSEIVDiTI6GQ1Z7y9C6tPlzzZ6J0kFGpIe+vulf
         91yg==
X-Gm-Message-State: AOAM533+WGKoc64ZTEZs+2rO3wWfLYhUtNrIoS3pL64jqnZqE+Ofa3rI
        jvr+iUwStGaXSu3iU8x2mKY=
X-Google-Smtp-Source: ABdhPJzhdAmgitEAHjHd4q7oxUOqHssQvkjGp8GQZVP8dwRoTSHGoKBoYquguQfk1hCgOdjr4LbIDg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr47110wro.355.1631142615891;
        Wed, 08 Sep 2021 16:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id l21sm348393wmh.31.2021.09.08.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:10:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove unused ODM_MacStatusQuery()
Date:   Thu,  9 Sep 2021 01:09:53 +0200
Message-Id: <20210908230953.16931-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908230953.16931-1-straube.linux@gmail.com>
References: <20210908230953.16931-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_MacStatusQuery() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 8 --------
 drivers/staging/r8188eu/include/odm_HWConfig.h | 7 -------
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index db4c072ec6c5..0a07795e3912 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -519,14 +519,6 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
 	ODM_PhyStatusQuery_92CSeries(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
 }
 
-/*  For future use. */
-void ODM_MacStatusQuery(struct odm_dm_struct *dm_odm, u8 *mac_stat,
-			u8 macid, bool pkt_match_bssid,
-			bool pkttoself, bool pkt_beacon)
-{
-	/*  2011/10/19 Driver team will handle in the future. */
-}
-
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum rf_radio_path content,
 					   enum rf_radio_path rfpath)
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 790ab4d1eff5..e2edcb7dbad6 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -95,13 +95,6 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt);
 
-void ODM_MacStatusQuery(struct odm_dm_struct *pDM_Odm,
-			u8 *pMacStatus,
-			u8	MacID,
-			bool	bPacketMatchBSSID,
-			bool	bPacketToSelf,
-			bool	bPacketBeacon);
-
 enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm,
 					   enum rf_radio_path Content,
 					   enum rf_radio_path eRFPath);
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D502932F8ED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCFIL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCFILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:11:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD38C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:11:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jt13so8369382ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+EF1AAM7EWJZCaU5TM8Zhhbah4qYiTm12Oy1y0E5dU=;
        b=YLMxrYy6mqzNRFVBFV5Ykra2gFccgHS1+n2U293scbkLDLh7fKriMG8uL4xhTidT0P
         NORJyP8VhBWV4MRZNEJ54z4p7o2DLxDLwzmBiKLf+XlTmX+RLveMTyC2DW170jgNYK9X
         svIWmtgm2Ilaetil3ky8QhfsLhPB+2gVyMH7TdtEWkLtutBUteJEvDh/L5QIkZI1gTiR
         zazm3qeoPusfxTpqYBYYGyIcsJt/ExGxJ+rYPKebYmUKXU2soUpeiFDATn1pOd9A01an
         W8va8yMDQP5CyM2/iywBynqSpU+EqNFvDTm4JQFJh1P3oZ/yAodra7KCRUsFbUhKmqBU
         f2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+EF1AAM7EWJZCaU5TM8Zhhbah4qYiTm12Oy1y0E5dU=;
        b=TOvTrAKWW2Lv8zz6foDCfkwqrVP3U41ueslFDPDmV9oWztPC1IgMvDpgSpAr0aaAHQ
         /Q1uggmVHkuyHAdPKzgTnU/YROX68WnJDskah1XYclZh5Z37jlEv0X3rE8hMdvruHsdf
         qqimEPhosGCY4scHJf9fV7Rmt1T1XSmv7UUOf6/zbXDcqKGyzOCbJYklagh0m77lsZWt
         FEk+8cUK5AM1iVx7oZveDXEcv3Cdviu0qgbTLGxsj60z6KTwKnDs2uR94t31L9NKTZw5
         /kx2k56sBYjOxA0wGXve40H3ps02WzEGZ9h6moix8XFZupTJqFOw+oYTaCl+V7zQ91Ck
         X9Jw==
X-Gm-Message-State: AOAM532wdoRZxxP0/8IfIe0UrKfYFlMONR5MYSnUYsjHM9v+r5mWBXFX
        uYJnbsvuWn4wlOhFO59n8FoO3CxPkVE=
X-Google-Smtp-Source: ABdhPJxUBjQEeTyEqWolOO/4GS/xqP+y5M+i/xlxR9fotLjHMVBmg1w/dn/P+Yg04qYLnjz8bLG3ng==
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr5928117ejf.438.1615018310815;
        Sat, 06 Mar 2021 00:11:50 -0800 (PST)
Received: from tumbleweed.fritz.box (dslb-002-204-141-079.002.204.pools.vodafone-ip.de. [2.204.141.79])
        by smtp.gmail.com with ESMTPSA id q11sm2814737ejr.36.2021.03.06.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 00:11:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: rename ODM_PhyStatusQuery()
Date:   Sat,  6 Mar 2021 09:11:32 +0100
Message-Id: <20210306081133.1272-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ODM_PhyStatusQuery() to odm_phy_status_query() to avoid camel
case.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c     | 6 +++---
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c  | 4 ++--
 drivers/staging/rtl8188eu/include/odm_hwconfig.h | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 65a346ae3cb0..c5af0c559cba 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -385,9 +385,9 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 }
 
 /*  Endianness before calling this API */
-void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
-			struct odm_phy_status_info *pPhyInfo,
-			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo)
+void odm_phy_status_query(struct odm_dm_struct *dm_odm,
+			  struct odm_phy_status_info *pPhyInfo,
+			  u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo)
 {
 	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
 					 pPktinfo);
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 7d0135fde795..0d06cb54b1ad 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -171,8 +171,8 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 		pkt_info.StationID = psta->mac_id;
 	pkt_info.Rate = pattrib->mcs_rate;
 
-	ODM_PhyStatusQuery(&padapter->HalData->odmpriv, pPHYInfo,
-			   (u8 *)pphy_status, &(pkt_info));
+	odm_phy_status_query(&padapter->HalData->odmpriv, pPHYInfo,
+			     (u8 *)pphy_status, &(pkt_info));
 
 	precvframe->psta = NULL;
 	if (pkt_info.bPacketMatchBSSID &&
diff --git a/drivers/staging/rtl8188eu/include/odm_hwconfig.h b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
index 2cd8a47a3673..dc86e4058eff 100644
--- a/drivers/staging/rtl8188eu/include/odm_hwconfig.h
+++ b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
@@ -93,9 +93,9 @@ struct phy_status_rpt {
 #endif
 };
 
-void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
-			struct odm_phy_status_info *pPhyInfo,
-			u8 *pPhyStatus,
-			struct odm_per_pkt_info *pPktinfo);
+void odm_phy_status_query(struct odm_dm_struct *pDM_Odm,
+			  struct odm_phy_status_info *pPhyInfo,
+			  u8 *pPhyStatus,
+			  struct odm_per_pkt_info *pPktinfo);
 
 #endif
-- 
2.30.1


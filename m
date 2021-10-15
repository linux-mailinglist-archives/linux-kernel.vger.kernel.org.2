Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0642F857
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhJOQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbhJOQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2AC061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p21so2988143wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CjF1ZSILAnzFxi0WDYQMSXFctas9qZfIH3klDlPYvc=;
        b=L7kVFtC3UAEzfogMa81OHDo57dAHJjXlT3qiR8za3FL8SQ5OHeAfizuPLtkseGF2GS
         kYSYn1vkKUQJi4cNr2qa8Hw9TFNZqPGcH87sW10eSHg9PvAqMg5srOC5Wao5iHf/109a
         B+JvXkJWjr4CeZV/T8Gx3fWBEjC7nJPyiU/C/JGCXVpIPJspRWp/gkJbjVCHrXdkPrIv
         FN2/DUyApaOihwfOeq5aj2a72uftkuse0HdzhBv7GTJtZsL9EKmByaugedUJi4tjuRMw
         sr8eB+uxHVl0BVwDVWhFm8nMD4uNx4GMnyfYCQuu+cv8O3RlNu9C5z2u6Y3HsRsC9Cdd
         XwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CjF1ZSILAnzFxi0WDYQMSXFctas9qZfIH3klDlPYvc=;
        b=alMw9oKBheMGOhz2+VtKNg1m0/fRrpGWam7YFIADXxe2Kqv72wnwcR0HrzpPqAckOI
         GDQJbgbGsYLCygwUHYoX9wYEKIC1bU/cGzg6ONb+Xf45gHETC0zf4N0uSBAV992cX2iL
         e1iuRsUmvuHDeO/1BsCHUBsRCf5oFPE43gI0pJcAcMBsw5YaNxI9lk2wKSAMdbvDI2L/
         Wi3yw9y2+PJ2wUydpHyt6H1nWqEZq7zvPtbca+UEBeoBGw74ZpJumaCzyYPWtM6tHV/f
         aI6fBekQJmpKONNvlhj6iOxFwfeI/Perh8k2PQfKF+Er1morl7v5GXr5cJFB3xMCbb3M
         HCFA==
X-Gm-Message-State: AOAM530mzxzS29WX6KW67Af6oKEnClqpglUQH8Le/TbL81jjNBgUJrIV
        8OXSmxa2l0zccQuMinVCcMc=
X-Google-Smtp-Source: ABdhPJzD1NPu08hqUyPPNC24lE0ZinhyYlUFSxHzLsSt6bGgOIj/gK/E9phBwgwyp+zb7Hnv/3tFPg==
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr26891090wms.81.1634315719441;
        Fri, 15 Oct 2021 09:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: pMacPhyMode is not used
Date:   Fri, 15 Oct 2021 18:35:06 +0200
Message-Id: <20211015163507.9091-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pMacPhyMode is not used. Remove it from odm_dm_struct and remove
related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 3 ---
 drivers/staging/r8188eu/include/odm.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 85bc5050cda5..a2cbe727f6e0 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -231,9 +231,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	/*  */
 	switch	(CmnInfo) {
 	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_MAC_PHY_MODE:
-		pDM_Odm->pMacPhyMode = (u8 *)pValue;
-		break;
 	case	ODM_CMNINFO_TX_UNI:
 		pDM_Odm->pNumTxBytesUnicast = (u64 *)pValue;
 		break;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 9745069060d7..6cbf64df9be7 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -269,7 +269,6 @@ enum odm_common_info_def {
 
 	/*  Dynamic value: */
 /*  POINTER REFERENCE-----------  */
-	ODM_CMNINFO_MAC_PHY_MODE,	/*  ODM_MAC_PHY_MODE_E */
 	ODM_CMNINFO_TX_UNI,
 	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
@@ -621,8 +620,6 @@ struct odm_dm_struct {
 	bool	bool_temp;
 	struct adapter *adapter_temp;
 
-	/*  MAC PHY Mode SMSP/DMSP/DMDP = 0/1/2 */
-	u8	*pMacPhyMode;
 	/* TX Unicast byte count */
 	u64	*pNumTxBytesUnicast;
 	/* RX Unicast byte count */
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABA32F8EE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhCFIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCFILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:11:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D38C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:11:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d13so6131850edp.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hicfc88XYtGQibPZ28ppgt5o+1tgAaCVylXJWyAasds=;
        b=oKYokwY++YPoDhoaha4j4EJXXRyJirxqeF0ayVaapc5KHKHCi+ch3sVzO2RIn8vLrX
         QzJs02Vl/CFBznt1BRpD2fhpAQWbNgQCEWCbMJSCaonmDx9K5CQMBruCFpVf++LwX/gf
         nxwCOoi5+TA99mqZP03+DdWwDDdFu5m1zlf/TnUA2cJeKyYWROydPOVZw5Q5gEAScOG9
         7o/ObWdRZ2GPkEqAGUzT3/mGk9TD5foR/jPXAwhlFzzm+Ca5PDcwzk6d0JScBJG2A/fx
         onnW93PZLPTD6ND32X8pDLQ/zPiKDZvzGa2mn4I/b0lX6f0iUOBrRGwTftrn15GoGqp1
         RPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hicfc88XYtGQibPZ28ppgt5o+1tgAaCVylXJWyAasds=;
        b=n0RhNdxCVLVrHLR3dmu1JhWQUaIL7KGQvtcwiAu7YTpLqYjd5h4FXWg9ZGAwLLXne+
         QBf+EC+j9Xm3MAHGNDcGxeIyaW4GeMFEkZ8oTC3pQHnKXZ0FpJmu5HUy/rcVnESwEOA0
         76sR9q8XxYZyyXyXdlhgistayLLGFgtZgEGo48qYQbDcNrOK57f9AjZ3EyVEgaPeOHHk
         OR0jf8QKY9Q89Re2wkiv0YQA6Ld6bNabJ/+ZBrDF5hzCDIdhfne5wQzfW3VSSVJ/e38z
         0HOKPOuocLSzJrsPTH1xgDfCU6wFNX2eua4vK7NcZKdW0m0wt46ePN4ZLZcl+6oG5b1b
         OvbA==
X-Gm-Message-State: AOAM5327Vpo5LFP77WC6ijakzuYlKeFk/6TrlfGarFnsJWOypQzzuHO4
        nnjvhnacjwR26q2tFTpoebd7xYThTmY=
X-Google-Smtp-Source: ABdhPJy+esI0OxBpQ+7WnmIxIKoMmtOQN5jOvv+3LtcZSrttMtG+CuWoH2llncOhwz0b5NF2/eUCUA==
X-Received: by 2002:a05:6402:220a:: with SMTP id cq10mr12942093edb.345.1615018311413;
        Sat, 06 Mar 2021 00:11:51 -0800 (PST)
Received: from tumbleweed.fritz.box (dslb-002-204-141-079.002.204.pools.vodafone-ip.de. [2.204.141.79])
        by smtp.gmail.com with ESMTPSA id q11sm2814737ejr.36.2021.03.06.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 00:11:51 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: rename parameters of odm_phy_status_query()
Date:   Sat,  6 Mar 2021 09:11:33 +0100
Message-Id: <20210306081133.1272-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306081133.1272-1-straube.linux@gmail.com>
References: <20210306081133.1272-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameters of odm_phy_status_query() to avoid camel case.

pDM_Odm -> dm_odm
pPhyInfo -> phy_info
pPhyStatus -> phy_status
pPktinfo -> pkt_info

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c     | 9 ++++-----
 drivers/staging/rtl8188eu/include/odm_hwconfig.h | 8 ++++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index c5af0c559cba..684b6cec0f09 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -386,13 +386,12 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 
 /*  Endianness before calling this API */
 void odm_phy_status_query(struct odm_dm_struct *dm_odm,
-			  struct odm_phy_status_info *pPhyInfo,
-			  u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo)
+			  struct odm_phy_status_info *phy_info,
+			  u8 *phy_status, struct odm_per_pkt_info *pkt_info)
 {
-	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
-					 pPktinfo);
+	odm_RxPhyStatus92CSeries_Parsing(dm_odm, phy_info, phy_status, pkt_info);
 	if (dm_odm->RSSI_test)
 		;/*  Select the packets to do RSSI checking for antenna switching. */
 	else
-		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
+		odm_Process_RSSIForDM(dm_odm, phy_info, pkt_info);
 }
diff --git a/drivers/staging/rtl8188eu/include/odm_hwconfig.h b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
index dc86e4058eff..4f4d3cfb6c77 100644
--- a/drivers/staging/rtl8188eu/include/odm_hwconfig.h
+++ b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
@@ -93,9 +93,9 @@ struct phy_status_rpt {
 #endif
 };
 
-void odm_phy_status_query(struct odm_dm_struct *pDM_Odm,
-			  struct odm_phy_status_info *pPhyInfo,
-			  u8 *pPhyStatus,
-			  struct odm_per_pkt_info *pPktinfo);
+void odm_phy_status_query(struct odm_dm_struct *dm_odm,
+			  struct odm_phy_status_info *phy_info,
+			  u8 *phy_status,
+			  struct odm_per_pkt_info *pkt_info);
 
 #endif
-- 
2.30.1


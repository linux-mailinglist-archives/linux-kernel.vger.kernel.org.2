Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE13E346F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhHGJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhHGJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AAC0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b13so14336950wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0Nbs2vmcFJXEerAnkAy24smDLy8w+T8wOrXCoqMSqg=;
        b=aPCtI+PJMs9bboSSaIICklzFdl0NMWKMIEZxYA1C37D9PSSEuaF9Wa8LgkysgONaQi
         2gKghmzxsWB6MLVfT+bnVqhzyiWUboGlyVcSwm3SeUyJ5RxHKTh6/ad2vwzL68CRJzx/
         d08UHFPGYdtPLaltqGQdswKCeLaXW4VAvgNsSKEqOE3r7tvu+qSdqQT4cbZ8uchXIf+c
         JAF+DZhlF5FCmGKzfQXVMHNqcerQtPhY7grmXq82ayG+/Vt4z037/xSflSBllhbu961V
         KgzFrATffUm/3b5ACAR3zZYuMoq3i1Vw/9Vq57+jj7iwKdw+1pDPUBY5Dtx+Gr1rpOvG
         X3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0Nbs2vmcFJXEerAnkAy24smDLy8w+T8wOrXCoqMSqg=;
        b=aszOrlOQJjONTNUqHRUwe1YyRPQq7fcUoFzbknOIYxo+bhMLibzURgkipKTBLhucWJ
         eCCsYaCDfHd47+24565QM+sElqeyZZIlHyqH2Niv9wrBOf8PQbpBA5a8kw79AALW4GE5
         46WGcdZKdjwjHTjgpMS8uXH7bUpeFVlNGq2ovFPbquYFnHey4U9MmcqeUfKxaRwVArFu
         hNzTwS4f77kNe434vHyDf7eNgx9IPV18FJ9NbYV/OVOUyg4bTyoDOglJoLLMIJ/QNPDy
         jpX1wKJORZc8+FVMaU/cxeqr8MY2FmSORphiFV3m5pO/PtBOda/nTxH+mOOI0K/+AsgQ
         A4KQ==
X-Gm-Message-State: AOAM531z/bTUF+T7GpW79wdJ++jHdj4dai3G/OQvSRkVXu5phWPdZi7C
        XRTdog1DKTc7gNL9q/vrfWZ/qn//yTU=
X-Google-Smtp-Source: ABdhPJwaJILn5gMj31zcvfSKxcI4B1veL2ug4dDqYsPwREdpZ7sQZkPSzlT9Sx4Cb/HXUyF8JtCM/w==
X-Received: by 2002:adf:f889:: with SMTP id u9mr2623307wrp.3.1628329700514;
        Sat, 07 Aug 2021 02:48:20 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id 140sm11706543wmb.43.2021.08.07.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] staging: rtl8723bs: move function to file hal/odm_HWConfig.c
Date:   Sat,  7 Aug 2021 11:47:56 +0200
Message-Id: <c2bb14c3d32d3a654df95288751f0bc8cd6566b0.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move function odm_cck_rssi() to hal/odm_HWConfig.c.
As it is used only in this file turn it to
static.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 27 +++++++++++++++++++
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c | 28 --------------------
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h |  2 --
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 6d7b34fd595e..2d4d8d57ceeb 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -71,6 +71,33 @@ static u8 odm_evm_db_to_percentage(s8 value)
 	return ret_val;
 }
 
+static s8 odm_cck_rssi(u8 lna_idx, u8 vga_idx)
+{
+	s8 rx_pwr_all = 0x00;
+
+	switch (lna_idx) {
+	/* 46  53 73 95 201301231630 */
+	/*  46 53 77 99 201301241630 */
+
+	case 6:
+		rx_pwr_all = -34 - (2 * vga_idx);
+		break;
+	case 4:
+		rx_pwr_all = -14 - (2 * vga_idx);
+		break;
+	case 1:
+		rx_pwr_all = 6 - (2 * vga_idx);
+		break;
+	case 0:
+		rx_pwr_all = 16 - (2 * vga_idx);
+		break;
+	default:
+		/* rx_pwr_all = -53+(2*(31-VGA_idx)); */
+		break;
+	}
+	return rx_pwr_all;
+}
+
 static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
 				      struct odm_phy_info *phy_info,
 				      u8 *phy_status,
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
index 325f2a7ae337..66bda505c01e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
@@ -6,31 +6,3 @@
  ******************************************************************************/
 
 #include "odm_precomp.h"
-
-s8 odm_cck_rssi(u8 lna_idx, u8 vga_idx)
-{
-	s8 rx_pwr_all = 0x00;
-
-	switch (lna_idx) {
-	/* 46  53 73 95 201301231630 */
-	/*  46 53 77 99 201301241630 */
-
-	case 6:
-		rx_pwr_all = -34 - (2 * vga_idx);
-		break;
-	case 4:
-		rx_pwr_all = -14 - (2 * vga_idx);
-		break;
-	case 1:
-		rx_pwr_all = 6 - (2 * vga_idx);
-		break;
-	case 0:
-		rx_pwr_all = 16 - (2 * vga_idx);
-		break;
-	default:
-		/* rx_pwr_all = -53+(2*(31-VGA_idx)); */
-		break;
-
-	}
-	return rx_pwr_all;
-}
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
index 752f180ebd46..12b3ca90a43d 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
@@ -9,6 +9,4 @@
 
 #define	DM_DIG_MIN_NIC_8723	0x1C
 
-s8 odm_cck_rssi(u8 LNA_idx, u8 VGA_idx);
-
 #endif
-- 
2.20.1


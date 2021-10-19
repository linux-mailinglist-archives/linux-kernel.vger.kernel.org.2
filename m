Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECB4337C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhJSNyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhJSNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:53:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDCC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e12so47893033wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQLYM1tjWYzX8if24IRLux/H2YDXzxiO/vti4eG5S14=;
        b=WxkhPGjGJuxJVxjPrr+7i0A0LxJoB/2hPtjBwwUj2HBUAbvZOsGxam/l7iEBlzSKw0
         tvjct9qIpkWNKEu6S0XJ+Q6MZnrTzFxIT8XR4q6meNu63bv4NjypHc2vh4S3KU28v/5C
         Y2wUKRvzcvTSIBlXGlConVqzs9ygCbF88VeRVV1JvqOn+PUiGa97FwZafcz7rvoUrga/
         v+5hNEMfMpBTw2RvtcRD+436L0RbyC/PPAj6qV/xZ/53U2VcpwICRlPZm3D3tUrY4Eir
         nz4lUXF0Z5zIfKcYhhxH0GznnoV31K5891i9GnGMXJnTeTFK79IwBnVDqsx6+K+zjXcU
         CY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQLYM1tjWYzX8if24IRLux/H2YDXzxiO/vti4eG5S14=;
        b=w+yaRjF5twUXau5dyrKp+vx9Yet1WUgvcklPmqL0DkJDJ6x4wyPrZxpNAoLGCnxh4F
         BgSXfyOzLZtwL4rBcHSbQnYxziAoFjz89qUQ1Zn7I2FoW6wDmAoa3eSQb4rtbjrkgjI5
         BcspWJ52hjdxPDPPrxh85GEiafETTJ8AyWWpZ+P2I5AEkEmL6gjpedgrXcwGwUMEfl9D
         eNBiiBRW4K042mCaVCbePFbgoBJJroLIMyYf9KYYSAlsoPWMnp5AhMK30TDJdtujYq6/
         5svA66SIHpBTONYHtK8KwQUIyR0+QSdL/rqLatHOIoiDkG2Ok5cbkUZfL5sbu93VyXFR
         BSVQ==
X-Gm-Message-State: AOAM533EEGQanzud/q03avm/sgEM3ay/YIQ+7uwtampHxbkNf6SV8wxi
        z/M3ECjEP5USX0Xumx4hZSY=
X-Google-Smtp-Source: ABdhPJysi2Tcxp6qmDat3XL3iEY4DZyE5otBdjezxTUuvlzkQfLHJ0FSXPRIFrBLqXm0b1RdIS7K1w==
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr45481741wra.156.1634651504104;
        Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: BTRxRSSIPercentage is set but never used
Date:   Tue, 19 Oct 2021 15:51:32 +0200
Message-Id: <20211019135137.9893-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTRxRSSIPercentage is set but never used, remove it from structure
phy_info.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 5 +----
 drivers/staging/r8188eu/include/rtw_recv.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index d83ef15c2cb6..4772c2c0d50d 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -60,7 +60,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 {
 	u8 i, Max_spatial_stream;
 	s8 rx_pwr[4], rx_pwr_all = 0;
-	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
+	u8 EVM, PWDB_ALL = 0;
 	u8 RSSI, total_rssi = 0;
 	u8 isCCKrate = 0;
 	u8 rf_rx_num = 0;
@@ -136,7 +136,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		}
 
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
-		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL;
 		pPhyInfo->recvpower = rx_pwr_all;
 		/*  (3) Get Signal Quality (EVM) */
 		if (pPktinfo->bPacketMatchBSSID) {
@@ -188,10 +187,8 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
 
 		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
-		PWDB_ALL_BT = PWDB_ALL;
 
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
-		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL_BT;
 		pPhyInfo->RxPower = rx_pwr_all;
 		pPhyInfo->recvpower = rx_pwr_all;
 
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 0b1fc752b0c1..1e28ec731547 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -78,7 +78,6 @@ struct phy_info {
 /*  Real power in dBm for this packet, no beautification and aggregation.
  * Keep this raw info to be used for the other procedures. */
 	s8	recvpower;
-	u8	BTRxRSSIPercentage;
 	u8	SignalStrength; /*  in 0-100 index. */
 	u8	RxPwr[MAX_PATH_NUM_92CS];/* per-path's pwdb */
 	u8	RxSNR[MAX_PATH_NUM_92CS];/* per-path's SNR */
-- 
2.33.1


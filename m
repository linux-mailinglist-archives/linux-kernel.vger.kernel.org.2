Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA67A3E346D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhHGJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhHGJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF51C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b11so14348209wrx.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvrs/t9mWUESzDPcxjj1KRsT2IHzyiSvfwyLWrUR7Wo=;
        b=MOgN6DlI3wk4RowbDbc02YaBvk/Rl3qOs2twAobCw1l5YfTOUJyYWn2nwpFLz8EOgK
         aDKg9xYWua7fa0ZD1CWdB3/kK+hps7QbUoPb/JjLCFahuQUnUT9xLDBzLpcoftsiW+LQ
         IhaVafjVXUzkIdXO1DWYGQXAb/hqSbSS1rdT9VqHsXwfZWLHn/4kG7x7GjAhZYe2PVrl
         TFUWwztjFMJ64TaNhRBhDdlNXbDzTJAdpLKIcL+ezqQ5omK7INlJuAc53fSuYs5nUYus
         28WLHumk6kbKFepvCr97cXGSapb+U8X5IkA+3OPIFGE28DCcyZml58hPxsq0SMsIWray
         18Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvrs/t9mWUESzDPcxjj1KRsT2IHzyiSvfwyLWrUR7Wo=;
        b=tK1BllzdrS44gVl/uuVPtWqDsmi9dlnKuiCB8xuOg2SQxqqj6+ri4xRU/Jtkh2sj+a
         VvzvcGH1uHQxG5EkNfDNT9Yj0rDFOJlLhCzhqDQ40KuMNzCB3xKJJtDNS4sui+Qfu6VX
         O/OJ7r9SZMbLHk6Oqd6bq7vCdtmjVIymFwtGd+iqVuwE4zH5sOyZxi8xkART4+1zfA7A
         2BSyeLVAiyLfHkQnLlOzkorG5mnhkNdCbY9RKrX2KLdG8pQIydI6jXxO9XKozVjA2SKz
         /T3MHasub4+SGFDM36yQNIMLN0de0C54ixmP0LYWh4Ci2GE1x+v05NbW7t7EIslmkxvG
         rCng==
X-Gm-Message-State: AOAM533ISWWWB5eQcdpFoVAXNtvHB78Vf2eSwjZbTPi0fzc3NDuV/ya2
        k6ub6CcGE4Y2kSJg9mYjYKZhFMeen7k=
X-Google-Smtp-Source: ABdhPJy3Q9QFNTnOJdGB7H9N1uk04ehOi0EGAOKA+OPxgBM5cyD9u3QTWxxM6RRAeTAjaaGPIktJhw==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr14571018wrw.176.1628329697881;
        Sat, 07 Aug 2021 02:48:17 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id y11sm14839535wru.0.2021.08.07.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] staging: rtl8723bs: remove unneeded loop
Date:   Sat,  7 Aug 2021 11:47:54 +0200
Message-Id: <45f2ed02b8e5bb25057da6e7dc3e7c8713a1a2c0.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded loop over multiple spatial streams
as phy only works on 1 spatial stream.

Removed commented code, removed condition
always satisfied, beautified comments.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 43 +++++++++-----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 17a5850183ad..af4d5ab1b382 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -78,7 +78,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 	struct odm_packet_info *pPktinfo
 )
 {
-	u8 i, Max_spatial_stream;
+	u8 i;
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
 	u8 RSSI, total_rssi = 0;
@@ -182,30 +182,27 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		pPhyInfo->rx_power = rx_pwr_all;
 		pPhyInfo->recv_signal_power = rx_pwr_all;
 
-		{/* pMgntInfo->CustomerID != RT_CID_819x_Lenovo */
-			/*  */
-			/*  (3)EVM of HT rate */
-			/*  */
-			Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
-
-			for (i = 0; i < Max_spatial_stream; i++) {
-				/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
-				/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
-				/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-				EVM = odm_EVMdbToPercentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
-
-				/* if (pPktinfo->bPacketMatchBSSID) */
-				{
-					if (i == ODM_RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
-						pPhyInfo->signal_quality = (u8)(EVM & 0xff);
-
-					pPhyInfo->rx_mimo_signal_quality[i] = (u8)(EVM & 0xff);
-				}
-			}
-		}
+		/*
+		 * (3)EVM of HT rate
+		 *
+		 * Only spatial stream 1 makes sense
+		 *
+		 * Do not use shift operation like "rx_evmX >>= 1"
+		 * because the compiler of free build environment
+		 * fill most significant bit to "zero" when doing
+		 * shifting operation which may change a negative
+		 * value to positive one, then the dbm value (which
+		 * is supposed to be negative) is not correct
+		 * anymore.
+		 */
+		EVM = odm_EVMdbToPercentage(pPhyStaRpt->stream_rxevm[0]);	/* dbm */
+
+		/*  Fill value in RFD, Get the first spatial stream only */
+		pPhyInfo->signal_quality = (u8)(EVM & 0xff);
+
+		pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = (u8)(EVM & 0xff);
 
 		ODM_ParsingCFO(pDM_Odm, pPktinfo, pPhyStaRpt->path_cfotail);
-
 	}
 
 	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
-- 
2.20.1


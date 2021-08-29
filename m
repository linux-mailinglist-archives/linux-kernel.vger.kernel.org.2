Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E4D3FAD93
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhH2R5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhH2R5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:57:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:56:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so8888286wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hct9WXGwxi0kZfiuUFWEyJRcWk1ylxYCbKFr9whU4ko=;
        b=Tfz4rdVeJAZl+sVPZFCBt3g3JGm2EOUJ6T/vkhfzPegFePaNRo0o8JO7vvRjCOLb0B
         FVI6oEYZxTEl8rgzKTy6ZCACc2Uiza4wBFzF7nSAI7c+VvIUYvznsbBh0UDRl9OKqFa+
         QpHhdrouIm+VAYNEyNR6VHRV/vvBrVjXd58V5cD1vZTkxv2k3f6uN3ypUYZORFCFBNSS
         6scMiV/SiKCYLkFEwUOQgNf7a2EA7JshYDJ56l2xQ3fMJHr4YDsFPITtmsCp+67a5/II
         42mTsVCwTNH3AzesDHtytG6Ad51FDzgFTv9p/sBhPnNALhPaOuHGnErT4F/SXYDRklav
         V0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hct9WXGwxi0kZfiuUFWEyJRcWk1ylxYCbKFr9whU4ko=;
        b=aGtpsXjwwlxS4wKB8nakQd2KLvyPu0KNlRBuUgwlmKDVSP1f+hMxRuIGepYnDYKEnA
         Wb8OcgcPorfthUsfgPEWqXxlePJ0f6YTkJtS88gPi2GagzHQYCcaqaed3m3+NxgIeSI6
         XoF0Nvz7f2WvGbqMv1+uuRY5Dgv3Rce/0w6TS4Y5AsEfl6jX6hHdRjeFwxcClf3robew
         Czr4ZjHMa8ajC+yuc5lWWSjbmomYM8otsSY04hm8hFabvgubu2kal+hQNDIOcGlZ/sqE
         m1Fnd8KjpVIaappOE/NCSU2kfuBqa4D9Jq6tBimUzVatdHlm61kQxv8TAmEhlYLblVHL
         Scfg==
X-Gm-Message-State: AOAM531UVpz9C/gZY+Ig7P2fOosEyPpoWaxq8T/Zs8ZXYtYZ6ewuWEV8
        x/2wRZKGBCqLZlFFTCkFVnU=
X-Google-Smtp-Source: ABdhPJy29m6zeYLEm3R+Yq5EgHSyLOREcHE5ZqfoPiGat2oWSCmOzYh7GY2v2IBRNwA+1Eeu9GjnmA==
X-Received: by 2002:a1c:d4:: with SMTP id 203mr18658456wma.67.1630259799319;
        Sun, 29 Aug 2021 10:56:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id k25sm13765256wrd.42.2021.08.29.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 10:56:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove local variable Indexforchannel
Date:   Sun, 29 Aug 2021 19:56:23 +0200
Message-Id: <20210829175624.5915-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable Indexforchannel in function
odm_TXPowerTrackingCallback_ThermalMeter_8188E() is initilaized to 0
and never changed. Remove the variable and replace its usage with 0.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 356885e27edd..1b0e1e7307cd 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -110,7 +110,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	bool is2t = false;
 
 	u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
-	u8 Indexforchannel = 0/*GetRightChnlPlaceforIQK(pHalData->CurrentChannel)*/;
 	s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
 		{0, 0, 2, 3, 4, 4, 		/* 2.4G, decrease power */
 		5, 6, 7, 7, 8, 9,
@@ -280,8 +279,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 				/* Adujst OFDM Ant_A according to IQK result */
 				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
-				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][0];
-				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][1];
+				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][0];
+				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][1];
 
 				/*  Revse TX power table. */
 				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index[0];
@@ -315,8 +314,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
 
 					/* new element A = element D x X */
-					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][4];
-					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][5];
+					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][4];
+					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][5];
 
 					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
 						if ((X & 0x00000200) != 0)	/* consider minus */
-- 
2.33.0


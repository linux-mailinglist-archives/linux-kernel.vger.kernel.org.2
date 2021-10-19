Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2094337C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhJSNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhJSNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:54:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so47978549wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F12BPIt+v3XNTHcLN2A5MDSV9pIZoXfGTfiqOPQbmvo=;
        b=esmBHBOmgPFn29+TU4iCBtbSGdk/0VVfE87Lj9+WrLuPbKfL/LtEFMBEGeHTHroIdA
         I+OC01iO8RcjymNH7yGWk3H/afGOiaL+P9mEh956pcLmxE9wV2TfCTd4FQFdEFrv3PfW
         35ALCY9J0/j44Yy51OvN1Qe8IDKsrShDbC8mvz5gqVQnjC4R+ffPUXcIgMH6B2Yl9fEf
         5Tcy0rGZRzyJwjcJhwsnUWYhACiY5+kEcLulYZK/NpiXiN78Ii5T6zdr9TNs30OxCGkS
         YUcksMo7swt9M8KJDvqJOi55hH5KJZCQxEHYgBjZdm3LL7eILf1GgsZ5CJW/lvv/jd/k
         KhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F12BPIt+v3XNTHcLN2A5MDSV9pIZoXfGTfiqOPQbmvo=;
        b=UYfI5KxQlY4aWh6wjJP2cn9SFb4/mB+mdq3kNmIZoEe1GF6SuwN6KjAAd69Xq/bmtb
         by4hyyT5yuyqtvXL1TlmluPZvBPTlASW5262IItTReM3qK1EFUPoPBc0YEFo4HFHHxR/
         4Qievp2eMX+GbQ7BOjDZ/z2UiTStscGas+c6B7DZe/ab5Ngu96uPZ3nNxjX3MXm4r4zF
         EF8oXVHRRQIAEFhlSZ+V5iRS+ugLeLDod2v8N/aCFYnNYSM2f1nJNG+FOOwQPgp85NJs
         V5eK1CEQpZPiwtPuRC25jJ6awE2rq/t0uizLU6WP6jqsM25LC91eN9G55DDY9DwT2ixL
         oqHA==
X-Gm-Message-State: AOAM5332DHpaxlhlO7EUFz/Qs8txUUClw/ojIn90cmu6lu2VU3q3r3m/
        rHHZ0MivFYDjNCjiEpXMFPY=
X-Google-Smtp-Source: ABdhPJz/hDG2hculQruMLjuhTELAJ15SN3en2ly8nzOxhvLqFm9LwLOj38J7ez1xlP5vihyxtTQUvQ==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr44021282wrm.271.1634651507035;
        Tue, 19 Oct 2021 06:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: r8188eu: remove unused enums and defines from odm.h
Date:   Tue, 19 Oct 2021 15:51:36 +0200
Message-Id: <20211019135137.9893-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enums and defines from odm.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 95 ---------------------------
 1 file changed, 95 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 97a24f8d2f53..eb46386ceddd 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -159,7 +159,6 @@ struct odm_rate_adapt {
 
 #define IQK_MAC_REG_NUM		4
 #define IQK_ADDA_REG_NUM	16
-#define IQK_BB_REG_NUM_MAX	10
 #define IQK_BB_REG_NUM		9
 #define HP_THERMAL_NUM		8
 
@@ -287,19 +286,6 @@ enum odm_ability_def {
 
 # define ODM_ITRF_USB 0x2
 
-/*  ODM_CMNINFO_RF_TYPE */
-/*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
-enum odm_rf_path {
-	ODM_RF_TX_A	=	BIT(0),
-	ODM_RF_TX_B	=	BIT(1),
-	ODM_RF_TX_C	=	BIT(2),
-	ODM_RF_TX_D	=	BIT(3),
-	ODM_RF_RX_A	=	BIT(4),
-	ODM_RF_RX_B	=	BIT(5),
-	ODM_RF_RX_C	=	BIT(6),
-	ODM_RF_RX_D	=	BIT(7),
-};
-
 enum odm_rf_type {
 	ODM_1T1R	=	0,
 	ODM_1T2R	=	1,
@@ -311,14 +297,6 @@ enum odm_rf_type {
 	ODM_4T4R	=	7,
 };
 
-/*  ODM Dynamic common info value definition */
-
-enum odm_mac_phy_mode {
-	ODM_SMSP	= 0,
-	ODM_DMSP	= 1,
-	ODM_DMDP	= 2,
-};
-
 /*  ODM_CMNINFO_OP_MODE */
 enum odm_operation_mode {
 	ODM_NO_LINK		= BIT(0),
@@ -341,38 +319,12 @@ enum odm_wireless_mode {
 	ODM_WM_AUTO	= BIT(5),
 };
 
-/*  ODM_CMNINFO_SEC_CHNL_OFFSET */
-enum odm_sec_chnl_offset {
-	ODM_DONT_CARE	= 0,
-	ODM_BELOW	= 1,
-	ODM_ABOVE	= 2
-};
-
-/*  ODM_CMNINFO_SEC_MODE */
-enum odm_security {
-	ODM_SEC_OPEN		= 0,
-	ODM_SEC_WEP40		= 1,
-	ODM_SEC_TKIP		= 2,
-	ODM_SEC_RESERVE		= 3,
-	ODM_SEC_AESCCMP		= 4,
-	ODM_SEC_WEP104		= 5,
-	ODM_WEP_WPA_MIXED   	= 6, /*  WEP + WPA */
-	ODM_SEC_SMS4		= 7,
-};
-
 /*  ODM_CMNINFO_BW */
 enum odm_bw {
 	ODM_BW20M		= 0,
 	ODM_BW40M		= 1,
 };
 
-/*  ODM_CMNINFO_ONE_PATH_CCA */
-enum odm_cca_path {
-	ODM_CCA_2R		= 0,
-	ODM_CCA_1R_A		= 1,
-	ODM_CCA_1R_B		= 2,
-};
-
 struct odm_ra_info {
 	u8 RateID;
 	u32 RateMask;
@@ -673,13 +625,6 @@ struct odm_dm_struct {
 	struct timer_list FastAntTrainingTimer;
 };		/*  DM_Dynamic_Mechanism_Structure */
 
-enum ODM_RF_CONTENT {
-	odm_radioa_txt = 0x1000,
-	odm_radiob_txt = 0x1001,
-	odm_radioc_txt = 0x1002,
-	odm_radiod_txt = 0x1003
-};
-
 enum odm_bb_config_type {
     CONFIG_BB_PHY_REG,
     CONFIG_BB_AGC_TAB,
@@ -687,38 +632,9 @@ enum odm_bb_config_type {
     CONFIG_BB_PHY_REG_PG,
 };
 
-/*  Status code */
-enum rt_status {
-	RT_STATUS_SUCCESS,
-	RT_STATUS_FAILURE,
-	RT_STATUS_PENDING,
-	RT_STATUS_RESOURCE,
-	RT_STATUS_INVALID_CONTEXT,
-	RT_STATUS_INVALID_PARAMETER,
-	RT_STATUS_NOT_SUPPORT,
-	RT_STATUS_OS_API_FAILED,
-};
-
-/* 3=========================================================== */
-/* 3 DIG */
-/* 3=========================================================== */
-
-enum dm_dig_op {
-	RT_TYPE_THRESH_HIGH	= 0,
-	RT_TYPE_THRESH_LOW	= 1,
-	RT_TYPE_BACKOFF		= 2,
-	RT_TYPE_RX_GAIN_MIN	= 3,
-	RT_TYPE_RX_GAIN_MAX	= 4,
-	RT_TYPE_ENABLE		= 5,
-	RT_TYPE_DISABLE		= 6,
-	DIG_OP_TYPE_MAX
-};
-
 #define		DM_DIG_THRESH_HIGH	40
 #define		DM_DIG_THRESH_LOW	35
 
-#define		DM_SCAN_RSSI_TH		0x14 /* scan return issue for LC */
-
 #define		DM_false_ALARM_THRESH_LOW	400
 #define		DM_false_ALARM_THRESH_HIGH	1000
 
@@ -726,23 +642,12 @@ enum dm_dig_op {
 #define		DM_DIG_MIN_NIC			0x1e /* 0x22/0x1c */
 
 #define		DM_DIG_MAX_AP			0x32
-#define		DM_DIG_MIN_AP			0x20
-
-#define		DM_DIG_MAX_NIC_HP		0x46
-#define		DM_DIG_MIN_NIC_HP		0x2e
-
-#define		DM_DIG_MAX_AP_HP		0x42
-#define		DM_DIG_MIN_AP_HP		0x30
 
 /* vivi 92c&92d has different definition, 20110504 */
 /* this is for 92c */
 #define		DM_DIG_FA_TH0			0x200/* 0x20 */
 #define		DM_DIG_FA_TH1			0x300/* 0x100 */
 #define		DM_DIG_FA_TH2			0x400/* 0x200 */
-/* this is for 92d */
-#define		DM_DIG_FA_TH0_92D		0x100
-#define		DM_DIG_FA_TH1_92D		0x400
-#define		DM_DIG_FA_TH2_92D		0x600
 
 #define		DM_DIG_BACKOFF_MAX		12
 #define		DM_DIG_BACKOFF_MIN		-4
-- 
2.33.1


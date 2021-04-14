Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD835FBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbhDNT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353385AbhDNT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:28:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:28:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w23so17330090ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfAx85OkCJIVXcb4Xjg0l17/YI2UWnOD3N2GZROAX/g=;
        b=Lif9KjvpplLZV4pQxvTvW1JCFouT7uzPDBHPdpvLA/mhzajjriwDMXI+rq7SU5aoqk
         K8LqGT8hx7N9vl6bUzP7+vX1fuhPtbzq1SC07nLp9mSZJH30jtPAqZ9ZsGd1GThr1Ubw
         OH/zZkf73jUW4Qh9FzpqHh4S50s7EaliB3cBsGWPfKp6zfB+6lTJzDeQE2+dVltLDKPm
         p03V9WxiVICfIinQQ4EY9YqJwyCZv5MlcC4Wud5OgoTNYZT/3+3MbzbGBz1d8Glx8EFN
         L+84rN/qP3Lx6j0G85EJ4LhIilauIVT61gbeFpWXoan25i2+9ss3sMxF8VxYXTJE8a57
         Sg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfAx85OkCJIVXcb4Xjg0l17/YI2UWnOD3N2GZROAX/g=;
        b=kvfN/yHFYS2kROpAzquvl9Y8xcuBRv2795PlUnl2PUZfvcsVRHMVnmoa2C3ckcscPi
         nPUrKK+ZuR1zbvPuccNQErQXnxEi9hwQKuGVWdKpvjBKkPM/Sd996U3+pvuBGXwV8Vf6
         Xkno/wy+6MNp2tA2jIvWw/hOQhnlhdUsY3Sd/pfEvct5lKhZgQmtiLyk0w4yv7B7TTtp
         Pkzb3jkYsFKCUfjz37Umd1n0dm2knv4OtU+AWZDTUCqIIOXIdc014dPmZGNtlAF86VOD
         5Fof9KzttrxBDXAvbluwY8/NLokfOHF4N1wveYCge3udTiHohF5bVUVm3Qp5ZLQwHfdg
         8ubg==
X-Gm-Message-State: AOAM530KxifzxNQfGuCmwxkOgr4Ay5JMMWqxDudvAaNi2FZQH8fzTYtG
        h4VWwwlTBp4j8zJk5HI/cbc=
X-Google-Smtp-Source: ABdhPJxCXkzUieoHXKPtiDeavfywnXCA0vKVb9IPpIg4hI+3LI4uH+bWJSeeTmS1Wg1v5R/IdTZCxA==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr455008ejk.338.1618428481883;
        Wed, 14 Apr 2021 12:28:01 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gn3sm259049ejc.2.2021.04.14.12.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:28:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [Outreachy kernel] [PATCH v3 2/2] staging: rtl8723bs: Remove everything related with LedBlink
Date:   Wed, 14 Apr 2021 21:27:50 +0200
Message-Id: <20210414192750.4974-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414192750.4974-1-fmdefrancesco@gmail.com>
References: <20210414192750.4974-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed struct LedBlink_param. Removed LedBlink entries in
rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
not anymore needed. Removed extra blank lines in the two mentioned
arrays and changend the numbers set in comments for having them in line
with the shift.

Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v2: Added this patch as 2/2.
Changes from v1: No changes.

 drivers/staging/rtl8723bs/core/rtw_cmd.c    | 27 ++++++---------------
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 14 +++--------
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index f82dbd4f4c3d..a74e6846f2df 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -22,7 +22,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_Write_EEPROM), NULL},
 	{GEN_CMD_CODE(_Read_EFUSE), NULL},
 	{GEN_CMD_CODE(_Write_EFUSE), NULL},
-
 	{GEN_CMD_CODE(_Read_CAM),	NULL},	/*10*/
 	{GEN_CMD_CODE(_Write_CAM),	 NULL},
 	{GEN_CMD_CODE(_setBCNITV), NULL},
@@ -33,7 +32,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_SetOpMode), NULL},
 	{GEN_CMD_CODE(_SiteSurvey), &rtw_survey_cmd_callback}, /*18*/
 	{GEN_CMD_CODE(_SetAuth), NULL},
-
 	{GEN_CMD_CODE(_SetKey), NULL},	/*20*/
 	{GEN_CMD_CODE(_SetStaKey), &rtw_setstaKey_cmdrsp_callback},
 	{GEN_CMD_CODE(_SetAssocSta), &rtw_setassocsta_cmdrsp_callback},
@@ -44,7 +42,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_SetDataRate), NULL},
 	{GEN_CMD_CODE(_GetDataRate), NULL},
 	{GEN_CMD_CODE(_SetPhyInfo), NULL},
-
 	{GEN_CMD_CODE(_GetPhyInfo), NULL}, /*30*/
 	{GEN_CMD_CODE(_SetPhy), NULL},
 	{GEN_CMD_CODE(_GetPhy), NULL},
@@ -55,7 +52,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_JoinbssRpt), NULL},
 	{GEN_CMD_CODE(_SetRaTable), NULL},
 	{GEN_CMD_CODE(_GetRaTable), NULL},
-
 	{GEN_CMD_CODE(_GetCCXReport), NULL}, /*40*/
 	{GEN_CMD_CODE(_GetDTMReport),	NULL},
 	{GEN_CMD_CODE(_GetTXRateStatistics), NULL},
@@ -67,24 +63,19 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_SwitchAntenna), NULL},
 	{GEN_CMD_CODE(_SetCrystalCap), NULL},
 	{GEN_CMD_CODE(_SetSingleCarrierTx), NULL},	/*50*/
-
 	{GEN_CMD_CODE(_SetSingleToneTx), NULL}, /*51*/
 	{GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL},
 	{GEN_CMD_CODE(_SetContinuousTx), NULL},
 	{GEN_CMD_CODE(_SwitchBandwidth), NULL},		/*54*/
 	{GEN_CMD_CODE(_TX_Beacon), NULL},/*55*/
-
 	{GEN_CMD_CODE(_Set_MLME_EVT), NULL},/*56*/
 	{GEN_CMD_CODE(_Set_Drv_Extra), NULL},/*57*/
 	{GEN_CMD_CODE(_Set_H2C_MSG), NULL},/*58*/
 	{GEN_CMD_CODE(_SetChannelPlan), NULL},/*59*/
-	{GEN_CMD_CODE(_LedBlink), NULL},/*60*/
-
-	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*61*/
-	{GEN_CMD_CODE(_TDLS), NULL},/*62*/
-	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*63*/
-
-	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
+	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*60*/
+	{GEN_CMD_CODE(_TDLS), NULL},/*61*/
+	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*62*/
+	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*63*/
 };
 
 static struct cmd_hdl wlancmds[] = {
@@ -144,17 +135,13 @@ static struct cmd_hdl wlancmds[] = {
 	GEN_MLME_EXT_HANDLER(0, NULL)
 	GEN_MLME_EXT_HANDLER(0, NULL)
 	GEN_MLME_EXT_HANDLER(sizeof(struct Tx_Beacon_param), tx_beacon_hdl) /*55*/
-
 	GEN_MLME_EXT_HANDLER(0, mlme_evt_hdl) /*56*/
 	GEN_MLME_EXT_HANDLER(0, rtw_drvextra_cmd_hdl) /*57*/
-
 	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
-	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/
-
-	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
-	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*63*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*60*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*61*/
+	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*62*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct RunInThread_param), run_in_thread_hdl) /*63*/
 };
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 517ae3b51386..28d2d2732374 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -537,11 +537,6 @@ struct SetChannelPlan_param {
 	u8 channel_plan;
 };
 
-/*H2C Handler index: 60 */
-struct LedBlink_param {
-	void *pLed;
-};
-
 /*H2C Handler index: 61 */
 struct SetChannelSwitch_param {
 	u8 new_ch_no;
@@ -709,13 +704,12 @@ enum {
 	GEN_CMD_CODE(_Set_H2C_MSG), /*58*/
 
 	GEN_CMD_CODE(_SetChannelPlan), /*59*/
-	GEN_CMD_CODE(_LedBlink), /*60*/
 
-	GEN_CMD_CODE(_SetChannelSwitch), /*61*/
-	GEN_CMD_CODE(_TDLS), /*62*/
-	GEN_CMD_CODE(_ChkBMCSleepq), /*63*/
+	GEN_CMD_CODE(_SetChannelSwitch), /*60*/
+	GEN_CMD_CODE(_TDLS), /*61*/
+	GEN_CMD_CODE(_ChkBMCSleepq), /*62*/
 
-	GEN_CMD_CODE(_RunInThreadCMD), /*64*/
+	GEN_CMD_CODE(_RunInThreadCMD), /*63*/
 
 	MAX_H2CCMD
 };
-- 
2.31.1


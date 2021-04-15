Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6590736031E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhDOHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhDOHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:18:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:17:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g5so28583518ejx.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qel2OPZGhx5lJbWSQUP/ydunsj2txfHm1wL988zsXDA=;
        b=i+DP25U6FJ2GdBJemsuVFT4rvEgX3pk41eJ97a3jwL56mNNOgPQe/6GDBtH+FpaLuq
         AbEdYBI96LtpadsR8Xf18OxHzBhMOqFK27Ceg3Q8G2qn05+a0zASoTE40J7W9ejQVNUd
         NlqI2clmxLx9vo7i9yTQ3CnRUS9NFA0ONLlWXV2oawpIHO+rZfMI22z3C+ySFImlelMU
         D3Q9QPYJin8Q/j3NnJAoTlGNW35z5HX3PjfGuzfh3R75P58hm5/+i2nY22KGuJ0NE3Gw
         SsoPnOulBvYPr9Krz3t3ubALVGM1IBzGhkdwJUc3k+U6V718lM/kxi8NnoisQhWW93H0
         Affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qel2OPZGhx5lJbWSQUP/ydunsj2txfHm1wL988zsXDA=;
        b=mL+sd38lwfn8Vn/NkZrRLwbpLIiKh504I5Woue6DXT0ILfpq8UR7T9PEPmmjt0UVXI
         Abtkvdm8bG+kUNSCrJ7CpbOiwh0NvcV6rg/JMMfFiA1byFSR8CXgwi0bkPEFVEx1ic2J
         losmJu+dX4qrlEiUo1EqWLNeVdHN5cKJy/4+TmuFpdPgI3UwysvJLYfrAjPR5MCZ7NlI
         PMVAPICzzaOsTYT4qZoVgIG+Vq0544a65SivCoLVqQSIzOJ4jB5xPG+AyvOe9/UmrpJx
         cUXq+bKiYMGJ2e+DidXly2QjqHh8jF/XHsyDV95ZdRLNfXtrISZXatTcK1ujXIEf3Zm+
         Qt1w==
X-Gm-Message-State: AOAM532kjhqMUYwK4pts6joub9JMTnCJ+OZXeRBenuKlhoRhrdjdTITA
        Go2yHx1mHPwKUw5jsTTNo3rxOjZ0EFmSzlj4
X-Google-Smtp-Source: ABdhPJwEMfSMl9tZaJHUYW6ZGaTBoRVpJqYg9ZmjSFWEZmOyrmWztHkGr/5X0NMKgzCs0l4Ns3qjvQ==
X-Received: by 2002:a17:906:3018:: with SMTP id 24mr2003959ejz.186.1618471057647;
        Thu, 15 Apr 2021 00:17:37 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id d15sm1237733ejj.42.2021.04.15.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 00:17:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4] staging: rtl8723bs: Remove led_blink_hdl() and everything related
Date:   Thu, 15 Apr 2021 09:17:31 +0200
Message-Id: <20210415071731.25725-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed useless led_blink_hdl() prototype and definition.
Removed struct LedBlink_param. Removed LedBlink entries in
rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
not anymore needed. Index of slots changed in arrays comments to reflect
current positions.

Reported-by: Julia Lawall <julia.lawall@inria.fr>
Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v3: Merged the series into one single patch for avoiding
unnecessary intermediate stages.
Changes from v2: Made a series and added another patch (2/2).
Changes from v1: Corrected a bad solution to this issue that made use of
an unnecessary dummy function.

 drivers/staging/rtl8723bs/core/rtw_cmd.c         | 16 +++++++---------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    |  9 ---------
 drivers/staging/rtl8723bs/include/rtw_cmd.h      | 14 ++++----------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h |  1 -
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0297fbad7bce..d834a82aaf55 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -78,13 +78,12 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_Set_Drv_Extra), NULL},/*57*/
 	{GEN_CMD_CODE(_Set_H2C_MSG), NULL},/*58*/
 	{GEN_CMD_CODE(_SetChannelPlan), NULL},/*59*/
-	{GEN_CMD_CODE(_LedBlink), NULL},/*60*/
 
-	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*61*/
-	{GEN_CMD_CODE(_TDLS), NULL},/*62*/
-	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*63*/
+	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*60*/
+	{GEN_CMD_CODE(_TDLS), NULL},/*61*/
+	{GEN_CMD_CODE(_ChkBMCSleepq), NULL}, /*62*/
 
-	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
+	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*63*/
 };
 
 static struct cmd_hdl wlancmds[] = {
@@ -150,11 +149,10 @@ static struct cmd_hdl wlancmds[] = {
 
 	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
 
-	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
-	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*63*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*60*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*61*/
+	GEN_MLME_EXT_HANDLER(0, chk_bmc_sleepq_hdl) /*62*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct RunInThread_param), run_in_thread_hdl) /*63*/
 };
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 873d3792ac8e..963ea80083c8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6189,15 +6189,6 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 	return	H2C_SUCCESS;
 }
 
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
-{
-
-	if (!pbuf)
-		return H2C_PARAMETERS_ERROR;
-
-	return	H2C_SUCCESS;
-}
-
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	return	H2C_REJECTED;
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
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 5e6cf63956b8..472818c5fd83 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -745,7 +745,6 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
 u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
-- 
2.31.1


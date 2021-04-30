Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3211036F69E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhD3Hqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhD3Hpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A1C061348
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so81487100edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=PNjPaoDBzfbnZKuYSYtUDG2oRGshZrqGSMVYCPdiF9tTUX3RxxaBcxvpZ0i4/XuBXO
         IIR8SM3OHKudaubAA3nnfVJAt7JLYN+eHMtAlvi8X6wdSZBrFzjCylrSgHISVHLl8hwa
         +Z72rebzTYZ09BmLpIQmO3zM8t6Nik6jrOleug5AOKqcOmDcu/TyfgcoIC44ADGSkhuu
         kQoHFEMgSFQC1pNhCF4PzrMv2LoqWHNSjm6I+foJBWGJ7GxxMMHvs2p2Ix5SKDLhp5bq
         ugWanh1gVoZmIwZDwe3szyOwauVX1VIGJ7f7jXYxAM/oLFGWtEMFYjFREUBtjkHlPiUw
         PfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=Jz5bssCiTgcaZZr4Tosj65wPLNXTuo8EckgkpVVkFkwBcUYdlpktKZ+Ei4cXvncQ7H
         xgoUEOVgPeukhGCXcs38Hnz1CTdmnCGOaMJ4L4/aNSawrIpjBRgK5gWmtj0aolZWMjIF
         KssRklCm/W7ZibMLFGIypsyJEbqptzDoBb33a+qqMh7XIvn0bF00irI/ANMHHjFsabSC
         bpDWWe6OHj3I3g1OBV7xyeBk2CtyjV7ANbUCfKokq4JTzT+PucDB92WEX9rwhHKrrccp
         xbii4fD/vszJT7m/vyvDlz5syirM1x3AXEMP2xOfWuKB3+Uny5QfRsj6D7RvGVl6ScsR
         25nw==
X-Gm-Message-State: AOAM533hvPSybtZmq984/IM8oBnOw/X1iz6tdPI+T1qK9bD4Av470OO0
        VRLFxQtJkViKrYJW1ZCA/2/4sHMXc1C/8w==
X-Google-Smtp-Source: ABdhPJxfJU3tz/p4oMifg2GMmyqH5A/3RLiPMbPqzbcjcJuDPgY490iE4fixKn6z3FDhj60gMbEQvg==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr4191751edd.116.1619768695113;
        Fri, 30 Apr 2021 00:44:55 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id i4sm1429496ejv.58.2021.04.30.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 30/43] staging: rtl8723bs: remove hal_btcoex_GetDBG() function
Date:   Fri, 30 Apr 2021 09:43:48 +0200
Message-Id: <f9bb3f1f0735f1f97c23da0db1a4c242459206f3.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused hal_btcoex_GetDBG() function definition and
prototype.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    | 123 ------------------
 .../staging/rtl8723bs/include/hal_btcoex.h    |   1 -
 2 files changed, 124 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index cac2d6077403..02d9997094f2 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1492,126 +1492,3 @@ void hal_btcoex_DisplayBtCoexInfo(struct adapter *padapter, u8 *pbuf, u32 bufsiz
 	DBG_BT_INFO_INIT(pinfo, NULL, 0);
 }
 
-u32 hal_btcoex_GetDBG(struct adapter *padapter, u8 *pStrBuf, u32 bufSize)
-{
-	s32 count;
-	u8 *pstr;
-	u32 leftSize;
-
-
-	if (!pStrBuf || bufSize == 0)
-		return 0;
-
-	pstr = pStrBuf;
-	leftSize = bufSize;
-
-	count = rtw_sprintf(pstr, leftSize, "#define DBG\t%d\n", DBG);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-
-	count = rtw_sprintf(pstr, leftSize, "BTCOEX Debug Setting:\n");
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-
-	count = rtw_sprintf(pstr, leftSize,
-		"INTERFACE / ALGORITHM: 0x%08X / 0x%08X\n\n",
-		GLBtcDbgType[BTC_MSG_INTERFACE],
-		GLBtcDbgType[BTC_MSG_ALGORITHM]);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-
-	count = rtw_sprintf(pstr, leftSize, "INTERFACE Debug Setting Definition:\n");
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[0]=%d for INTF_INIT\n",
-		(GLBtcDbgType[BTC_MSG_INTERFACE] & INTF_INIT) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[2]=%d for INTF_NOTIFY\n\n",
-		(GLBtcDbgType[BTC_MSG_INTERFACE] & INTF_NOTIFY) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-
-	count = rtw_sprintf(pstr, leftSize, "ALGORITHM Debug Setting Definition:\n");
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[0]=%d for BT_RSSI_STATE\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_BT_RSSI_STATE) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[1]=%d for WIFI_RSSI_STATE\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_WIFI_RSSI_STATE) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[2]=%d for BT_MONITOR\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_BT_MONITOR) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[3]=%d for TRACE\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[4]=%d for TRACE_FW\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_FW) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[5]=%d for TRACE_FW_DETAIL\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_FW_DETAIL) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[6]=%d for TRACE_FW_EXEC\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_FW_EXEC) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[7]=%d for TRACE_SW\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_SW) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[8]=%d for TRACE_SW_DETAIL\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_SW_DETAIL) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-	count = rtw_sprintf(pstr, leftSize, "\tbit[9]=%d for TRACE_SW_EXEC\n",
-		(GLBtcDbgType[BTC_MSG_ALGORITHM] & ALGO_TRACE_SW_EXEC) ? 1 : 0);
-	if ((count < 0) || (count >= leftSize))
-		goto exit;
-	pstr += count;
-	leftSize -= count;
-
-exit:
-	count = pstr - pStrBuf;
-
-	return count;
-}
diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 9048499e756a..eb9d0ba861a5 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -53,6 +53,5 @@ u8 hal_btcoex_LpsVal(struct adapter *);
 u32 hal_btcoex_GetRaMask(struct adapter *);
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen);
 void hal_btcoex_DisplayBtCoexInfo(struct adapter *, u8 *pbuf, u32 bufsize);
-u32 hal_btcoex_GetDBG(struct adapter *, u8 *pStrBuf, u32 bufSize);
 
 #endif /*  !__HAL_BTCOEX_H__ */
-- 
2.20.1


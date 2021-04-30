Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4C36FCCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhD3Oqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD3OqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCBC06134D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t4so22344169ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=LVBMMg67l4taR31IN3XgjFIOVq1N4KNMj2Vf42zt7IaRmgo/cGx3wdlrzv/mvAa6Kv
         pmTOf87VHJMrXdt2fXZTupNOc/fXv3IU/TSuzX3PCaZNARrrK6IpwNY4OVANRx2FYfOy
         UQkOzT1IbYavyW7MrpynWssgx2AYNGe1pJiokIqoXy2inMriTxUaaTv7mp+E93FIP+At
         jASGMQiSCIeQDBoN1uy7M1tAZSgga/ermg7OVrxtqVDh7wh4LBCcygcbfOAnKVst0Z9L
         mI+y81O0rvBDlVy4qenCb4cjzLcjb9LNZi/3kAGT3eFliHb9BcU92pUVfJakeaBMgiB4
         CsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=BFDJvrCUDj2VmlnZDDh0jDf0RrVv5CEa0PKBxiGwwtMzUI3uBaVQiq0QrQjhlv1V7B
         GQdi+QAk/lfPBZ9o5LfqdXNDle5aWpKqKgq32JUImDOwCuM3uuWg8mLnv+BcbQn3voM4
         +KpoABQTntagFg0lSywND955fJdHfc3melXUC2mAo6f0jwS0b+aoe5GNv+y4TnRUgnI7
         gwNRNp3B6dt+YvXrwFiYYxjZDIZnPsmAA0c3YAVyFtN0enXEUu8XeBJ6ys6iXi2Qj/QN
         ZbxNzyOZChwOxBoCYanz8j2l4rmExJstxrrX9tdug2/IZGEhhlHi8AstAlqmza1XHbZV
         r0FA==
X-Gm-Message-State: AOAM531ztmPr8cccQZaUvyxI7vstuAjDov2+Qx5b0Y2BDQh37zVWdTUg
        J0ENvkTlgIa49PI/LcEoaYmw5N7dJAU=
X-Google-Smtp-Source: ABdhPJwBgYegRmG+ormUkzCwY7kLd0s8u2MGMB4YbhbHi4H7uD46DguquufNey5K/doP2g5S0OgzMw==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr4881058ejc.476.1619793899527;
        Fri, 30 Apr 2021 07:44:59 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id a22sm1448234edu.14.2021.04.30.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/43] staging: rtl8723bs: remove hal_btcoex_GetDBG() function
Date:   Fri, 30 Apr 2021 16:44:00 +0200
Message-Id: <cfac6fa149e983377f9fdba798103d432b103486.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1197336FD17
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhD3O7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhD3O6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC85C061352
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t4so22407553ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=fVHPKcMKa/S9dO+O5iVKxoFS/kcSZFglV5HxNDv1dg74vTispDQXa3vh978mR35S+0
         3fnpnEs3/cH1DUWVnwvt2Gsa7jLc198PZXVArFcIg+69TS+rZFUw79F1F/kkpdDbwdGd
         0WmwlBgQ3e6rY8bPeK4J6CHsqrWsslsb+h3ltuj11igG3w5juUP9XGzZ6rHbZ5lCY+mq
         lIt8qf30mR1NvBlQEqUu29u03v89It527T9vzCU/RNyBycu7ucp+41lbjCRfopg59K2J
         vzwiRT3dIDPEKDj+m1oRMaYt2HWFehesYXPXNZII7OmfAT32ju3/S0I/HDBGI7sK79J9
         Eu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUdMFn0pzx+qCKX4tOp46p2P1z+8kq23wVz0Evq/QVQ=;
        b=uO1CzlDDt6vTV4fMmUqwV50k7h71WZyu1oDrtqv7E3zm2bmZuSemIatoqaRJQT6n4+
         hKerTF2CF9bqJ87uclefKZwqAUb9hUUaG4ZGn0g/2kH7vGNgPHgiS7LGyd5gTR5SCx0R
         jnxYvYery+zNWf2SwuN8dHamDCZKB/1llIn2pz7KQh3wb8dTOpicdj7x78lBAwlMkn6o
         Bj7N6BOhXLU9CSWOWFyzDxLSHdCmm2EI0OH6pKssk8gc7OhuVpYm6+XnNRUOvlocNOTI
         8X4ZdK4d92Zi/ct3zIp0MzxnkGZxB+7vQIJh1xXZbHH4mQo3NcBNw1TyK4MLPHNlSB5y
         wWxQ==
X-Gm-Message-State: AOAM532QWpkI95bxdKgL0d1gGkO28na6sUe5RiEk5/CZinVA3FXFjMNN
        HOlg24MwFGEBTcLdt5sSd6Ue24lLFLs=
X-Google-Smtp-Source: ABdhPJw+3oTkE1uxWIoUqQDi9ywnrSFiKEoxFmSEBYVACSL3x+jAf57N9GrQvKvsZa8kMdac+7Wztg==
X-Received: by 2002:a17:906:1dd3:: with SMTP id v19mr4753188ejh.4.1619794676596;
        Fri, 30 Apr 2021 07:57:56 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id re26sm2117832ejb.3.2021.04.30.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/43] staging: rtl8723bs: remove hal_btcoex_GetDBG() function
Date:   Fri, 30 Apr 2021 16:56:52 +0200
Message-Id: <8b06dc12a65ef15f3e67bd32d097dc4db3f78586.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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


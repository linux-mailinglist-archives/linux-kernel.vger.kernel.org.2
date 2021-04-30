Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6683E36FCCA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhD3Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhD3OqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6EFC06134A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i3so57234380edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=eX2FTUUqCF9IJcSgsL2f0pytSl95/5JIUnBu1KYeeE9BF8lc2nor+zv5dnlXJF0MCb
         EMePxEZ1jOC/G9wnIk92xoKa1yLVzcPPJ1imFcfjoo6OVrIjMked7IVqamvR+Wehc2H0
         NaAVp6PIYITypPiJ2MM/3QgR2H825B5F0b0ZSXi5LoKsAZp0Ks830wRm36350MHGQELE
         wKmzLZpQqV3L54OMvXQfth+uGK3Q8Gk7YUlvvSmiQRjHd1IDqNFNlQ/51X9lbzKZgdnZ
         qTdMYEgEUxXE7kqeZbymyKzzMbBrNcZYd+Up4GL0HpoAfeDkldwDcv/p3xhuORWYk7o2
         HD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=N/2gsGBk7EaYT8ydO5DeKgIC/zmR4o4p1DytotPo1Sc+ILWeeciCIiPdoA5vj/r/Wm
         8li07D5l1FIrkXGzV868dT7CAGPiwznms/lud76coT0+1PdmIIeKzKjRJChqIEXkkKc/
         /LV1/DZhMB5/J8KSABOOQMJSjsDTvj4oc6uZba11wGWL/ui8eHV2pfpZrpea3RLtD+Y7
         tWL6PIERNLvT9DFe4e9ISbWDpyD6s1N9+wf/htYZZsNWnO1UK23Z0ZcYyITqnnF5VNbs
         3SRCnlx0YxBkpG0jTnwKpt28f942pNIoUPfYnyz5k0Wh1eKZ7ggIrehu/vJN/RV4vdE3
         VUEA==
X-Gm-Message-State: AOAM532aMUvGrmgyu1xYk13zc3H4BSGPLPj802X0D1sooFxA9/4b3Upg
        eUiDnY5dqZVs4bJb38gwvgir1hv4WBI=
X-Google-Smtp-Source: ABdhPJxuRNHKC615TCh2qI2M9ZeHFvHxYNv1so7Sz8ft1jWVy0jWMdYEbLc/JfcnrQe79VCEgE0niw==
X-Received: by 2002:a50:82e2:: with SMTP id 89mr6409983edg.0.1619793897987;
        Fri, 30 Apr 2021 07:44:57 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id dk13sm1522287edb.34.2021.04.30.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/43] staging: rtl8723bs: remove unsed hal_btcoex_SetDBG() function
Date:   Fri, 30 Apr 2021 16:43:59 +0200
Message-Id: <c0e39a96c48a62fa79609f51de1d15abfee92061.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused hal_btcoex_SetDBG() function definition and
prototype.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c     | 12 ------------
 drivers/staging/rtl8723bs/include/hal_btcoex.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 30d763b48349..cac2d6077403 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1492,18 +1492,6 @@ void hal_btcoex_DisplayBtCoexInfo(struct adapter *padapter, u8 *pbuf, u32 bufsiz
 	DBG_BT_INFO_INIT(pinfo, NULL, 0);
 }
 
-void hal_btcoex_SetDBG(struct adapter *padapter, u32 *pDbgModule)
-{
-	u32 i;
-
-
-	if (!pDbgModule)
-		return;
-
-	for (i = 0; i < BTC_MSG_MAX; i++)
-		GLBtcDbgType[i] = pDbgModule[i];
-}
-
 u32 hal_btcoex_GetDBG(struct adapter *padapter, u8 *pStrBuf, u32 bufSize)
 {
 	s32 count;
diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 3c03be210d87..9048499e756a 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -53,7 +53,6 @@ u8 hal_btcoex_LpsVal(struct adapter *);
 u32 hal_btcoex_GetRaMask(struct adapter *);
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen);
 void hal_btcoex_DisplayBtCoexInfo(struct adapter *, u8 *pbuf, u32 bufsize);
-void hal_btcoex_SetDBG(struct adapter *, u32 *pDbgModule);
 u32 hal_btcoex_GetDBG(struct adapter *, u8 *pStrBuf, u32 bufSize);
 
 #endif /*  !__HAL_BTCOEX_H__ */
-- 
2.20.1


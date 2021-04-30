Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963A236FD16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhD3O7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhD3O6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7652C06134E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f24so7144982ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=vTf7SNlFdufji5mPBBnF/GSJA30nUvi9dPT2MeqdJR5c3J6YT2WTxbNsM+KdcGiw/d
         beCumluAs7HxTKYhMtyNjusLof7Ybi6zsn05Wp+tUe35fkr20FSsRKMfolpVGPkdgfBp
         WfvJ+yS5HqCargTc5ibB7/kTiU7dltBXXCg8L5v8k+t5kP7US+9+A+kw/9cxdskUit/r
         hG0LHyKkkjsh0Ah0LW0MqlcrI5WHRyKA8rvmC2D+N2o0kI9azNUBKIEwPmI6bNbK+lQ/
         QY+x+pMLPq0n51rrVxtOtTaYY4d2WKyjp2eeKtYrasFZh0An9VHHtmRB5h/NlgoIjYvh
         OYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=gdO8BLVkyexqrDd4Bx8cVu936DEX+oLk2tHT9CQ5rmBdmnaRUNXWZ4z7HK0AfDAWAc
         tX9K0vMdPtwlUjommb+t8UX38VdqmO1OvO3fX8yMa9FqEzh9q694KrdjYzJk4zw/xefv
         ufqLpBUMzNqTtE3Sx4DBOTrsjcvttwrXxP44+lSOgez+VGg+4qntm4ORUW/eNOBBxcP8
         NS1TOKu15Z3aPF8gRnx3IIjoUMc3YGI721lr1V99VvNqjtg0qNHk+VrdDcMJCT/ebehs
         UOgphar0lQIWdBpzII1c0CXvAmrM6M0rOC0sC6UKs83NxK6eyAbINTElq0jCNUwkn3dF
         igYw==
X-Gm-Message-State: AOAM5301XQbrKIYGqYP24ihgbI+ueYy15hvDnxCFueMPfdIkHEGND6ga
        R51/uApeRIhi0kpqsT7Ukm+vpo46UV8=
X-Google-Smtp-Source: ABdhPJzZ/g03twHVsqlxXIZnO2o9tqxqr1tboktV8WoHP1g14QkNcj1sneWlLlgeMhocvvDT0RVqjw==
X-Received: by 2002:a17:907:2176:: with SMTP id rl22mr325872ejb.155.1619794674905;
        Fri, 30 Apr 2021 07:57:54 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id j7sm1481570edv.40.2021.04.30.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 29/43] staging: rtl8723bs: remove unsed hal_btcoex_SetDBG() function
Date:   Fri, 30 Apr 2021 16:56:51 +0200
Message-Id: <4f8aa4e4312777aff1aea621d26c00e81754025a.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57C636F69D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhD3Hqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhD3Hpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED7C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so81487015edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=hdnxRlbsuzZqIwtskBrPu475JDPPw4kX6b7Qo7tOuH3L7FznOZ1O+Lj4s2XZMB2zQo
         mBmTu3CQvOSLy6CuIr8e6zghKbT5+CsdZ7WRp9IJzyj989Mz3jySZ1S6/uCw3fgECykk
         7mquGRgoukaRBo0mVpN3sSflv/NawmnkCTXLanJTJMVRZIjU/4dMkmjRlJkMMYIj7hD7
         XL95tzVxY7nmnSK2NWnlb/rlRoguZsG+WFZG0aewSvkpbegLDyp0lvZt5Xk2IWv5UZvK
         3w7N1SW/7h3PKyDU+0z/PgenNRIc0WayWp+mddZlKYZEf9kRVl+hjs4ELbqx0Y3wl74C
         YO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0VrDyabi3mV4M4fhUFp6n3KhHlZMOtcz1Nzpn72r40=;
        b=Qv7BSVDdebXV8U/7NHnw15LFfQEksFV30kHh9o8ZqR0Rwm/qvDqwpGyI98+5/JfQGX
         HkOPFch5QKK/ylfL07MTfGPmh/QUNPK5UnyCtm/ELyIMi16mr0VP25NVM4j1h4/Xg8b2
         oPsxt3iv/HLleesfaIJ9v5AK4fhy0TT1ig0w/40lDFOAeLLWkUBX3NDYUsqVCNg58N7c
         ZpsM+80Gjak2bDIFNxCJjGvWd3anmlF11X924B2rqLwzLzSNA1qXlPbLOdZoeas2E5QU
         a5mV8ORsDYtKty7TGO+spOPmKgqi+yd/IEyn27Dcjw9yP+CVKnQ3dXLTuc58uxfe5lCT
         5E1w==
X-Gm-Message-State: AOAM5304fqQ6rfGW+firDVBvq1ap7WmQn25XFp/D35vd0XeVK02h8tTQ
        LheijttvXfiDSusob/j5btOd97StP4q4EQ==
X-Google-Smtp-Source: ABdhPJxnen2/Y1KaKLlGqB8dBopjyOcPovBAChb33XN207qqh5mT2cqHxCUGev6+fzwI5dE4x0t7qA==
X-Received: by 2002:aa7:d589:: with SMTP id r9mr4102869edq.286.1619768693427;
        Fri, 30 Apr 2021 00:44:53 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id x7sm1408238ejc.116.2021.04.30.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 29/43] staging: rtl8723bs: remove unsed hal_btcoex_SetDBG() function
Date:   Fri, 30 Apr 2021 09:43:47 +0200
Message-Id: <6b21b37582c53cafe14eb15fa034b36b68954a2a.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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


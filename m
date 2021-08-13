Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDB3EB9C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhHMQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHMQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:08:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:08:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n12so16135489edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXQ80Gs0H0ckHUhiV5CBPamMCfkNtK9JJS8DplDPVh0=;
        b=C+/eBvISmrWAxL30BXiIrSYvtBlT2cP/bl5ecbUJINRUl23pXihPPOZozfj1WW9Cko
         g+peHw+l1sf3X0Jff/1VCsk97fFD/1jMzfyta4RmpPe6CIUBBE1sMJVazzh2aDwRPNyd
         /usQVQWhm3gZnUQemrAAH5ILUdUrgSPMJ5VCvpJDSh1xFT/JYqrnSYYLDB40DtdzfoiM
         AuEPRHq184/MlWmIEIuoLmXKIM6b0Mw1J8qmA1s0hdqhgL+Ir0lsN6hrJQOgBGCsBWHN
         yRfLY1eRYsNig/GuVK6SUxyS0MKYVFxLCDKJcc1lE57wqKCFo3OzcK8aHMxgfEVDiWoR
         0pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXQ80Gs0H0ckHUhiV5CBPamMCfkNtK9JJS8DplDPVh0=;
        b=bM/3GX1PE2j2U2G6GiAqjGRUSFV68/StorK3bbNFqLzZqD6d8CpUrELQQ3WEZFnGYL
         DecCreyqlaJ39ynEu7ab9UJFxRA9iZRdhJ9stTLNyXJGvmkmqjGaLFsiLgHP/DVkARub
         7YFCnyF2Tn3HyMlocyDB4UCgcudvqDuU/rgBdtsb9o2v3SqPV1IRjK6YZ2nuZilmaX5l
         3GKypAPfjkbnj+5YrL4k20vqVyGvn/ronpapSEN7A97gDwu5Dbo950hBmTcpduiCSssk
         pPfxbSC5bWotNBlAusICfzDRg/k0SmFKp/hiRZbvbbx0XMru/jsJMyIHj1R1r+RimryI
         /tkQ==
X-Gm-Message-State: AOAM533UI3l23k+3WfzJP4UmvdmdbzFnYg3tj5IaCN0nTLXpw96wVArR
        EgwTYfbIy+RfMPmV1j+HbyI=
X-Google-Smtp-Source: ABdhPJzEngTX6vrqGbuHEb2U8rOaX0JKh3br/was1EZUscFkM8GCSzco7Uxk20wuttNU6BUIU85BRg==
X-Received: by 2002:a05:6402:35c7:: with SMTP id z7mr3982152edc.85.1628870895584;
        Fri, 13 Aug 2021 09:08:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id a3sm1087817edu.46.2021.08.13.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:08:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove variables and simplify PHY_SwChnl8188E()
Date:   Fri, 13 Aug 2021 18:08:12 +0200
Message-Id: <20210813160812.17603-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "bResult" and "tmpchannel" and all tests and assignments that
are related to them in the code of PHY_SwChnl8188E().

"bResult" was always true, therefore its test led to a null statement.
"tmpchannel" was used only to restore "pHalData->CurrentChannel" to its
previous value only if _PHY_SwChnl8192C() was not called; therefore
assign "channel" to "pHalData->CurrentChannel" if and only if
_PHY_SwChnl8192C() is to be executed (and get rid of that temporary
storage).

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 02955b8c4005..9af91ec92d36 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -1091,8 +1091,6 @@ void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
 {
 	/*  Call after initialization */
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
-	u8 tmpchannel = pHalData->CurrentChannel;
-	bool  bResult = true;
 
 	if (pHalData->rf_chip == RF_PSEUDO_11N)
 		return;		/* return immediately if it is peudo-phy */
@@ -1100,17 +1098,8 @@ void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
 	if (channel == 0)
 		channel = 1;
 
-	pHalData->CurrentChannel = channel;
-
 	if ((!Adapter->bDriverStopped) && (!Adapter->bSurpriseRemoved)) {
+		pHalData->CurrentChannel = channel;
 		_PHY_SwChnl8192C(Adapter, channel);
-
-		if (bResult)
-			;
-		else
-			pHalData->CurrentChannel = tmpchannel;
-
-	} else {
-		pHalData->CurrentChannel = tmpchannel;
 	}
 }
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5C417C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbhIXUvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348455AbhIXUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:51:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC797C061760
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d21so30940496wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1PU/DWp0zhZhGgDyFhxiTEWeLIl4kkj5NZM4AVkHRY=;
        b=KWMUh8xl8UaxNJA9SYFksYkUTnqvDinC2cBfe+fcEnzH76d3JLIYlIZAm5+NeJDmXT
         klgQHmhK8tKgOUqqRfITQSpnUdf+i7X2WhFyLKXqkntXwI/TxAm+G96jbd1SVPUtxiqJ
         xILi6i+WU/vv7dIniGDnV4decjP4yr+eWiWawZSkOesb9lGYh/C2szzTRvRmfFkMZq1z
         JIC0wcyQFM9OrTereDX8n8utTJP7KACFPXAKI+AJ+ytkBzltwvJwj/zI+ly/z4l/ykPC
         GVHbRVPQrx9DwOiWXFvTAraT0KvxLERZT/ecUp1lqyPPEHGUuGAz/YRA43JkoHwcJh0q
         3Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1PU/DWp0zhZhGgDyFhxiTEWeLIl4kkj5NZM4AVkHRY=;
        b=4xPB7zbxwr2M5253AnwpFh3lgyEehAM1wEq69GpQvmGGmBhmjE2YlUuVsHzLinxu5L
         fcmFjI/UUKpnMeaIiIXsqjtY83b93Et8SM9KZrfvwoe+nVxK4DR5Vp67JkMY5xrZ6S+T
         VkPWReThrpBiXGH3ISIDbuBdRr/Ws6uvuIi1NQwARqzz7WBctDHD8Qoo9UcdEPioRSf1
         fa0NsXSy0Vhnh6C3R7z1o2po6S21ly9LR41SU35pelRC6wcdo7ic611MovMYhHvo4evy
         Xy+pghKOIF0EobABhmj67Yp1+RRYHlyGcQYGCfQTCw/tCGE8xFqbWHF5pWtuIIvFGyrL
         2lGw==
X-Gm-Message-State: AOAM530kFOdf4tMgdE1elrODGjhD+nVWrOKGrkeeS7G+GzlOFVOpEBuO
        7Qm3RWjh/uWeDvmzvh4z0iw=
X-Google-Smtp-Source: ABdhPJyHdhmt9IB8ff6bR64KP46d5Od5N17Qz7RPmaU/12/FO3aFlJepyfDtYRaJ/8waoTbiUSTHQQ==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr4083424wmq.166.1632516572504;
        Fri, 24 Sep 2021 13:49:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51da])
        by smtp.gmail.com with ESMTPSA id j19sm9040292wra.92.2021.09.24.13.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:49:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove _InitHWLed()
Date:   Fri, 24 Sep 2021 22:49:16 +0200
Message-Id: <20210924204917.6313-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924204917.6313-1-straube.linux@gmail.com>
References: <20210924204917.6313-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _InitHWLed() does nothing, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 097fb42bf7b2..483a3b0ea94f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -403,18 +403,6 @@ static void _InitEDCA(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
 }
 
-static void _InitHWLed(struct adapter *Adapter)
-{
-	struct led_priv *pledpriv = &Adapter->ledpriv;
-
-	if (pledpriv->LedStrategy != HW_LED)
-		return;
-
-/*  HW led control */
-/*  to do .... */
-/* must consider cases of antenna diversity/ commbo card/solo card/mini card */
-}
-
 static void _InitRDGSetting(struct adapter *Adapter)
 {
 	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
@@ -830,8 +818,6 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write16(Adapter, REG_PKT_VO_VI_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
 	rtw_write16(Adapter, REG_PKT_BE_BK_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
 
-	_InitHWLed(Adapter);
-
 	/* Keep RfRegChnlVal for later use. */
 	haldata->RfRegChnlVal[0] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
 	haldata->RfRegChnlVal[1] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
-- 
2.33.0


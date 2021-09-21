Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12331413AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhIUTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhIUTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A211C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u15so93487wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vh05SKxl7lxX8F8/fcAY/OkP0eJgGhNwDaPrfeFnqi8=;
        b=UvC4RB+bIDEv6a53MUJ7f9o9bANl1pdMe4TwFep+cLCPUANVn6TC3fNukSk0iGprFM
         OqbY6aZS16RCBJzmrmmkK1YGrHTmIqMUkBLwd4SdfezbD+HJYoVv+lVRcovkn8R2psql
         XQMNK/03sCCZxZueuW6M6sInn7Ii0aKf19F6QTzjXem54Vqyn5Qp8cvK8t4eCeag1OlO
         tTh2TOKwBrjsd0ecCetbNx/nBXF90OruxwiY2HvrYkpvL3BKid4J7ppP32Cdot+c2x76
         5liqIAizQ+stJwc79sQa55owVy942c6WLIc4S59G2kJ2327vaXNqNBgvnaplFKZMN5gf
         jMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vh05SKxl7lxX8F8/fcAY/OkP0eJgGhNwDaPrfeFnqi8=;
        b=l4CZypQ6w2jXu0XA7OjbQA/fAMOm3WeeNr8c0kqIEc9H6c9G007q0eMC2y+sLkouQM
         dOJteeBIuSAfaHRGuUBJFJ4EmDzDbWyJyasHd59aXlWzQqZkn3EjL/AmG6Khxf1vBb0w
         4sOSTfvfW01LHHPxTpB2+Ru/zTTxPTF7mI4KqBELgMUxyzBwYpB80VGtg78lBostpZqE
         iGzwMaS/uTpdhLOX2d//mBgIFkaogEEiJV9lpRuVAYZqORfpBwpKQb46qyipSx4m2Q0x
         5pfeqRHsY1myn0F5Wm4nNMSbO+vQ4/bSevrtde4Z5nm+ef27myPSOspnglONqn3Q/d1O
         9iEg==
X-Gm-Message-State: AOAM531lmdYtau3/RInEkc5BeidNByBvZW1oLW9iujs45KSI6YiHE1bX
        Coxmsck96SEvWPPk7NwyA4A=
X-Google-Smtp-Source: ABdhPJytrho0jHGr+ofEuQ60o7zpZ6TSCvrV36I/xjNsZPuko5VNXHoMK+1kL/02LETMAn9tiuYD1A==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr12119525wru.250.1632253642062;
        Tue, 21 Sep 2021 12:47:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: r8188eu: remove odm_DynamicTxPowerNIC()
Date:   Tue, 21 Sep 2021 21:46:51 +0200
Message-Id: <20210921194658.10654-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DynamicTxPowerNIC() does nothing, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 12 ------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 40eb1a938f8c..9fc36ec2f56c 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1207,7 +1207,6 @@ void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm)
 	switch	(pDM_Odm->SupportPlatform) {
 	case	ODM_MP:
 	case	ODM_CE:
-		odm_DynamicTxPowerNIC(pDM_Odm);
 		break;
 	case	ODM_AP:
 		odm_DynamicTxPowerAP(pDM_Odm);
@@ -1217,17 +1216,6 @@ void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm)
-{
-	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
-		return;
-
-	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
-		/*  ??? */
-		/*  This part need to be redefined. */
-	}
-}
-
 void odm_DynamicTxPowerAP(struct odm_dm_struct *pDM_Odm)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index cd8e3d2db212..91f74d694770 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -57,7 +57,6 @@ void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
 void odm_1R_CCA(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm);
-void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicTxPowerAP(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0


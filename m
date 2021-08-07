Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89C3E3471
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhHGJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhHGJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD74C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so4268956wrr.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULeafM1R3YduxD1dAv+SkYM7oMOT+IRds1g32q9BMXo=;
        b=hukA4IRMFM2o8QrAOywMzSxmDBju1xUuI/lLLewvaqvTB7VIHceZMK1OcyScko9QDM
         tJpOQiTtCXPLOgYEAKWBWHm34cV/oD1+GpKgAl+lPFmnVLFpYb5cEuGLpjAMpWh3iETs
         cuka8MUOcaWF9v68ty1ntxA/RUBl3/RljLAW56PdFQhROoJ/QvCy2LW4wFfgi/9Gt3L1
         yzZrjM8OhsC6WqwOhR+ifCy2VBZQKFC1DN4qHchHADsqHwQoALcQPD1mEQ16YQ6FS3is
         CTiMgCH7MvR2dsbNUofhXkn9k6UqZm0Yzs5W9+r/C98s8Axm//V2BFGxadceIa+Uzfst
         I6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULeafM1R3YduxD1dAv+SkYM7oMOT+IRds1g32q9BMXo=;
        b=ZA0/ZrRElI8QEOxHwl+yQtElO53OceHn9X+NifcWoqhrK1lRLL5csAy4MIkNvutfHB
         ZLUIQjoFmWkqQ/RmdLEWED2AiiML9hSpinmy8s1OR3xeQpknKJjK0AbDLBKbVaaUuxxG
         gKTwiq6sVmS/oLUQ3wdUnCiM35fPnGrOrBgUqBAYs0GfuGHEBsM5h7zZzyRpd+w1GGTR
         Knoru3U0Uhv971r8bvsZ20A/Y25cTZS4/jXcV7f+OWph80aQo7bpree1MeBGI9o+ufPu
         7TDIh7ZMgE4eQ5ijtMsp+dCwsTwEhn39CvhgSJd/xG/DBI4Yso0VZ8TXXqKsSTih5rRe
         UUEw==
X-Gm-Message-State: AOAM531gqDc+QqGQ1qPbQzZrAqQnpreWMgUfcXTVRT9iwnxnb5E8Wv0g
        fvGBy3ie3w6IWyE+hl1ncsNSAHNyWA4=
X-Google-Smtp-Source: ABdhPJy81EVkINQuWhOXhLbE9coNz8iFuFg0VDmDx90jDs81WsFw0/+cMkpi73aLu9WqnBktD/DL5g==
X-Received: by 2002:adf:a188:: with SMTP id u8mr15179454wru.245.1628329703177;
        Sat, 07 Aug 2021 02:48:23 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id z20sm10844212wmi.36.2021.08.07.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] staging: rtl8723bs: remove wrapping static function
Date:   Sat,  7 Aug 2021 11:47:58 +0200
Message-Id: <786fc4d72db2a4b5e22c95e0e1437cfb734e1218.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded wrapping static function in
hal/odm_HWConif.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 2d4d8d57ceeb..5e6186040484 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -393,7 +393,7 @@ static void odm_Process_RSSIForDM(
 /*  */
 /*  Endianness before calling this API */
 /*  */
-static void ODM_PhyStatusQuery_92CSeries(
+void ODM_PhyStatusQuery(
 	struct dm_odm_t *dm_odm,
 	struct odm_phy_info *phy_info,
 	u8 *phy_status,
@@ -407,17 +407,6 @@ static void ODM_PhyStatusQuery_92CSeries(
 		odm_Process_RSSIForDM(dm_odm, phy_info, pkt_info);
 }
 
-void ODM_PhyStatusQuery(
-	struct dm_odm_t *pDM_Odm,
-	struct odm_phy_info *pPhyInfo,
-	u8 *pPhyStatus,
-	struct odm_packet_info *pPktinfo
-)
-{
-
-	ODM_PhyStatusQuery_92CSeries(pDM_Odm, pPhyInfo, pPhyStatus, pPktinfo);
-}
-
 /*  */
 /*  If you want to add a new IC, Please follow below template and generate a new one. */
 /*  */
-- 
2.20.1


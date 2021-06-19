Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8633AD9A1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFSKup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFSKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B41C061768
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so7029786wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgKRjBPM8AFL+ak+0aT9uZMXv7Z59szsWp5P9GybssM=;
        b=oLFksRJfvCphjvG9FVIVr30QoP27GRWPSNihX+Jn2K6qoaY9d706OtSksRz6e0zTXD
         Hc6aCeai61SPAetyj5QYi/CLftu1AU568J614iTrf++J/BktRgppRPxWrwOzhl3ukffP
         flgst2+YnybrN7h1ROBUTFKqXUTc0pLwtg7XDLhgRtObIFlO4HT+P/ybW7mmqa4qF01p
         VMMiwppSXj0sbzVfTXOSDGNiSSceSiAU8GsY4WQkmOyKSE3eWvjFkL0IupZQwMj+8MoS
         2pFj0fx6Sg8qzTup3CkyeYfGkOKzs4cU52gziVPHgeswtvubmawAOmrOnmKeWF0dIkri
         gxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgKRjBPM8AFL+ak+0aT9uZMXv7Z59szsWp5P9GybssM=;
        b=XOb1d+CPhvgdiKswZ5SSmIT27HCxNtZRRRyGy9k2vo/BUC4IkFGPLSpgl1ac5SIyKW
         BmWlmZo1cHw5uVLKBzOKjUprMkFRfLmDCwXuMmXpoXYgHpX+l8SJNib7jHpeiuJMJ4F0
         zHhY3JpzGDW3qLwYNolPKJ+VrZ6T8s5vlnpa69I63CrO5kuy0uaCXAjb4dWoeWpvvRuX
         PTkPBifEXfE3moEdEqZoE2WmKzxHfsj/Y0NdJ0lP6II/zTupV3AYpjSy8BQbBM21dItX
         57jtaiLEImT/vjrBiP8ECtz2xYUDopoe79QSpuWTWN4JtxroDuxTI2lNJHlitbfQtzLL
         8YmA==
X-Gm-Message-State: AOAM531KnmVpwRFaoktGCbrHSu5zkVEjtPnj03LVWD7I5QnWWLVov9+X
        pbRLiv3xa7c78Wn2NJoO3zIsatOVStq0ug==
X-Google-Smtp-Source: ABdhPJw791kXxYFuNxxUFMUO/WBvnRvlgF79IQkxNZjoPKkbzRqWfUIaLSWmcOzrVgWFwYLcA1eB8g==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr15712468wmg.44.1624099663808;
        Sat, 19 Jun 2021 03:47:43 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id l39sm6937459wms.6.2021.06.19.03.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] staging: rtl8723bs: remove register initializations tied to 802.11ac standard
Date:   Sat, 19 Jun 2021 12:47:18 +0200
Message-Id: <66706b5cb6474c4482c3342c4383fe62eba54967.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove register initializations tied to 802.11ac standard which
is not supported by the device.

It's a dangerous operation, relying only on comments, but tested
on a Lenovo Ideapad MIIX 300-10IBY tablet seems to work.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 059d3050acc6..3a03dfb8d275 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1718,24 +1718,12 @@ void _InitBurstPktLen_8723BS(struct adapter *Adapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
 	rtw_write8(Adapter, 0x4c7, rtw_read8(Adapter, 0x4c7)|BIT(7)); /* enable single pkt ampdu */
-	rtw_write8(Adapter, REG_RX_PKT_LIMIT_8723B, 0x18);		/* for VHT packet length 11K */
 	rtw_write8(Adapter, REG_MAX_AGGR_NUM_8723B, 0x1F);
 	rtw_write8(Adapter, REG_PIFS_8723B, 0x00);
 	rtw_write8(Adapter, REG_FWHW_TXQ_CTRL_8723B, rtw_read8(Adapter, REG_FWHW_TXQ_CTRL)&(~BIT(7)));
 	if (pHalData->AMPDUBurstMode)
 		rtw_write8(Adapter, REG_AMPDU_BURST_MODE_8723B,  0x5F);
 	rtw_write8(Adapter, REG_AMPDU_MAX_TIME_8723B, 0x70);
-
-	/*  ARFB table 9 for 11ac 5G 2SS */
-	rtw_write32(Adapter, REG_ARFR0_8723B, 0x00000010);
-	if (IS_NORMAL_CHIP(pHalData->VersionID))
-		rtw_write32(Adapter, REG_ARFR0_8723B+4, 0xfffff000);
-	else
-		rtw_write32(Adapter, REG_ARFR0_8723B+4, 0x3e0ff000);
-
-	/*  ARFB table 10 for 11ac 5G 1SS */
-	rtw_write32(Adapter, REG_ARFR1_8723B, 0x00000010);
-	rtw_write32(Adapter, REG_ARFR1_8723B+4, 0x003ff000);
 }
 
 static void ResumeTxBeacon(struct adapter *padapter)
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76033415386
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhIVWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhIVWhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:37:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:36:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v24so15967917eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djhccSj2zuwrw0KRuY/CdOVwYrmV8VfWXeYGdC/ylR0=;
        b=jcvvN0d0O5zrrrD4YYBQUrEY+d76nIb7a1TjlJH+u0FpiYah61xgNl3Yc6cGCBsssz
         pyuSC2CsZ2Ggb8/uI5Zn0aHQjIl9JBU0YMxy0mRLAS++LDmOL4ZzDCIdPqN0OH3ICyx5
         M1fUIVd7u9xrbzQm0JAwyfNfznIMqTnyS35edlge69aLqRFIyj+Vxg0l1Rm85mGCbZVh
         qfInvNWxZ+iHB3Cn4+HJqnwOXVcXxZQCfeezDrzLINZfmxVpCAAdP/tVadn7Y22T8QT5
         IUblamnZn+6EgOK7WVAeB7GaVo+jbNImqn/9bEep+94hNqD+GYr/CkheIxGm1bxE71Yg
         xgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djhccSj2zuwrw0KRuY/CdOVwYrmV8VfWXeYGdC/ylR0=;
        b=EFV71KYD5cUHLipA/gM457mHA8wr3OQppnTzwUWgh8KrQDrIYY8VdChtJFI2yA5bXS
         l8AL/iKtbLgzob41hLnK3LSvnAFN5UWOdzkAtftPREHb5A7jyfQAzftcy69gw2L2YFx9
         KnNiErcNF07/48t2cyMeEkJRjdauzSuEVmSa35TKkbreGqaWEhoIPHknyvskH781rAyL
         PbcaMNUaTfo982KEJ3jecgX6BwnfS8fD7pW6Q7Vs/IRfZUzl7uZFS/i1ZlXIWvbl6h0h
         pdDyKirUq+8lLB1lTcwMBC2oM8AMc5ZxYK3SsWH5IFcLCO6eKDbXjTAxe/2pSeyP84Yc
         beZw==
X-Gm-Message-State: AOAM531TYYQKLeePzA1nj+KV70iXZ8p1DRjSQdYOJs2TLSXOSHBTkI2x
        Fn8A6Jiapsz8Z9DmifkDgfI=
X-Google-Smtp-Source: ABdhPJx1mlwGET+HoscEHH9+yYLOlxxQEmJ9zWYIV9Amj1AWFTU5y6QHU4Oe5jYb3UljXCfxLHGSjA==
X-Received: by 2002:a50:bae6:: with SMTP id x93mr1987579ede.232.1632350170187;
        Wed, 22 Sep 2021 15:36:10 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id bj21sm1686168ejb.42.2021.09.22.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:36:09 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Replace camel case variable name
Date:   Thu, 23 Sep 2021 00:35:59 +0200
Message-Id: <20210922223605.639953-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work in progress: replace camel case variables

bShortSlotTime -> b_short_slot_time

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 4 ++--
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index ff596bdcee8d..cf7f292f1c8d 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2200,7 +2200,7 @@ bb_set_short_slot_time(struct vnt_private *priv)
 
 	bb_read_embedded(priv, 0x0A, &by_bb_rx_conf); /* CR10 */
 
-	if (priv->bShortSlotTime)
+	if (priv->b_short_slot_time)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
@@ -2223,7 +2223,7 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data)
 	/* patch for 3253B0 Baseband with Cardbus module */
 	if (by_data == priv->abyBBVGA[0])
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
-	else if (priv->bShortSlotTime)
+	else if (priv->b_short_slot_time)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 9bec1cd036be..b562d09b1ba2 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -258,7 +258,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		bb_write_embedded(priv, 0x88, 0x08);
 		bySIFS = C_SIFS_BG;
 
-		if (priv->bShortSlotTime) {
+		if (priv->b_short_slot_time) {
 			bySlot = C_SLOT_SHORT;
 			byDIFS = C_SIFS_BG + 2 * C_SLOT_SHORT;
 		} else {
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 3d8e28c45287..08c011074193 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -215,7 +215,7 @@ struct vnt_private {
 
 	bool bEncryptionEnable;
 	bool bLongHeader;
-	bool bShortSlotTime;
+	bool b_short_slot_time;
 	bool bProtectMode;
 	bool bNonERPPresent;
 	bool bBarkerPreambleMd;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 1b214546bf65..e88ba1319cfb 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1440,9 +1440,9 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		if (conf->use_short_slot)
-			priv->bShortSlotTime = true;
+			priv->b_short_slot_time = true;
 		else
-			priv->bShortSlotTime = false;
+			priv->b_short_slot_time = false;
 
 		CARDbSetPhyParameter(priv, priv->byBBType);
 		bb_set_vga_gain_offset(priv, priv->abyBBVGA[0]);
-- 
2.25.1


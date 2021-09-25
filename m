Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3B418057
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhIYIfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhIYIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:35:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4CC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:34:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v18so10344050edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsaAE8HlzAXVTBpCmEq8PUtA22C9vD/GKBl1wD0YUvc=;
        b=ZVoWXZoAZL8GOtYeD+acu6cV0BqHiDwr8mT1gXhbE9HNHObw516FrkxdLwTWVAYiGr
         TYJ3Ct6D3VjrVqXimMh/8k99f5yhXefSLQV2d/2XZfvk25Al+Wx3gMgMbOflLs6rc+2i
         +iQNtUU8MIv+T3DZoKKe5i+SJIelC1GL5m6U0wL62cbiLbp25nh3b/ScsM7bUdjmWYot
         GtO3uH2sg+l82no7ooyvrmJTHir8iHLp9jpaB2Su9V6KyXQV2/1+SrmK+BWbOme8nLyx
         ZMjYzgy+EMSMp9sOwwqwdNxQ100d8WhDLdFuBdI9JFa2KZNaCwp1s5LVH31CE9RmZ6HG
         YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsaAE8HlzAXVTBpCmEq8PUtA22C9vD/GKBl1wD0YUvc=;
        b=aOAiPF84NcRKyeZ8nIk1byNOSyIndYnpa0c9+NfEo+RuJxmblGbXkmtEV41+Rw+Z/g
         /1+zPTRESLF8XvChjGwYNWAW3A6xo6htKQ1IiXEsdYLAgbDt6cfDKl4+hgaOAxFo2U0I
         0WtD7Zr+CdpzvTsoqvJSax2FqbKsTZMnz5RPcBwLzWWldUDqZOSZXDwi7TNRUUwpNZHE
         EPesLtg90rAvO7HegI14LaD8MhKBqsbeUUTlrmKZc1JdXC8G/tMoKiR44Fq5QM3jmX+K
         CTJSOd5vNblDweBP1pJvmk0LlzgeOtoZuIDg2IOYmBGVGE5RPq0xIEqFy/vXRTLIOPID
         wrrw==
X-Gm-Message-State: AOAM530ZEhq9/M3taBV6eZqhz/fIgLBZe2KNiblRIpiYK+7M6sMeXOWw
        /3atvSJr5R8xTsbAc5ddA5Y=
X-Google-Smtp-Source: ABdhPJyxZYuYSKaA+bjoKIRc4ZBr6dBM6365oxxX+TjikzOH9L3DxfrI4i5BSSzc2RPEqaEO0b5DDQ==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr15870157ejf.50.1632558849558;
        Sat, 25 Sep 2021 01:34:09 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id p21sm6056514ejm.88.2021.09.25.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 01:34:09 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] staging: vt6655: replace camel case b_short_slot_time instead of bShortSlotTime.
Date:   Sat, 25 Sep 2021 10:33:42 +0200
Message-Id: <20210925083350.13996-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925083350.13996-1-tomm.merciai@gmail.com>
References: <20210925083350.13996-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v3:
 - Fix patch changelog.

Changes since v2:
 - Add patch changelog.

Changes since v1:
 - Make the commit message more clearer.

 drivers/staging/vt6655/baseband.c    | 4 ++--
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f73f3fad3e05..170c4056946f 100644
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
index 3ef3a6e0e6e1..7a08ea0c7692 100644
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
index 2af769174e33..63aa62e483c8 100644
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
index d40c2ac14928..8ae0fbfd134f 100644
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


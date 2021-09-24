Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7B417CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbhIXVCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348464AbhIXVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:02:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BC6C06161E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:01:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm26so6657489edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAXAaftQ7R7FT4gEZLTolo8/7qufIX4WQkAIlEz7WwI=;
        b=HLtSJVLlhGM/kOC+DMIs381+3TN1L9gk5u7TrStWlT7dSMpv24sv6rrIMiN+rOeOe7
         SdRVAUV0GDjC8PxEcEFfo00hPejPQK3nKPnZNzJ2UQzA2i+3iw80LKQTdxse2H5On9hl
         QUXA/IvRU0bmY8nZwKX1z0/vgUg8/SPCk/A/FoEa7vNJrQWBwOjPzadrrcEXbEtCwRWA
         slCBIQHAKyhUUqLQehoqtAmLTRyZIhh+WaW7r31b+BtIT66RtF6AwFgzeB+6FJ9uDEIi
         EHazqALNhSTxyVZcJ/yfynMkZmJtZa3YUCSkSlLCQffcxGZ11QWtkX7sASgNBUuKRwKh
         soBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAXAaftQ7R7FT4gEZLTolo8/7qufIX4WQkAIlEz7WwI=;
        b=ZzrByDKa1pwGQX6L2oYZc7yZMed2pN/C0pjUjur6x/IFOggGgTEC3Y5odDo34d4axG
         R1yk9pgA73fCtANEusyfcJbK73EdWR3HKEb49JrohX2bEb4i5Mwxv0TI21ZfZHPfin46
         Wa8cJIpPiK7Hg17pUXwWuBEfBbc0SXZDYlHrMM/O54SMLhmTq5zGsYQG12TnIB0RP2lk
         tMDMWvGfDB5rPjr0Z8/ihmsKXfQcs1Hyaco7XMORUgFvjougOtUq3WoQJlm+kxnk/brv
         qYhqFduddQlscuyPag/lim6c1PrzSa2/UkTCnCmBjFD1YBvPczwbM9VLcyAo7pnAnhrJ
         /Dmw==
X-Gm-Message-State: AOAM531VG5IckLj/d1+ihe6jKPxVLmkhHCwC6jWs9Ax4BakM2aUVdJcU
        bgWV/z4DVtZGW+bGbxVa5S4=
X-Google-Smtp-Source: ABdhPJwQZi1FCDQJ0N7eJMWPS23+nvGKv+D0URW77Oz5G6LT96ahoXW9r+ujnfz2Xq219fPVIhx/Ww==
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr7609182edx.224.1632517260394;
        Fri, 24 Sep 2021 14:01:00 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id 11sm5456109ejw.50.2021.09.24.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:00:59 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: vt6655: replace camel case b_short_slot_time instead of bShortSlotTime.
Date:   Fri, 24 Sep 2021 23:00:00 +0200
Message-Id: <20210924210008.106355-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924210008.106355-1-tomm.merciai@gmail.com>
References: <20210924210008.106355-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
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


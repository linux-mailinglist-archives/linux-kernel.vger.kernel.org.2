Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D76418039
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhIYHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhIYHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 03:47:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE4C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:45:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so45435793edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7p782qEQOwTmUP6i78fOuN5iYdNpfQeSNflUoul3do=;
        b=MPDszJlcvAfzArOADD8e4/CcLNn4giALAJKkfCThgnMmazzvKj6vAsmdWbhbfIjSv1
         MI1rVsbG3J/erVcEKOWFy/1Wb5eyUtqZ9GkDtOTmIKY0QVmIuziblerhCQPA4hLgT3JJ
         Y275cRMGoAi1Z41S7dOy3R8tIZxq7GDKGcJ7MhvkdwXrX0E0Qd5ERh1GdCEHSm7vIpWL
         OIE4ZRLjLzCykcHDECsZjx6/9mMHW2/TT7NEW1T0r+/EFeNj636MmTS6xA1GM4RqSjlj
         YiaGyw4z0niQasCTR5XQlhD3D3Evjiw0dfpYYo7aELVrufta5Oi9Q+XQvUGpgLFBYoIj
         BRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7p782qEQOwTmUP6i78fOuN5iYdNpfQeSNflUoul3do=;
        b=QaIXDFN3Fb2hcvrihham6U4sLcTY9LbAkVZEugZ8OtWmu0oYJwqmSDv2D5DaYJ3UpZ
         r36yOal0yiFmIwcI4GOJ8D9sE4ckyb2prvo6nCrK59vmpGl9I6c+oXVVq3QaZd6J8ftz
         nd3NW2Qe7j3z3CHfnp+XCcNfx1kFeNYsqJUDgzfEietaJjHWjSLHOoFcxhn25o+tNl9l
         WBvF26tBMdLTgNXR1ooj9uS9sqJVWR215QphD4qHdT+u5s/etmsa8/2KiWG53FXHY3/d
         Lh1BbOwJ0zmUsUfNM61lBzieWxoSkiibm62suyfR2Gbg4lF1fNxi1Oy18UaUznpA05Vq
         4fjQ==
X-Gm-Message-State: AOAM532h5tQaoMpGm7F844/EWq9+Ad5hVHDkzpw4FmjScRiHOx6O0Pcg
        eb5ZhopwcLfYED5tphsqnmk=
X-Google-Smtp-Source: ABdhPJwFm8dr+sjB1Mp69vK/5Ogrwp0VYLGLI2gGaYZEs+0hCFbb6HxWnqVUF8JMldbWcLLAmw438g==
X-Received: by 2002:a17:907:2bdb:: with SMTP id gv27mr15387654ejc.483.1632555958366;
        Sat, 25 Sep 2021 00:45:58 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id m14sm5949900ejl.74.2021.09.25.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 00:45:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] staging: vt6655: replace camel case b_short_slot_time instead of bShortSlotTime.
Date:   Sat, 25 Sep 2021 09:45:22 +0200
Message-Id: <20210925074531.10446-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925074531.10446-1-tomm.merciai@gmail.com>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v2:
 - Add changelog.

Changes since v1:
 - Make the commit message more clearer.
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B4105D1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbhIRJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbhIRJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC349C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so11767439wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCRS9YO/EfFwLmhMCxMGwWzVTAfOXMSICKT6p7l5oDc=;
        b=ZOkdbx6LyN56shmP7X0Ky0YwEfqR2sv/sVkHCxvzI7pcj4O5Wah7rDlht27vAY9Sl3
         VTRU9snCF9A5FZtzqpNHzobaqlAmz8XYWByunyFy82FZv60HTuXdYdEz1uQj9FgbjAM1
         s/gKTaJLNlJ9YsQWhItMfJL9WcEX5SDaoKk35PQpGWhxo+YXC4oH9IRe9AzN/C1oh/Zl
         efyKCaXsgAvBSEME8hwAH/GKUpAcvA41AeTemEh2d8jBi9rZiDz1GPc3DQ0HjXTDBbOg
         aL/WVNNleph5pbU76sdMIp2D9ReTUTXAlIhOTlfQZ2wIG5hvH7TTIDTFoa78YDhNS9NG
         6V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCRS9YO/EfFwLmhMCxMGwWzVTAfOXMSICKT6p7l5oDc=;
        b=7W9WWDetASUPRKjIzRI0zJSHsY81Y4fWZWg3adzgQuEJUT/BNrDHmGErUhqDdNsIpf
         0tEIPAZQSvVhhUCGFyms2o8LfewJ2wWjrSTng4ZvvJDR6nbKKaRl6ztugJXiGYiPx0Qy
         3hdcwX6EXYa1tn/AwMZ2FTHMAd6m4/CjAZPg9gNWPFA5ECMD9NeehzSD238f/wjJOQ4t
         x5QdzznMTWSBR/0hA8SPrkKU6AKPi8WbEtJy6zun9vh1xfABldHUsfkE7ink8+R7U9gk
         ddOHRZM6dAUIgOdayNnOkg7SZCeQ6YuQBy72EuMbj4D8udJdVmEoyab4ENJb12KRKldO
         q3YA==
X-Gm-Message-State: AOAM530MyzXdPehcTOZBDZ5G8mj9HsBQyjMZIghaBsBz0Z2DqOkOVFLb
        6NU0oNDnw+d/zqzxXz5pMgM=
X-Google-Smtp-Source: ABdhPJx6Ivac7Ps7cXJKkeDGJW1OzuuZerqrs0i7OCRBlFR144IOK44ExYNZ6WX6iYwi/pe/hcM1zw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr10767585wma.115.1631959078309;
        Sat, 18 Sep 2021 02:57:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: r8188eu: remove rtl8188e_RF_ChangeTxPath()
Date:   Sat, 18 Sep 2021 11:57:22 +0200
Message-Id: <20210918095727.13591-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_RF_ChangeTxPath() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 22 -------------------
 drivers/staging/r8188eu/include/rtl8188e_rf.h |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 2f16c0966973..2fffe42e97c0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -50,28 +50,6 @@ struct rf_shadow {
 
 /*------------------------Define local variable------------------------------*/
 
-/*-----------------------------------------------------------------------------
- * Function:	RF_ChangeTxPath
- *
- * Overview:	For RL6052, we must change some RF settign for 1T or 2T.
- *
- * Input:		u16 DataRate		0x80-8f, 0x90-9f
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 09/25/2008	MHC		Create Version 0.
- *						Firmwaer support the utility later.
- *
- *---------------------------------------------------------------------------*/
-void rtl8188e_RF_ChangeTxPath(struct adapter *Adapter, u16 DataRate)
-{
-/*  We do not support gain table change inACUT now !!!! Delete later !!! */
-}	/* RF_ChangeTxPath */
-
 /*-----------------------------------------------------------------------------
  * Function:    PHY_RF6052SetBandwidth()
  *
diff --git a/drivers/staging/r8188eu/include/rtl8188e_rf.h b/drivers/staging/r8188eu/include/rtl8188e_rf.h
index da6b7f8212a3..04556496baad 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_rf.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_rf.h
@@ -9,7 +9,6 @@
 #define		RF6052_MAX_PATH			2
 
 int	PHY_RF6052_Config8188E(struct adapter *Adapter);
-void rtl8188e_RF_ChangeTxPath(struct adapter *Adapter, u16 DataRate);
 void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 				     enum ht_channel_width Bandwidth);
 void	rtl8188e_PHY_RF6052SetCckTxPower(struct adapter *Adapter, u8 *level);
-- 
2.33.0


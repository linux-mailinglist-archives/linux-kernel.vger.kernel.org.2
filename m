Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257841E062
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352892AbhI3R5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352857AbhI3R5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:57:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F1C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:55:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so11509391wri.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbVxM8mxOXwgCWrpKBMnbYActDzjYnGg34O6XPMbP2M=;
        b=Kt73KgoFAiWY7u8VwTebeZP9VkfahBqa+BHGL9r89cqFD9xpDQWuzicd9d5rYy5yqU
         3HFG4Nzbn2jAN4+UGWtl7LRcVnVYxqQGUVt4qHhtLIirT/zFRLPSJrOmHKXB54NNt+wX
         OfXL+FEv+l5exUtI3cicFCt5a7sYvMNiCSD4Vns2Kt2QRRSaCwDXgbCdbSXNZFl61Ppx
         xzez6q7qoHgi25fP7dRn0QqKKK1BnOoZKXILLS/aQTIvCWuhjBC7yuMZLi3Kl0gUl1zU
         0Y/63UfjFHqTvG/4qzne/4yQdnf6RRtscfw7ca2fbo/PPjvpakFn5qtK/eH9f/jaKBpw
         MmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbVxM8mxOXwgCWrpKBMnbYActDzjYnGg34O6XPMbP2M=;
        b=aRJUKIYQIc1PkmH5iq4KVuebUkuqBsDwmlEjkDnnKcVRKNiaaLxEGj7nrIJNjUw1Is
         Yx5vzTSUlR/iYyS6rCXDt/wUcnG5X9LMKrEIdGzmTGrc0uc8IKomV2f/UsdjMEEWtp7y
         lmo7ib5Afo4zH2mvvW/IMgwLTCmi4e+zyp58lNv21nSnvm3tEFX5am5JNaj0PR6GAxPM
         GWM5PYOPC5wV4bv6SMzLGa6h8JbAEHwORmdxX/vbVxg6QTCl98RKbs/RONH8xIlBOLCG
         rKBLXrhAKt7E7IIp2Avp9xoItRHBhPuPnuHfOUPodEu2AEYdocN7h/zr31h8ZJd0hAxu
         GO6w==
X-Gm-Message-State: AOAM532zsoDFY8ZDRpkF90vgjfTzmXmefZLcNr0PHU0sv6BgVmPO+5d4
        35T6Z1lVG2un16HPs7j1mJWbHRpMt9U=
X-Google-Smtp-Source: ABdhPJy6pTuA1TmvWcwTWIw7ViCetbLmvca8QBXgWjhc7gFCQz5XT9LWs3TQyUkY22c4JYtdAcpMOQ==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr7868824wri.322.1633024554411;
        Thu, 30 Sep 2021 10:55:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc89])
        by smtp.gmail.com with ESMTPSA id y11sm4391820wrg.18.2021.09.30.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:55:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: r8188eu: remove rtl8188e_silentreset_for_specific_platform()
Date:   Thu, 30 Sep 2021 19:55:46 +0200
Message-Id: <20210930175546.11175-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_silentreset_for_specific_platform() is empty.
Remove it and remove code that does nothing other than using the
unwanted DBG_88E macro now.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Remove code that just uses DBG_88E after removing the function.

 drivers/staging/r8188eu/hal/rtl8188e_sreset.c     | 14 +-------------
 drivers/staging/r8188eu/include/rtl8188e_sreset.h |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c      |  6 ------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 16fa249e35d3..ea793fef6f10 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -6,10 +6,6 @@
 #include "../include/rtl8188e_sreset.h"
 #include "../include/rtl8188e_hal.h"
 
-void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter)
-{
-}
-
 void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
@@ -24,7 +20,6 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 	if (txdma_status != 0x00) {
 		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
-		rtl8188e_silentreset_for_specific_platform(padapter);
 	}
 	/* total xmit irp = 4 */
 	current_time = jiffies;
@@ -32,15 +27,8 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 		diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_time);
 
 		if (diff_time > 2000) {
-			if (psrtpriv->last_tx_complete_time == 0) {
+			if (psrtpriv->last_tx_complete_time == 0)
 				psrtpriv->last_tx_complete_time = current_time;
-			} else {
-				diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_complete_time);
-				if (diff_time > 4000) {
-					DBG_88E("%s tx hang\n", __func__);
-					rtl8188e_silentreset_for_specific_platform(padapter);
-				}
-			}
 		}
 	}
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
index 880c5792d5dd..5d7fec78a27b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_sreset.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 #include "rtw_sreset.h"
 
-void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter);
 void rtl8188e_sreset_xmit_status_check(struct adapter *padapter);
 void rtl8188e_sreset_linked_status_check(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index dd47098ed1e5..78c260d83725 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4002,12 +4002,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DUMP_TXPKT, &extra_arg);
 			}
 			break;
-		case 0x0f:
-			if (extra_arg == 0) {
-				DBG_88E("###### silent reset test.......#####\n");
-				rtl8188e_silentreset_for_specific_platform(padapter);
-			}
-			break;
 		case 0x15:
 			{
 				struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA73D4E68
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhGYPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGYPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:18:57 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0EAC061760;
        Sun, 25 Jul 2021 08:59:28 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXF-0000SM-Ko; Sun, 25 Jul 2021 17:59:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/18] staging: rtl8188eu: remove HW_VAR_TXPAUSE
Date:   Sun, 25 Jul 2021 17:58:47 +0200
Message-Id: <20210725155902.32433-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "HAL layer variable" HW_VAR_TXPAUSE is not used in this driver.
Remove its define and the code for setting and for reading a value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c  | 6 ------
 drivers/staging/rtl8188eu/include/hal_intf.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 633feae0fca5..79e86ed8798e 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1178,9 +1178,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			usb_write8(Adapter, REG_INIRTS_RATE_SEL, RateIndex);
 		}
 		break;
-	case HW_VAR_TXPAUSE:
-		usb_write8(Adapter, REG_TXPAUSE, *((u8 *)val));
-		break;
 	case HW_VAR_BCN_FUNC:
 		hw_var_set_bcn_func(Adapter, variable, val);
 		break;
@@ -1613,9 +1610,6 @@ void rtw_hal_get_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_BASIC_RATE:
 		*((u16 *)(val)) = Adapter->HalData->BasicRateSet;
 		fallthrough;
-	case HW_VAR_TXPAUSE:
-		val[0] = usb_read8(Adapter, REG_TXPAUSE);
-		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2 */
 		val[0] = (BIT(0) & usb_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index e2ce71db3fa1..ad0a6bd5f510 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -18,7 +18,6 @@ enum hw_variables {
 	HW_VAR_BSSID,
 	HW_VAR_INIT_RTS_RATE,
 	HW_VAR_BASIC_RATE,
-	HW_VAR_TXPAUSE,
 	HW_VAR_BCN_FUNC,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_CHECK_BSSID,
-- 
2.20.1


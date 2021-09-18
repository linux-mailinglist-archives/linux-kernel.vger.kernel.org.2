Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF74106FD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhIROMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIROMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:12:09 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:10:45 -0700 (PDT)
Received: from dslb-178-004-203-016.178.004.pools.vodafone-ip.de ([178.4.203.16] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mRb39-00026S-UI; Sat, 18 Sep 2021 16:10:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove the HW_VAR_CHECK_TXBUF "hal variable"
Date:   Sat, 18 Sep 2021 16:10:34 +0200
Message-Id: <20210918141034.28481-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting HW_VAR_CHECK_TXBUF is an empty operation.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 1 -
 drivers/staging/r8188eu/hal/usb_halinit.c   | 2 --
 drivers/staging/r8188eu/include/hal_intf.h  | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 26e14e91a42c..38ab1ab18872 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7785,7 +7785,6 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_DISABLE) {
 		/* for first time sitesurvey_cmd */
-		rtw_hal_set_hwreg(padapter, HW_VAR_CHECK_TXBUF, NULL);
 
 		pmlmeext->sitesurvey_res.state = SCAN_START;
 		pmlmeext->sitesurvey_res.bss_cnt = 0;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5133d533674f..8bb2466d71a2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1813,8 +1813,6 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_CHECK_TXBUF:
-		break;
 	case HW_VAR_APFM_ON_MAC:
 		haldata->bMacPwrCtrlOn = *val;
 		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index cc8db98cd200..f1ebb6a2395d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -84,7 +84,6 @@ enum hw_variables {
 	HW_VAR_EFUSE_BT_USAGE,
 	HW_VAR_EFUSE_BT_BYTES,
 	HW_VAR_FIFO_CLEARN_UP,
-	HW_VAR_CHECK_TXBUF,
 	HW_VAR_APFM_ON_MAC, /* Auto FSM to Turn On, include clock, isolation,
 			     * power control for MAC only */
 	/*  The valid upper nav range for the HW updating, if the true value is
-- 
2.20.1


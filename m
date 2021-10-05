Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25442314C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJEUKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhJEUKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:10:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:08:52 -0700 (PDT)
Received: from ipservice-092-217-085-112.092.217.pools.vodafone-ip.de ([92.217.85.112] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mXqk4-000847-Br; Tue, 05 Oct 2021 22:08:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/9] staging: r8188eu: remove two write-only hal components
Date:   Tue,  5 Oct 2021 22:08:17 +0200
Message-Id: <20211005200821.19783-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211005200821.19783-1-martin@kaiser.cx>
References: <20211005200821.19783-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RegTxPause and RegBcnCtrlVal from struct hal_data_8188e are set but never
read. Remove them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index bd3ba6ab364f..1e6885d75bf3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -556,8 +556,6 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
 	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
 
-	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
-	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
 	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
 	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2);
 	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index bfe32864ded6..b374398bad24 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -307,9 +307,6 @@ struct hal_data_8188e {
 	u8	LastHMEBoxNum;
 
 	u8	fw_ractrl;
-	u8	RegTxPause;
-	/*  Beacon function related global variable. */
-	u32	RegBcnCtrlVal;
 	u8	RegFwHwTxQCtrl;
 	u8	RegReg542;
 	u8	RegCR_1;
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17945DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhKYRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbhKYQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:58:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A2C061374
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:48:03 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHuh-0006ye-Bt; Thu, 25 Nov 2021 17:47:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: remove _ps_close_RF
Date:   Thu, 25 Nov 2021 17:47:44 +0100
Message-Id: <20211125164745.8188-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125164745.8188-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _ps_close_RF is empty. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 995ea4a55435..0b1aaa162c21 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -850,12 +850,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	return status;
 }
 
-static void _ps_close_RF(struct adapter *adapt)
-{
-	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
-	/* phy_SsPwrSwitch92CU(adapt, rf_off, 1); */
-}
-
 static void CardDisableRTL8188EU(struct adapter *Adapter)
 {
 	u8 val8;
@@ -921,9 +915,7 @@ u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_HIMRE_88E, IMR_DISABLED_88E);
 
 	DBG_88E("bkeepfwalive(%x)\n", Adapter->pwrctrlpriv.bkeepfwalive);
-	if (Adapter->pwrctrlpriv.bkeepfwalive) {
-		_ps_close_RF(Adapter);
-	} else {
+	if (!Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (Adapter->hw_init_completed) {
 			CardDisableRTL8188EU(Adapter);
 		}
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151D74297FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhJKUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhJKUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54497C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:27 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1ep-0004mk-MW; Mon, 11 Oct 2021 22:12:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/8] staging: r8188eu: simplify rtl8188e_HalDmWatchDog
Date:   Mon, 11 Oct 2021 22:11:53 +0200
Message-Id: <20211011201159.10252-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't call dm_CheckStatistics any more, we don't need
fw_cur_in_ps and fw_ps_awake.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 43 +++++++----------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index af8b2752b664..90b30606fe13 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -113,42 +113,25 @@ void rtl8188e_InitHalDm(struct adapter *Adapter)
 
 void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 {
-	bool fw_cur_in_ps = false;
-	bool fw_ps_awake = true;
-	u8 hw_init_completed = false;
+	u8 hw_init_completed = Adapter->hw_init_completed;
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
-
-
-	hw_init_completed = Adapter->hw_init_completed;
+	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
+	u8 bLinked = false;
 
 	if (!hw_init_completed)
 		return;
 
-	fw_cur_in_ps = Adapter->pwrctrlpriv.bFwCurrentInPSMode;
-	GetHwReg8188EU(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
-
-	/*  Fw is under p2p powersaving mode, driver should stop dynamic mechanism. */
-	/*  modifed by thomas. 2011.06.11. */
-	if (Adapter->wdinfo.p2p_ps_mode)
-		fw_ps_awake = false;
-
-	/* ODM */
-	if (hw_init_completed) {
-		struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
-		u8 bLinked = false;
-
-		if ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) ||
-		    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))) {
-			if (Adapter->stapriv.asoc_sta_count > 2)
-				bLinked = true;
-		} else {/* Station mode */
-			if (check_fwstate(pmlmepriv, _FW_LINKED))
-				bLinked = true;
-		}
-
-		ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
-		ODM_DMWatchdog(&hal_data->odmpriv);
+	if ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) ||
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))) {
+		if (Adapter->stapriv.asoc_sta_count > 2)
+			bLinked = true;
+	} else {/* Station mode */
+		if (check_fwstate(pmlmepriv, _FW_LINKED))
+			bLinked = true;
 	}
+
+	ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
+	ODM_DMWatchdog(&hal_data->odmpriv);
 }
 
 void rtl8188e_init_dm_priv(struct adapter *Adapter)
-- 
2.20.1


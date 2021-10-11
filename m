Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6324C4297FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhJKUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhJKUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE06C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:25 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1eo-0004mk-2E; Mon, 11 Oct 2021 22:12:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/8] staging: r8188eu: remove dm_CheckStatistics
Date:   Mon, 11 Oct 2021 22:11:52 +0200
Message-Id: <20211011201159.10252-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dm_CheckStatistics function is empty. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index f99a8526fe18..af8b2752b664 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -8,10 +8,6 @@
 #include "../include/drv_types.h"
 #include "../include/rtl8188e_hal.h"
 
-static void dm_CheckStatistics(struct adapter *Adapter)
-{
-}
-
 /*  Initialize GPIO setting registers */
 static void dm_InitGPIOSetting(struct adapter *Adapter)
 {
@@ -136,13 +132,6 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 	if (Adapter->wdinfo.p2p_ps_mode)
 		fw_ps_awake = false;
 
-	if (hw_init_completed && ((!fw_cur_in_ps) && fw_ps_awake)) {
-		/*  Calculate Tx/Rx statistics. */
-		dm_CheckStatistics(Adapter);
-
-
-	}
-
 	/* ODM */
 	if (hw_init_completed) {
 		struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
-- 
2.20.1


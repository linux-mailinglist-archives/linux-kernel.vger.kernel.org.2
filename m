Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57803E1752
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhHEOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhHEOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:51:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9588C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:51:11 -0700 (PDT)
Received: from dslb-188-096-137-143.188.096.pools.vodafone-ip.de ([188.96.137.143] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mBei8-0003eR-4B; Thu, 05 Aug 2021 16:51:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] staging: r8188eu: remove label at the end of a function
Date:   Thu,  5 Aug 2021 16:50:26 +0200
Message-Id: <20210805145026.14572-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805130750.7974-1-martin@kaiser.cx>
References: <20210805130750.7974-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation fails for me

drivers/staging/r8188eu/hal/rtl8188e_dm.c: In function ‘rtl8188e_HalDmWatchDog’:
drivers/staging/r8188eu/hal/rtl8188e_dm.c:182:1: error: label at end of compound statement
  182 | skip_dm:
      | ^~~~~~~

Remove the label at the end of the function. Replace the jump to this label
with a return statement.

Fixes: b398ff88aa36 ("staging: r8188eu: remove return from void functions")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - add Fixes tag

 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index b5f42127a751..72b3130eddd2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -145,7 +145,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 	hw_init_completed = Adapter->hw_init_completed;
 
 	if (!hw_init_completed)
-		goto skip_dm;
+		return;
 
 	fw_cur_in_ps = Adapter->pwrctrlpriv.bFwCurrentInPSMode;
 	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
@@ -179,7 +179,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 		ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
 		ODM_DMWatchdog(&hal_data->odmpriv);
 	}
-skip_dm:
+
 	/*  Check GPIO to determine current RF on/off and Pbc status. */
 	/*  Check Hardware Radio ON/OFF or not */
 }
-- 
2.20.1


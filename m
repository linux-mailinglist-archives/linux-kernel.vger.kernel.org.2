Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309A43026D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbhJPLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhJPLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14124C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:40 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhtd-00046d-8z; Sat, 16 Oct 2021 13:30:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/8] staging: r8188eu: remove unused function prototypes
Date:   Sat, 16 Oct 2021 13:30:04 +0200
Message-Id: <20211016113008.27549-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove prototypes of functions that aren't present in this driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index ee4b26ecd19d..084bccc5dcb9 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -194,18 +194,10 @@ void PHY_SetBWMode8188E(struct adapter *adapter,
 
 /*  channel switch related funciton */
 void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
-/*  Call after initialization */
-void ChkFwCmdIoDone(struct adapter *adapter);
 
 /*  BB/MAC/RF other monitor API */
 void PHY_SetRFPathSwitch_8188E(struct adapter *adapter,	bool main);
 
-void PHY_SwitchEphyParameter(struct adapter *adapter);
-
-void PHY_EnableHostClkReq(struct adapter *adapter);
-
-bool SetAntennaConfig92C(struct adapter *adapter, u8 defaultant);
-
 void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 				 u32 mask, u32 data);
 /*--------------------------Exported Function prototype---------------------*/
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA343542D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJTT47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhJTT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:56:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:39 -0700 (PDT)
Received: from dslb-188-096-142-022.188.096.pools.vodafone-ip.de ([188.96.142.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mdHfX-0007Cd-EC; Wed, 20 Oct 2021 21:54:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: remove unused defines and enums
Date:   Wed, 20 Oct 2021 21:54:01 +0200
Message-Id: <20211020195401.12931-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
References: <20211020195401.12931-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of unused defines and an unused enum
from rtl8188e_cmd.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_cmd.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index 01404b774ebd..1e01c1662f9a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -27,15 +27,6 @@ enum RTL8188E_H2C_CMD_ID {
 	/* Class DM */
 	H2C_DM_MACID_CFG		= 0x40,
 	H2C_DM_TXBF			= 0x41,
-
-	/* Class BT */
-	H2C_BT_COEX_MASK		= 0x60,
-	H2C_BT_COEX_GPIO_MODE		= 0x61,
-	H2C_BT_DAC_SWING_VAL		= 0x62,
-	H2C_BT_PSD_RST			= 0x63,
-
-	/* Class */
-	 H2C_RESET_TSF			= 0xc0,
 };
 
 struct cmd_msg_parm {
@@ -44,10 +35,6 @@ struct cmd_msg_parm {
 	u8 buf[6];
 };
 
-enum {
-	PWRS
-};
-
 struct setpwrmode_parm {
 	u8 Mode;/* 0:Active,1:LPS,2:WMMPS */
 	u8 SmartPS_RLBM;/* LPS= 0:PS_Poll,1:PS_Poll,2:NullData,WMM= 0:PS_Poll,1:NullData */
-- 
2.20.1


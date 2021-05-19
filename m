Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301E3388517
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhESDCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:02:02 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:26846 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhESDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:02:01 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id D1EBC8027B;
        Wed, 19 May 2021 11:00:39 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wang Qing <wangqing@vivo.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: delete extra blank lines
Date:   Wed, 19 May 2021 11:00:17 +0800
Message-Id: <1621393219-28665-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh0YTVZMGhgdHUgfGBhPQhhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6ISo6Qj8KFSocIkoLAk8X
        DTlPCSxVSlVKTUlKSEJISU9LSE9IVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBSUlPTzcG
X-HM-Tid: 0a7982916fd5b037kuuud1ebc8027b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing CHECK:Blank lines aren't necessary before a close brace '}'

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 7876b38..52eeb56
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -46,7 +46,6 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 			netdev_err(dev, "%s(): Unknown bandwidth: %#X\n",
 				   __func__, Bandwidth);
 			break;
-
 		}
 	}
 }
@@ -73,7 +72,6 @@ bool rtl92e_config_rf(struct net_device *dev)
 
 		pPhyReg = &priv->PHYRegDef[eRFPath];
 
-
 		switch (eRFPath) {
 		case RF90_PATH_A:
 		case RF90_PATH_C:
@@ -143,7 +141,6 @@ bool rtl92e_config_rf(struct net_device *dev)
 				   __func__, eRFPath);
 			goto fail;
 		}
-
 	}
 
 	RT_TRACE(COMP_PHY, "PHY Initialization Success\n");
@@ -170,7 +167,6 @@ void rtl92e_set_cck_tx_power(struct net_device *dev, u8 powerlevel)
 	rtl92e_set_bb_reg(dev, rTxAGC_CCK_Mcs32, bTxAGCRateCCK, TxAGC);
 }
 
-
 void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -215,5 +211,4 @@ void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 				   (byte1 << 8) | byte0;
 		rtl92e_set_bb_reg(dev, RegOffset[index], 0x7f7f7f7f, writeVal);
 	}
-
 }
-- 
2.7.4


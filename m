Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2822043026F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbhJPLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbhJPLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9EAC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:43 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhtf-00046d-1G; Sat, 16 Oct 2021 13:30:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/8] staging: r8188eu: clean up Hal8188EPhyCfg.h
Date:   Sat, 16 Oct 2021 13:30:06 +0200
Message-Id: <20211016113008.27549-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a bunch of unused structs, enums and defines
from Hal8188EPhyCfg.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 59 -------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index feae0b32cac6..58377edf724d 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -21,23 +21,6 @@
 /*--------------------------Define Parameters-------------------------------*/
 
 /*------------------------------Define structure----------------------------*/
-enum sw_chnl_cmd_id {
-	CmdID_End,
-	CmdID_SetTxPowerLevel,
-	CmdID_BBRegWrite10,
-	CmdID_WritePortUlong,
-	CmdID_WritePortUshort,
-	CmdID_WritePortUchar,
-	CmdID_RF_WriteReg,
-};
-
-/* 1. Switch channel related */
-struct sw_chnl_cmd {
-	enum sw_chnl_cmd_id CmdID;
-	u32 Para1;
-	u32 Para2;
-	u32 msDelay;
-};
 
 enum hw90_block {
 	HW90_BLOCK_MAC = 0,
@@ -73,16 +56,6 @@ enum wireless_mode {
 	WIRELESS_MODE_N_24G		= BIT(3),
 };
 
-enum phy_rate_tx_offset_area {
-	RA_OFFSET_LEGACY_OFDM1,
-	RA_OFFSET_LEGACY_OFDM2,
-	RA_OFFSET_HT_OFDM1,
-	RA_OFFSET_HT_OFDM2,
-	RA_OFFSET_HT_OFDM3,
-	RA_OFFSET_HT_OFDM4,
-	RA_OFFSET_HT_CCK,
-};
-
 /* BB/RF related */
 enum RF_TYPE_8190P {
 	RF_TYPE_MIN,		/*  0 */
@@ -141,24 +114,6 @@ struct bb_reg_def {
 				 * Path A and B */
 };
 
-struct ant_sel_ofdm {
-	u32 r_tx_antenna:4;
-	u32 r_ant_l:4;
-	u32 r_ant_non_ht:4;
-	u32 r_ant_ht1:4;
-	u32 r_ant_ht2:4;
-	u32 r_ant_ht_s1:4;
-	u32 r_ant_non_ht_s1:4;
-	u32 OFDM_TXSC:2;
-	u32 reserved:2;
-};
-
-struct ant_sel_cck {
-	u8 r_cckrx_enable_2:2;
-	u8 r_cckrx_enable:2;
-	u8 r_ccktx_enable:4;
-};
-
 /*------------------------------Define structure----------------------------*/
 
 /*------------------------Export global variable----------------------------*/
@@ -208,18 +163,4 @@ void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 #define PHY_SetRFReg(adapt, rfpath, regaddr, bitmask, data)	\
 	rtl8188e_PHY_SetRFReg((adapt), (rfpath), (regaddr), (bitmask), (data))
 
-#define PHY_SetMacReg	PHY_SetBBReg
-
-#define	SIC_HW_SUPPORT			0
-
-#define	SIC_MAX_POLL_CNT		5
-
-#define	SIC_CMD_READY			0
-#define	SIC_CMD_WRITE			1
-#define	SIC_CMD_READ			2
-
-#define	SIC_CMD_REG			0x1EB		/*  1byte */
-#define	SIC_ADDR_REG			0x1E8		/*  1b9~1ba, 2 bytes */
-#define	SIC_DATA_REG			0x1EC		/*  1bc~1bf */
-
 #endif	/*  __INC_HAL8192CPHYCFG_H */
-- 
2.20.1


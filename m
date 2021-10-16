Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709B0430270
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbhJPLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbhJPLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D57C061766
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:45 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhth-00046d-HZ; Sat, 16 Oct 2021 13:30:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/8] staging: r8188eu: CurrentWirelessMode is not used
Date:   Sat, 16 Oct 2021 13:30:08 +0200
Message-Id: <20211016113008.27549-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CurrentWirelessMode in struct hal_data_8188e is not used. Remove the
component and the enum with its possible values.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 8 --------
 drivers/staging/r8188eu/include/rtl8188e_hal.h   | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 58377edf724d..6f901ce607e8 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -48,14 +48,6 @@ enum rf_radio_path {
 						 * total three groups */
 #define CHANNEL_GROUP_MAX_88E		6
 
-enum wireless_mode {
-	WIRELESS_MODE_UNKNOWN = 0x00,
-	WIRELESS_MODE_B			= BIT(0),
-	WIRELESS_MODE_G			= BIT(1),
-	WIRELESS_MODE_AUTO		= BIT(5),
-	WIRELESS_MODE_N_24G		= BIT(3),
-};
-
 /* BB/RF related */
 enum RF_TYPE_8190P {
 	RF_TYPE_MIN,		/*  0 */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5fdee1c6299c..ced7e12d9013 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -162,7 +162,6 @@ struct hal_data_8188e {
 	u8	PGMaxGroup;
 	/* current WIFI_PHY values */
 	u32	ReceiveConfig;
-	enum wireless_mode CurrentWirelessMode;
 	enum ht_channel_width CurrentChannelBW;
 	u8	CurrentChannel;
 	u8	nCur40MhzPrimeSC;/*  Control channel sub-carrier */
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1D364B05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhDSUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhDSUNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:13:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C9C06174A;
        Mon, 19 Apr 2021 13:13:11 -0700 (PDT)
Received: from dslb-188-097-210-083.188.097.pools.vodafone-ip.de ([188.97.210.83] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lYaGZ-0006ik-S7; Mon, 19 Apr 2021 22:13:07 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/4] staging: rtl8188eu: remove unused function parameters
Date:   Mon, 19 Apr 2021 22:11:26 +0200
Message-Id: <20210419201126.25633-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419201126.25633-1-martin@kaiser.cx>
References: <20210417180037.17806-1-martin@kaiser.cx>
 <20210419201126.25633-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Enable and Linked parameters of _BeaconFunctionEnable are not used.
Remove them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - no change, re-sending the entire series

 drivers/staging/rtl8188eu/hal/usb_halinit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index abe58cf2de16..80cdcf6f7879 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -574,8 +574,7 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 	haldata->RegCR_1 = usb_read8(Adapter, REG_CR + 1);
 }
 
-static void _BeaconFunctionEnable(struct adapter *Adapter,
-				  bool Enable, bool Linked)
+static void _BeaconFunctionEnable(struct adapter *Adapter)
 {
 	usb_write8(Adapter, REG_BCN_CTRL, (BIT(4) | BIT(3) | BIT(1)));
 
@@ -1961,7 +1960,7 @@ void beacon_timing_control(struct adapter *adapt)
 	usb_write8(adapt,  REG_RXTSF_OFFSET_CCK, 0x50);
 	usb_write8(adapt, REG_RXTSF_OFFSET_OFDM, 0x50);
 
-	_BeaconFunctionEnable(adapt, true, true);
+	_BeaconFunctionEnable(adapt);
 
 	ResumeTxBeacon(adapt);
 
-- 
2.20.1


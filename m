Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25739CA07
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFERBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFERBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:01:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3449C061766;
        Sat,  5 Jun 2021 09:59:31 -0700 (PDT)
Received: from dslb-188-096-145-192.188.096.pools.vodafone-ip.de ([188.96.145.192] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lpZdv-0002hw-MJ; Sat, 05 Jun 2021 18:59:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/9] staging: rtl8188eu: use existing define for ethernet header len
Date:   Sat,  5 Jun 2021 18:58:56 +0200
Message-Id: <20210605165858.3175-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605165858.3175-1-martin@kaiser.cx>
References: <20210605165858.3175-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the driver's internal define with ETH_HLEN.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index c20141638b73..ef37cc6bf51f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -7,6 +7,7 @@
 #define _RTW_RECV_C_
 
 #include <linux/ieee80211.h>
+#include <linux/if_ether.h>
 
 #include <osdep_service.h>
 #include <drv_types.h>
@@ -17,7 +18,6 @@
 #include <linux/vmalloc.h>
 #include <net/cfg80211.h>
 
-#define ETHERNET_HEADER_SIZE	14	/*  Ethernet Header Length */
 #define LLC_HEADER_SIZE			6	/*  LLC Header Length */
 
 static u8 SNAP_ETH_TYPE_IPX[2] = {0x81, 0x37};
@@ -1503,7 +1503,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
-		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+		if (a_len < (ETH_HLEN + nSubframe_Length)) {
 			DBG_88E("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
 			goto exit;
 		}
-- 
2.20.1


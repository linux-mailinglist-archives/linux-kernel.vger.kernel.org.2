Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1937C39CA01
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFERBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFERBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:01:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B43BC061766;
        Sat,  5 Jun 2021 09:59:29 -0700 (PDT)
Received: from dslb-188-096-145-192.188.096.pools.vodafone-ip.de ([188.96.145.192] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lpZdt-0002hw-4Q; Sat, 05 Jun 2021 18:59:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/9] staging: rtl8188eu: simplify rtw_get_wireless_stats
Date:   Sat,  5 Jun 2021 18:58:54 +0200
Message-Id: <20210605165858.3175-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605165858.3175-1-martin@kaiser.cx>
References: <20210605165858.3175-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary temporary variables.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index ebd61ba93ef0..70c028e06aee 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2920,25 +2920,18 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 {
 	struct adapter *padapter = netdev_priv(dev);
 	struct iw_statistics *piwstats = &padapter->iwstats;
-	int tmp_level = 0;
-	int tmp_qual = 0;
-	int tmp_noise = 0;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 		piwstats->qual.qual = 0;
 		piwstats->qual.level = 0;
 		piwstats->qual.noise = 0;
 	} else {
-		tmp_level = padapter->recvpriv.signal_strength;
-		tmp_qual = padapter->recvpriv.signal_qual;
-		tmp_noise = padapter->recvpriv.noise;
-
-		piwstats->qual.level = tmp_level;
-		piwstats->qual.qual = tmp_qual;
-		piwstats->qual.noise = tmp_noise;
+		piwstats->qual.level = padapter->recvpriv.signal_strength;
+		piwstats->qual.qual = padapter->recvpriv.signal_qual;
+		piwstats->qual.noise = padapter->recvpriv.noise;
 	}
 	piwstats->qual.updated = IW_QUAL_ALL_UPDATED;/* IW_QUAL_DBM; */
-	return &padapter->iwstats;
+	return piwstats;
 }
 
 struct iw_handler_def rtw_handlers_def = {
-- 
2.20.1


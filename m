Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247783631B2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhDQSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhDQSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 14:01:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FFC061574;
        Sat, 17 Apr 2021 11:00:55 -0700 (PDT)
Received: from ipservice-092-217-095-235.092.217.pools.vodafone-ip.de ([92.217.95.235] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lXpFQ-0002pi-K5; Sat, 17 Apr 2021 20:00:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: rtl8188eu: change bLeisurePs' type to bool
Date:   Sat, 17 Apr 2021 20:00:34 +0200
Message-Id: <20210417180037.17806-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bLeisurePs is used as a boolean variable. Change its type from
u8 to bool.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
index 06062643c868..4345dc0c7cf9 100644
--- a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
@@ -171,7 +171,7 @@ struct pwrctrl_priv {
 	unsigned long ips_deny_time; /* will deny IPS when system time less than this */
 	u8 ps_processing; /* temp used to mark whether in rtw_ps_processor */
 
-	u8	bLeisurePs;
+	bool	bLeisurePs;
 	u8	LpsIdleCount;
 	u8	power_mgnt;
 	u8	bFwCurrentInPSMode;
-- 
2.20.1


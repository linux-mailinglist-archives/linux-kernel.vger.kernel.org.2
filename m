Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B224078C1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhIKOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhIKORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA61C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:10 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3na-0006bt-Bg; Sat, 11 Sep 2021 16:16:06 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/12] staging: r8188eu: remove unused enum and array
Date:   Sat, 11 Sep 2021 16:15:18 +0200
Message-Id: <20210911141521.24901-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PS_BBRegBackup in struct pwrctrl_priv is not used. Remove this component
and the related enum _PS_BBRegBackup_.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 97102c1ec553..bb0c9866fd61 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -53,14 +53,6 @@ enum rt_rf_power_state {
 	rf_max
 };
 
-enum _PS_BBRegBackup_ {
-	PSBBREG_RF0 = 0,
-	PSBBREG_RF1,
-	PSBBREG_RF2,
-	PSBBREG_AFE0,
-	PSBBREG_TOTALCNT
-};
-
 enum { /*  for ips_mode */
 	IPS_NONE = 0,
 	IPS_NORMAL,
@@ -126,7 +118,6 @@ struct pwrctrl_priv {
 	u8		bHWPwrPindetect;
 	u8		bkeepfwalive;
 	u8		brfoffbyhw;
-	unsigned long PS_BBRegBackup[PSBBREG_TOTALCNT];
 };
 
 #define rtw_get_ips_mode_req(pwrctrlpriv) \
-- 
2.20.1


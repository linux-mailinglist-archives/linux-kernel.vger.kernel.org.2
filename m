Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732ED4078B7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhIKORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhIKORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:20 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:07 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nX-0006bt-Kw; Sat, 11 Sep 2021 16:16:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/12] staging: r8188eu: remove unused power state defines
Date:   Sat, 11 Sep 2021 16:15:15 +0200
Message-Id: <20210911141521.24901-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused defines and macros related to power states.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 08d821575755..bd05d1dfe77e 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -39,42 +39,6 @@ enum power_mgnt {
 	PS_MODE_NUM
 };
 
-/*
-	BIT[2:0] = HW state
-	BIT[3] = Protocol PS state,   0: register active state,
-				      1: register sleep state
-	BIT[4] = sub-state
-*/
-
-#define PS_DPS			BIT(0)
-#define PS_LCLK			(PS_DPS)
-#define PS_RF_OFF		BIT(1)
-#define PS_ALL_ON		BIT(2)
-#define PS_ST_ACTIVE		BIT(3)
-
-#define PS_ISR_ENABLE		BIT(4)
-#define PS_IMR_ENABLE		BIT(5)
-#define PS_ACK			BIT(6)
-#define PS_TOGGLE		BIT(7)
-
-#define PS_STATE_MASK		(0x0F)
-#define PS_STATE_HW_MASK	(0x07)
-#define PS_SEQ_MASK		(0xc0)
-
-#define PS_STATE(x)		(PS_STATE_MASK & (x))
-#define PS_STATE_HW(x)		(PS_STATE_HW_MASK & (x))
-#define PS_SEQ(x)		(PS_SEQ_MASK & (x))
-
-#define PS_STATE_S0		(PS_DPS)
-#define PS_STATE_S1		(PS_LCLK)
-#define PS_STATE_S2		(PS_RF_OFF)
-#define PS_STATE_S3		(PS_ALL_ON)
-#define PS_STATE_S4		((PS_ST_ACTIVE) | (PS_ALL_ON))
-
-#define PS_IS_RF_ON(x)	((x) & (PS_ALL_ON))
-#define PS_IS_ACTIVE(x)	((x) & (PS_ST_ACTIVE))
-#define CLR_PS_STATE(x)	((x) = ((x) & (0xF0)))
-
 struct reportpwrstate_parm {
 	unsigned char mode;
 	unsigned char state; /* the CPWM value */
-- 
2.20.1


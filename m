Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E834409C93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbhIMSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbhIMSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:54:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C3C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:53:12 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mPr4k-0005CM-3p; Mon, 13 Sep 2021 20:53:06 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/8] staging: r8188eu: remove unused power state defines
Date:   Mon, 13 Sep 2021 20:51:04 +0200
Message-Id: <20210913185110.3065-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913185110.3065-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
 <20210913185110.3065-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused defines and macros related to power states.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- rebased against today's staging-testing branch

 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 4f657bc0d8e7..463eb9845e0b 100644
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


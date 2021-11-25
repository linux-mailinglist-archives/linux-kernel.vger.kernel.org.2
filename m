Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20145DD20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhKYPUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348746AbhKYPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:18:04 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E6C061748
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:14:53 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqGSX-0005zf-PQ; Thu, 25 Nov 2021 16:14:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/6] staging: r8188eu: Efuse_CalculateWordCnts is not used
Date:   Thu, 25 Nov 2021 16:14:31 +0100
Message-Id: <20211125151436.5895-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125151436.5895-1-martin@kaiser.cx>
References: <20211125151436.5895-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the Efuse_CalculateWordCnts function, which is not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 16 ----------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index f88d086329b1..62d194587fb1 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -11,22 +11,6 @@
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-/*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
-u8
-Efuse_CalculateWordCnts(u8 word_en)
-{
-	u8 word_cnts = 0;
-	if (!(word_en & BIT(0)))
-		word_cnts++; /*  0 : write enable */
-	if (!(word_en & BIT(1)))
-		word_cnts++;
-	if (!(word_en & BIT(2)))
-		word_cnts++;
-	if (!(word_en & BIT(3)))
-		word_cnts++;
-	return word_cnts;
-}
-
 /*  */
 /* 	Description: */
 /* 		Execute E-Fuse read byte operation. */
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 4d8eff8e860e..68394c6302a3 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -28,7 +28,6 @@
 
 /*------------------------Export global variable----------------------------*/
 
-u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053643026C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbhJPLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbhJPLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B8C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:40 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhtc-00046d-Cz; Sat, 16 Oct 2021 13:30:36 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/8] staging: r8188eu: remove two checks that are always false
Date:   Sat, 16 Oct 2021 13:30:03 +0200
Message-Id: <20211016113008.27549-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aefb1fc5c185 ("staging: r8188eu: odm BoardType is never set")
clarified that the odm board type is always 0.

The CheckCondition functions extract the board type from the hex
parameter and stores it in _board. For _board == 0,
(_board == cond) && cond != 0x00 is always false. Remove the checks.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c | 5 -----
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index a623e0aaa0d0..f6e4243e0c7b 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -13,7 +13,6 @@
 
 static bool CheckCondition(const u32  condition, const u32  hex)
 {
-	u32 _board     = (hex & 0x000000FF);
 	u32 _interface = (hex & 0x0000FF00) >> 8;
 	u32 _platform  = (hex & 0x00FF0000) >> 16;
 	u32 cond = condition;
@@ -21,10 +20,6 @@ static bool CheckCondition(const u32  condition, const u32  hex)
 	if (condition == 0xCDCDCDCD)
 		return true;
 
-	cond = condition & 0x000000FF;
-	if ((_board == cond) && cond != 0x00)
-		return false;
-
 	cond = condition & 0x0000FF00;
 	cond = cond >> 8;
 	if ((_interface & cond) == 0 && cond != 0x07)
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 3e2a09fc2619..5e0a96200078 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -6,7 +6,6 @@
 
 static bool CheckCondition(const u32  Condition, const u32  Hex)
 {
-	u32 _board     = (Hex & 0x000000FF);
 	u32 _interface = (Hex & 0x0000FF00) >> 8;
 	u32 _platform  = (Hex & 0x00FF0000) >> 16;
 	u32 cond = Condition;
@@ -14,10 +13,6 @@ static bool CheckCondition(const u32  Condition, const u32  Hex)
 	if (Condition == 0xCDCDCDCD)
 		return true;
 
-	cond = Condition & 0x000000FF;
-	if ((_board == cond) && cond != 0x00)
-		return false;
-
 	cond = Condition & 0x0000FF00;
 	cond = cond >> 8;
 	if ((_interface & cond) == 0 && cond != 0x07)
-- 
2.20.1


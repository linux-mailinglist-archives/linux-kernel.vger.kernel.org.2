Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D33D4E64
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhGYPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhGYPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:18:57 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40261C061757;
        Sun, 25 Jul 2021 08:59:27 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXA-0000SM-Sl; Sun, 25 Jul 2021 17:59:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/18] staging: rtl8188eu: remove unused defines
Date:   Sun, 25 Jul 2021 17:58:45 +0200
Message-Id: <20210725155902.32433-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that power cut mask is not used any more, we can also remove the
defines for power cut masks.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/pwrseqcmd.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/pwrseqcmd.h b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
index bfa0405cccde..bbf4f302c9f4 100644
--- a/drivers/staging/rtl8188eu/include/pwrseqcmd.h
+++ b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
@@ -15,17 +15,6 @@
 #define PWR_CMD_DELAY		0x03
 #define PWR_CMD_END		0x04
 
-/* The value of cut_msk: 8 bits */
-#define PWR_CUT_TESTCHIP_MSK	BIT(0)
-#define PWR_CUT_A_MSK		BIT(1)
-#define PWR_CUT_B_MSK		BIT(2)
-#define PWR_CUT_C_MSK		BIT(3)
-#define PWR_CUT_D_MSK		BIT(4)
-#define PWR_CUT_E_MSK		BIT(5)
-#define PWR_CUT_F_MSK		BIT(6)
-#define PWR_CUT_G_MSK		BIT(7)
-#define PWR_CUT_ALL_MSK		0xFF
-
 enum pwrseq_cmd_delat_unit {
 	PWRSEQ_DELAY_US,
 	PWRSEQ_DELAY_MS,
-- 
2.20.1


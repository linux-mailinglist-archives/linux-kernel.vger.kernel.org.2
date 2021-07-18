Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247E53CCA22
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhGRRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGRRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702AC061762;
        Sun, 18 Jul 2021 10:37:38 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5AjO-0006oR-9R; Sun, 18 Jul 2021 19:37:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/10] staging: rtl8188eu: remove PWR_CMD_READ
Date:   Sun, 18 Jul 2021 19:36:09 +0200
Message-Id: <20210718173610.894-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210718173610.894-1-martin@kaiser.cx>
References: <20210718173610.894-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the power flows and transitions includes a read command.
PWR_CMD_READ can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c     | 2 --
 drivers/staging/rtl8188eu/include/pwrseqcmd.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
index f2b973b377dd..cab774e31c60 100644
--- a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
+++ b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
@@ -25,8 +25,6 @@ u8 rtl88eu_pwrseqcmdparsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcm
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
 		switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
-		case PWR_CMD_READ:
-			break;
 		case PWR_CMD_WRITE:
 			offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
diff --git a/drivers/staging/rtl8188eu/include/pwrseqcmd.h b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
index e364ee450beb..a5eb95fc58b9 100644
--- a/drivers/staging/rtl8188eu/include/pwrseqcmd.h
+++ b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
@@ -10,7 +10,6 @@
 #include <drv_types.h>
 
 /* The value of cmd: 4 bits */
-#define PWR_CMD_READ		0x00
 #define PWR_CMD_WRITE		0x01
 #define PWR_CMD_POLLING		0x02
 #define PWR_CMD_DELAY		0x03
-- 
2.20.1


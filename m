Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF6434C13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJTNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJTNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:30:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10BEC061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:28:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so10265043wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Bd0wj+p+9TRlN1ZXP/TSahnjo8YS2SPX8pyBePDyCc=;
        b=F0ZS43EWDOllEFrcmG5QFNCOD6Xo2np6Nh2MDNP76gKqkXmn/cjijdlZAhmtSXOzHd
         07ev4RT9ZJgGD7KhM2zVgUwrZvJSQLBXwv1qvOwErvRr3bSlXlrylvZtKSB4CaFL0MTs
         UNxyHYTpwLS/AxALC//Kz6+G6u93fvqVmSi2eljeOhhyJUpsjIFjuOiFehxQnkd7ZYlj
         tk1wAq3JVnUpPVyqMbHYmoT96BwsdQ2oFnIY0tXcvE92vDjSsmrGlT10bBMrTLuwiyDA
         M2Bt8/Nu8j9UlrY/b9fGFzXHnEJizPAhCWoV9B2sLz6kK1V+t0+DrD0YGHZyC4YXc6wg
         chuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Bd0wj+p+9TRlN1ZXP/TSahnjo8YS2SPX8pyBePDyCc=;
        b=5Jyc7I02ygKy9Pw5mIPBN18RZ5+b7oYm+yQiCvTgRoab59+4jOXa4AVPKyQMXV7ajI
         ZFBqY1JDAwNUt0R8SRIv9T0VdtVy+uYCvXnK4d06u3pIV6WsoP9hk+m6tw3imnyWxrwf
         emOPO0EUCOtxHPI2gGU58jEpBfTRZEUHbvsTUicnfUc20t+6QzpmpwC+c4SSz2E9mfjx
         S6TkOLw5+GNuUEdrhe7XJAqD+fCh/ZCHSrtVCfH/IJjD/Li3cxlQLK68lxRpMdzXvxMi
         G2TGFn/Muuzu5YVkTZLRONXvP3cr9PsT48RSRzAsI0EbDXvYmch6UKeNpdtE8AvsBVea
         lBZg==
X-Gm-Message-State: AOAM531jwPG+Wmk7juPT6aBGAiH4SE4wgRyDQNT+hQWqZNPxQVmuGifD
        dcD7WB3fRD0o/F23nfcRo6Y=
X-Google-Smtp-Source: ABdhPJwBIundAVhXSa2XBj9FIMgfaHwj18HTzkFmuT+0+SI3LetT79OI4bq2J7OEBJpmhhd2pf1yGg==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr13816618wmb.101.1634736522212;
        Wed, 20 Oct 2021 06:28:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id n26sm3323115wmi.16.2021.10.20.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:28:41 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH] staging: vt6655: Rename `dwAL2230InitTable` array
Date:   Wed, 20 Oct 2021 14:28:11 +0100
Message-Id: <20211020132811.417341-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation prefix in `dwAL2230InitTable` array.
Change it to use snake case.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <dwAL2230InitTable>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index a6f17162d017..6bdacf8fbc27 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -33,7 +33,7 @@
 #define SWITCH_CHANNEL_DELAY_AL7230 200 /* us */
 #define AL7230_PWR_IDX_LEN    64
 
-static const unsigned long dwAL2230InitTable[CB_AL2230_INIT_SEQ] = {
+static const unsigned long al2230_init_table[CB_AL2230_INIT_SEQ] = {
 	0x03F79000 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
 	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
 	0x01A00200 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
@@ -545,7 +545,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	IFRFbWriteEmbedded(priv, (0x07168700 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW));
 
 	for (ii = 0; ii < CB_AL2230_INIT_SEQ; ii++)
-		ret &= IFRFbWriteEmbedded(priv, dwAL2230InitTable[ii]);
+		ret &= IFRFbWriteEmbedded(priv, al2230_init_table[ii]);
 	MACvTimer0MicroSDelay(priv, 30); /* delay 30 us */
 
 	/* PLL On */
@@ -557,7 +557,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	ret &= IFRFbWriteEmbedded(priv, (0x00780f00 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW));
 	MACvTimer0MicroSDelay(priv, 30);/* 30us */
 	ret &= IFRFbWriteEmbedded(priv,
-				  dwAL2230InitTable[CB_AL2230_INIT_SEQ - 1]);
+				  al2230_init_table[CB_AL2230_INIT_SEQ - 1]);
 
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPE3    |
 							 SOFTPWRCTL_SWPE2    |
@@ -699,7 +699,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			return false;
 
 		for (ii = 0; ii < CB_AL2230_INIT_SEQ; ii++)
-			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230InitTable[ii]);
+			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), al2230_init_table[ii]);
 
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable0[uChannel - 1]);
 		ii++;
-- 
2.30.2


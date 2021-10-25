Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C4398AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhJYOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhJYOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA8C061225
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so171981wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAj0aiWl+Hji1MErAOm7QfqsGTlwZNUkSUsTTflQ6nc=;
        b=czlC5k1WkXToJ+m2VHFI27g7tQ3OxyiA3rL2Yq4a+KMUhEOAgXei30wU1sGBisPT+z
         vh0cIZnHRn2JCE23Zs3Azd2GrEqWdb2NVeLV9UZGIKdykjJRYXXnkjKq6lm5qe9FzIhf
         Rr2nlL/Lg74QzynpN+ffYQ+MKRZA6vqWTIJ4B/Bvvics4eSusk9iEAlReengHJl3GV18
         QwwV7o/a9z/sxk9vw33VRn4cEQqF9J8reBi1W42T3LRB6bDh74K5fqBiVo1YfKX9z0WL
         o02tWsvG+p5f++FAbVfpxJV/P/dD2HPvu+GSPvReGWdrY8vhrvB2VrXfEAidzO0kex+Q
         ezsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAj0aiWl+Hji1MErAOm7QfqsGTlwZNUkSUsTTflQ6nc=;
        b=CnTz0afjKusy4eRNzbpJ3u1rOD7KgIda6ViAhuHmOP7ZYv3vKxtq+jdsubVU0xeSQb
         ANf2XiVx/Of0nQBC1P9zkMDqpbfB73cxooj5c3YzgXQd/vKEZJ86fd8zAT7/MbVKO5WM
         5Bx8NIN5ycLGNVI+cbSGcuWpp8X098YuMBkrpoaAIIzgpg31qWqJG7TGEDCkEEB5l1ea
         7tGbe8ZRZ57EL6YRhEl9FvGy8OT6V0ufQ0+E60M597NWApY62Kdh0Ke5IvuIduGZdDOz
         VIMvZd4QnipukMkcSDOpH3eGdT0RUuf4Njvi3C0mTH8jW2wcn60m8uxrA1tm8HiBvJUi
         iwGQ==
X-Gm-Message-State: AOAM533GOo3BFdjRJLJ7tJ5QiF3hULjN4Sor0nrk3tKTqDIUeXyw3Aea
        XqFoAHSQ4M3wLC3zQn4lEO0=
X-Google-Smtp-Source: ABdhPJxr9ESgn+40Y9hxhGj5zHGF83DSmBOBVIvzFIlnBzxa7DWjGPRdRU3n0+UmcmKC0uejYFmLYA==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr49988880wmi.131.1635172348279;
        Mon, 25 Oct 2021 07:32:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:27 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 8/8] staging: vt6655: Rename `dwAL7230InitTable` array
Date:   Mon, 25 Oct 2021 15:31:34 +0100
Message-Id: <4e78c4628ba75d9793bd8a60d69a1b0cc4d2a073.1635171519.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635171518.git.karolinadrobnik@gmail.com>
References: <cover.1635171518.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the kernel coding style, remove the type from
the variable name and do not use CamelCase.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <dwAL7230InitTable>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 1c81c44f086c..bc4abe77db7b 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -155,7 +155,7 @@ static unsigned long al2230_power_table[AL2230_PWR_IDX_LEN] = {
 /* 40MHz reference frequency
  * Need to Pull PLLON(PE3) low when writing channel registers through 3-wire.
  */
-static const unsigned long dwAL7230InitTable[CB_AL7230_INIT_SEQ] = {
+static const unsigned long al7230_init_table[CB_AL7230_INIT_SEQ] = {
 	0x00379000 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel1 // Need modify for 11a */
 	0x13333100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Channel1 // Need modify for 11a */
 	0x841FF200 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* Need modify for 11a: 451FE2 */
@@ -420,7 +420,7 @@ static bool s_bAL7230Init(struct vnt_private *priv)
 	bb_power_save_mode_off(priv); /* RobertYu:20050106, have DC value for Calibration */
 
 	for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[ii]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[ii]);
 
 	/* PLL On */
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
@@ -434,7 +434,7 @@ static bool s_bAL7230Init(struct vnt_private *priv)
 	ret &= IFRFbWriteEmbedded(priv, (0x3ABA8F00 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW));
 	MACvTimer0MicroSDelay(priv, 30);/* 30us */
 	/* TXDCOC:disable, RCK:disable */
-	ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[CB_AL7230_INIT_SEQ - 1]);
+	ret &= IFRFbWriteEmbedded(priv, al7230_init_table[CB_AL7230_INIT_SEQ - 1]);
 
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPE3    |
 							 SOFTPWRCTL_SWPE2    |
@@ -716,7 +716,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTable[i]);
+				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
 				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table_a_mode[i]);
@@ -932,13 +932,13 @@ bool RFbAL7230SelectChannelPostProcess(struct vnt_private *priv,
 		ret &= IFRFbWriteEmbedded(priv, al7230_init_table_a_mode[15]);
 	} else if ((byOldChannel > CB_MAX_CHANNEL_24G) && (byNewChannel <= CB_MAX_CHANNEL_24G)) {
 		/* Change from 5G to 2.4G [Reg] */
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[2]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[3]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[5]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[7]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[10]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[12]);
-		ret &= IFRFbWriteEmbedded(priv, dwAL7230InitTable[15]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[2]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[3]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[5]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[7]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[10]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[12]);
+		ret &= IFRFbWriteEmbedded(priv, al7230_init_table[15]);
 	}
 
 	return ret;
-- 
2.30.2


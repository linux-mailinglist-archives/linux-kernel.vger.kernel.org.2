Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238084398AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhJYOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhJYOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6DC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e4so13239626wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFyJ2L3s6j7dSuTLK7kekavdGRbGtq40Furx3B47yQg=;
        b=UtZQS3f3IVHe1e63LYR2ja/AvtuqYK9Q8AEv3iq0yzUkJqwqCqlsMbuvZcIR2ejLOp
         vqJpp6tjw4w6PWCPCup4eGDsScsvalZurSDM9+ABMfZhGgiOC79e7xbfBwynZuzDPwtl
         CrF4boMvWDPGYo2HTR49jP1OWBLeEa3z5CX7RnKxIkKTDFctNe2xQb+csYt1g46/wdiE
         LJMrLBKMsS78cECFAXzTXraYPuG0rsROyPy1ZHeGbTklnPiPRH6LH2Ajh4RTlKNcFYdR
         4/LwJlR/Zi1tam2514viwf849X/9e1ry/zQI2WHRni5fKVazNa3X7EM20QX3lFlcbIQ6
         Sx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFyJ2L3s6j7dSuTLK7kekavdGRbGtq40Furx3B47yQg=;
        b=AKH7HDXEucG2+Ay2131lkej9KC9fFXCYVoKUFRR4IFkOaqXvGAxuylr//Y1q14yh6m
         q7u3XaSVtQop/DKv5oKjQ4g2hmZtGAAoG2wivltToGUxKvDjZduBR+I0ymhsOQ9zAmF/
         nCBHmuD/aKDLjfI+SP9HUO1DqmyAkmJKzFX7PopXROXfEwOmRLo6ZTaq9QmS4z+b9aii
         hhHcQGNMMUkcnH5qKCkOH2FjCsP4gRCeGnVAEIy0vaBH8vV+ZUl0LKoU8ZKG0tIO39/K
         M9S9qq9rgH8MaKzWZxUcy3G51GVtvZNB9S4Ud7ldKe9m0igpRqkRVEHe5zGW1ueCa0Ib
         xrdg==
X-Gm-Message-State: AOAM533lEZapTVLRzpkNeLxzsId/r+rY73IwbQNfh38tht0GIN+LvlnW
        LKNGQ/Dx+LdKkiwlWl3wbQRmEx7gcuVvkw==
X-Google-Smtp-Source: ABdhPJx0EFbTXUT3CZfrosXLAVe3d1smwOJiHrAHltBb3q0bMnu9q66cbG37LY3vV4MHN1uPUBmCJg==
X-Received: by 2002:adf:eece:: with SMTP id a14mr20768403wrp.79.1635172341816;
        Mon, 25 Oct 2021 07:32:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:21 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 5/8] staging: vt6655: Rename `dwAL7230ChannelTable2` array
Date:   Mon, 25 Oct 2021 15:31:31 +0100
Message-Id: <055bde0a3206573209b757a22ab150c02f50f007.1635171519.git.karolinadrobnik@gmail.com>
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
  CHECK: Avoid CamelCase: <dwAL7230ChannelTable2>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 4dac3ad1abbe..a5c8dc5875eb 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -327,7 +327,7 @@ static const unsigned long al7230_channel_table1[CB_MAX_CHANNEL] = {
 	0x02AAA100 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 165, Tf = 5825MHz (56) */
 };
 
-static const unsigned long dwAL7230ChannelTable2[CB_MAX_CHANNEL] = {
+static const unsigned long al7230_channel_table2[CB_MAX_CHANNEL] = {
 	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  1, Tf = 2412MHz */
 	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  2, Tf = 2417MHz */
 	0x7FD78400 + (BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW, /* channel =  3, Tf = 2422MHz */
@@ -465,7 +465,7 @@ static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byCha
 
 	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table0[byChannel - 1]);
 	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table1[byChannel - 1]);
-	ret &= IFRFbWriteEmbedded(priv, dwAL7230ChannelTable2[byChannel - 1]);
+	ret &= IFRFbWriteEmbedded(priv, al7230_channel_table2[byChannel - 1]);
 
 	/* PLLOn On */
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
@@ -726,7 +726,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		i++;
 		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable2[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


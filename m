Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F684374DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhJVJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhJVJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B4C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so2699880wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V57x0MEr6fuE5L3vURExVJ6RMqS7xwkhHXyJYTkcluM=;
        b=d3zqbzBkMTaMN+TQfvkijPPkv8G4hEufMVUiYKmqQaecIbqqDBlf6sdbonICXPubU4
         FCSbsdbrLOhcZYVnI0fLzr4QL7/ReF/4vCRNHL+bgLeBJvzJpMUqv0iiASu51wqzmrAq
         QzbCFzT5NKnuygO8Mkje4BuN+GoHLUkdoktjcePMkt+dwTmKDct52Gb9TQRytCVKHx9C
         0K0snlfZ4qQyGt/GiZK4i4p46utLgbXX4HX9eujI1oNxCXq26urPotJ5w2FDtLTOaZTG
         EIX7KEXB9QyG5NE7kH/xXactMiTCY96YLBIWIK8+TjAM8dNoVn1ILEjTRjeuBEh7r3tQ
         J4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V57x0MEr6fuE5L3vURExVJ6RMqS7xwkhHXyJYTkcluM=;
        b=oTLraj0VKMtBOaprL8uU1N5EcQ8f4fHxpYNbVUwbGoclmgtmJxwZO++BYxSasVpI/j
         ISIyFFQCFLAF7QpUrp2td2KfG0XKiQGAIpPPKaccu0kXtx9OP29jVvK+GEgYeMNgJR7T
         t9chdbRwS2Sby2ysTlrlmS2PZACbD9NSaG2ZTKJ39+XudbZtarfY4LSBr1A83114KRx6
         nXX/RPIS5LjosKDDuCj/MNARDiDpxxG9ikq9a4SNkGAoK6jWZoKeSxEbps5QVdYKdx1Y
         h9qF/0Uigol2udH8xhSU0ygGPAL0CLnhUWdoaIvxF+y3/EfcQMdJvQLX+bC03qEli97m
         UN9w==
X-Gm-Message-State: AOAM532jkMHDfl6b+pDIu4iMeYBfqLX4yg5jPRyaEDmp6YRbkMdc0nXN
        n05bn/xDztz4So0wdzTTA2k=
X-Google-Smtp-Source: ABdhPJw2JLJdPg0xXxRj0dg5M4UGggmy7+sYiLaZ/OCLeXTKC+xuDK4xkvnVPg9VM9GIlFD3mSkE2g==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr11130877wmj.87.1634895465474;
        Fri, 22 Oct 2021 02:37:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:45 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 1/5] staging: vt6655: Rename `ii` variable
Date:   Fri, 22 Oct 2021 10:37:14 +0100
Message-Id: <91591b7ca0aaf05d2de1e5ae9477ae3b8f13427f.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634826774.git.karolinadrobnik@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation in the loop counter `ii` in
`RFvWriteWakeProgSyn` function.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 6bdacf8fbc27..7e441309dd9c 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -680,7 +680,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			 u16 uChannel)
 {
 	void __iomem *iobase = priv->port_offset;
-	int   ii;
+	int i;
 	unsigned char byInitCount = 0;
 	unsigned char bySleepCount = 0;
 
@@ -698,12 +698,12 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
 			return false;
 
-		for (ii = 0; ii < CB_AL2230_INIT_SEQ; ii++)
-			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), al2230_init_table[ii]);
+		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable0[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL2230ChannelTable1[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable0[uChannel - 1]);
+		i++;
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL2230ChannelTable1[uChannel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -715,18 +715,18 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			return false;
 
 		if (uChannel <= CB_MAX_CHANNEL_24G) {
-			for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230InitTable[ii]);
+			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTable[i]);
 		} else {
-			for (ii = 0; ii < CB_AL7230_INIT_SEQ; ii++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230InitTableAMode[ii]);
+			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230InitTableAMode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable0[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable1[uChannel - 1]);
-		ii++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + ii), dwAL7230ChannelTable2[uChannel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable0[uChannel - 1]);
+		i++;
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable1[uChannel - 1]);
+		i++;
+		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), dwAL7230ChannelTable2[uChannel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


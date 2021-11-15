Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737B4502EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhKOLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhKOK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498FC061767
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w29so29730509wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdnvnZ7J2/koQu70kgtIUFr3wg0Bu4erMOm8YnDNdUM=;
        b=A5E0hXaT2bWiSVAxf7gesyVmU+UILmQB8ZTYTpV4rdR9GVUzKdlxi6qLnyQ0dAhC2U
         QzaxvNB4Q9Ex3d6xHkcygAWArAhZmGCrYDBt8Kezwrz4NHqBvXIMpj7QlhIhpKsR8Agu
         TQz5RtTgwHrFQccf+Oj0+QbtMIf3CWJuc+fhY45633nS5/6lTvgAVzPcg6a40na99g5N
         cGrsm285fdt+QkhCgmCY4q3Km92sx2sAVg9WVBQmGAhJ+cXU8bLGj4OGLGQXrEb3eypH
         rgpq3aR7tRR10TORWmo/5c8AFG4jWhGF7cJ47PsDVWfkR9nABI6QFU0kvHMpGIwBgWTw
         hS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdnvnZ7J2/koQu70kgtIUFr3wg0Bu4erMOm8YnDNdUM=;
        b=F2TeqSC9vYDmnBZp5u0RIe3WFpoipBrjUtEHnklNnKwdBu45dS3tpd+RY2J5uNB9Ko
         e+6bQyV1PbPG2Ida21DQwnNSHsbIqqU24vo1I8Eaq6RzJzrqdQRL/7ApwS8zIeAKYfMf
         6TX7EZms/A8HOICUkyjEh3b6vUhKphvnWep6Ffiigp8mUzfNdnGeukIUxKmf94jcA1FS
         8ma538Au7Kv3TM4OCllD5k35hvUMUi9rw0tCCnruRiv9vXuQFFjWrxxQeJJfJMO4PSJe
         vDQS8LE1Ift3lXiBJ6w5q+Npk+gZxuChEPGFjTmKTMIp0C202UxGLqN1HJcB+o3Lzfo3
         vjJA==
X-Gm-Message-State: AOAM533SmxfuaH3CzTnaKpNudzWSU4CRrwFPopWBK7LCLCrBEvintQqv
        Kdabu57MS402aHbkYv43CX8=
X-Google-Smtp-Source: ABdhPJxjjTfJSXRn9cYdTi97NN5Mk1IOKlI3DD5T+4fuf/wawGIueN4B1KOHK/a5DFhJV9h2gg62YQ==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr45732136wrr.152.1636973782467;
        Mon, 15 Nov 2021 02:56:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:22 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 3/8] staging: vt6655: Use incrementation in `idx`
Date:   Mon, 15 Nov 2021 10:55:44 +0000
Message-Id: <9affeaf40ddb31e03b21db9acd099db4d80da179.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment `idx` in a loop instead of adding the loop counter
`i` to do so. Delete increments of `i` that were rendered
unnecessary by this change.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index d57fab3f10fb..ce91a03eb58f 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -700,11 +700,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, idx + i, al2230_init_table[i]);
+			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, idx + i, al2230_channel_table0[channel - 1]);
-		i++;
-		MACvSetMISCFifo(priv, idx + i, al2230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -717,17 +716,15 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx + i, al7230_init_table[i]);
+				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx + i, al7230_init_table_a_mode[i]);
+				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
 		}
 
-		MACvSetMISCFifo(priv, idx + i, al7230_channel_table0[channel - 1]);
-		i++;
-		MACvSetMISCFifo(priv, idx + i, al7230_channel_table1[channel - 1]);
-		i++;
-		MACvSetMISCFifo(priv, idx + i, al7230_channel_table2[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


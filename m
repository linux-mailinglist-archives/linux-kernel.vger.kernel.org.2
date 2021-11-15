Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216A34502EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhKOLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhKOK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42747C061204
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d24so29859110wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfoIbbQyeoaiMVTbbswbVOIqx8arnjzrsrDHWc/2QRA=;
        b=fICl6o6qvgnNDUrRxFFC9A7JfHMK5wooQfuCLafAMEgZz7pzOnKPBk0Iaj1KTmZZ5h
         1pM+6bl8YW4SQrRBzPRVlONWXQc4biLjsT0zbeoZSqNxFZTStOO/BoAXIUPUzSnV7L1p
         gxPagntPe0GpltGbtwJZkV4c7d3kZli7tpB+X6Kiq0rJ0491cKidV4B+ajSDH+uKNkiU
         8CC7SLwsupagjstanh5jQlx4Lfp0lssQI4J57Q8GFSBB27smKbbLHS+68ZWk1Tm7aR/l
         8/6e9Pcyax1I0LuogQuPfRkZDjTHjt8S0wFjuElJioJD1Cac0JYf9ppzEO6ulvNOuMGx
         ipXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfoIbbQyeoaiMVTbbswbVOIqx8arnjzrsrDHWc/2QRA=;
        b=ye7UfAz/AT4ydxNtpBmo+H29GpEzKnuQSm2QZ08M9Cd3CRCHCziYTqD+LucM8rnrif
         vCv9pEy4Zkfr9spd5bC65wwstN/LB15kTgXnfGWF4GnCtCEOWYWBNsWTKc3IfK48eLQw
         NWyVxPN3RMJIasATcB1o3gVMNpqGCqVdPyJAN8+bsir5L8xd3vWelo6LM/mXRcUcEqTi
         w7/cQ+CIqeIF3Mmi8/O4KOZrhP9E0AUUrONvSuaBRoTy6L5+v2Gfe/X3ZQRHImjNAD3c
         rLXuaO388YJ8SyBP112Xuy0qgyBl/ALJSMcdPmItFsOZELuF1tySsQHKWLHzuImg1F5Z
         sUQQ==
X-Gm-Message-State: AOAM531lgCWg6EBUtKgDZc1Je4io2Jw8x2tCgKNdqJMh8I1uz4wIPU/N
        MXxNKtGsZx2GehIg8zxPk2DpzSENtIk=
X-Google-Smtp-Source: ABdhPJxhMlkdpUZZ0QEODXx8CLC3/MXNHzt2/8DVaZ+wgH7FYZuLT+Nqib9MBZpofR9ZuTUMffD7iw==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr45812392wrj.144.1636973779927;
        Mon, 15 Nov 2021 02:56:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:19 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 1/8] staging: vt6655: Remove unnecessary type casts
Date:   Mon, 15 Nov 2021 10:55:42 +0000
Message-Id: <c9a5718479deda078b582cbc42a4e7b2f3a6cb39.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove casts to unsigned short in `RFvWriteWakeProgSyn` function as they are
not needed.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index bc4abe77db7b..aa90890c5c7a 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -699,11 +699,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_init_table[i]);
+			MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -716,17 +716,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table[i]);
+				MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table_a_mode[i]);
+				MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_init_table_a_mode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table2[channel - 1]);
+		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05134502ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhKOLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKOK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94730C061206
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so29825164wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HPYX9X+l+SHMmWoMwHMGj/nK3Gcy82dnkpOrVU1y4E=;
        b=CcxZc9cS925dLew7ws68qf5eBV9pJQabvv8BbtQMgpSQzwWCQ2KEKKVcFl3Zx1gs0K
         DxvPIOm3KH8dBW5STxTN2Pzohae0DTChOFxuZywi2gZkViHJxLdhlidyMMjcvFtIAhlJ
         u3qnHodw2I9rK3K5PwvvA68U8O1YKlfBpdvzBtsN7T6ApI4IId0hjkMO2w0gArjPE/Jv
         X7uAMW3kdugV6D9/sWL/WbvDJQTDRNKYRHhkBQwTDvsLezvSjzcBeKhhk424pDk3ljvb
         Yphfax2rjc+gURj5hXkKt0mlJmkXiQWj+x3tea0OdvEJ46tHRt+LlJn6+uSrKbm9Dk5u
         ONMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HPYX9X+l+SHMmWoMwHMGj/nK3Gcy82dnkpOrVU1y4E=;
        b=OblnFhl5oo0o6YXj3gbbWct7lvUCAbgg5KnE4Et2POSUrAmMu0Nr2bftuYU/J+edqA
         +ZUuEk5qTkWqs5EewhjFZfG6AFDuLRbXBx722hgypmImxsZPplNxizC6TEx7RLzPQn/j
         EWm5UuzXmjtIclsUfqd4x2GCn7aYaaSvn5pS9zKpVthd8waPZUdiHHqQm7hyQGwjz7vd
         wPUX1mUZu8t5J0Ire07e2LEO4i/mxyOw4BWEwxgTz4TTdHyo6CXuCpaoxYlMyQww6Aa+
         cFi144N5DBVCKNFR3N3ByxXDeLJAP8LArxIvHzel7MHWVEbY1cB4clDJCMQtydcyyc4z
         8nCA==
X-Gm-Message-State: AOAM530V0mjWMcIerMdv+LbGXPXoO6VwwOC8qAjIBlWOjz4KZPRCcCEv
        6LxEKt/3kkfPD9wwHWBKAOM=
X-Google-Smtp-Source: ABdhPJzqA2RlLBUuG/d82nyaOjbE+nb6tj5VUh9bpUB0N5xHIrE6wRNRaSI63CKb7VDdtlJmayWZ1Q==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr44376663wrc.193.1636973781248;
        Mon, 15 Nov 2021 02:56:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:20 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 2/8] staging: vt6655: Introduce `idx` variable
Date:   Mon, 15 Nov 2021 10:55:43 +0000
Message-Id: <596ae9bc980379860b5b1785b3ecc88e18121103.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a local variable to store `MISCFIFO_SYNDATA_IDX` offset.
This change helps in shortening the lines in `rf.c` that
are deemed too long by checkpatch.pl.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index aa90890c5c7a..d57fab3f10fb 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -683,6 +683,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 	int i;
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
+	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
@@ -699,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_init_table[i]);
+			MACvSetMISCFifo(priv, idx + i, al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx + i, al2230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al2230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx + i, al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -716,17 +717,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_init_table[i]);
+				MACvSetMISCFifo(priv, idx + i, al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_init_table_a_mode[i]);
+				MACvSetMISCFifo(priv, idx + i, al7230_init_table_a_mode[i]);
 		}
 
-		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx + i, al7230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx + i, al7230_channel_table1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, MISCFIFO_SYNDATA_IDX + i, al7230_channel_table2[channel - 1]);
+		MACvSetMISCFifo(priv, idx + i, al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


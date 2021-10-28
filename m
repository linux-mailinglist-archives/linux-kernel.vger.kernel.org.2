Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3E43DF02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJ1Ki0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhJ1KiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12547C061243
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d3so9295701wrh.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVb5GC93bP5+2in7SXHaVRcFzvFScW/Z0MhMVVxwoss=;
        b=UBeWVGZjUohQkuLKp9B+34RO1/T07RvSf3ohLXqfSxP5X8++zY037fpNoSiErYR0Nt
         0uFiBOyT318fafXT1HJPh49qgSOgzuO0l0IiVc2Ln6GHGo4TcSh3ZM0ed3PtbizorHc8
         /9N1cWxqkqVCkrl/eUV35behsErEToo+Tj8acJ/XLfB+Rflp0QmZr3IoQ2/fALLgLa80
         puAeL+DtrzIcfpyRnu28cLgcM3tfisoVJyGBBzJbCsBgCwr1mfVKKg/n3to4nhoSw0p1
         Q+nUblPinH81PdK5rZUJbA0H5Ew6VGjgO5n3d29bSJsx0Cf1YMhcYtp0QhFvLKsV1v2S
         LMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVb5GC93bP5+2in7SXHaVRcFzvFScW/Z0MhMVVxwoss=;
        b=4ZhKEVfHkuBjx5Ogye9TjHGLm3muTl7wRyyW0QlIVfbLrZq2/dLgTVUH/6agbsfD5Q
         WUAtYn6FoOlbjt06en04s06wRfRG1WvDJtLzhaVVUsYc7kVPl4S58eJyUTgLV8pBPeMO
         r5JhHkRgqlDtJmpPryf8dqkXqq74juQe40FkLyqZbfqkqk8AbFG3wttbmMw8ySkZH5Tj
         Hz8S5q9tAwsTCya8GB69vF8tLRY3mtzjoPJu0IoeFeBDz4nUyLwAKTLDwEVLs5Rkbrfe
         S4OTpvhXXFqtWdvDoQXt9z+iS7Sw14/TT6sSWyNc5SKOrzr/LZc99/N7HXIauWAkmuz5
         hn5g==
X-Gm-Message-State: AOAM533G5eLu95MfirqFjT72XTsfgqpJv3oENjJsvlRZX7osxSc3Vvi/
        7ZYaEC4BbCWKa2v6RKWy/NQ=
X-Google-Smtp-Source: ABdhPJwiXEHBUCpyKrHw/X3PhlHP/nFSJvqYQBgj4YRA51NuRP3X7B+7tyydB+mAxH5jYHTXVT0SnA==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr4552817wrm.395.1635417353741;
        Thu, 28 Oct 2021 03:35:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:35:53 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 1/7] staging: vt6655: Introduce `idx` temporary variable
Date:   Thu, 28 Oct 2021 11:35:31 +0100
Message-Id: <34bd0e8f42597edf006a950d420345befc4e0bc2.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
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
index bc4abe77db7b..f195dafb6e63 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -681,6 +681,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 {
 	void __iomem *iobase = priv->port_offset;
 	int i;
+	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
 
@@ -699,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_init_table[i]);
+			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al2230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -716,17 +717,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table[i]);
+				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_init_table_a_mode[i]);
+				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table_a_mode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(MISCFIFO_SYNDATA_IDX + i), al7230_channel_table2[channel - 1]);
+		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


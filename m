Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1A441CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKAOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhKAOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E4C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y196so4257991wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGvktVhPA6KMBN53Q9S7sFoN48GUfEwFvixIWYHV+nI=;
        b=QrSVBQO2aEvZdNSzkMa9ZuGKL08XxThQoagtuWQgTesTJCvoQsEqE48/j+Oi5/B83L
         CAtxsju77hrS9XtiBLOLxZcCS8/zgkjnYcyC1PZvHWjt32h+Z5skC74MvTZ/8M+jrski
         22p6QszRKI7EOwtJuvK+KrKWwFhitEc8VePs/pvV3t9tB9hJ6dJ28Gr+NPlLSptzVxAi
         nBhGqNSkPWxpdZTpPWOF6/CBMYg2iZVjLiObHsf6t7IQnsQz2g6ZEiRPDvdeQ+tDb0Y4
         ch0NJkQFe/8anOQ5/1WQvtFNMoJshsu0//egt5Divhi6A8rZ+M2cV8swmaLKG/WQHwzs
         8mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGvktVhPA6KMBN53Q9S7sFoN48GUfEwFvixIWYHV+nI=;
        b=sh2XMHA5Gy1F1LjLYPFBFtQx/1Vcw1gMHRANSjVrrdNKXQ9RtOqES5XNehdTKbYbV+
         1g5Xr30g4dT+YPfQJzOqazmH0zDFHwDbbpkjDw+vzn/fR8rcVaQtKlje+2e+sDMmM88w
         jh9xfx11byOmSQjB1dTY4JNqsS3MyQwCtZ2hYdpFARzy0kig9kkk2OFFa3r+DiU/Cs5O
         kYoQValqKCksA8F1Yd2pgwF6tVPACh+I7WGlI0d+zpQ+lmuDK4uMDz5kYhNNflussJ6I
         b1PXG2ykV8TZY3Lyp8ebJAXjMnxPlFsU1R+G8wup/Z+Wa2ww5bCLeGa3jDrA7aSn8oC1
         Y2GA==
X-Gm-Message-State: AOAM533yuU4AQjM4G40JaaYyfAL1/DfAVeXJWhR2+uSYrL1sIMoIzvcV
        17/wUpfM65rOso0muiw/bvM=
X-Google-Smtp-Source: ABdhPJyBxxnYIkT8f0+ebVqZPcFuVpU1ZLO5Cd8RuA4PjGOWBer6swPapezuqaO9eUYpLA4itlsslw==
X-Received: by 2002:a1c:1f94:: with SMTP id f142mr22652861wmf.192.1635777143199;
        Mon, 01 Nov 2021 07:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:22 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 2/8] staging: vt6655: Use incrementation in `idx`
Date:   Mon,  1 Nov 2021 14:32:00 +0000
Message-Id: <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increment `idx` in a loop instead of adding the loop counter
`i` to do so. Thanks to this change, the cast to unsigned short
can be removed.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index f195dafb6e63..c07653566d17 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
+			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
 
-		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
 		break;
 
 		/* Need to check, PLLON need to be low for channel setting */
@@ -717,17 +717,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 
 		if (channel <= CB_MAX_CHANNEL_24G) {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table[i]);
+				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);
 		} else {
 			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table_a_mode[i]);
+				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
 		}
 
-		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table0[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table1[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
 		i++;
-		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table2[channel - 1]);
+		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
 		break;
 
 	case RF_NOTHING:
-- 
2.30.2


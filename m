Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0943DF03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJ1Ki2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJ1KiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268DC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d10so9367421wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGvktVhPA6KMBN53Q9S7sFoN48GUfEwFvixIWYHV+nI=;
        b=Sxm6VcJphDjRh8Me8C4V+iuxN95Imhe2VFw9dMiGYEPDnIANrGILveOFbbl5lffyBq
         dB8d5n3t5HSZK+6nhvKr3YQ+YahQaX4k7yVF08/INr4GquIYITDKfXb/vlybNYyEZc3W
         Y5u4HcDng50sSWYpb0P8h3c7RFxzRXLhCyF9AzGJTg4Ck1mFvb2DeNkwPlh+p9ogf4+h
         Ugn+13kuXh4IoUBkTxeSOIPoZvDEn5kyDtZ3iORy9UhPX7+eMdKUxnBubHpL572ILA1u
         AaTokTyYHdSAbGJ3N4IdI1wIQ9mQCHPVT0L9J6OoU/9YPlBJKRYQcCqby/BjgQFBzSPO
         nm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGvktVhPA6KMBN53Q9S7sFoN48GUfEwFvixIWYHV+nI=;
        b=LL7VZc53DGLLwgAtaeAVG9rTBLywNuaLJSrbOfQctHWVpxpyk/bXHiXabyB5Ekh1Cl
         pS2y0G1akS+KDoN/4X41moTGyk20zAZcYmDK8ZF2J5CrfqarVT1GcHZLf9HhNQzgYYJ2
         06ZR3VFtAIgnDk259p1cSz3sYNwvithK6vQPo8aAKkbx22Za4894c8AmahKS08xSlU1G
         0+z6gALSRP3uRHH1c6GaKMho44q7BHtZCVaCWLgJfZ4pce1JvG1GEiEi1p4+OkaWVAgx
         HbAPFt0oKflQYjFhtCN+sE2xYB+n2N4h+u9ti0s/sDyxuBjpI+RmYBoAdxtdzZmHJ4yS
         LwRg==
X-Gm-Message-State: AOAM5337tQg33PISIU2YUyCiV1AiVOFZTUl6OB1xbfUwfIOZSX/4ljFc
        /dmfVjTIpp+BgUG4q94FFco=
X-Google-Smtp-Source: ABdhPJy0OHC/Z0pjoruA7fVybjLgRInXO+fCbCQ6mm2m62n6br5IuulLDNIS8la03WanY6gQB39Osg==
X-Received: by 2002:adf:e0c1:: with SMTP id m1mr4558338wri.241.1635417356520;
        Thu, 28 Oct 2021 03:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:35:56 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 2/7] staging: vt6655: Use incrementation in `idx`
Date:   Thu, 28 Oct 2021 11:35:32 +0100
Message-Id: <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
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


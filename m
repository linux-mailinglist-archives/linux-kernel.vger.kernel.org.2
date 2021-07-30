Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F23DB737
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhG3KiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbhG3Kh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:37:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F3C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p21so12474778edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLnKGJ4zU6EShY9oN7ziimVIk/9qsj11+Ck6qmbE50I=;
        b=InwobTsdCpBUyM5f+nITEbSMaSKS+etexul+GEBCofQ2Sk4G8Zh07/F/qsrCb8XJAt
         iLvexW2X2d+YqsTv0f3ZH5hGdNIm2NYRbXMVI1gq1ZYAeYk1E0ouunlcXJo302cceEnQ
         U/8S6+2d2Xoo0Hcvrj0dEjKMdImZvBVFxHYr7g/R2cFOoxX/fCjsODQdDeaDhdhmv9JB
         YMTxJaK20b9yaOG1xraRfRLrx8Sst/Vs33euhisrr+ZFhZmQ7k+AWJY/9gXLp5cJApPL
         ynFsXZx8Ys0f8eQqDWO9yPjlZqUpVcJCuZdudT8xeO9/jXcqR1jYm+XbdLz2CYIjbtKi
         ec8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLnKGJ4zU6EShY9oN7ziimVIk/9qsj11+Ck6qmbE50I=;
        b=g5Yv/A74o7sp/zmO2GcqdZVk5Sl3Nd+okOA3tTPxVSKblCZ8ExBb8F6Km2sQ7k8Lub
         fLFxcbUjCf2XIhZUVwWJWa4OvZXppr4P3oAUdg9reSLsneE2aOfCoOTWMVJqTJfhX2z3
         aXq+OSCijj7zk6IJF4EaR8Vyrsvqu9qDuSbBzqcyFNMcCmr95NKB6L+gwWgUJ6zj2Bfx
         wIlYXSG3h+4ure6PUd4WRHmomy5u3lUAUaeDLh9u4NpJ7WkkS6RtdQ0VYA5VRH7+G5uV
         OinZ/wwB97DGXrVJ8xdq+ID6DMjcPtXkOpN01u2kvhh6zLVX9QPX2/ter4sj8XGm+dv9
         d+IQ==
X-Gm-Message-State: AOAM5314QcPbgEA7z9NDm8onj1tX5LhxLLExh+hCt7PxbCJePP5SuWqI
        vAUFDigJDe3CXROXWT2OqGE=
X-Google-Smtp-Source: ABdhPJz1bJU2z/R42BUYF+1Ym2zOekoMO52zqLtsfY5oRH+UdSi2RStrqOHLrnWZ7LMdlH9w14P8Dw==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr2165940edb.12.1627641472810;
        Fri, 30 Jul 2021 03:37:52 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id v17sm493436edc.47.2021.07.30.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:37:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: Remove no more used functions and variables
Date:   Fri, 30 Jul 2021 12:37:16 +0200
Message-Id: <20210730103716.27210-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730103716.27210-1-fmdefrancesco@gmail.com>
References: <20210730103716.27210-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the functions and variables from rtw_security.c that are no more
necessary since the patch that replaces getcrc32() with crc32_le().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 37 ---------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 9625beea4b3c..136ba1e61dca 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -74,43 +74,6 @@ static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32
 
 }
 
-static int bcrc32initialized;
-static u32 crc32_table[256];
-
-static u8 crc32_reverseBit(u8 data)
-{
-	return (u8)((data<<7)&0x80) | ((data<<5)&0x40) | ((data<<3)&0x20) |
-		   ((data<<1)&0x10) | ((data>>1)&0x08) | ((data>>3)&0x04) |
-		   ((data>>5)&0x02) | ((data>>7)&0x01);
-}
-
-static void crc32_init(void)
-{
-	if (bcrc32initialized == 1) {
-		return;
-	} else {
-		int i, j;
-		u32 c;
-		u8 *p = (u8 *)&c, *p1;
-		u8 k;
-
-		c = 0x12340000;
-
-		for (i = 0; i < 256; ++i) {
-			k = crc32_reverseBit((u8)i);
-			for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
-			p1 = (u8 *)&crc32_table[i];
-
-			p1[0] = crc32_reverseBit(p[3]);
-			p1[1] = crc32_reverseBit(p[2]);
-			p1[2] = crc32_reverseBit(p[1]);
-			p1[3] = crc32_reverseBit(p[0]);
-		}
-		bcrc32initialized = 1;
-	}
-}
-
 /*
 	Need to consider the fragment  situation
 */
-- 
2.32.0


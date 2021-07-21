Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D93D0D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhGUKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbhGUKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:20:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404CC061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:01:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dj21so1899872edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcJkR5Zxpqb3xet/tE7gmdtBw2VTR3bkSSoPiQJ8c+g=;
        b=BuJBgfO1hH9KAclLZMCRPfKxFwbz4EyFar6FGWEC2FIJWPas/bukSjttYYPBkbBmbB
         DoSRiRKgWOzcgjyf32D9qWsOznOvmMC+yF8jX8W5DmQ3qTa6Xr+mw8fkCCCwikqFh0hh
         DEDsbPU3YUf6hy5H1hOFBLjxmhQP/+1nOq/YEN1L+UBCAoRU555otAmpH+o8kEP+QKFg
         V5gNxQWQPLns6P5C/O+It3MZbskljY/KIXiM1OY4Xw02J+qo7QnlmzkFqmG0padsdDxE
         pcj9Tg//zCgAKaufIJoNZ7i8jHPvEdHQo8FuGBnUgMgKLKmMof2U1nN4moTzri+xuPae
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcJkR5Zxpqb3xet/tE7gmdtBw2VTR3bkSSoPiQJ8c+g=;
        b=BSvI7VM50Ma+Vymqr/uFKYP7XQtIY5SlreVrerGB0pZbMVtYsfr4re+8fRfdsHshtY
         h0uEdVU9XXU5O+yPo375CBAVaa49s9QdsIGRPOrtDo5qAOJ6e5b41SBQALiWRQlxUHsS
         uHH/L/ZTYnA5Q4wvrq6Yq2R+Y5Ls+1zhunfleIDd4XV+nGTfI2E9Y/t76Q+PgiVLQ/fk
         ydvGajgyT/b1y5V45kXMF97pJVv441x8w/JmSYefoNs415ziVm72Uft8mHbwFxuMqyp3
         N81/lS/t25kPneSR58udPi6N/DRGI/Ee9GqBfdj34dO5Srm9Bos6KiUMnwJlnIMNg1so
         w1Gw==
X-Gm-Message-State: AOAM533EfnbaoDWBruvMj+o1WhtacLtu04q8F9cifOcetw/7mlNSzLQ/
        gSco5dkJ8RqNE6BsRyzvjpw=
X-Google-Smtp-Source: ABdhPJy+mu2ZBgTCZ2SpSsajNh9R4BJG/O9dgMAJtQk6mZHxB7wdIKLXeiFbHjMmYwB8mk8fjvhxtQ==
X-Received: by 2002:a05:6402:74c:: with SMTP id p12mr47105613edy.153.1626865265131;
        Wed, 21 Jul 2021 04:01:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id f5sm8102482ejj.45.2021.07.21.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:01:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 2/2] staging: rtl8188eu: Remove no more used functions and variables
Date:   Wed, 21 Jul 2021 13:00:52 +0200
Message-Id: <20210721110052.26376-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721110052.26376-1-fmdefrancesco@gmail.com>
References: <20210721110052.26376-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the functions and variables from rtw_security.c that are no more
necessary since the patch (1/2) that replaces getcrc32() with
crc32_le().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2 --> v3:
Join two related patches in a series because they must be applied in 
order (first 1/2, then 2/2). Rebase to the current Greg K-H's tree and resend.

v1 -> v2:
Update the commit message with the URL of v2 of the above-mentioned
patch.

 drivers/staging/rtl8188eu/core/rtw_security.c | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index e9de61afe881..8ec0b897ba3b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -76,42 +76,6 @@ static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32
 		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
 }
 
-static int bcrc32initialized;
-static u32 crc32_table[256];
-
-static u8 crc32_reverseBit(u8 data)
-{
-	return (u8)((data << 7) & 0x80) | ((data << 5) & 0x40) | ((data << 3) & 0x20) |
-		   ((data << 1) & 0x10) | ((data >> 1) & 0x08) | ((data >> 3) & 0x04) |
-		   ((data >> 5) & 0x02) | ((data >> 7) & 0x01);
-}
-
-static void crc32_init(void)
-{
-	int i, j;
-	u32 c;
-	u8 *p = (u8 *)&c, *p1;
-	u8 k;
-
-	if (bcrc32initialized == 1)
-		return;
-
-	c = 0x12340000;
-
-	for (i = 0; i < 256; ++i) {
-		k = crc32_reverseBit((u8)i);
-		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
-		p1 = (u8 *)&crc32_table[i];
-
-		p1[0] = crc32_reverseBit(p[3]);
-		p1[1] = crc32_reverseBit(p[2]);
-		p1[2] = crc32_reverseBit(p[1]);
-		p1[3] = crc32_reverseBit(p[0]);
-	}
-	bcrc32initialized = 1;
-}
-
 /* Need to consider the fragment  situation */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-- 
2.32.0


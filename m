Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC513C76C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMTG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:06:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBAC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:04:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb6so43388190ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRHnqgTDleVFG5NcQlSkXobdxLX8J2tzmW5qrxaqAB8=;
        b=Xdi05Fm4oIRff4UVzx1er5Cq+7tg+KuRGe6A7JK2alkLfWTlO/oy/ByAsCNBU+3wMu
         IHVsR3ZlA/UP2c0f1MWe/J/x3kmL8OyoACCTsQNwoYWGlMyLOjUDc3w/VO+iYgA25XKJ
         kmWLAn1zl6jkHg6PuKrp1PG9hfOzs5xh9YLlpp8F79e/xBvatxEVIyi1F0dOE7+lvk+V
         T1FeLUYm/P9j/M0rxzhhk1LpOvbkjcc7coFKWqKXJeiNYnFdgZAK4pM/PSbBqk2+btmo
         ZyJx5VK6ZDjXpONyvMSYst9IwugA0vIjdiHx3mq/bsuVlvjS6xw7Fa2uOICDO1jtVesn
         BKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRHnqgTDleVFG5NcQlSkXobdxLX8J2tzmW5qrxaqAB8=;
        b=aLRs8E4qU0gmzgBhWBpchbzbo76jCIYwBxvHvkP4tE3yS1s5BieV/w8Vbmqtx4IQIe
         vOjGYLKqVIppd/YaT0c90c2GFj+0v0FE5DYol0RL9OO2iZqFQiTk6r8yeT7624rBXqxr
         he9qv7JDrvhmjRug5Na4EHaUCue6BByVa15GIcZjJJJwk8R+JRUHQPbMuGMu300+bYtL
         Igm+edgjbyos81844m0Dq+w2qSapodoGWrLJyED+r97E6T/DLcc5OOh4O73mM9sJDzw0
         IkkeXImmpPn7dLkj2O1AKVA977qdQRhP4fAhLXz3gmyNmzKFM0wyIZ0m+jfLjZ+nR9UO
         9I9Q==
X-Gm-Message-State: AOAM531en5F5HSE3fkdJ4p+9a7/2soXJwb+xcmQI6Pb4H879H/isxjzU
        53+rxh7hvvpvGKipRL8C51U=
X-Google-Smtp-Source: ABdhPJz7otacVuB2JTm1gosl7q2fM5LVZfUIJ+w17cg59HUTB6KjvdvIWAV8N63GbhIXpstezhiY3A==
X-Received: by 2002:a17:907:988e:: with SMTP id ja14mr7444582ejc.173.1626203042308;
        Tue, 13 Jul 2021 12:04:02 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id g23sm10045807edp.90.2021.07.13.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:04:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Remove no more used functions and variables
Date:   Tue, 13 Jul 2021 21:03:58 +0200
Message-Id: <20210713190358.11864-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the functions and variables from rtw_security.c that are no more
necessary since the patch that replaces getcrc32() with crc32_le():
https://lore.kernel.org/lkml/20210713184629.7358-1-fmdefrancesco@gmail.com/

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2:
Update the commit message with the URL of v2 of the above-mentioned
patch.

Please, apply this patch after the above-mentioned one to make the 
code build with no errors.


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


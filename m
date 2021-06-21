Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97E3AE4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhFUIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:21:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86302C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:19:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v13so8112734ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77hf/T8lwDKu+LOBcDl7pOZpmghmTiN2GKRCSb96Rx8=;
        b=DY4YWQUf04XklvK2k1UJkaX/mFPv5j/WzVzLuU4pgdzbOhzY1ZSQ8g4GV1bG/BNJFz
         /3Wv/ZRnqVvTvR0RhyzX43rm0uiQ8SjPK5z6v+HvTXnemGQycjwZzIzNvCFnDVi1EqMv
         CEoaaxrOSq609fK/fH9XUO6Q8GrTCb65a++MkgO1/eAjplkFlPL7c6eh2DwqkaY3qmCr
         lvsFEnUgfz80XY/+E8sd5LeU239VqUJpUdAi/b8mRMVJKk/KHrMLoQqDrpp9zA+UuX1q
         P5jCag4SYP9hnzjF6qW4VbpIDQczTqKq193OEEAaRATB5+vl/vPEcz0st/3nRNLQfkzd
         qJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77hf/T8lwDKu+LOBcDl7pOZpmghmTiN2GKRCSb96Rx8=;
        b=CvbOzjK95H2q2G3FOPtk+jIwc+rlwQIOkNWEfJFZMydnyEqOgc8rESl/FpRMIMhZNn
         CjhCk6ElNs3+hLcvGu8QB7G59xh5NKt1MA/W8Gpq2JzTphi90IzwWHo/ukTDL6bZiLlO
         8BrwfCUprgTg4iaqvWtL9YkhhUqoVDiDfBQ+XzLu7fR7FuVUyDdXcgSdyOxzw+md0Stt
         FFmu6f0+0n6fvN0rtwSPU2+4sOipkobjDv9C5F+AvPTtzZNjfgBsD+KQ9xl8CTOuF78k
         CHDrLXjHhK+Jas5e7coPgrNXkXrSBSixnLZtXzVfjybgPriMX8yDeczdHXJrt/JkyPLj
         pe7A==
X-Gm-Message-State: AOAM531Xi6eI2LJ6hzujkRlgye8DNs02EQHkGPKnGEOw0hDybt39m9cd
        Znf9D6a/q1dKIA2T3s41z6s=
X-Google-Smtp-Source: ABdhPJwmTtMRPENxKEKo5otLMCyugFRQtTECBJzwX0OindmT7C4PaS0PZJARgPsf4hnCNGXhvJr9+Q==
X-Received: by 2002:a17:90a:4410:: with SMTP id s16mr24872989pjg.25.1624263583815;
        Mon, 21 Jun 2021 01:19:43 -0700 (PDT)
Received: from jm.lan (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id u1sm14384584pfu.160.2021.06.21.01.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 01:19:43 -0700 (PDT)
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Subject: [PATCH v5] rtw_security: fix cast to restricted __le32
Date:   Mon, 21 Jun 2021 16:19:28 +0800
Message-Id: <20210621081928.145203-1-fbihjmeric@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619075255.107807-1-fbihjmeric@gmail.com>
References: <20210619075255.107807-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning of fix cast to restricted __le32.

There was a change for replacing private CRC-32 routines with in kernel
ones.
However, the author used le32_to_cpu to convert crc32_le(), and we
should cpu_to_le32.

Ths commit also fixes the payload checking by memcmp instead of checking element
by element and removes the unused variable.

Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..8dc6a976b487 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -92,7 +92,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
-	u8 crc[4];
 	signed int	length;
 	u32 keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
@@ -119,10 +118,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		/* decrypt payload include icv */
 		arc4_setkey(ctx, wepkey, 3 + keylength);
 		arc4_crypt(ctx, payload, payload,  length);
-
-		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
-
 	}
 }
 
@@ -537,7 +532,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u32 pnh;
 	u8   rc4key[16];
 	u8   ttkey[16];
-	u8 crc[4];
+	__le32 crc;
 	signed int			length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -618,10 +613,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
-			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
-			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
+			if (memcmp(&crc, payload + length - 4, 4) != 0)
 				res = _FAIL;
 		} else {
 			res = _FAIL;
-- 
2.32.0


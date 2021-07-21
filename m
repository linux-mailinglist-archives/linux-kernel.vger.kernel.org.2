Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBC3D0D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhGUK22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbhGUKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:20:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62CC061767
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:01:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so1866810eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqsuFT6nvaHo3QaDsUicVMY69Lhvw7YRbkMUFq70o0w=;
        b=gsDZQxc+f7nzPsQgsOGrO9szBsk4vVrJtiUk8P2ZjI72iYDlZc7b7/CU7H+JArAP8X
         ClLJQXDbFtj96x/+Tej697Tw7pcqtzWbTJ3snMwHpdwb3cN/Pq4UT5iFoHLO1BGcL7mZ
         ahj4U7pndGW7enEIn+9An6R2VhHCUyYzmlnaqXOy6NmAv8quETBOz8yWHrqIsjgApMFX
         KeXc2gysWNaRyRx5vmbeFCRq7nCGp0gCChXX6/5BLLt/T3OezQEM9OIzyFLdv1fCFhFN
         Fsf7OabzknaT1gmmbdNpCwHfRi4t8PrNgdSUtqI3N0ZGAAbCUrbhg31GDVEalYbWan5X
         9zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqsuFT6nvaHo3QaDsUicVMY69Lhvw7YRbkMUFq70o0w=;
        b=Ni6b7GAvBSv3ko6Zd8qFC+qvwmycpyzW9KdXXZnlWKxgAjaVioKgL6hqFR/nrqvpIa
         jsgK/oS3L+owN4B9vKflWXxXM80D8SWKYOKWFNnQX1iDmPYuqkHWYXzsc6MzI0YjlwCl
         rilO4GlvCbmpp38ZOM1+m3YKnSdb3WK+QjLJMU3KA74dRF+unfkFq6Ck7oUBZkMcIa5V
         NVTZ2PXedoVDMoY5Zrw19DJGLXzxCpp53S7VR+hvOrTWmyJHh4RTS4gVPJoI7EopM0m8
         gBf8mfb5BwxD2Rtj9s5PiDFfpq7XtNB3UIeACp0Cd9JW8+GVRcqn6ZgZAvHxxMDxlAVz
         bhdQ==
X-Gm-Message-State: AOAM532oyKhWdFrebyfsB+5S8C6IczIDAw/0fIPxU5lWRHPyrnGz7S2V
        Ml+uLmFgmZ9L4IJwnxAUOvU=
X-Google-Smtp-Source: ABdhPJy+hB2uUujRC5g4BAMOVIdEGVgqybPGVHIEEeyiZxbi/VwbKplBkRXkoxJvZE+JT89f6rHmxg==
X-Received: by 2002:a05:6402:686:: with SMTP id f6mr38621021edy.127.1626865260265;
        Wed, 21 Jul 2021 04:01:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id f5sm8102482ejj.45.2021.07.21.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:00:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/2] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Wed, 21 Jul 2021 13:00:51 +0200
Message-Id: <20210721110052.26376-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721110052.26376-1-fmdefrancesco@gmail.com>
References: <20210721110052.26376-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use crc32_le() in place of the custom getcrc32().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2 --> v3:
Join two related patches in a series because they must be applied in 
order (first 1/2, then 2/2). Rebase to the current Greg K-H's tree and resend.

v1 --> v2:
Use cpu_to_le32() to assign native endian return value of crc32_le to
crc in little endian byte order.

 drivers/staging/rtl8188eu/core/rtw_security.c | 23 ++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 1b2cb6196463..e9de61afe881 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -11,6 +11,7 @@
 #include <wifi.h>
 #include <osdep_intf.h>
 #include <net/lib80211.h>
+#include <linux/types.h>
 
 /* WEP related ===== */
 
@@ -111,21 +112,6 @@ static void crc32_init(void)
 	bcrc32initialized = 1;
 }
 
-static __le32 getcrc32(u8 *buf, int len)
-{
-	u8 *p;
-	u32  crc;
-
-	if (bcrc32initialized == 0)
-		crc32_init();
-
-	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
-
-	for (p = buf; len > 0; ++p, --len)
-		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
-}
-
 /* Need to consider the fragment  situation */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
@@ -609,14 +595,15 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
 				} else {
 					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
+
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
@@ -682,7 +669,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			arcfour_init(&mycontext, rc4key, 16);
 			arcfour_encrypt(&mycontext, payload, payload, length);
 
-			*((__le32 *)crc) = getcrc32(payload, length - 4);
+			*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
 			if (crc[3] != payload[length - 1] ||
 			    crc[2] != payload[length - 2] ||
-- 
2.32.0


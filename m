Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F83AECBF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFUPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:50:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDEEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:48:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5so10237695pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5SJuzT9tzAwJWaOzIHCdtjjnLO4VyofXEKA88BIzpY=;
        b=L0hxzZsRscJCbcvH0UePK3/+y5jaKpD6basVpvHD83ktdhFDwVVV5Y//6bu8NUjbsK
         Q/1G3trvyv7Z5CmjC8GGSX0eE7fYE5iC2oUhBND4z2/Gq3VyQh+zjTwmuo66Jk9zFXql
         eAzkd9LLhXPg98AoG20orQG6v25sMf9ONn9Bhfks2oWqMfquvulVD/on/IKCdYSuhoRG
         DiDcsVfxoaMIcBuuTyzzaVZkzqZ76pwf5RmeIJvifIi80u0aDqHMj0LOoQ/kJ2A29LI4
         FRWimF0QIyFKdn+vGmaSswHtFNsF8y/nV5yUA+cW76rLjElvijmcWFnGfDqHurqMlV4Z
         HVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5SJuzT9tzAwJWaOzIHCdtjjnLO4VyofXEKA88BIzpY=;
        b=UsKm5nZhd+7cNiuBVbbO5Wul/ZjRzjvuMR3jL26wB5cFXcyQ8GBp5482aamYJ1de2x
         mpewzqdlYEb5hGWuUTIQZJLDYsz7QtNWL6iIlGS4zldUNLGwpjqzXqTqFviB7613KV/t
         HKLh3y8KAQ0cIvm2Yq+30bLW7MYC+HOIyeCjT3r+6gwI5q/t9JplyDSZBNlKwkB0oYOB
         d4XOZ97tCf5chy0MzN71U0ks4iAVL/jCdiRZrBDVSbXuJHRTXc5OIq8UcnvNjorqf6ib
         RpKK4rRb7Q3JNWaHqV+chtTe47gSRBAPKJXL0ab04LRd68c8bH3RHF67ubzvDYX0+t0m
         oqoA==
X-Gm-Message-State: AOAM531M/EFIHYLh9+qzPn9ZRQzQAScsxB5bdm/QKalPAu+i++CPB9hO
        6XgQx7Qo0BLoyWG0Z1j+GiQ=
X-Google-Smtp-Source: ABdhPJyBeElckm23B8UhxM60Qd04pcvdlCEwIzxB5UdewjpYk9IluaiNQ12s1wZwi1U8V6OVvsxaew==
X-Received: by 2002:a17:902:a5c9:b029:f7:9f7e:aa2f with SMTP id t9-20020a170902a5c9b02900f79f7eaa2fmr18584320plq.54.1624290507932;
        Mon, 21 Jun 2021 08:48:27 -0700 (PDT)
Received: from jm.lan (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id l201sm16143892pfd.183.2021.06.21.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:48:27 -0700 (PDT)
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jhih-Ming Huang <fbihjmeric@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6] rtw_security: fix cast to restricted __le32
Date:   Mon, 21 Jun 2021 23:48:17 +0800
Message-Id: <20210621154817.149667-1-fbihjmeric@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621081928.145203-1-fbihjmeric@gmail.com>
References: <20210621081928.145203-1-fbihjmeric@gmail.com>
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

Reported-by: kernel test robot <lkp@intel.com>
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


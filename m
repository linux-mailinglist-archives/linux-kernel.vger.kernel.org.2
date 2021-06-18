Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429563AD1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhFRSUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhFRSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:20:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:18:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n12so8394208pgs.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoEdXh/VaJ+mbzDRuncceAoCRUlb0lvwPS0zh9/WG+I=;
        b=rm2SiL72/vhadlYZz1wnHDoZbZbCMgU/Gry+VpWLCPiFNvsIUcjKcBBqY/ojvhCCHz
         sZACEvqbm+arlZrxNyFsySDYOObUU9gTFPMq++Z0wOKR0OH6/gXxPfVlgQIyprJmlwIN
         pmMeDrLfHt/biZ0uCf5Wi0mYaRbiYR0I+nQnmrBdNNeTTewruhJTyXJylM83R1bn4tVQ
         Qh+cYaZQh0V/i6ZqItGa/1A+c6uRE870zu0ETARSMBDVPI7+oSMnSv44yLGXyWkH0Bxf
         xM2z0ANFrWbghlp12ss/eAubl9kTv6Oj2QSg/p4F4/C1fxEti/cHX59gyCo22ECkk23y
         YITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoEdXh/VaJ+mbzDRuncceAoCRUlb0lvwPS0zh9/WG+I=;
        b=bTVzQ+E4Gu/dcE7cYVJXl/tfNCVUL+CT17206chbcGBs6F71kaqQIcYvhgII6opHve
         7rGoVu4Fqv7FScnIEvihrj8Eyj/cA4YRX+AS//ffjoAqLFxE6JHoaLFTfTnn+I4Cjxrn
         7d6E08WXIwMRNdhReyvuw5YEDcTWCdoOahRcJ3fwNKgkn5zYWOXzMX1d+bFkEkNREnZK
         CxlqYp+WiWLYv2PHJWBDupa/sVnEouuTqYkZslInmSERLRv7wglArWgaBuEMUsl7P7H0
         RSPWSmWSZWAeinBd1pxzjh70mj3i+qrkcYGrPFasj8kJxD7IWhDIUlw7uoW//ni6Umym
         TCVw==
X-Gm-Message-State: AOAM531qtO9lWolXREGJEkgqUHurr84zOVbEXew5zqZ1vfHha9wtRXRN
        TDOzNrNZhUGCxsxeaN9JxAbQNaEXrzAv1Q==
X-Google-Smtp-Source: ABdhPJxxLzRZKmYzjmg30+asLiYN9SPrEQ4JMEgRRucb6cPGRBHBqhr5QKYIm3jJLR5lzV2iaMzS9w==
X-Received: by 2002:a63:d053:: with SMTP id s19mr11271566pgi.326.1624040291117;
        Fri, 18 Jun 2021 11:18:11 -0700 (PDT)
Received: from jm.lan (1-171-85-235.dynamic-ip.hinet.net. [1.171.85.235])
        by smtp.gmail.com with ESMTPSA id t193sm984195pfc.166.2021.06.18.11.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:18:10 -0700 (PDT)
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Subject: [PATCH v3] rtw_security: fix cast to restricted __le32
Date:   Sat, 19 Jun 2021 02:17:51 +0800
Message-Id: <20210618181751.95967-1-fbihjmeric@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
References: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
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
by element.

Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..97a7485f8f58 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
 	}
 }
@@ -618,10 +618,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
-			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
-			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
+			if (memcmp(&crc, payload + length - 4, 4) != 0)
 				res = _FAIL;
 		} else {
 			res = _FAIL;
-- 
2.32.0.288


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6483EDA63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhHPQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbhHPQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF181C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so9622648wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1dKHIJTq4qxeAvZPGI2tveZiuONxwwZ+x27EuMD30E=;
        b=UYrTbe03kvNj/3F9ZbRjZk8wjR7Oic/teWAhTcJtnnec7czBAurDiDV9uT3ZHXci2r
         IjVhVCwDUQ9uHOsBeR82nuW6jOHMFcGLj9UszglG0wDp5c/Rh46heUXsUDS750PC2vCL
         ShPwh/qss6SAO30iy5IaqnEVBwFt51EiVJNzcYzQwAgHQwBptAVUtYmEYBh2rtLYPOzs
         QOWmeH9neDUcyAWbBSmZlho/f1p9dKnl4VlBHzd684O7IWo6WiG/dx8Zjha40r2V+z4O
         +GIgyw/4RPH7777hqXUSCDUCiWOllVc0kpoB+ywXR+Y6fZER62XylQhEHGNHsmraRndU
         x6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1dKHIJTq4qxeAvZPGI2tveZiuONxwwZ+x27EuMD30E=;
        b=qMFBhz8agwqPqaRf3b/KFVQqD7epQUQG3ub69bG35o45UGoBq4DcNHSTK/T61/dLkD
         occR3BZmOyrIPLCMoS2VjZRfD5R4RfUqySGKGK0FsuByQVtzuUCmSwvS6u/7LSyn+HvY
         fg0Qhd3balNeBw2/SYOBRbPLOuD0qebhIs2KGW5JznDv+bodtUbYWUbQTvjR1SPOA26F
         f91YqHh/zkWhojzoG3AfB7Gyd+twbg/IO9UFh0Co7zsxaoW4eVdeVuKFIkioY4rWji6D
         L7TvvtlQwq2Cym0+oLwKTJsGsUqojHkxbK+sY+9NMIM3JNOJkOANPglNKsp+rSAcgS5m
         m4JQ==
X-Gm-Message-State: AOAM532bvgWpcYR/Na2qZcFdJbnRpazArafG33siGPL1Z4RSZFokZttV
        rPm1lOXSurcv0r7LgLMe7vY=
X-Google-Smtp-Source: ABdhPJz8ymQEzKlbZgSlCQH3JMUty5s84PXDrgEwBgGi3QZegb7eqXlMAqqcNIXxWW8gycHb2bEuNw==
X-Received: by 2002:a05:600c:3b08:: with SMTP id m8mr12268927wms.32.1629129574597;
        Mon, 16 Aug 2021 08:59:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/23] staging: r8188eu: clean up spacing style issues in core/rtw_mp.c
Date:   Mon, 16 Aug 2021 17:58:07 +0200
Message-Id: <20210816155818.24005-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_mp.c reported by checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 8de6af042156..8c044d3bb61a 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -595,7 +595,7 @@ static int mp_xmit_packet_thread(void *context)
 			}
 		}
 
-		memcpy((u8 *)(pxmitframe->buf_addr+TXDESC_OFFSET), pmptx->buf, pmptx->write_size);
+		memcpy((u8 *)(pxmitframe->buf_addr + TXDESC_OFFSET), pmptx->buf, pmptx->write_size);
 		memcpy(&pxmitframe->attrib, &pmptx->attrib, sizeof(struct pkt_attrib));
 
 		dump_mpframe(padapter, pxmitframe);
@@ -698,7 +698,7 @@ void SetPacketTx(struct adapter *padapter)
 	/*  offset 8 */
 	/*  offset 12 */
 
-	desc->txdw3 |= cpu_to_le32((pattrib->seqnum<<16)&0x0fff0000);
+	desc->txdw3 |= cpu_to_le32((pattrib->seqnum << 16) & 0x0fff0000);
 
 	/*  offset 16 */
 	desc->txdw4 |= cpu_to_le32(HW_SSN);
@@ -882,7 +882,7 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 	i = psd_start;
 	while (i < psd_stop) {
 		if (i >= psd_pts) {
-			psd_data = rtw_GetPSDData(pAdapter, i-psd_pts);
+			psd_data = rtw_GetPSDData(pAdapter, i - psd_pts);
 		} else {
 			psd_data = rtw_GetPSDData(pAdapter, i);
 		}
@@ -891,7 +891,7 @@ u32 mp_query_psd(struct adapter *pAdapter, u8 *data)
 	}
 
 	msleep(100);
-	return strlen(data)+1;
+	return strlen(data) + 1;
 }
 
 void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
@@ -964,7 +964,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 	;
 }
 
-void Hal_ProSetCrystalCap (struct adapter *pAdapter, u32 CrystalCapVal)
+void Hal_ProSetCrystalCap(struct adapter *pAdapter, u32 CrystalCapVal)
 {
 	CrystalCapVal = CrystalCapVal & 0x3F;
 
-- 
2.32.0


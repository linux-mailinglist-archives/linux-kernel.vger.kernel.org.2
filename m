Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9D3325C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCIMtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCIMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:48:57 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A974C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:48:57 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id b5so12027869ilq.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+KRVYYDfV87KFB6tUI9FoT8TIrlqrfga0gxkkg+SWw=;
        b=I9w2f8aMpEAj0XV6jP3/gp/JWkDbLZKqW4VqQUsbdf4LKeCoBsc92x6L7u4MIsJLJo
         F9raivv5YQMaRRjyO+dcRRHI44MA/FJ5OgE4x+IE7vVoEpIunt6vcW5f5gdRhb7q885l
         tvi1Mz4t+h0myScM0WYrzUoKkaXTpdLUsQnN/NLeqaBCKlnK/1NIlsFlmpuOhcZjYfRI
         La6Eil57+K0XvIC/wRnh+45tOaFmQwKtxbLhGqaHC4mrY4b1fn7uEFPXjTIOcIyBfBaR
         rt3O8mCfgkbH+p21109IOjWWR4LiDtq1QDJ6O/cPO+kwixAs6luimglrpn7EAFD+Jy9S
         ObIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+KRVYYDfV87KFB6tUI9FoT8TIrlqrfga0gxkkg+SWw=;
        b=PnANpkDvQtmQnZR7I7g3PovPrLRWSO11ofHaqWG05Fvx5jIxuYybJ2NywGtu+mhjtt
         dQ+3lAeRGthWOpDVlxC94C+KNVBvm1/bhEKd4jamVyFBI+cZpnhyD8GmEmrSSU22MLRz
         cxydw+JNJvmat1YuT2FNPMCaIkwCrkRwnROekvTbHp5vH+bIRyvHlcjhchvOk8A3aRp2
         L3mBMEqvyogWEvP140yL/ccVx+A6WQdZrOoFbMDI70lsWgkClP96MGfexEf21tWxOOio
         sGHSA1TvH5sPbydz+dN4a9Cl/otSyVswM9ckgdEN3NScDzKssDSQHeZsY/R4Bo1qVGeJ
         ToCw==
X-Gm-Message-State: AOAM532KfBmUp5goFNyFqN/x0fIimbQLxSX8b/exEZLbou/dYtyliLoQ
        j+6wLh17R5712zsk/pmjnmFI5Q==
X-Google-Smtp-Source: ABdhPJwq3y2yp8sHUos0cToFgMNUZYzOcOkqzIDt+ubkukCwJw8PedHn9n1/ADUB898U1kqaJXpu9w==
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr23938935ilo.41.1615294136729;
        Tue, 09 Mar 2021 04:48:56 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o23sm7810009ioo.24.2021.03.09.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:48:56 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        David.Laight@ACULAB.COM, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/6] net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
Date:   Tue,  9 Mar 2021 06:48:47 -0600
Message-Id: <20210309124848.238327-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309124848.238327-1-elder@linaro.org>
References: <20210309124848.238327-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of C bit-fields in the rmnet_map_dl_csum_trailer
structure with a single one-byte field, using constant field masks
to encode or get at embedded values.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
v3: Use BIT(x) and don't use u8_get_bits() for the checksum valid flag

 .../ethernet/qualcomm/rmnet/rmnet_map_data.c    |  2 +-
 include/linux/if_rmnet.h                        | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 3291f252d81b0..72dbbe2c27bd7 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -365,7 +365,7 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
 
 	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
 
-	if (!csum_trailer->valid) {
+	if (csum_trailer->flags & MAP_CSUM_DL_VALID_FLAG) {
 		priv->stats.csum_valid_unset++;
 		return -EINVAL;
 	}
diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 22ccc89bb5d8e..a848bb2e0dad0 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -19,21 +19,18 @@ struct rmnet_map_header {
 #define MAP_PAD_LEN_FMASK		GENMASK(5, 0)
 
 struct rmnet_map_dl_csum_trailer {
-	u8  reserved1;
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u8  valid:1;
-	u8  reserved2:7;
-#elif defined (__BIG_ENDIAN_BITFIELD)
-	u8  reserved2:7;
-	u8  valid:1;
-#else
-#error	"Please fix <asm/byteorder.h>"
-#endif
+	u8 reserved1;
+	u8 flags;			/* MAP_CSUM_DL_*_FMASK */
 	__be16 csum_start_offset;
 	__be16 csum_length;
 	__be16 csum_value;
 } __aligned(1);
 
+/* rmnet_map_dl_csum_trailer flags field:
+ *  VALID:	1 = checksum and length valid; 0 = ignore them
+ */
+#define MAP_CSUM_DL_VALID_FLAG		BIT(0)
+
 struct rmnet_map_ul_csum_header {
 	__be16 csum_start_offset;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-- 
2.27.0


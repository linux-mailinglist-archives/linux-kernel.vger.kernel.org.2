Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B312C32F804
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCFDQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhCFDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:16:00 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CADDC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:16:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o9so4151774iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 19:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v75WqFNEqmNfaFvo+fJoS+EBGR7oORQvhBv4GH6rgs0=;
        b=o4HiSXgu0idLl/ulWk8usLU0pMTEcPGiNrBY7cmCtob+2QUIgLgh0WGzC4tToMdqcr
         ZewxhKsdTKHknEEs/ImvzgvmJ93jjxcJiwWXxIFM2tNc4PiBVvQF/5uZkz3R19xRQKNq
         zi9SmowDHhzAR3r9x6aQo7zD0nF0PW+A2lMOf3iVEhOq1xLkai45OwKSdZnEAcpNPSQM
         aGic4P6rrBAGS0NqC9JN43LrD3koQJc7UQyG7jJFEe/rJKoertziZ57ucAhZucS48cY5
         /KCAZYk3zU2ptJDhGB/9gI1NnrxoUSFIkfCk7SrFS0fDbK0j/zOc8DDFmPp5QKXVgVuU
         4Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v75WqFNEqmNfaFvo+fJoS+EBGR7oORQvhBv4GH6rgs0=;
        b=UIOVmC4WBeaXbHjOu+tpjuLliogpeP9rd5hC9/BGersdFVJ9h8JsfGkPlfCM56m8L3
         gRO3aF+vYff75Wy10Xn1s81zxKZOj1WYo9efWh9C1lOwduMtDb1XszL/g+ea2S/SwGu3
         LzY6USJqhaQjXpOjpNA1bwRjyfPEWXhToV/AVNa5TQYUZDm0Rgodw3+K5r6AgE5JUXnc
         CB5k3yTA+k/KZOj+IiCf96rg6tVL46fvsIH+O0qpoDLdC05nfk18Bq/umPjEi7SxyNFT
         4pSmZjs4LDHp2g2zywTYVVFMpnOzR+X0r7Aw4WDJfzv3L29XScRMsiCniGFqbsKnd2CA
         hWRw==
X-Gm-Message-State: AOAM530mxg94FBGSXqPjoUBwG4TgxYcBKwxvq1BNUhuqaMndD/KbsXJM
        e2zkh6iJQRBepBQseR8zHl/73A==
X-Google-Smtp-Source: ABdhPJweLcMc/ise0niUmOJXyK4ZVWQSoaa4YWoBzVuIsaW+t6Ln0kznijsuH/q4GGXlHy6s8JJ/Eg==
X-Received: by 2002:a02:9985:: with SMTP id a5mr13152384jal.122.1615000559695;
        Fri, 05 Mar 2021 19:15:59 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i67sm2278693ioa.3.2021.03.05.19.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 19:15:59 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/6] net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
Date:   Fri,  5 Mar 2021 21:15:49 -0600
Message-Id: <20210306031550.26530-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210306031550.26530-1-elder@linaro.org>
References: <20210306031550.26530-1-elder@linaro.org>
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
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c    |  2 +-
 include/linux/if_rmnet.h                        | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 3291f252d81b0..29d485b868a65 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -365,7 +365,7 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
 
 	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
 
-	if (!csum_trailer->valid) {
+	if (!u8_get_bits(csum_trailer->flags, MAP_CSUM_DL_VALID_FMASK)) {
 		priv->stats.csum_valid_unset++;
 		return -EINVAL;
 	}
diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 4824c6328a82c..1fbb7531238b6 100644
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
+#define MAP_CSUM_DL_VALID_FMASK		GENMASK(0, 0)
+
 struct rmnet_map_ul_csum_header {
 	__be16 csum_start_offset;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-- 
2.27.0


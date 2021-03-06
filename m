Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5432F807
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCFDQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhCFDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:16:12 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5BEC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:16:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u20so4140393iot.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 19:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQkKL/OB7ALpeFx7XOfbe4/eCQx3rmR+Ln/joz2blFc=;
        b=fiVdoyp41dr0PAzh3H73TXdQmN7xdWdEPXFvKEEXCEtpiqU6kqPtU4+0I+YCAoeTMA
         pVbwgNkuuXzpfN5J6HrZcMcJyoT6O3gSp8Hixome4W7bd5t1cbVELqfXexhTYArjkF6r
         vW+uxsKYiVdOntRLYlaNNl5WLg6Ycik7GYaTnaIsH0DygM+4vqqCeVw4N5ixClepaa0u
         E7Bqd+vDf8YASWQDZqjwiT1CPRtrM4IBZ0XifO9EhkFEg0ZQy38PG1sVHxToNQ9O+K5a
         J6yvdvzO9H/OCgqKKlbV8YkvhiBS2UTWtEeS2QN61rKJKSB0ruZo33ovqj01KEegN9jP
         IHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQkKL/OB7ALpeFx7XOfbe4/eCQx3rmR+Ln/joz2blFc=;
        b=KaJvZxoR4vMqNQxE/SpDKYj5YFiA3HPuAS+Gj4kUUg8V+ayos4pZwolGkcO2hTTYCl
         ryl2XkDB/BJZkYfxbJmGjsA6wzyK5K7ig4ExTw9Q8FBT7oxuVs/aq1v30LtvmNyxeJG8
         EzbriC335eppWCPdWowLVekWA4/K/+Qs6Oc8nKF7hjpeoMBpKECdibkVr4MktjvbVTOs
         YdxAXnUZylifFTJn2+7QlSREec8vkEZdF/7Hn7E5Y3jXsfBm3THJysDhqe64qySsyMh4
         08PStkX/P1WkX9GI5T7RKFFIlxl6478AEaDX3E2aRuc4xKmopNbziAT0iLZwu3QxKqX4
         UR+g==
X-Gm-Message-State: AOAM531Wo67Wh/4slFTFV+TRS/1U0ORDkMyPC4oOP6/xIyy3+tOGVs8r
        pcUrcJJ+OlkBnx3GcwreNKmQ5g==
X-Google-Smtp-Source: ABdhPJwFBE10PUxqwR8yVwSpUUBGs29zSQHaNITWJCbDULDzQIHd9CfsLwjXQQp/+QIIhJxdz/+n4Q==
X-Received: by 2002:a6b:8b0e:: with SMTP id n14mr10951457iod.199.1615000560938;
        Fri, 05 Mar 2021 19:16:00 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i67sm2278693ioa.3.2021.03.05.19.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 19:16:00 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v2 6/6] net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum header
Date:   Fri,  5 Mar 2021 21:15:50 -0600
Message-Id: <20210306031550.26530-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210306031550.26530-1-elder@linaro.org>
References: <20210306031550.26530-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of C bit-fields in the rmnet_map_ul_csum_header
structure with a single two-byte (big endian) structure member,
and use field masks to encode or get values within it.

Previously rmnet_map_ipv4_ul_csum_header() would update values in
the host byte-order fields, and then forcibly fix their byte order
using a combination of byte order operations and types.

Instead, just compute the value that needs to go into the new
structure member and save it with a simple byte-order conversion.

Make similar simplifications in rmnet_map_ipv6_ul_csum_header().

Finally, in rmnet_map_checksum_uplink_packet() a set of assignments
zeroes every field in the upload checksum header.  Replace that with
a single memset() operation.

Signed-off-by: Alex Elder <elder@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---
v2: Fixed to use u16_encode_bits() instead of be16_encode_bits().

 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 34 ++++++-------------
 include/linux/if_rmnet.h                      | 21 ++++++------
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 29d485b868a65..b76ad48da7325 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -198,23 +198,19 @@ rmnet_map_ipv4_ul_csum_header(void *iphdr,
 			      struct rmnet_map_ul_csum_header *ul_header,
 			      struct sk_buff *skb)
 {
-	__be16 *hdr = (__be16 *)ul_header;
 	struct iphdr *ip4h = iphdr;
 	u16 offset;
+	u16 val;
 
 	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
 	ul_header->csum_start_offset = htons(offset);
 
-	ul_header->csum_insert_offset = skb->csum_offset;
-	ul_header->csum_enabled = 1;
+	val = u16_encode_bits(1, MAP_CSUM_UL_ENABLED_FMASK);
 	if (ip4h->protocol == IPPROTO_UDP)
-		ul_header->udp_ind = 1;
-	else
-		ul_header->udp_ind = 0;
+		val |= u16_encode_bits(1, MAP_CSUM_UL_UDP_FMASK);
+	val |= u16_encode_bits(skb->csum_offset, MAP_CSUM_UL_OFFSET_FMASK);
 
-	/* Changing remaining fields to network order */
-	hdr++;
-	*hdr = htons((__force u16)*hdr);
+	ul_header->csum_info = htons(val);
 
 	skb->ip_summed = CHECKSUM_NONE;
 
@@ -241,24 +237,19 @@ rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
 			      struct rmnet_map_ul_csum_header *ul_header,
 			      struct sk_buff *skb)
 {
-	__be16 *hdr = (__be16 *)ul_header;
 	struct ipv6hdr *ip6h = ip6hdr;
 	u16 offset;
+	u16 val;
 
 	offset = skb_transport_header(skb) - (unsigned char *)ip6hdr;
 	ul_header->csum_start_offset = htons(offset);
 
-	ul_header->csum_insert_offset = skb->csum_offset;
-	ul_header->csum_enabled = 1;
-
+	val = u16_encode_bits(1, MAP_CSUM_UL_ENABLED_FMASK);
 	if (ip6h->nexthdr == IPPROTO_UDP)
-		ul_header->udp_ind = 1;
-	else
-		ul_header->udp_ind = 0;
+		val |= u16_encode_bits(1, MAP_CSUM_UL_UDP_FMASK);
+	val |= u16_encode_bits(skb->csum_offset, MAP_CSUM_UL_OFFSET_FMASK);
 
-	/* Changing remaining fields to network order */
-	hdr++;
-	*hdr = htons((__force u16)*hdr);
+	ul_header->csum_info = htons(val);
 
 	skb->ip_summed = CHECKSUM_NONE;
 
@@ -425,10 +416,7 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
 	}
 
 sw_csum:
-	ul_header->csum_start_offset = 0;
-	ul_header->csum_insert_offset = 0;
-	ul_header->csum_enabled = 0;
-	ul_header->udp_ind = 0;
+	memset(ul_header, 0, sizeof(*ul_header));
 
 	priv->stats.csum_sw++;
 }
diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 1fbb7531238b6..9ff09a2bcf9e1 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -33,17 +33,16 @@ struct rmnet_map_dl_csum_trailer {
 
 struct rmnet_map_ul_csum_header {
 	__be16 csum_start_offset;
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	u16 csum_insert_offset:14;
-	u16 udp_ind:1;
-	u16 csum_enabled:1;
-#elif defined (__BIG_ENDIAN_BITFIELD)
-	u16 csum_enabled:1;
-	u16 udp_ind:1;
-	u16 csum_insert_offset:14;
-#else
-#error	"Please fix <asm/byteorder.h>"
-#endif
+	__be16 csum_info;		/* MAP_CSUM_UL_*_FMASK */
 } __aligned(1);
 
+/* csum_info field:
+ *  OFFSET:	where (offset in bytes) to insert computed checksum
+ *  UDP:	1 = UDP checksum (zero checkum means no checksum)
+ *  ENABLED:	1 = checksum computation requested
+ */
+#define MAP_CSUM_UL_OFFSET_FMASK	GENMASK(13, 0)
+#define MAP_CSUM_UL_UDP_FMASK		GENMASK(14, 14)
+#define MAP_CSUM_UL_ENABLED_FMASK	GENMASK(15, 15)
+
 #endif /* !(_LINUX_IF_RMNET_H_) */
-- 
2.27.0


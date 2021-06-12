Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40F3A4F55
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhFLOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:41:09 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38626 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhFLOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:41:00 -0400
Received: by mail-io1-f45.google.com with SMTP id b25so34687280iot.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVpsNjSma8gM+rAIpOEpuls8lMMnYBT1zZkyUPGfEFw=;
        b=hOPtH3zpGyr1MV5KOt5zRKenpTYTd117KUeSynzayvtWHqD8DFx5VRUBZQy6mMwS6f
         eyOqfO9BuxOWigyV+lcbyc0fxYiE5vwb+Ds561lZQKBO/UpaSqc9+bMZOBrMfyCNp+N4
         2yj9JKIsWP0btROkRPBboi26dkUSiDDeefvL1lKC7j9yO8AMIx+UwbH5/8/MVena7UdQ
         wUkzOR0cexOHVyeD4QRo/++Mc8E4VW41YpIEn5zjTA8f5cBpORVDDusFzTJbNsJNFQ7g
         S51+d8yf/WarPTfI7GofmR0jAtYUxhgBNbucwYJidKmPFhL8lrrT/cTHLWMRr90fALUY
         OtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVpsNjSma8gM+rAIpOEpuls8lMMnYBT1zZkyUPGfEFw=;
        b=Hz4zBeoGilN8mA3RnAQQNbGfvmFFkD6dsJuLfaRjrN3Eh0Gan6uG7arQeFC5vkZc0L
         A5qBJdjVxdhiTF/zGO4vrJ+fIk8+KAqIXmRRQR8uwe/15mfyLphxkK0Id9BNK5jYuWPX
         WYp4151WvnFpZHTJLYTKnzHHgPvH33bhsNbv25uP32BM1e3hcOAOn63s54GvSj/2BSmW
         wwkJ3wuI8Tg22pdOVO1wjggSg3jFLm8yK/hQMMJg6BVdZeChLvdEFoREccRDQ0C3JggD
         OddbO0226267d6y8/dtnM9s2S01FAmD/hCePZbclRPlL9rW+s5uBvNt0OJDyj+jxu9Wb
         B90Q==
X-Gm-Message-State: AOAM5304ovtrsKrs8atHUYW5da9MPbBpB7r7QyEVKEfS+Ct65rP38eJU
        0Cml0FsCYZAiAJIRMEJTOvXQ6A==
X-Google-Smtp-Source: ABdhPJzClMEThmFRq31OhIVO5ERWyfTasoDwNWUWfEo6BifoMZl3AfQRHsB4Ceenem7zJlu3cmSZbA==
X-Received: by 2002:a05:6602:2143:: with SMTP id y3mr7447828ioy.89.1623508664920;
        Sat, 12 Jun 2021 07:37:44 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k4sm5126559ior.55.2021.06.12.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:37:44 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/8] net: qualcomm: rmnet: trailer value is a checksum
Date:   Sat, 12 Jun 2021 09:37:34 -0500
Message-Id: <20210612143736.3498712-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210612143736.3498712-1-elder@linaro.org>
References: <20210612143736.3498712-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csum_value field in the rmnet_map_dl_csum_trailer structure is a
"real" Internet checksum.  It is a 16 bit value, in big endian format,
which represents an inverted ones' complement sum over pairs of bytes.

Make that clear by changing its type to __sum16.

This makes a typecast in rmnet_map_ipv4_dl_csum_trailer() and
another in rmnet_map_ipv6_dl_csum_trailer() unnecessary.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 5 ++---
 include/linux/if_rmnet.h                             | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 033b8ad3d7356..610c8b5a8f46a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -87,7 +87,7 @@ rmnet_map_ipv4_dl_csum_trailer(struct sk_buff *skb,
 	 * header checksum value; it is already accounted for in the
 	 * checksum value found in the trailer.
 	 */
-	ip_payload_csum = (__force __sum16)~csum_trailer->csum_value;
+	ip_payload_csum = ~csum_trailer->csum_value;
 
 	pseudo_csum = ~csum_tcpudp_magic(ip4h->saddr, ip4h->daddr,
 					 ntohs(ip4h->tot_len) - ip4h->ihl * 4,
@@ -132,8 +132,7 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 	 * checksum computed over the pseudo header.
 	 */
 	ip_header_csum = (__force __be16)ip_fast_csum(ip6h, sizeof(*ip6h) / 4);
-	ip6_payload_csum = ~csum16_sub((__force __sum16)csum_trailer->csum_value,
-				       ip_header_csum);
+	ip6_payload_csum = ~csum16_sub(csum_trailer->csum_value, ip_header_csum);
 
 	length = (ip6h->nexthdr == IPPROTO_UDP) ?
 		 ntohs(((struct udphdr *)txporthdr)->len) :
diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index be17610a981ef..10e7521ecb6cd 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -25,7 +25,7 @@ struct rmnet_map_dl_csum_trailer {
 	u8 flags;			/* MAP_CSUM_DL_VALID_FLAG */
 	__be16 csum_start_offset;
 	__be16 csum_length;
-	__be16 csum_value;
+	__sum16 csum_value;
 } __aligned(1);
 
 /* rmnet_map_dl_csum_trailer flags field:
-- 
2.27.0


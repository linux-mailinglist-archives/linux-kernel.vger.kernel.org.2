Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BC3A4F49
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFLOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhFLOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:39:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7CCC0613A4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:37:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q3so11469258iop.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdGocdnkWEhyGlWBEvMTXuqlG7P/EjC9lkmvGdkeF8Y=;
        b=Zm4N0uZcjB0fKwr+fcqoXcomkjX5uGAtQwpxvbw9ddhNqvUSCkXVPiDHenZ5/H4Bpg
         zIdROMvqaBPtm1ynaHGl9WiCt+K2P4bTQQueHqqhO50QnoN2hnZdtTK8sxdenRJT28hF
         BT+z3Lu913mpAh+x8OadVadY6Xihwh0ifuUvvujgm5dWHH/EDTWX4pTHq+mux0JzNTG2
         sP/0iZs0hZqwH+z0OK3Zg5CB/eKVoEYndhIoosDiRXI6+ZhgejITCkU37qrjjEjWNWpp
         zG+p2nHnmjiqvfDE4T0yMozGHXF5rOSVQBStxK6XdDWglwD4ZRmFI1lN+joRRpwvADMv
         1RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdGocdnkWEhyGlWBEvMTXuqlG7P/EjC9lkmvGdkeF8Y=;
        b=RwrCqwjuTpkb4XbvQdGszajvaRsuCTwavAVqSBSltsWQlrH/ZxYRB3pGbnF1IijUOh
         xyzykilt7WQ0hDaUct6M84nI0DB89cBAJgauJuecQEFZp5LDwT0OuIYJVw9l/lPQEFkw
         zWyJmd4Su4naQwI9HEifiQKxGJxJRFE1ZIX9EHumW1RIdJtJGxEwX+lGbtKmsLD8H4GG
         cKrIz/1DaFYnP88QaKWS/sBLipUsWP1xTH7N8jzSiI1h+h9dJJwwPcWpvPRoMlY8j4j7
         pS3e3X8hBT09xnaJCTGZqIvJSQBk60sXpNzCxTe2cd2Px/H0Tyd4czT4jpPY5ZfMZKmT
         KpuQ==
X-Gm-Message-State: AOAM530uLs+D/e4Kyg7156uMa+3LGGdrmngMJb5uuWsD9Z+BhKJ5wn7/
        0kkLMdJoaG6cQlYA1wt0bpug7g==
X-Google-Smtp-Source: ABdhPJwzos8hat4ZiV35fsZZn+J2uRBUMFuxvxkarIyMQfrAnpR2FDodp9Kfn1CqDNwjgXypQEPFVg==
X-Received: by 2002:a6b:b7d6:: with SMTP id h205mr7554507iof.188.1623508665772;
        Sat, 12 Jun 2021 07:37:45 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k4sm5126559ior.55.2021.06.12.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:37:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/8] net: qualcomm: rmnet: drop some unary NOTs
Date:   Sat, 12 Jun 2021 09:37:35 -0500
Message-Id: <20210612143736.3498712-8-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210612143736.3498712-1-elder@linaro.org>
References: <20210612143736.3498712-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We compare a payload checksum with a pseudo checksum value for
equality in rmnet_map_ipv4_dl_csum_trailer().  Both of those values
are computed with a unary NOT (~) operation.  The result of the
comparison is the same if we omit that NOT for both values.

Remove these operations in rmnet_map_ipv6_dl_csum_trailer() also.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 610c8b5a8f46a..ed4737d0043d6 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -87,11 +87,11 @@ rmnet_map_ipv4_dl_csum_trailer(struct sk_buff *skb,
 	 * header checksum value; it is already accounted for in the
 	 * checksum value found in the trailer.
 	 */
-	ip_payload_csum = ~csum_trailer->csum_value;
+	ip_payload_csum = csum_trailer->csum_value;
 
-	pseudo_csum = ~csum_tcpudp_magic(ip4h->saddr, ip4h->daddr,
-					 ntohs(ip4h->tot_len) - ip4h->ihl * 4,
-					 ip4h->protocol, 0);
+	pseudo_csum = csum_tcpudp_magic(ip4h->saddr, ip4h->daddr,
+					ntohs(ip4h->tot_len) - ip4h->ihl * 4,
+					ip4h->protocol, 0);
 
 	/* The cast is required to ensure only the low 16 bits are examined */
 	if (ip_payload_csum != (__sum16)~pseudo_csum) {
@@ -132,13 +132,13 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 	 * checksum computed over the pseudo header.
 	 */
 	ip_header_csum = (__force __be16)ip_fast_csum(ip6h, sizeof(*ip6h) / 4);
-	ip6_payload_csum = ~csum16_sub(csum_trailer->csum_value, ip_header_csum);
+	ip6_payload_csum = csum16_sub(csum_trailer->csum_value, ip_header_csum);
 
 	length = (ip6h->nexthdr == IPPROTO_UDP) ?
 		 ntohs(((struct udphdr *)txporthdr)->len) :
 		 ntohs(ip6h->payload_len);
-	pseudo_csum = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
-				       length, ip6h->nexthdr, 0);
+	pseudo_csum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+				      length, ip6h->nexthdr, 0);
 
 	/* It's sufficient to compare the IP payload checksum with the
 	 * negated pseudo checksum to determine whether the packet
-- 
2.27.0


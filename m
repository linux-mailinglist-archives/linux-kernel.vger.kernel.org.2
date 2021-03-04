Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA132DD24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhCDWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhCDWeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:34:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F9C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 14:34:37 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id a7so31551527iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDRd/k3SE2dFfwLHBJ3IM2QixWpwECC8r/K+T//z74M=;
        b=tWAVR0yakCZ7JbblHhvdUrAUdw/HKQQ+0MJzkilNGz6FKRZXu65N0zJK7UF2UGzRQi
         rcixBryYc2QViduTnMU8eveNB96pOEul3Fe3MrYHMd3mp2H6P95Rqk7b8jHTRB2UWzxz
         +/SQM82ClIpQgqi9tQNIESuGP87s7V8k5YautEZOBCMamrRs96VVVX9awMGjYxpaEcRf
         fXeKkKuBdQsimbfnDf3O5OOJ425DT+W59GAdJeZ1jifWwQ1RVUuMsBtZp2WggZ/8z3wj
         pnbU6oeJyQGaR3AtKqddwZsv4MT7nyCbRYEi2/XGAw7ixJd867oOWli7kzvAYC+aklZh
         750A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDRd/k3SE2dFfwLHBJ3IM2QixWpwECC8r/K+T//z74M=;
        b=onSmzhjCxdgQLSUwiJCpBT6CjWbNVnVeLAHtU3qhi3UeJ6q7+srXrWqlDfctvKkNHe
         oAFStg7DsLCDI/u664SaIDAhsv8dXaNFru6gnKvG0vAlI5Mz2Ie0VZhI3HE3+erd0pFA
         ZPkIzM5LJvq/OQccakvRcJCYWl0VpTrO4nl/s2KgIYFTZe+/y8ydvyNlc9IjQ/IbLQ9R
         60MyrPsQVaT4sMA9Qt2pPD0vQlJGKyhEN9bKGzFDVYr4CKw7pB2Ptgd7ZokQ/I+nj/4S
         tUQUcAMSFgl/IfEaIRfolX+aFHfkJIRpcBHNVRHRkR6F0pskBBKTA7iY6/2MD6KS+cuu
         eLIg==
X-Gm-Message-State: AOAM531nHwDc7xlWgCQkYP+9UDPMeyan3ynLBdhIhw9S5XLK6P2nDIio
        QtSo96nq+VXhU3UD7ozPBlkrnw==
X-Google-Smtp-Source: ABdhPJzut91zOjLiXLXYscqglNiYbdwfO2+JCmzKwSIjNlkV5uZSdVWatK4i7w1EtS7S1EmfAfyREQ==
X-Received: by 2002:a05:6602:2102:: with SMTP id x2mr5722603iox.83.1614897276818;
        Thu, 04 Mar 2021 14:34:36 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s18sm399790ilt.9.2021.03.04.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:34:36 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: qualcomm: rmnet: simplify some byte order logic
Date:   Thu,  4 Mar 2021 16:34:27 -0600
Message-Id: <20210304223431.15045-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304223431.15045-1-elder@linaro.org>
References: <20210304223431.15045-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rmnet_map_ipv4_ul_csum_header() and rmnet_map_ipv6_ul_csum_header()
the offset within a packet at which checksumming should commence is
calculated.  This calculation involves byte swapping and a forced type
conversion that makes it hard to understand.

Simplify this by computing the offset in host byte order, then
converting the result when assigning it into the header field.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 21d38167f9618..bd1aa11c9ce59 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -197,12 +197,13 @@ rmnet_map_ipv4_ul_csum_header(void *iphdr,
 			      struct rmnet_map_ul_csum_header *ul_header,
 			      struct sk_buff *skb)
 {
-	struct iphdr *ip4h = (struct iphdr *)iphdr;
-	__be16 *hdr = (__be16 *)ul_header, offset;
+	__be16 *hdr = (__be16 *)ul_header;
+	struct iphdr *ip4h = iphdr;
+	u16 offset;
+
+	offset = skb_transport_header(skb) - (unsigned char *)iphdr;
+	ul_header->csum_start_offset = htons(offset);
 
-	offset = htons((__force u16)(skb_transport_header(skb) -
-				     (unsigned char *)iphdr));
-	ul_header->csum_start_offset = offset;
 	ul_header->csum_insert_offset = skb->csum_offset;
 	ul_header->csum_enabled = 1;
 	if (ip4h->protocol == IPPROTO_UDP)
@@ -239,12 +240,13 @@ rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
 			      struct rmnet_map_ul_csum_header *ul_header,
 			      struct sk_buff *skb)
 {
-	struct ipv6hdr *ip6h = (struct ipv6hdr *)ip6hdr;
-	__be16 *hdr = (__be16 *)ul_header, offset;
+	__be16 *hdr = (__be16 *)ul_header;
+	struct ipv6hdr *ip6h = ip6hdr;
+	u16 offset;
+
+	offset = skb_transport_header(skb) - (unsigned char *)ip6hdr;
+	ul_header->csum_start_offset = htons(offset);
 
-	offset = htons((__force u16)(skb_transport_header(skb) -
-				     (unsigned char *)ip6hdr));
-	ul_header->csum_start_offset = offset;
 	ul_header->csum_insert_offset = skb->csum_offset;
 	ul_header->csum_enabled = 1;
 
-- 
2.20.1


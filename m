Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB99F3325B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCIMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCIMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:48:54 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:48:54 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id f10so12035823ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYtxP12FPoFyXStxU+dIm5i6FSzaCM643MO9iKA6Wx4=;
        b=Zq87I4II0E01k+QPxUIYPCaiDnxXPJaS2UlN4RnGSqSK26aJ66HiWv+g8NtnZWYcVm
         tE7gneLkRAAJou61yaRGLIB9zbWw3yS8Fa/EeheX3VexPuxW8nYijGC9V+r+cKQvdj6g
         9dH5Wqu5L/RA6zSmoPS1rk6WngRb+uSsw+Ttdfe0a2P00Kjv3zNO+PffFdjtkFuCsuvq
         SA2fGqHtJYQIa9fEt96I5RwtHx9gpgYKDDgnhl/vcJZDRL6DVkJZknB3viWMYlkJtuJC
         0C76ENVaOUI0+6ROGoAd6eRmxcNBzW9km+a24MBwYqVpBvLjrqtoqZN2SMmdcURs8gdx
         z2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYtxP12FPoFyXStxU+dIm5i6FSzaCM643MO9iKA6Wx4=;
        b=UvpLPlYGw7h8ub6mdUCnL6h+Zgb5qKERefg5VJR+S8Nus4Q2qk99PBAL7jOg10jvdd
         +Yb+gL8XSlihOCteCscFBM1I4MJz3Vwqck+w0kGrOWBh4HpGkU9FA07DQ1iwsBNhKnrr
         mkEQPNa2pPxI9gbQgPeChgcS1iVxhIU2bSsD8NcqO6yvAdVdR8MwdBgW4s0pyZKDA3/V
         uXgeqcQR1wzUmwIA6mgOEXmgnQqR2xbEjMReoqF9CR4GSNp1mXc9+VcI0ZBnkfDAesyZ
         YG+Ebzjtnx9PWDC9ldVt8GdIh5gXq6EdFXBw4zATJH8C0EQPQ/SraRSQzDTgwzuneWdy
         MCVw==
X-Gm-Message-State: AOAM530Dx0OhOS2F2CdW23V9UFVi8EgVxohwExx2LZkNpve0WVn6+oPb
        7NEVNE6E1CH8x/KpGgjNE/WuFg==
X-Google-Smtp-Source: ABdhPJzDWj+fKmtGASPwGZpJqReoAsQIHTCNptyZ8mZVUSpGf9byWVv24TOnSAQQfUGbWqX/erbieA==
X-Received: by 2002:a92:c26f:: with SMTP id h15mr23293678ild.65.1615294133638;
        Tue, 09 Mar 2021 04:48:53 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o23sm7810009ioo.24.2021.03.09.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:48:53 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        David.Laight@ACULAB.COM, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/6] net: qualcomm: rmnet: simplify some byte order logic
Date:   Tue,  9 Mar 2021 06:48:44 -0600
Message-Id: <20210309124848.238327-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309124848.238327-1-elder@linaro.org>
References: <20210309124848.238327-1-elder@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
2.27.0


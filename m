Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650273A4F53
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhFLOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:41:06 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37405 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhFLOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:40:58 -0400
Received: by mail-io1-f41.google.com with SMTP id q7so34759523iob.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zm655iiQBvNsM1zGTE3Z5YIWcNDBpgG+PR5dwnxy8PY=;
        b=znbHIRfQQsxi7yyp1vZex0OL8FYa7DTX2/4Ukwx5Qk4nUcoP0/3iEfVYw4koyVI23I
         1/aLvM4kisHWHNzGsUkn3GIuKV9rEOQd1F+YP8+jQjZnu69WDmR+m9YWh61NalMWA3sn
         Huk9FCnB8BHM2dhR3IuUDsBP14YuGCGYb9Yf6LNbDAiUEFIPvHAJPNtmeK2nFGA+IH04
         yE2GpEVX8V/me/ZLURyguAZYOgvnwQyAcQJ1SfDFlpsc2n2Ce2WPSD30ZDcNlRLtmjEZ
         dfaJaujqMlV1PrmUnQrzh+F2aKt1/fEgbJBYAN+Jp3mBNGBsOnkxoF74IFIkiCwngV3B
         L2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zm655iiQBvNsM1zGTE3Z5YIWcNDBpgG+PR5dwnxy8PY=;
        b=GCzcaNYWhIm5as91dZpsIMmYs9cV3zZ658bSrUd1WqPSV2ah5TLIonMvf+rGONhXlG
         w4XXof6pGaX2x2Emvd34sCSOX9RKXKmlqnHl8ut/8eNTeO1u4O4kh8SWDCh97xF/th/f
         zJ2tx/mLYqR+cIbgOAHLZeVP4dggOfZGHMZRm4c7D4uWeJ/Fhzpq8/Dc0l4/y2UxWUpf
         hp8h6YPsUBpKvBQX3zPt3fRxBRVOpnVuqYKbIaX/kvgElTqxVcIOgwzLKkTY2ZS4owqN
         ZsixxP99TnxJtH2lLkNLlzcDtmog8EEIDEhijRMdBScsRXmA00FjXKLcO5wJpyV/+XdY
         iugQ==
X-Gm-Message-State: AOAM532Rcn/8DpxuUx5QUs43IUE/fmJU26+C4w0Yi9fs6tslmzVJ2aoP
        y6+afW7XSAe1DNufsPPDJWKKZA==
X-Google-Smtp-Source: ABdhPJwLMvXqqkYmksjDRRGQuJHfz+h2zudIKmnedTpsfXCIwTy/hfXfukAjVFFURNz+GyXt5AsZ8A==
X-Received: by 2002:a05:6602:114:: with SMTP id s20mr7562158iot.98.1623508662310;
        Sat, 12 Jun 2021 07:37:42 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k4sm5126559ior.55.2021.06.12.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:37:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/8] net: qualcomm: rmnet: show that an intermediate sum is zero
Date:   Sat, 12 Jun 2021 09:37:31 -0500
Message-Id: <20210612143736.3498712-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210612143736.3498712-1-elder@linaro.org>
References: <20210612143736.3498712-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply demonstrates that a checksum value computed when
verifying an offloaded transport checksum value for both IPv4 and
IPv6 is (normally) 0.  It can be squashed into the next patch.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 1b170e9189d8a..51909b8fa8a80 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -84,6 +84,11 @@ rmnet_map_ipv4_dl_csum_trailer(struct sk_buff *skb,
 					 ip4h->protocol, 0);
 	pseudo_csum = csum16_add(ip_payload_csum, (__force __be16)pseudo_csum);
 
+	/* The trailer checksum *includes* the checksum in the transport
+	 * header.  Adding that to the pseudo checksum will yield 0xffff
+	 * ("negative 0") if the message arrived intact.
+	 */
+	WARN_ON((__sum16)~pseudo_csum);
 	csum_value_final = ~csum16_sub(pseudo_csum, (__force __be16)*csum_field);
 
 	if (unlikely(!csum_value_final)) {
@@ -150,6 +155,10 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 				       length, ip6h->nexthdr, 0);
 	pseudo_csum = csum16_add(ip6_payload_csum, (__force __be16)pseudo_csum);
 
+	/* Adding the payload checksum to the pseudo checksum yields 0xffff
+	 * ("negative 0") if the message arrived intact.
+	 */
+	WARN_ON((__sum16)~pseudo_csum);
 	csum_value_final = ~csum16_sub(pseudo_csum, (__force __be16)*csum_field);
 
 	if (unlikely(csum_value_final == 0)) {
-- 
2.27.0


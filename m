Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F573A4F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFLOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhFLOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:39:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A10C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:37:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so8153625ilk.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MPm/CDH/wz97xhLG1zwJ5+gY1yCELg1LNPAC/aA5x8=;
        b=pCoXZqOCkaUfU2CKczK/N5M4NvRp5vOr3O96/Aj4IvXXFyqcuvkvtGtSbs9Z15v7Bq
         7woSGdi9JzMR4m6QYiBQ5fi15KABSdUHyXBU/IiKAt7KWXeMW5Xno69yLZYBPgUWHoc9
         NI4TpJwAY/mHm7AO/AYqeBNfeMmd19JvccI+9VpmQFCXxzoFi+7wj8ZHn3nAeml5fNge
         xfkZUDwC3/IoRDOCpVnh4uLfJC0vX1IMsAwbU0xRhfKc2hsLyyDSD7E79CGD1Ls7tjlV
         z8cZUoOpbwISZ6aQgaVbg8pZxXzPXVUozj/IaRubNMm6RqWUH62fnyv8UdZ0iMYsBRFf
         y6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MPm/CDH/wz97xhLG1zwJ5+gY1yCELg1LNPAC/aA5x8=;
        b=b+FIDX/Bp7xF6wxDYWvlUgFDBkPLGgz+PCRytUXkCB3b3jQc+StPRMsw0wDIb838TC
         s7y/rSzYGZQNKwOLiI1ZKw3dRki6MvNfmFTyaI2gpo9fx6BsXcFwfxwHFyQTDNRcvU35
         dizl9ZGDh1VVGfmQqGxt1ZyPaU/c6Z50DKCSXdNIU3ytcwCLQ8YOzr5hvUiQxb+Ss8vI
         yk8UB15Frt7bRozLW3BuebMYG4GibMIP33KCxm02QES+z5oGXKQgkQILQChkEIt3dID0
         tfQVemTpKljcGeEmzZ9fAbNe4MCW+qx5odkt38qJ9HphHILkRGERHp7xxURSUra5/yuK
         Xhjg==
X-Gm-Message-State: AOAM533VjlHPTnlNKm4LtUkIUVbdGd6bOXjDihgdzv2tMw+im5liC+2B
        KmlWUpk+yn1O/FY75wJcz7vW5YRfnRthkopD
X-Google-Smtp-Source: ABdhPJzqFze+MKxM0K17QTjwUEXfh1pziZWK1axL4Wv/ez7/5jFwo8+SybtNpKAQU+86FySACkc3Uw==
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr7248404ila.64.1623508661372;
        Sat, 12 Jun 2021 07:37:41 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k4sm5126559ior.55.2021.06.12.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:37:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/8] net: qualcomm: rmnet: rearrange some NOTs
Date:   Sat, 12 Jun 2021 09:37:30 -0500
Message-Id: <20210612143736.3498712-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210612143736.3498712-1-elder@linaro.org>
References: <20210612143736.3498712-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ones' complement arithmetic, the sum of two negated values
is equal to the negation of the sum of the two original values [1].
Rearrange the calculation ip6_payload_sum using this property.

[1] https://tools.ietf.org/html/rfc1071

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 3e6feef0fd252..1b170e9189d8a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -140,8 +140,8 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 	 * checksum computed over the pseudo header.
 	 */
 	ip_header_csum = (__force __be16)ip_fast_csum(ip6h, sizeof(*ip6h) / 4);
-	ip6_payload_csum = csum16_sub((__force __sum16)~csum_trailer->csum_value,
-				      ~ip_header_csum);
+	ip6_payload_csum = ~csum16_sub((__force __sum16)csum_trailer->csum_value,
+				       ip_header_csum);
 
 	length = (ip6h->nexthdr == IPPROTO_UDP) ?
 		 ntohs(((struct udphdr *)txporthdr)->len) :
-- 
2.27.0


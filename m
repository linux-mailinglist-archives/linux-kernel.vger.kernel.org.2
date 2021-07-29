Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6C3DA15F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhG2Kld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:41:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47724
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236034AbhG2Kkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:40 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 8E9373F10E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555236;
        bh=Cw3WxWMdLZ5M5UUT98hz5uB4oSAZN8UMdeHX+1yibmU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=f6P0ep9s8myPt1q5zKD6HSvg/Hmk+cNMuYa127/LjWDmke/nuikcV04a4q0Bx4OLo
         uDLZyWBXcV8ws4E1yWbUdg60dlBeiQxHF5nbqIU6svJLr5gGjz3u6KhX3FHtI2ygpK
         NPIpi92IVCduPvKZG6ZWDDtH/UbfOwlH3qI5YKJD6ZJubDtZwPnRB83wXfBLON2bWQ
         KGJrfH9IPiG3dJejbHRE02M5LD3nYtZFQwxaFSaCP3InK7Tb6uzW0YG4tiTBa7oCjI
         LXY54VSB1hiZwz1BPOb0F6Cm90N97xRpKX6vlElrc3ClPxBMhs+OAOQi1cdApeSOu1
         4vBZsVzHDpp9w==
Received: by mail-ej1-f72.google.com with SMTP id r21-20020a1709067055b02904be5f536463so1858112ejj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw3WxWMdLZ5M5UUT98hz5uB4oSAZN8UMdeHX+1yibmU=;
        b=jqG8oKQe0CKJk+4D8MnHno24qIu9tnbmLp3Q2TUpsv4FG2p14MpMQDzmCy/vggYyRK
         B1qCSecWHr238fBjvYimao/KVr4d/wox3rjIueupIb1o663XgDJRbBZ0qJdvDTAv33eg
         C/ra5ky6wScacvIqWuLnHFZl6Rr3jYLgcDfAKLFjhf3woQ0l4JTnwFFI5LRM3sDbtmxJ
         c9T48tR0hnFHnnZJMFJ07LAEcdSl8IAofKAyo5jYo1hmZXB9ka5wZKMZXcQUS8Dq0tqz
         xhLi673g9JZy0WyDLdVZXxniEmw/TZI5aWb3dXN+9z1JYkDgXF2ZaXWgUsOovAeTPIq3
         zBwg==
X-Gm-Message-State: AOAM530r0OCItRakrCDvvPhadtFZfTUnuMnaE+pwDBe+32DIdCixy/lp
        unrZrtmEZu14RV16qDZ85KPBTNBzBGYgERiq5ln9qGVxeA1CB5+Dtzav0/4WXgE1i7sCZimOH2D
        jt9MWTq0oGGxVt2Nnqe/JZgUcdyIN104X+WZwQzqE4g==
X-Received: by 2002:a17:907:1190:: with SMTP id uz16mr3961126ejb.543.1627555236307;
        Thu, 29 Jul 2021 03:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyelGCc7LxjALvK3umx0eo+PexaLLnBk1cGkBUbydBmcQuE3sbk2nmw8yhHldZtMsl1cgWHbw==
X-Received: by 2002:a17:907:1190:: with SMTP id uz16mr3961115ejb.543.1627555236127;
        Thu, 29 Jul 2021 03:40:36 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 02/12] nfc: mei_phy: constify buffer passed to mei_nfc_send()
Date:   Thu, 29 Jul 2021 12:40:12 +0200
Message-Id: <20210729104022.47761-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer passed to mei_nfc_send() can be const for correctness and
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/mei_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 41146bb99474..f9cca885beec 100644
--- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -202,7 +202,7 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)
 	return r;
 }
 
-static int mei_nfc_send(struct nfc_mei_phy *phy, u8 *buf, size_t length)
+static int mei_nfc_send(struct nfc_mei_phy *phy, const u8 *buf, size_t length)
 {
 	struct mei_nfc_hdr *hdr;
 	u8 *mei_buf;
-- 
2.27.0


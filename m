Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97071402894
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbhIGMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:21:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33708
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344193AbhIGMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:20:02 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C3F83F329
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017122;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p6LZZbIg1to2ts6cu67R1es7EOim/qXVlfC3JEgC9jC/L0AOPbYkBh+kuyMyb8len
         QX1MlKBXoV+Ni1S/Cop6LeAWlBxpR5VoQYW725udLhFlwMOmtqJTycYMviWzc9P+Uh
         OS3T0l7KtKWqBnxWLd0HM+AySHEfWea+l0KuQOoOtqMx7/sPZp1uWSE6psgFKKg007
         Z1RIRuWKA5bd2yC52t/0nr6fAafxGAoL0vLgUbJaac4+xFFVWMeHLp8007WYac0rnl
         Vqf0C5NjmmMPoUOaOG6R5tKSQXY6qE0DgeHxPcyMRJYmh1bdKJ8ZB7zASG6lNf3Z5L
         h8OvieK8K4Dmw==
Received: by mail-wr1-f72.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso2034967wrs.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        b=nCezvaE994t0qLZRBctegEwHOQE+AI92i+Q9D64FJj4F1UYsj96u4NkqY39cxautr3
         l/Jeo8/CGnwbu/hWftuwqd1b3own2znbpxoks/rSqx8RSgFXeor9EZs1EMoLYBHBbhT7
         TaSml+Bqm917e2n94ybUCX+GghxNHmlzuIuYbmyVTGXOXs9dE5uDxVZnlIRV9IIszHDK
         4m21/Ef0hw4+WH0kZbwsrYe8BLgF70HnlkSmQBQ8c1SEc6HwG8br+TnAPW9DnWpCL80R
         eOnE01ch9zttAzuAOn6saVwZ4OIEPBhcSm6oGLmPrUzenU47YMTEJSGuA2iRvMxJsBaL
         mBlA==
X-Gm-Message-State: AOAM530I49KbmPSivnb+9uItL4W4qG4WSa6+FIoWR0TtwvQCih2EMnYC
        re4pXw8oE2wdCmBw9s6hGKiDn3paubQGLtBpsSxyBspb19URHuBXKcrepuS0z5w7hM0PIpzL9Ln
        nxBcckbZwFQUBRWKhxmXifHb/adaM5dhlt0+v6Xs61A==
X-Received: by 2002:a05:600c:1d27:: with SMTP id l39mr3629437wms.146.1631017120414;
        Tue, 07 Sep 2021 05:18:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzkQReT6hqXvnsRi4xVMvPv5mwLHDY/KqHilLqyCDbOJpRRpQ8tjRRU7brxn8w70vPDRKkmA==
X-Received: by 2002:a05:600c:1d27:: with SMTP id l39mr3629425wms.146.1631017120289;
        Tue, 07 Sep 2021 05:18:40 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 15/15] nfc: mrvl: drop unneeded memory allocation fail messages
Date:   Tue,  7 Sep 2021 14:18:16 +0200
Message-Id: <20210907121816.37750-16-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nci_skb_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index edac56b01fd1..e83f65596a88 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -76,10 +76,8 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
 	struct nci_data_hdr *hdr;
 
 	skb = nci_skb_alloc(priv->ndev, (NCI_DATA_HDR_SIZE + plen), GFP_KERNEL);
-	if (!skb) {
-		pr_err("no memory for data\n");
+	if (!skb)
 		return NULL;
-	}
 
 	hdr = skb_put(skb, NCI_DATA_HDR_SIZE);
 	hdr->conn_id = NCI_CORE_LC_CONNID_PROP_FW_DL;
-- 
2.30.2


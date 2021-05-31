Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688E39565B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhEaHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:41:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60620 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhEaHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:41:00 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncW8-000387-MA
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:39:20 +0000
Received: by mail-wr1-f71.google.com with SMTP id m14-20020a5d4a0e0000b0290117148ba384so90419wrq.15
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqhoxm5CLlbJM/5GAddet7UbrdiBVjWGcbVsawnnnn4=;
        b=O8kc3BgxteANg5FJoSJ4ELVaOLSmDBg8gCBW1S8UQPrhfGEbtYDkgxOMkYkh4TJa8i
         DJL70jCXR61v8VfcCTp94GTS8LDlkvlWIdRVIggG7fFfn2TtlZZmjJAweCb5X1Vfs3Kz
         IDG5MlncJlAsxsIGH2baBNe7igFrAPXe4w+W22lGyGt3CSyGeMWUwdwDNnhNGRF201kc
         upI7AWtQP5NbC+XvbUlMt4NAdPMGiKPImVshSQM68JS4GuoIV1pDs2ndHPfFIPaStCE2
         Bfdl3sComBZ6fBoJK4bsHSbtHVVKaSGxbIzaHWtc+nrdw/nR3Co9rrsPC1Pdu0qhAtIT
         KMFQ==
X-Gm-Message-State: AOAM533Zr30sRhFo0e+Y7EQyUohVSPLscoHSytOPNj21U7lfqKYrZMMB
        9gqVpF+MJS50J79fjHsIiDtI4FgNtg1OFGwoDzPQOuB9Dil597Nmu/dg8fpvoxbNAMmLV4oqbXX
        APYZBgRA9WXz9mdJ3SBl1jE+dNJjelTx8GAmbd/OicQ==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr4723197wma.89.1622446760489;
        Mon, 31 May 2021 00:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3sisp3Wo09P8lmTnXy6HbSldTGXnsq3kSNvNn0N2+ZhFPrlfzfkHfeYDOg39Tl+QlYG3WJQ==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr4723180wma.89.1622446760345;
        Mon, 31 May 2021 00:39:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id a1sm9168911wrg.92.2021.05.31.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:39:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 07/11] nfc: pn533: drop unneeded braces {} in if
Date:   Mon, 31 May 2021 09:38:58 +0200
Message-Id: <20210531073902.7111-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
References: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

{} braces are not needed over single if-statement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index bb04fddb0504..e6bf8cfe3aa7 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -192,9 +192,8 @@ static int pn533_i2c_probe(struct i2c_client *client,
 				phy, &i2c_phy_ops, NULL,
 				&phy->i2c_dev->dev);
 
-	if (IS_ERR(priv)) {
+	if (IS_ERR(priv))
 		return PTR_ERR(priv);
-	}
 
 	phy->priv = priv;
 	r = pn532_i2c_nfc_alloc(priv, PN533_NO_TYPE_B_PROTOCOLS, &client->dev);
-- 
2.27.0


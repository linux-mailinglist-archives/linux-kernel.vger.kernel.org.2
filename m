Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC2361FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhDPMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:23:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbhDPMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:23:42 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXNVF-0006nL-6b
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 12:23:17 +0000
Received: by mail-ed1-f70.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso6903054edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzqFDF62IKS/7ZqV+8AeRm9rshpYPcGYLb2VCKEzlxc=;
        b=JGp/9dSlbNRw1wRiPwPPDtH8Gz6aBRg9/iF/LSbCttwv+HCIzlsGw1DSd4EFlrI/be
         iAIqnNTSrs5oA/520yilsv/87vGIC7oRqGUW4TPaN6og2hGHDAzVGrSmhkGSlY0moNUO
         yvUDNvm9KeqYX2Hpcy37CvGQipHzMR8AVTVLM7DlPKKWSbSZFMjeiKqQjMdBEqRuZWEy
         OKTH9SX8z/ZmKvG1U2yT0TDt96f0rRHWTV77rnI2Fb1U1fbW5DVJoJ9/81EdqCDZyLUt
         pMUkTdKYvffhpQaHFFQHQjLv3AQRco3kEdZY4v0AGaHEWwymR50oi09AcdBsPPhAz4Zo
         Wrvg==
X-Gm-Message-State: AOAM530i+fvPfK4nxvkAlIi4+68yBycA4MbzV63hOEXrIDSegkExRz7L
        tEJoIX+knxEizYSVG0KPrBi9Wkmvp9/cbW3+SAZcFDBh+Xbcct+/U3JS2yUFmxThujKM/V89k98
        Ad9BJ0E6UnLJ6z6vb8BxkT8ZKE+X8+TcM4ev65cX7ZA==
X-Received: by 2002:a17:906:a052:: with SMTP id bg18mr8164931ejb.18.1618575796877;
        Fri, 16 Apr 2021 05:23:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8rqxe4OShPzOPdaQiMJqPwX4MP+1hJHO+t8/0TCP0lXdUaa3BKe1KRRwEsifKkCWnlacHmg==
X-Received: by 2002:a17:906:a052:: with SMTP id bg18mr8164918ejb.18.1618575796702;
        Fri, 16 Apr 2021 05:23:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id i25sm2328924edr.68.2021.04.16.05.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:23:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] crypto: s5p-sss - consistently use local 'dev' variable in probe()
Date:   Fri, 16 Apr 2021 14:23:11 +0200
Message-Id: <20210416122311.223076-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416122311.223076-1-krzysztof.kozlowski@canonical.com>
References: <20210416122311.223076-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For code readability, the probe() function uses 'dev' variable instead
of '&pdev->dev', so update remaining places.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/crypto/s5p-sss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 8c310816deab..55aa3a71169b 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -2186,14 +2186,14 @@ static int s5p_aes_probe(struct platform_device *pdev)
 	}
 
 	pdata->res = res;
-	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	pdata->ioaddr = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pdata->ioaddr)) {
 		if (!pdata->use_hash)
 			return PTR_ERR(pdata->ioaddr);
 		/* try AES without HASH */
 		res->end -= 0x300;
 		pdata->use_hash = false;
-		pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+		pdata->ioaddr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(pdata->ioaddr))
 			return PTR_ERR(pdata->ioaddr);
 	}
-- 
2.25.1


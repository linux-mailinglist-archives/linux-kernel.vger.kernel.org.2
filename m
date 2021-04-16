Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912AE361FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbhDPMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:23:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbhDPMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:23:41 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXNVE-0006mp-6t
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 12:23:16 +0000
Received: by mail-ed1-f71.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so6922057edb.22
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuRrK2sERCiDBtlFETS0bmY5iva8IGRiUD4dm9TuXd4=;
        b=VtgL27muCy65txZCqBGN82rM7W/YQ032VmDnwLIXWUCCiiMP1Icc29F8n2ImauGvYV
         FS20uLg6d1mdykbbjEwj0lRsUx9Hc//bYTvn0v4g78gK2l004rsmRQDQr2FpsaL0Tm1T
         VIqnHJNNFscBv37Fye07/j/AbioNwhe3DAUQIzQnKUUicpoiAIgwJiZQzV2sZt8Kq594
         sxzuJC6srbC/C7VWUVOvRlQaiiPBfwsOOdrTFg3Vf7VyNKKopzAoOWVY4mDKuy+t9VEt
         jCCc+LdVaCcdvDagx8jmKPG+SEqCS9794YFilGopV0qiRWKdY7OMEfQgzaviPqtjyLRP
         810g==
X-Gm-Message-State: AOAM530KnjbxbM9Eo4Jf7s2+PeycgANO6rJLg6wBuMItwK/EqfyqB6fX
        ACBChPsQ3n7+E0wjUAZfc8oItrdHreh4Iu6vhOn6QOVlz5szLjlKXdbloMVs63X0RNc0OWkhupl
        1GeddcDrtF/Wlm/p20gSIfqLF2jALiLXZrutE1SN10A==
X-Received: by 2002:a17:906:9a81:: with SMTP id ag1mr8040927ejc.464.1618575795988;
        Fri, 16 Apr 2021 05:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdnin0iDK9J8ErpoBD20g+6ncHdztuhrSzlgqmrf2izOZ21roWcd7CEU6qe6bfTPxitKVrkw==
X-Received: by 2002:a17:906:9a81:: with SMTP id ag1mr8040914ejc.464.1618575795818;
        Fri, 16 Apr 2021 05:23:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id i25sm2328924edr.68.2021.04.16.05.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:23:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] crypto: s5p-sss - remove unneeded local variable initialization
Date:   Fri, 16 Apr 2021 14:23:10 +0200
Message-Id: <20210416122311.223076-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416122311.223076-1-krzysztof.kozlowski@canonical.com>
References: <20210416122311.223076-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of 'err' local variable is not needed as it is
shortly after overwritten.

Addresses-Coverity: Unused value
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/crypto/s5p-sss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index d613bd557016..8c310816deab 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -2156,7 +2156,7 @@ static struct skcipher_alg algs[] = {
 static int s5p_aes_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	int i, j, err = -ENODEV;
+	int i, j, err;
 	const struct samsung_aes_variant *variant;
 	struct s5p_aes_dev *pdata;
 	struct resource *res;
-- 
2.25.1


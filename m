Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8C41E9C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbhJAJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:43:37 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56962
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353124AbhJAJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:32 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C193402E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081307;
        bh=AbbCj9W6fgvQ0YX3UCQV/nDvOLaUQu6puIQCBSTWMLI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GCsjuBOvV8fh2yMPyArirrxsa3EOsPaXaDp5CjIAri1uO0BGKJM1+vpj8aMa7BFWD
         VhCRK0fzoVAr0wK/ZcV7aS9/ZMOuht0xbbRLZzM379yhC2TkxGc9Itgaz05/I5bXgR
         C2/RU6UWCGfdALv/oq8ewtiRY5wKcxIQ/9oIX/izaeatVheAFaJvFHQ/a2CbuCCT6t
         +0gavhZbxNipRE4beFbkUsxMUJ9G/zgmKO/dF3lOs66QTysjSvMxx1o73kgYSHRkZp
         2OHCfcfBMNrENqamsfcMkPJf4Yq8nWx9EwvDPTYIeL8JBkjQ60HLGqgDpkY99xUx8H
         7L7Oow34FFoMw==
Received: by mail-lf1-f69.google.com with SMTP id o4-20020a056512230400b003fc39bb96c7so8453242lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbbCj9W6fgvQ0YX3UCQV/nDvOLaUQu6puIQCBSTWMLI=;
        b=X6XbZIRC4ErWy6mFqwNOwMqdjGWlxGlAJr76ooQnnzqrXC21iBGkeEC8DgoYuwlXHs
         Q6S/NlZQpYFWz8EhpTXlUZeJ2tl2oME//kOFog9xPi+QuHG/bWxPfXA2x2k8LY5VpnEV
         noUflujippIDEbXSMk9vz3C8rT4bc7c0YV5LI7g0EeifeGwJD0/zGqWDFJHWqd17Pn4b
         iXdJwSFGP0ZIP1oLmRkegzRixivo3CGd259hgDQbEmPuUTgX9EjUmOBFbAtYT6kKJ09l
         l1yvaspYp9gFBYSqaEWU3lBUcpiUhgOb+VJgLBis6tSwue0T6nnFYHMPNJRnL1VRTUrF
         S0Rg==
X-Gm-Message-State: AOAM5321HdvGPLMD37gQI3QHEEj3hSo8b+XnxgBwvvI2n3RxAgjWfaDD
        ixjFRbKcNKUwoYnUrepE8u+gRJ9tzPPo7cogR23QLOIO82sSYT2tqBqSuwwqFjkAQdChm/sBj7g
        L2MoZMDJcHOGvN7Jkb0TNZKYja8h9QKpyZfqhKCVqkA==
X-Received: by 2002:a05:6512:234a:: with SMTP id p10mr4595016lfu.558.1633081306801;
        Fri, 01 Oct 2021 02:41:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyg7W1xzgknYSesTbUGNII7OW6AkXeOJ/Dcs6Zcc8B3ryexy+M7AriWK9TeCvsP8l3FNeeRw==
X-Received: by 2002:a05:6512:234a:: with SMTP id p10mr4594990lfu.558.1633081306628;
        Fri, 01 Oct 2021 02:41:46 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id g29sm673784lfj.212.2021.10.01.02.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:41:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2 02/10] regulator: dt-bindings: samsung,s5m8767: correct s5m8767,pmic-buck-default-dvs-idx property
Date:   Fri,  1 Oct 2021 11:40:58 +0200
Message-Id: <20211001094106.52412-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was always parsing "s5m8767,pmic-buck-default-dvs-idx", not
"s5m8767,pmic-buck234-default-dvs-idx".

Cc: <stable@vger.kernel.org>
Fixes: 26aec009f6b6 ("regulator: add device tree support for s5m8767")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
index d9cff1614f7a..6cd83d920155 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
@@ -39,7 +39,7 @@ Optional properties of the main device node (the parent!):
 
 Additional properties required if either of the optional properties are used:
 
- - s5m8767,pmic-buck234-default-dvs-idx: Default voltage setting selected from
+ - s5m8767,pmic-buck-default-dvs-idx: Default voltage setting selected from
    the possible 8 options selectable by the dvs gpios. The value of this
    property should be between 0 and 7. If not specified or if out of range, the
    default value of this property is set to 0.
-- 
2.30.2


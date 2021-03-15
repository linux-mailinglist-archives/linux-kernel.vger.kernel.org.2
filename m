Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619DA33B306
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCOMoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:44:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCOMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:44:29 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLmaC-0004m7-P8
        for linux-kernel@vger.kernel.org; Mon, 15 Mar 2021 12:44:28 +0000
Received: by mail-wr1-f70.google.com with SMTP id n17so15070613wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gGnLzfKnSbhAp7wcwwflz5hIzJKIGDPcT3wtolL3Hk=;
        b=IC32F04Q163uExktRMlVTeN3uRCZP7v6VaWOXXdcZVN5yeoVJ3Unmdk/L9GP83lZul
         oQHbzkaA0iWRWtEiFO/19tphzwHtbm1IQfkMEkFdpkexPYGZm5iOuGp3HPHXv6lZVhcU
         MVLWhfmaYRtgQWw9A7+8RyZNJsLXEIPKPojiaQ7vwonGfNVyBcmorK+iCK+NkVghkbVv
         Rwwl30xfwOHPxXpMJV+KlfcxQU6pbNpozkP6oJyIoU3zyLCYIYID8bK3WtP006doUGxg
         /2GD057+7W/8uzOD3cmsJKSl9Wv47zJ6NBhiIS6ldqcsidysZ03m+gbimMWkHqESnphL
         9OxA==
X-Gm-Message-State: AOAM533/D4zQHLaSmGJqzMlmRl1sAcZFPOtwTnB8fJqjsYsx7ZkkrDsD
        i+cjoTKkD/NjTuhhyJd4DhPpGGsBS1LiNftegDFVN3Eq8OnGAWwgjBdimAIhE/NO8j8kL21CvK/
        Ph3zwhTgjb1sWGG72xSqbWx82ZIb/uO+N0NVAZ+xWeg==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr26756825wru.119.1615812268534;
        Mon, 15 Mar 2021 05:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWR+Bmea44gJeIWJ9PHBWyWebX11p4nAm3PHo6SEI65iJSnDF6/KFoVyo4wSB6gli4ewtK0Q==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr26756812wru.119.1615812268415;
        Mon, 15 Mar 2021 05:44:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id n4sm12311444wmq.40.2021.03.15.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:44:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] dt-bindings: add vendor prefix for YIC System Co., Ltd
Date:   Mon, 15 Mar 2021 13:44:22 +0100
Message-Id: <20210315124423.115039-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
References: <20210315124423.115039-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for YIC System Co., Ltd (http://www.yicsystem.com).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 89d6b0d2cb25..c20194b54315 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1274,6 +1274,8 @@ patternProperties:
     description: Yamaha Corporation
   "^yes-optoelectronics,.*":
     description: Yes Optoelectronics Co.,Ltd.
+  "^yic,.*":
+    description: YIC System Co., Ltd.
   "^ylm,.*":
     description: Shenzhen Yangliming Electronic Technology Co., Ltd.
   "^yna,.*":
-- 
2.25.1


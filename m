Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE01742CAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhJMUXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhJMUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:23:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:21:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g36so165919lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+pdIjVhlHP+7rLIgR547hoyyJNbKcaM94b/z/uUGNg=;
        b=mUKylLN0rmroc7iuJFfT8v5mKbMKa0vrIVpPwGOZfgE1DA5AMzomYi78UPeXsPtFlD
         JNmzE1mQotpBQy9iA10PpWwn1B7kv04/5mOA43jMANaCCgWI2ZuieVoI6gso6nfd0PYE
         8FfZYOuYw/T+0+uKeE6kvE/Y4it4+nVMKq7hc8VaPRV+zIoId9jA3NON4aA2feMlpS6h
         zj91YsD+GIL1zz4nVj6QuX+/RLU1hFEPmFV6VHaT11D2Eh10t/gX3aibbEZWSt0EBw1x
         owgKRxIRZzFSA1YLAjThZ/k+ExiOVwVz5pecaasIC5Ws+ICpIk/EZWujeHmnn/cl42I8
         t4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+pdIjVhlHP+7rLIgR547hoyyJNbKcaM94b/z/uUGNg=;
        b=PkjwYuVgQVe32XXjFhKcB/EEXLznjZRGJWOdpyxoj2/xPof0S6j06njHKQi2fqHTGq
         eLcSuF9ySagLR7Cw3WbpBp0g3jCZ55ULdFH0l0cPhQgChq2zmRb5dh3nFh/TVEvvWiiR
         q6NOYqcY7CF1xuelFDu1UoyCNVSu9ye6XvY6+966SPiHZX5vPgGlDoxJcQuJocDR7EZj
         29W5KWW5/vk/JX6QwdCS6l5leTH++4koQJZfxnonyP+7KN4l/HjAqtzZIy32Qhi1Yufi
         EZfQahqwgSihsUFqN4gP4qNi8aHSnZ+AvSmASApmCoK9JkTaVQRosp2vagaea4yA+epq
         5uqw==
X-Gm-Message-State: AOAM532RQjiJw+9SEsLhjR82HsTaCZ+GPn7xiWobuUKdL/wKaVgWLi6k
        VpygF5qVkpyPhOTvC0Neszn5cg==
X-Google-Smtp-Source: ABdhPJxPwBPXAbXW7RzLbkgwhZFxOovy0H0wBCrL/A7/65cB6zORLS1yJXZVdUrexPiIl7I/lxKVoA==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr1041308lfb.517.1634156473544;
        Wed, 13 Oct 2021 13:21:13 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id bd19sm53567ljb.28.2021.10.13.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:21:13 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: samsung: exynos-chipid: Document Exynos850 compatible
Date:   Wed, 13 Oct 2021 23:21:09 +0300
Message-Id: <20211013202110.31701-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013202110.31701-1-semen.protsenko@linaro.org>
References: <20211013202110.31701-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Exynos850 chip-id. While at it, use enum
instead of items/const, to reduce further cluttering of "compatible"
list.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/arm/samsung/exynos-chipid.yaml       | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
index f99c0c6df21b..bfc352a2fdd6 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: samsung,exynos4210-chipid
+    enum:
+      - samsung,exynos4210-chipid
+      - samsung,exynos850-chipid
 
   reg:
     maxItems: 1
-- 
2.30.2


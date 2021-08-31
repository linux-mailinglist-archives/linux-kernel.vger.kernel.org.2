Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3D3FC7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHaNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:07:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40740
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233245AbhHaNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:07:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 583CD40179
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630415208;
        bh=jb4Ta6fMMydeh8dJ+siO8U0aOew1wuXL5oWGSgaOpHo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=OiZDTZREj74srvXpKwO1hRmgxDFk74g+LNkkYjyAt0RAIR/tZV+t/hV4bQSrsQLFd
         j+LEMwiK6VjQgd5sv2kG94+9GSXA/tow4ZKKlCdUNIuS0val67ihVkrItlfaK+1zmg
         epBrzgGYEicJREBgKHRJh6SwyG6nn4JqI/JuC7NGajp4UEQqMCTQsgObrzx2u9hDgv
         sf7suMELPaojqarurSP8+DXTCdWOoC/JMD7NMbXCMHnacvQu9LFViTEszLSh+MdfpS
         Trjb4dS0+1uwflfzBlRV5qh6DLtG17wYq4BT8M7zJBAYM7rfNKBuVaUGP5yHQxf8Zp
         sAVvNU//Ql04g==
Received: by mail-wr1-f72.google.com with SMTP id q11-20020a5d61cb0000b02901550c3fccb5so4015510wrv.14
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jb4Ta6fMMydeh8dJ+siO8U0aOew1wuXL5oWGSgaOpHo=;
        b=e8XY/1QmqHiDF3tTXSQN7vHaAuDGajvkfkhegrA/bwNmSXGaiUMm1+u/4pUzROeeXh
         ry8o8U1wqIySMivuwFUZJpXhKy13EVuz1cIiJrekdC08aY7q3kQnPDfCJXbRf3L/LT9B
         g/5qLc0Cv1oU98JQp2OATqKes/rz13MVhlRj5hVTMMbfSYpyk0y+YZhucs7uoyuKI1D3
         DJ6Jc54vCnP5PHiDd12DfGEhT87Vfh3v4j8LfqDhZdbimBPMxCgIBms5E1zntWN66lNm
         /qIel9j5Bp73czQhq72M4X6zdpuOori6dHspa5qDednVPDKzILe6J9eHrV6rw8DXWBXE
         3nFg==
X-Gm-Message-State: AOAM5328GI2Eo+xT6Ih5AMlCw05Iwg4QWgml+UiJs4k2LxXHJ4IFEBU6
        H3fMDLTuVSp81a1ijqWMI8OlcIqSc9RD74slxdf20MlgAWb0KcPaIP/InGKHOeJsU9x4DNGCgb7
        wUn7YmpjBVGEcdD/1zU9jEEHIVJPMhO19OlTKFOXL8A==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr4034755wmd.113.1630415208043;
        Tue, 31 Aug 2021 06:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRzBmZSNKQmsvfdl3PEsodfUa1SAbfBbCTnsvKSPFIvVjQbifNg+VvzvXV88t2ef5XMKkkKA==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr4034739wmd.113.1630415207887;
        Tue, 31 Aug 2021 06:06:47 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id u2sm2450035wmj.29.2021.08.31.06.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:06:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: samsung: fix header path in example
Date:   Tue, 31 Aug 2021 15:06:43 +0200
Message-Id: <20210831130643.83249-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proper header is exynos4.h:

    samsung,exynos4412-isp-clock.example.dts:19:18: fatal error: dt-bindings/clock/exynos4412.h: No such file or directory

Fixes: 7ac615780926 ("dt-bindings: clock: samsung: convert Exynos4 to dtschema")
Reported-by: Stephen Boyd <sboyd@kernel.org>
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

The SHA in fixes tag is from linux-next. Might not be stable.
---
 .../devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
index 7b405bcd6fef..1ed64add4355 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
@@ -52,7 +52,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/exynos4412.h>
+    #include <dt-bindings/clock/exynos4.h>
     clock-controller@10048000 {
         compatible = "samsung,exynos4412-isp-clock";
         reg = <0x10048000 0x1000>;
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CFC3E56EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhHJJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:32:52 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42568
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237915AbhHJJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:50 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id C715540C82
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587947;
        bh=/TjUAhhwvSRFuslwguP2QiddIzNChxvR3o7MxjSQJ14=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=P3dMRhJ94z4SbEeqHGR2UwlFLPPStVsQmsleniCRwWm7MjWbX0yganjB3ITo7VugD
         svZy0IpdGcGFLD2Ld4820VkvvU3PnXDXmT++JhmVnzNpfQ0EU6x8fvXR2gLby5mpKE
         EuwcKSEL2+Id6neDf7wh71ETtu7mIVHlJ5zUyLszTllL8aUVHMOOgdMzdcDJJ1VE3J
         C7d6/vmLEev1U0szgcRSUSfxMcbIrTDjV62rK03VkbFSxj2rrg0PyLUpJCyKL/80AS
         OETUN1G81mGKUcyvpqUyi+Us3g+t6iOlKcvvXX9SLWbgzd9qclTj+a9OmYQuoJJ5Me
         8rg+/XTH1wvcg==
Received: by mail-ed1-f69.google.com with SMTP id dh21-20020a0564021d35b02903be0aa37025so8238609edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TjUAhhwvSRFuslwguP2QiddIzNChxvR3o7MxjSQJ14=;
        b=AZ+xPcbG3qfslvFcpjgP3DD1UtrWaxN/wjf7QjlZyKE+oSIhLvCMb+0pxLCc8NGmbk
         vi21mq0vox82qWTqmX4GFE6OnJS179NlmBpJ00Vast1BPvwKHyLsag4BbZOqCUhCIqRM
         2Iagb90oaP3v7zh04CPwGHbXm2/8C7lTK5Xp4BM5MYk2huFDV5YEdSRlwf6AQD9z42y+
         MyfSpJTWF50AsyAkGg5VebnVO2uG44VS1Tgfzx5GC1mRsJ/6AoxuaawDwpjHhIFjkgAa
         rAuKg79FB1XR11iAqVwbGb4wjLWfFp1oczzWPEzb2usauwt+iJWiL9tqHqE16OLE2ZzO
         cEbg==
X-Gm-Message-State: AOAM530PPa/LSIaRoh+q2VOGmhR+jvtompgsC2mK5h0mmZw13gjp9YHc
        0+jjrOeBaOa5rXtWMvFCJJbKPsqwrLr759spHce1b74wHSbPBK5POphpWiT3UvE4awX59PcWHKU
        BsScQZmlAKVFXPd4DE5DdxVs/DRj7bVEn6Y2BlXUH3w==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr3886385edy.57.1628587946810;
        Tue, 10 Aug 2021 02:32:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTDejpsnySJ5hI4EiBZYSmNUdOwiCDaSglUDL7QJIhM3zKW5UGTy4wbFQDlfcb7RdEzzFCRA==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr3886364edy.57.1628587946598;
        Tue, 10 Aug 2021 02:32:26 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 0/8] dt-bindings: clock: samsung: convert to dtschema
Date:   Tue, 10 Aug 2021 11:31:37 +0200
Message-Id: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Combined patchset of separate v1 sets:

https://lore.kernel.org/linux-samsung-soc/20210809120544.56596-1-krzysztof.kozlowski@canonical.com/T/#t
https://lore.kernel.org/linux-samsung-soc/20210809130935.80565-1-krzysztof.kozlowski@canonical.com/T/#t
https://lore.kernel.org/linux-samsung-soc/20210809135942.100744-1-krzysztof.kozlowski@canonical.com/T/#t

Changes since v1:
1. Patch 7/8: include header to fix clock IDs error in example.

Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  dt-bindings: clock: samsung: convert Exynos5250 to dtschema
  dt-bindings: clock: samsung: add bindings for Exynos external clock
  dt-bindings: clock: samsung: convert Exynos542x to dtschema
  dt-bindings: clock: samsung: convert Exynos3250 to dtschema
  dt-bindings: clock: samsung: convert Exynos4 to dtschema
  dt-bindings: clock: samsung: convert Exynos AudSS to dtschema
  dt-bindings: clock: samsung: convert S5Pv210 AudSS to dtschema
  MAINTAINERS: clock: include S3C and S5P in Samsung SoC clock entry

 .../bindings/clock/clk-exynos-audss.txt       | 103 ------------------
 .../bindings/clock/clk-s5pv210-audss.txt      |  53 ---------
 .../bindings/clock/exynos3250-clock.txt       |  57 ----------
 .../bindings/clock/exynos4-clock.txt          |  86 ---------------
 .../bindings/clock/exynos5250-clock.txt       |  41 -------
 .../bindings/clock/exynos5420-clock.txt       |  42 -------
 .../clock/samsung,exynos-audss-clock.yaml     |  79 ++++++++++++++
 .../bindings/clock/samsung,exynos-clock.yaml  |  87 +++++++++++++++
 .../clock/samsung,exynos-ext-clock.yaml       |  46 ++++++++
 .../clock/samsung,s5pv210-audss-clock.yaml    |  77 +++++++++++++
 MAINTAINERS                                   |   4 +
 11 files changed, 293 insertions(+), 382 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos3250-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5250-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5420-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml

-- 
2.30.2


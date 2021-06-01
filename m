Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2439777B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFAQH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:07:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49037 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFAQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:07:56 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo6uE-0006dj-2L
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 16:06:14 +0000
Received: by mail-ej1-f69.google.com with SMTP id e11-20020a170906080bb02903f9c27ad9f5so692284ejd.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyb6Ru3IbIthqWH2D/m1QZNA0swOAiK0r578mI2XYZw=;
        b=A4VIFUy4H66uq7KzQamPBQ+C/e1S0KcgYfguDERG3XyakeUHF91iZICd7uNxCyCJVy
         65/9LKiuz5IQfzc77/ChNXny53GK1Zz1j2TuT5eX/6uISPOB4/sW0Fo5TOTmpInfzHM5
         DAdCkdVN0nt7fXNe0xLW29jGBwzVQUvgxNXhwugkygDf9vFTm8PQyr5N1RG9daFgPGCT
         O1OS3JVQwc9P2Ajl6k6VQLD4uhgrWkavo7mK7tJtG5AjgVfvwg9q3yquFQcTIqT6YuMO
         4ygIik19PAeTUmMvza/GCctXaPMemaRZAZiuqKnbGzGdNhyiQM/9vEDwOjwMAKqDGRPb
         2H+g==
X-Gm-Message-State: AOAM531PfAJ5eQ4ev0Ajt9K50BW+F0fccD62cYq9XnDFq7Lxnwm7WM+T
        XrWz4AKU25FDRv00kicyiOkXPRUzkQh+swIcsD2FCrNdlm8oXci0dxxD0oOVUy6iMqD/7MnXynS
        6gSF6hBk2WIeU7USGp0BItF2uab3fJzbhWfEr6oNkLg==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr15998232ede.94.1622563573856;
        Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgEGH0cJC2S6UmgZBt8EnbaIvGANzMLXyMZvfOy+JlDpUcy2dBgidamQ2B9j+0uPEhaC5gug==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr15998223ede.94.1622563573729;
        Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id n15sm1523708eds.28.2021.06.01.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:06:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: memory: cover also header file
Date:   Tue,  1 Jun 2021 18:06:08 +0200
Message-Id: <20210601160608.312446-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601160608.312446-1-krzysztof.kozlowski@canonical.com>
References: <20210601160608.312446-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add include/memory/ in memory drivers maintainers entry.  So far there
is only one file there for Renesas Reduced Pin Count Interface driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 365f873d0077..ac632ac6d533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11860,6 +11860,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
 F:	Documentation/devicetree/bindings/memory-controllers/
 F:	drivers/memory/
 F:	include/dt-bindings/memory/
+F:	include/memory/
 
 MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
 M:	Dmitry Osipenko <digetx@gmail.com>
-- 
2.27.0


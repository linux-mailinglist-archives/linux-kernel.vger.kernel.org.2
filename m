Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99A536A8AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhDYRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 13:50:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYRu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:50:29 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1laitA-0005Hh-Cw
        for linux-kernel@vger.kernel.org; Sun, 25 Apr 2021 17:49:48 +0000
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso21666421edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 10:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RBjEAtJQftD+dVBcJH/vI5ONKidJRREyztVu/ffD0/8=;
        b=p4hP00EoXAJ7Kgvzv7dp+SPB2lhWDeIc6PzCgRjJDix7hWxHYKQqPdlN+9VomYDSxN
         orTPz0UUBJSvRpqQq6UXIB5gADOawBb+7CoWPpZc/1/KPc/q5c8sZx7DKha74pR99W6b
         ArG+NMPxY2srE7kuw5Q3brIcOEx8TwucexIbX/XygcE/OCLnfUA6jUsHEhWtis3nfTFo
         R2TV4zRLg1ZMWmu7z7odJC4fB0XjFm14hnBGgI4AW1X4c6sk843PYOXYzQLRLeYJcyGJ
         6UOmcF1TcjDJUU5OGG95KZbpWU7E71c6EatWQZXGugCbAaa5ia3njCJkWu1r9QP3nZOw
         hEOg==
X-Gm-Message-State: AOAM532OthTIkKYzH5R4ZG727JLiVZRtPTzjjzdJM9ZOc9smKWu48Xuf
        P9Dan3c8Pzwrn/lxlyi7N12acWk10SxVwqE/dH1p49KcX+zT4RIqY2qNIevu8DnHniISzZclS1O
        IxFvV2I4E9zddjNb7eWrqK5xJ5Y6cmUs2I5Nf4FcQvw==
X-Received: by 2002:a17:906:38c5:: with SMTP id r5mr14085228ejd.230.1619372988161;
        Sun, 25 Apr 2021 10:49:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxIa+fvr/8tH3+GL4vr6HdZUUJF//xEt4ORa/3i/PjDfkoJ3qcmGmy6Th5L2m2eXQP7EgPhw==
X-Received: by 2002:a17:906:38c5:: with SMTP id r5mr14085217ejd.230.1619372988033;
        Sun, 25 Apr 2021 10:49:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id ca1sm12113585edb.76.2021.04.25.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 10:49:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: add missing of_node_put for loop iteration
Date:   Sun, 25 Apr 2021 19:49:45 +0200
Message-Id: <20210425174945.164612-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_compatible_node() should decrement the
node reference counter.  Reported by Coccinelle:

  arch/arm/mach-exynos/exynos.c:52:1-25: WARNING:
    Function "for_each_compatible_node" should have of_node_put() before break around line 58.

Fixes: b3205dea8fbf ("ARM: EXYNOS: Map SYSRAM through generic DT bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/mach-exynos/exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 25b01da4771b..8b48326be9fd 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -55,6 +55,7 @@ void __init exynos_sysram_init(void)
 		sysram_base_addr = of_iomap(node, 0);
 		sysram_base_phys = of_translate_address(node,
 					   of_get_address(node, 0, NULL, NULL));
+		of_node_put(node);
 		break;
 	}
 
@@ -62,6 +63,7 @@ void __init exynos_sysram_init(void)
 		if (!of_device_is_available(node))
 			continue;
 		sysram_ns_base_addr = of_iomap(node, 0);
+		of_node_put(node);
 		break;
 	}
 }
-- 
2.25.1


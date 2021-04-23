Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C590C369033
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhDWKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:18:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42116 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhDWKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:18:56 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZst9-0001bH-GW
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 10:18:19 +0000
Received: by mail-wm1-f72.google.com with SMTP id d78-20020a1c1d510000b0290132794b7801so581028wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC3zoWq2BZfFb/EWRvBNqc9bpLHCgYUaPIXnRPSJVLg=;
        b=jCnrydZpS2A4uq3N47mACZJbosc54an/oWCPpbSJKiu1V599jJZxlAlApU8Nr2Ht6m
         j++z03gkP40BxXVHQr3vJpskCF1f9ctAO9sJr8dnRK+hq3PPV3t59qdJ/fgzhDAd819f
         PyT3+XR5nJI9HQnDfoAQFIMjZg01zbxP7VrXGdQoDrhidmhBoV2EHvfjjSvhfmkiFCLn
         437tpwSHdn0ao671lIuaSMCjLLwL0Vg+xj+UoM3O8WiUAYFwd2J2GXwRxwgz/o6LptfB
         PGzsgJ9aF8X6+XictJXMJRbKsjZl6UzujVoj6o0HQbBHyBw9+zBkIvQKEJO9N1lF6K4G
         2D+w==
X-Gm-Message-State: AOAM531n7r40aYxqu0W+ItJkwbWelciwmEseRncuqsZdkeJi/aQyE+0o
        rl7bIHqQUGHUy/vqTabbzwcNOqkfIa1cZ9eY3VLemI2b4vENyYE7RV84lALT7q/EwoxSNiRDjzR
        ClspYIHr2UhyiSHjEKKv9fTgXEEBbPPu6ucPRQBn4lA==
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr3767662wrw.290.1619173099133;
        Fri, 23 Apr 2021 03:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF9sI9bCBwQSREZbDeBLDvxvweCTOZ8qI9QcsoUrGVo9CdTEpRonVxU+F0lh3KuSjDfn1b0A==
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr3767654wrw.290.1619173099028;
        Fri, 23 Apr 2021 03:18:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id k22sm9011546wrh.5.2021.04.23.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:18:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] memory: atmel-ebi: add missing of_node_put for loop iteration
Date:   Fri, 23 Apr 2021 12:18:15 +0200
Message-Id: <20210423101815.119341-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
References: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/memory/atmel-ebi.c:593:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 604.

Fixes: 6a4ec4cd0888 ("memory: add Atmel EBI (External Bus Interface) driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/atmel-ebi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 14386d0b5f57..c267283b01fd 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -600,8 +600,10 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 				child);
 
 			ret = atmel_ebi_dev_disable(ebi, child);
-			if (ret)
+			if (ret) {
+				of_node_put(child);
 				return ret;
+			}
 		}
 	}
 
-- 
2.25.1


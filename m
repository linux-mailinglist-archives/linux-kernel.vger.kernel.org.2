Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE9369032
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbhDWKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:18:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhDWKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:18:55 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZst8-0001aN-9S
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 10:18:18 +0000
Received: by mail-wm1-f69.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so508071wmg.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aYP7r7LEZu6SffM7BQ/kCnDNHMdX1uJGOUnQwrtupd4=;
        b=h+TwyQg1fDyKcPwTbRgH2ObQPZPKWQHV5rnTGQspYIV0ReUbTshVtIaaYaDTqWQ4pi
         R4IK34LLLyTbIc2137DjowbL5QQgHxk/HIBBXZJktxBBkQmRKglPFDPgZzzDnjT+qF17
         hNOA2XUO220GdwmNJ1uaQLbmtpFGXwwhMaPAKT6yMSxVoXaAVCeckifc2K0VkcugFfZN
         nhKDMXn+4/tY/+jotQmdzIjQbSZrFGMlFubXQE20rUcdTUacgxdaV8EQ17UacajFX90d
         v2Yw3ZhRq+QkzDtZCvrV6JBrBP2lqcYgs9R8Ggjmd+VFBy0Ea6i4VkT72HmSWXVYp1u4
         xXWQ==
X-Gm-Message-State: AOAM533Jiw3gBk5WbITGLMfmegFwgeCpyutiXjZN6bqjO8xDe9e9ShPu
        SkAkIkG4UGw+/KnFfS1aDMGHnuvw9821KUmnTVPvgaMNas7pUOT/k0kBsO0KqW1GxNYCUcB+83v
        MSV0uEsdmMwtuiXi+k1PVM6OLj5HeckxxNGQWVO3PRQ==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr3621882wrq.321.1619173098076;
        Fri, 23 Apr 2021 03:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYKHJDOkDZqAUM3Wgbi5Urcq0uh3Bk7tH9x1MWtycNV6cQpV4aktMYKexZVqRVW2OoCmZ6Xw==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr3621863wrq.321.1619173097904;
        Fri, 23 Apr 2021 03:18:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id k22sm9011546wrh.5.2021.04.23.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:18:17 -0700 (PDT)
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
Subject: [PATCH 1/2] memory: stm32-fmc2-ebi: add missing of_node_put for loop iteration
Date:   Fri, 23 Apr 2021 12:18:14 +0200
Message-Id: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/memory/stm32-fmc2-ebi.c:1046:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 1051.

Fixes: 66b8173a197f ("memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 4d5758c419c5..ffec26a99313 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1048,16 +1048,19 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
+			of_node_put(child);
 			return ret;
 		}
 
 		if (bank >= FMC2_MAX_BANKS) {
 			dev_err(dev, "invalid reg value: %d\n", bank);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
 		if (ebi->bank_assigned & BIT(bank)) {
 			dev_err(dev, "bank already assigned: %d\n", bank);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -1066,6 +1069,7 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			if (ret) {
 				dev_err(dev, "setup chip select %d failed: %d\n",
 					bank, ret);
+				of_node_put(child);
 				return ret;
 			}
 		}
-- 
2.25.1


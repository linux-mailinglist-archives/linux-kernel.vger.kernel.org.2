Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBB358DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhDHTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:50:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41549 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:50:48 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUafk-00042d-9L
        for linux-kernel@vger.kernel.org; Thu, 08 Apr 2021 19:50:36 +0000
Received: by mail-wm1-f69.google.com with SMTP id f3so283721wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I3rxjojN2v/kK7LxnxTnuoS/24IOjJzT+k5Y2qcQ58=;
        b=bvIgFem+rjAm3NrDo0KjiLVpSaU6nj8B4DCHLvDmaIQzwbmFBxs09E4+jYD/XTuy9s
         JyvROjB2B1jUJnmA1cZ6Tqmi+DQWy9JxPfuTm2pJNcRRmKPcqpOyI888lnzI3nA7EXs0
         0wFPiFFxJoFaN0oNSWe9NW+ghrllViHdj4A0GbD6hITkVSMy18K+/ChE4A/7x6p8gmWa
         +2ikiGmK5w1oPiyfZy5D7aEiKJSl+9grAYa56JcE5pxwCGsewXnWDcJxwypK/PfR05mu
         S7HWNxoRF4++QyNnWHYk2ueSJ6LmE3ds9NANeMUJrXEtUF+hy8O9rACWUuIiHAKiii4V
         ne+g==
X-Gm-Message-State: AOAM531QdVywi39MREAY9nb8816Y4r4nAfibh6WqR9O5Y6VqrwheSIX/
        VsFRhGZU9Z79l90ZVYtXeA7kYekmsLZkSqBtB4lSQuCNu0fw5hMTpeBJCbFs/Mb18CzuLjj/HnZ
        HI/yKrQLK0fQwxhZ9ca7NMPTPhSGXmOfrAiaiOQ6CEw==
X-Received: by 2002:adf:ea46:: with SMTP id j6mr13632656wrn.34.1617911436043;
        Thu, 08 Apr 2021 12:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzylv5JuU33P7EpPdff1gvFG44EL00KZzjjJZBKpQNPh3ZDEbsa5BmwCFBD7BAoFjC2rPb72g==
X-Received: by 2002:adf:ea46:: with SMTP id j6mr13632640wrn.34.1617911435854;
        Thu, 08 Apr 2021 12:50:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id f20sm312022wmg.36.2021.04.08.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:50:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pinctrl: samsung: use 'int' for register masks in Exynos
Date:   Thu,  8 Apr 2021 21:50:29 +0200
Message-Id: <20210408195029.69974-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Special Function Registers on all Exynos SoC, including ARM64, are
32-bit wide, so entire driver uses matching functions like readl() or
writel().  On 64-bit ARM using unsigned long for register masks:
1. makes little sense as immediately after bitwise operation it will be
   cast to 32-bit value when calling writel(),
2. is actually error-prone because it might promote other operands to
   64-bit.

Addresses-Coverity: Unintentional integer overflow
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Not tested on ARM64.

Dear Linus,

Please apply it directly, I don't have any patches for Samsung pinctrl
in my tree.
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 0cd7f33cdf25..2b99f4130e1e 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -55,7 +55,7 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
-	unsigned long mask;
+	unsigned int mask;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
@@ -83,7 +83,7 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
-	unsigned long mask;
+	unsigned int mask;
 	unsigned long flags;
 
 	/*
@@ -483,7 +483,7 @@ static void exynos_irq_eint0_15(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static inline void exynos_irq_demux_eint(unsigned long pend,
+static inline void exynos_irq_demux_eint(unsigned int pend,
 						struct irq_domain *domain)
 {
 	unsigned int irq;
@@ -500,8 +500,8 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct exynos_muxed_weint_data *eintd = irq_desc_get_handler_data(desc);
-	unsigned long pend;
-	unsigned long mask;
+	unsigned int pend;
+	unsigned int mask;
 	int i;
 
 	chained_irq_enter(chip, desc);
-- 
2.25.1


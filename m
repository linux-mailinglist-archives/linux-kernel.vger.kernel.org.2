Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7973D7EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhG0Tqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhG0Tqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:46:36 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E229C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n19so195927ioz.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpKATF26Oehqbj9lTGQY7PBo/hOLLmivLGfbP+CflK4=;
        b=QmVNUSY3LsuSyY6FD99L5WcKmSWbBwUxw6irXRHPTSYqTUUxh8K2ntp8JTi4EQV8vO
         fVxRMGX9WI5xhMjAcXW1QuPEJJFyHgjAGD8rTI4MgG2mbj/ZFW59IPZ1gtA0t6b62JrA
         9jQZO2ByxKZR+hmLY+I3cTDUWxExHVKIhw8kpN2xD8z5QGko0GwwPANN3yVZvb44U7/T
         zzJHl2U9mPlYcsoAgzVjgyREm2f0IsYPdQfVXCsmeBmwt9qNuif5la5Stxog9cl9/TEL
         DH3i8/XMy7j2KB1Yhb7+zXK0CihxPNubhAf5Z1c5XbKF/bBLFCAlSMwT74jJwafW2RWY
         8YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpKATF26Oehqbj9lTGQY7PBo/hOLLmivLGfbP+CflK4=;
        b=kPurXzgvcw+5BJ9NFJzUbF4CbxytnSi2eb0VvYbSmV9OjLgyHICylUg1OwgnvbE2eI
         XsUrp+HrpizXBZwjNzbzjllUla4AhYIXt35Wn7gCz/b0qIA70I7HvFfa7c6xgQl4271C
         ULGV4U00K1rwXId10MLN4Wwo+LN+FPsAApT6MzHAjeddlpSsnruk8ZAsDLnlPbeK3d0R
         fv8TEXJf7w23upP0kkdlmE0uBc52Gh+RRbGIbMj4zDyFabqqhnSXH8F9ufI8b33wmiTI
         C8dCAx/l3Z70Gh8bhK3+i/n+zMBooomapDZkN8vDT+cRYUqv67uTy6fqS9hIA4inZ6bH
         DzBA==
X-Gm-Message-State: AOAM532VOv49k4t5Kp/pp2qsVAIA0CEl01lTEJmttsCR7j4W+i6VtOOK
        ZSor8Wy7OiYeD3x0RkKf745ZRQ==
X-Google-Smtp-Source: ABdhPJxwAxCI+R4uinIwfBMoUieAzOdLhtyzjmXynDCd6tMUVseKsR7S/wjGTOrxvRhDRqw/uJTaWA==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr23365375jag.53.1627415194152;
        Tue, 27 Jul 2021 12:46:34 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c1sm2443014ils.21.2021.07.27.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:46:33 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: ipa: clear disabled IPA interrupt conditions
Date:   Tue, 27 Jul 2021 14:46:27 -0500
Message-Id: <20210727194629.841131-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727194629.841131-1-elder@linaro.org>
References: <20210727194629.841131-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We ignore any IPA interrupt that has no handler.  If any interrupt
conditions without a handler exist when an IPA interrupt occurs,
clear those conditions.  Add a debug message to report which ones
are being cleared.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 7dee4ebaf5a95..c12d0c33557cd 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -79,6 +79,7 @@ static void ipa_interrupt_process_all(struct ipa_interrupt *interrupt)
 {
 	struct ipa *ipa = interrupt->ipa;
 	u32 enabled = interrupt->enabled;
+	u32 pending;
 	u32 offset;
 	u32 mask;
 
@@ -87,8 +88,8 @@ static void ipa_interrupt_process_all(struct ipa_interrupt *interrupt)
 	 * only the enabled ones.
 	 */
 	offset = ipa_reg_irq_stts_offset(ipa->version);
-	mask = ioread32(ipa->reg_virt + offset);
-	while ((mask &= enabled)) {
+	pending = ioread32(ipa->reg_virt + offset);
+	while ((mask = pending & enabled)) {
 		do {
 			u32 irq_id = __ffs(mask);
 
@@ -96,7 +97,17 @@ static void ipa_interrupt_process_all(struct ipa_interrupt *interrupt)
 
 			ipa_interrupt_process(interrupt, irq_id);
 		} while (mask);
-		mask = ioread32(ipa->reg_virt + offset);
+		pending = ioread32(ipa->reg_virt + offset);
+	}
+
+	/* If any disabled interrupts are pending, clear them */
+	if (pending) {
+		struct device *dev = &ipa->pdev->dev;
+
+		dev_dbg(dev, "clearing disabled IPA interrupts 0x%08x\n",
+			pending);
+		offset = ipa_reg_irq_clr_offset(ipa->version);
+		iowrite32(pending, ipa->reg_virt + offset);
 	}
 }
 
-- 
2.27.0


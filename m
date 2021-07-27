Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497793D7EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhG0Tqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhG0Tqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:46:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51824C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n19so196012ioz.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eH4S8FNsAoKRYvFR0Ki+05n7mxmZZlMccibOdhfBxlg=;
        b=MgJnPNwGGGC8USKl7KNWBI56pzqNdFS7mvjfVzTn1v7II1LQF8+IxuJOUhUgNNAiNN
         7osh0jaO1pZXNA42jKDLWA8P9ywA4SFxlRncmLYOnjrUtxjUoJzA44vcnrqNJaJtNlpI
         Ym1ehl4GYYUG6sR1YjCAf8oKL8nmEbOw4IntTbvO7qGkKgmh+bv291pxio8tjuuCF5qX
         47BkgFa/booLy4dfisVIolTlOOuJXGVZXAIxijz63awCZwabMQI1XRW7RCF3gHTOC38J
         4wYue0xhxaSeWRaI2kVB/bBqG0iTOr1kDBKOerzdplFVkExUV+0nnd12GjRUfOGzSN+4
         VSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eH4S8FNsAoKRYvFR0Ki+05n7mxmZZlMccibOdhfBxlg=;
        b=dC2YfjzeS8YIfHQG9pweFTfcyQchvYt/fpufL9+Cv9WTAdUiQNJshXyRN8hzSoTAae
         GB7VIDR01nHghJJi78WelX7weSloH6WNA0SC7CHsobyGRA3NRl2+uvUM9tIr4PyfY9be
         NXj6mxPNmcyxnFVpUDJrRDXVTTXeMUloI2dKqlXi4mbWl8GUutxAHClA9nQK1kUMUMQS
         Hkw18SlfYPjBDBgF77yvcfHO0VRdWupa+EZQPGuDv4/Yqxb6UPlMZm9uRcIko9FmaQBY
         436FED7DORU8zQSXN+Cn2Ewlx8zk5I45Zvys3k9b8r+W+aI3LVm4sMPEP43qTZ2fRWsP
         JQqQ==
X-Gm-Message-State: AOAM531yV4XP5ddgRRHkafWyEGTUY7MtpinWAaZw14W4gh1GXViXCN/A
        V+AkceNR3PP7Y1cjiO35ioVurw==
X-Google-Smtp-Source: ABdhPJxj7rruGR0xMsW5vaqPUWfzQAl/sXuesY+/95E+0HFosKPKp4Gbdvgw+zgvnwagRsRBZFA+WA==
X-Received: by 2002:a05:6638:538:: with SMTP id j24mr22703457jar.59.1627415195809;
        Tue, 27 Jul 2021 12:46:35 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c1sm2443014ils.21.2021.07.27.12.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:46:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: ipa: kill ipa_interrupt_process_all()
Date:   Tue, 27 Jul 2021 14:46:29 -0500
Message-Id: <20210727194629.841131-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727194629.841131-1-elder@linaro.org>
References: <20210727194629.841131-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ipa_isr_thread() is a simple wrapper that gets a clock
reference around ipa_interrupt_process_all(), get rid of the
called function and just open-code it in ipa_isr_thread().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index d149e496ffa72..aa37f03f4557f 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -74,15 +74,18 @@ static void ipa_interrupt_process(struct ipa_interrupt *interrupt, u32 irq_id)
 		iowrite32(mask, ipa->reg_virt + offset);
 }
 
-/* Process all IPA interrupt types that have been signaled */
-static void ipa_interrupt_process_all(struct ipa_interrupt *interrupt)
+/* IPA IRQ handler is threaded */
+static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 {
+	struct ipa_interrupt *interrupt = dev_id;
 	struct ipa *ipa = interrupt->ipa;
 	u32 enabled = interrupt->enabled;
 	u32 pending;
 	u32 offset;
 	u32 mask;
 
+	ipa_clock_get(ipa);
+
 	/* The status register indicates which conditions are present,
 	 * including conditions whose interrupt is not enabled.  Handle
 	 * only the enabled ones.
@@ -109,17 +112,6 @@ static void ipa_interrupt_process_all(struct ipa_interrupt *interrupt)
 		offset = ipa_reg_irq_clr_offset(ipa->version);
 		iowrite32(pending, ipa->reg_virt + offset);
 	}
-}
-
-/* IPA IRQ handler is threaded */
-static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
-{
-	struct ipa_interrupt *interrupt = dev_id;
-	struct ipa *ipa = interrupt->ipa;
-
-	ipa_clock_get(ipa);
-
-	ipa_interrupt_process_all(interrupt);
 
 	ipa_clock_put(ipa);
 
-- 
2.27.0


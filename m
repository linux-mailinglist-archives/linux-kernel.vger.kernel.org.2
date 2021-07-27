Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FA3D7EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhG0Tqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhG0Tqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:46:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70CC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:35 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id k3so433287ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLz2frAd3QKDDMnRP6OXGsrEzL53XboKZfJ8zI0IXQU=;
        b=rBzZlHEkQej+rUd/GCmCW8HOR6qggFZa6keLtFb0bUxK3OfBXp0NsBaKM1xag4NxH4
         Eki/Ji18uJTBG7/wuuHOyRBlZXvKgM0nIHNlI6+SbwnJiE0YxWtVFrNav3V02RNwuAMm
         aZmVKhaMMRYxRySSNW7bAc6A1ICLphUted4QmL/L1IN/M92cYBGsi1UH/xeQup+s+L/y
         V/DcAMvyoPECxofUraxiOZRvTqwPVK8u+4OX2pLgUh7Hd1nDQE7G50F41CS6SCSrzIhs
         11VKHfZKb+BfO7N9koDQaVZuHpv2LK4FAQ9o/hI4WZj9kTU/4f4axqn2JbUfpOc+l3Ni
         OVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLz2frAd3QKDDMnRP6OXGsrEzL53XboKZfJ8zI0IXQU=;
        b=NKk8rCCp4n/1fz4SlNtAoRk5Tjx/gACjCPKT6/M0/mh/4IaTkSWoZ7Jj3iARVkD47T
         POn6phvlMm5ZwpoJ+c1u0kF9RYLpXmdbgxkcv9qmw1qiWNSAN5KZzFp8rk5uKg442nzl
         3cZykCyCiE6XJ6qN0G2pTMQxD7SmEwNle7JX0zWI/VAalU7iD5wy4+wBHRR+KraFdYu/
         WHilGcyt2E3MZM+7sr1k3Q5jY4PX38dbEBxD7/wdNq/3vN5kepHXuH9RGjWIebe/Ifg7
         sONCjbH+v6i+7d+7EH/iGSFwsD1Gvx1JeDUHiKRyIVO4kXkfWMgT0UN5gEb1Hns+QMoG
         Hz8Q==
X-Gm-Message-State: AOAM532YxxUHHf5y+ssTdXPDDnavAR601noX27suFZKOkG809/d6FT5R
        F6ycjAimLOJr/y26EDfz+XxKZw==
X-Google-Smtp-Source: ABdhPJyywaS6QHNTVPqQ5RTaV+g+kFPjZebNeJqzKRVYO2KZsEq2UcXPTdIIkG8U8BLtFH9Or40Ehw==
X-Received: by 2002:a05:6e02:1a05:: with SMTP id s5mr1029683ild.232.1627415194959;
        Tue, 27 Jul 2021 12:46:34 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c1sm2443014ils.21.2021.07.27.12.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:46:34 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: ipa: get rid of some unneeded IPA interrupt code
Date:   Tue, 27 Jul 2021 14:46:28 -0500
Message-Id: <20210727194629.841131-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727194629.841131-1-elder@linaro.org>
References: <20210727194629.841131-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pending IPA interrupts are checked by ipa_isr_thread(), and
interrupts are processed only if an enabled interrupt has a
condition pending.  But ipa_interrupt_process_all() now makes the
same check, so the one in ipa_isr_thread() can just be skipped.

Also in ipa_isr_thread(), any interrupt conditions pending which are
not enabled are cleared.  Here too, ipa_interrupt_process_all() now
clears such excess interrupt conditions, so ipa_isr_thread() doesn't
have to.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index c12d0c33557cd..d149e496ffa72 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -116,26 +116,11 @@ static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 {
 	struct ipa_interrupt *interrupt = dev_id;
 	struct ipa *ipa = interrupt->ipa;
-	u32 offset;
-	u32 mask;
 
 	ipa_clock_get(ipa);
 
-	offset = ipa_reg_irq_stts_offset(ipa->version);
-	mask = ioread32(ipa->reg_virt + offset);
-	if (mask & interrupt->enabled) {
-		ipa_interrupt_process_all(interrupt);
-		goto out_clock_put;
-	}
+	ipa_interrupt_process_all(interrupt);
 
-	/* Nothing in the mask was supposed to cause an interrupt */
-	offset = ipa_reg_irq_clr_offset(ipa->version);
-	iowrite32(mask, ipa->reg_virt + offset);
-
-	dev_err(&ipa->pdev->dev, "%s: unexpected interrupt, mask 0x%08x\n",
-		__func__, mask);
-
-out_clock_put:
 	ipa_clock_put(ipa);
 
 	return IRQ_HANDLED;
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AC32E485
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCEJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCEJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:16:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50653C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:16:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y67so1732521pfb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5nDa8ihoIJpLer4Bi4xqhQH/JF+3GQj9pb6pXq2s2M=;
        b=EFjVdA+66Y38kCVfbG3obo2I54lmTmPeSTi9BhKTi+yjbihkYbzsvOtQ7BdiojHb1w
         N5GgRwETQ2tCwV1/1ZcVCJvcqZSVroxT1ZCcTzrA/6APY9EKyvmO24QmHfVSvMVSFn6I
         wZ5MQXSuaTrP4dS64571aWqlpOhq67f8TVmhmj+gGo85kB/KYpGfDAwrl6c4khiL2UJm
         t94hp4+mhDdU4OdDmlJASJnIk26tspi+8k2H4Q95CEtz6loXNccnb/Srwu2jIoqo6Oq8
         pC1q0G2+hE6g/v12FBwth+U246vcaQs0hydfN8DaT4CR1dO0qoWvBWnb1XIEouMsRaH7
         GeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5nDa8ihoIJpLer4Bi4xqhQH/JF+3GQj9pb6pXq2s2M=;
        b=NPe/nDYLuYBDKko4zCyNiZ7/fFGDprY9pCRAj8ZNIgo4IyQovKe+Anhw0zrkkWeg38
         Yuz0UGZZTNCsiXCR7u4N3Z/g9UhS0S7z7vX+OEVXBITknhwCxlPHlM6NR96G2bZXOUB2
         jomk5kzLgsc2II2WiVJjEhw7z7hM+MqcUNg6gsLFq+qa2vlK5tnGPxXBjUcvH6uwQ9+I
         sI8ZtADZ7zFncYI79xOX5iaI6zrcPE/4uEWrzB52xUf6TOK0dhll3qeV+VeydnNRiGqp
         qqN8rbxL2haJuytjCjY0+u+/DaEfAQLpQCV9CMIb9ijA5I/UBwSOu9CPvkwBDCkh3/7Y
         zinQ==
X-Gm-Message-State: AOAM532yIuRVIk1bKUrj0XLBpg5X94Cg4+BsVEl8CEbfKYArW1soxdHX
        Id8FfyPXfde0G/DjJ5V9zmuMVw==
X-Google-Smtp-Source: ABdhPJyv21Rrqt1I5WnTtlf1VxWzLnlaeMxTsJXoeYHTmv9Ql+lPIC/YchmdSvEayNHi9Xzjxuywig==
X-Received: by 2002:a63:1542:: with SMTP id 2mr7671663pgv.338.1614935764899;
        Fri, 05 Mar 2021 01:16:04 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:a46:9050:1f13:4024])
        by smtp.gmail.com with ESMTPSA id o11sm1701106pjg.41.2021.03.05.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:16:04 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] clocksource/drivers: fix typo in timer-pistachio
Date:   Fri,  5 Mar 2021 01:03:17 -0800
Message-Id: <20210305090315.384547-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial typo, rename local variable from 'overflw' to 'overflow' in
pistachio_clocksource_read_cycles().

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/clocksource/timer-pistachio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index a2dd85d0c1d7..6f37181a8c63 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -71,7 +71,7 @@ static u64 notrace
 pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflw;
+	u32 counter, overflow;
 	unsigned long flags;
 
 	/*
@@ -80,7 +80,7 @@ pistachio_clocksource_read_cycles(struct clocksource *cs)
 	 */
 
 	raw_spin_lock_irqsave(&pcs->lock, flags);
-	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
 	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
 	raw_spin_unlock_irqrestore(&pcs->lock, flags);
 
-- 
2.27.0


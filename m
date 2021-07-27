Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53BB3D81AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhG0VVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhG0VVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B5C0619EA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:19:38 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r6so399051ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3uz0iVJxizzXZ9+aams9EiglAvKImvZjcrox/hrMaU=;
        b=XTQ7C3gQQt6VjfMHy9T420taCAaoshrC5lHVT9RchXvxeScTEKZH0dnecJm8ALnfe2
         dWzyEreWASw+jAndnwiMj0oryVOhWIksXgV/b6qMv39Q8kHDFKCHLVo0bCKH+kxsNUYt
         xskGhYjF7daJXpA3VSqBh/xb9yCrsLibAbxjp+MMhdFefgIr7AdNYh408rIs8j/5+V+1
         /rOPP7408dAub30ROjJSDaKYzwOr0QNVCX17hB31N40jSO2IUOBqaviUh+ULjJ8r0pzA
         vfBriODCNw8xO4foskaHthcq7x9Wx5CK0LTNZmDS5UMpplpZY4KozS6peWVLFKxEnxPm
         YiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3uz0iVJxizzXZ9+aams9EiglAvKImvZjcrox/hrMaU=;
        b=X8Tq41+mZUWKzxKDb8culy3NV6g8kmlAXJbMwVVGNE/u/WDtgGuci1uBW/Fztm2EYd
         FsLDtQDtR64PX1Kdo4/ijNxcuB3LWlDs14St0An3q7pJbzgbIc3ysUOKvQYqbfZF5BgB
         KJELnFQDa2taQCHRiyVuBseZL/L1xn2Yf1hf+qqr19d4uINIjLHhbn6m5KsSvzODLx0d
         jMlAQ6TFynT2Sy65zw6uV4EVa7qKnYnflgJRB/eJQE8wRumOpXPT/N2Vs+W2XAB/MeYn
         Y8VX37TZ3Q41YTk0JKBJm/GWu6/UoFpbVmyxW3u0rjsdJx8V2LeNv0OLGk8t95+qKTY7
         duIg==
X-Gm-Message-State: AOAM532IyVV4VcML2o1R6I0fJXBlG1d2LIeNqWujO8h6wP8cbLfYCLDH
        iS3cemFFl2ItY2x//1Ocf7Lsvw==
X-Google-Smtp-Source: ABdhPJynK/LpgSxWe6jlE0oVPlVXdTVfm+2AOr1cHIjf4XPzk8cS+yQBaktxh2wvpFtwwVR2Z9hPRw==
X-Received: by 2002:a6b:6310:: with SMTP id p16mr20276050iog.148.1627420777830;
        Tue, 27 Jul 2021 14:19:37 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s21sm3136068iot.33.2021.07.27.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:37 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: get another clock for ipa_setup()
Date:   Tue, 27 Jul 2021 16:19:30 -0500
Message-Id: <20210727211933.926593-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727211933.926593-1-elder@linaro.org>
References: <20210727211933.926593-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two places call ipa_setup().  The first, ipa_probe(), holds an IPA
clock reference when calling ipa_setup() (if the AP is responsible
for IPA firmware loading).  But if the modem is loading IPA
firmware, ipa_smp2p_modem_setup_ready_isr() calls ipa_setup() after
the modem has signaled the hardware is ready.  This can happen at
any time, and there is no guarantee the hardware is active.

Have ipa_smp2p_modem_setup() take an IPA clock reference before it
calls ipa_setup(), and release it once setup is complete.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_smp2p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 93270e50b6b35..0d15438a79e2d 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -156,11 +156,16 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 	if (!smp2p->disabled) {
 		int ret;
 
+		/* The clock needs to be active for setup */
+		ipa_clock_get(smp2p->ipa);
+
 		ret = ipa_setup(smp2p->ipa);
 		if (ret)
 			dev_err(&smp2p->ipa->pdev->dev,
 				"error %d from ipa_setup()\n", ret);
 		smp2p->disabled = true;
+
+		ipa_clock_put(smp2p->ipa);
 	}
 
 	mutex_unlock(&smp2p->mutex);
-- 
2.27.0


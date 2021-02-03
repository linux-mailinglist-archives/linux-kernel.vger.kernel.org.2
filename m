Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB530DE42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhBCPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhBCP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:29:45 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC3C061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:29:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u20so11548333iot.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhwlK/0Dz6i4rhS6CqV6gw/YDZHe+oacHIsDYWLXy98=;
        b=jMZs86uVyvZ/BUdRF50YnogWNWfr84cD8rDT5RKFqR/Z1eu/C7fSq1YMvVGkWgplOd
         wAcghBWHu84bvcOXKk+/sZmV0ItuVTH/bRH+UV+koNY4C2ksxWpTJFugcfmLnZlU6rr5
         qgMbhF0495K9ItQEE3vGMDGHhEt7aGaEvt0hw6JCSrGGWD98b7MIRgI0qYsJavti2nat
         PRIk3SHfbMV89F6W9cwLbD2eYBhQ4c7hf04gWfxJRzUTGIhqBdZ2BF2U2q8K6zCZUJPo
         fq6qG1AiNXZ+tsYfuujwfk41jIcCrDt6XATZl9Y2l9U6wqSOjjIzghe47X53YwKh8olh
         3xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhwlK/0Dz6i4rhS6CqV6gw/YDZHe+oacHIsDYWLXy98=;
        b=PnIE8v06Bxo3Yrd757SYA7JGjyT7Pi2HHSsgBeQTP9m8sMG1SAKUooZo+bG2SFGzNP
         PlfUC7tGQurQM57OhERH9fOv/ZmP9ASQ3mayBLjVGWkC94k+U2KAPp7W7IWGbGqZVAkD
         7F40dAeqa+3PK9W1GZWIaSn+c/6HmvPUCrUexv8utLRirM7420o4CBDZ72g1fQCkCUn5
         dhLiHXwJ/Vz3+RN/8OTO0csqTWdswa1xxXa9dYAiLS5c4EjDPPJP8cmjlLqxOUczXE6r
         34v07UvAVXv45Tts37QWoHCdeH94DEPa0XbaNYC1SSVX4724LQq1btJFzMivGR7GsCeq
         TK+Q==
X-Gm-Message-State: AOAM532wbDsamhbIy6WND+KPt27U3US6lGr5ML6G6Xc8foIMvk6qavPi
        6ln8U2Xd21yz13qN+bcJdkvnbw==
X-Google-Smtp-Source: ABdhPJznmQp/8oNQh/yQFUjES5HS0W1g4rv4rgBKTEIWj0Yy6ie9Y+mUiEoRWXoUFEF4AjyGeao7Pw==
X-Received: by 2002:a02:c909:: with SMTP id t9mr3431290jao.125.1612366144556;
        Wed, 03 Feb 2021 07:29:04 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a15sm1119774ilb.11.2021.02.03.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:29:03 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] net: ipa: remove two unused register definitions
Date:   Wed,  3 Feb 2021 09:28:52 -0600
Message-Id: <20210203152855.11866-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203152855.11866-1-elder@linaro.org>
References: <20210203152855.11866-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not support inter-EE channel or event ring commands.  Inter-EE
interrupts are disabled (and never re-enabled) for all channels and
event rings, so we have no need for the GSI registers that clear
those interrupt conditions.  So remove their definitions.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_reg.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index 0e138bbd82053..299456e70f286 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -59,16 +59,6 @@
 #define GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(ee) \
 			(0x0000c01c + 0x1000 * (ee))
 
-#define GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFSET \
-			GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(ee) \
-			(0x0000c028 + 0x1000 * (ee))
-
-#define GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFSET \
-			GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
-#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(ee) \
-			(0x0000c02c + 0x1000 * (ee))
-
 #define GSI_CH_C_CNTXT_0_OFFSET(ch) \
 		GSI_EE_N_CH_C_CNTXT_0_OFFSET((ch), GSI_EE_AP)
 #define GSI_EE_N_CH_C_CNTXT_0_OFFSET(ch, ee) \
-- 
2.20.1


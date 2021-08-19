Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE473F22F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhHSWUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhHSWUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:20:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E12C061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:19:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f15so7508303ilk.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ea8eXEbDTB/SYuwLfJzfxPyqpl/zzxI98JJtyMRIl0g=;
        b=NX0uCRmEc5Mf/VMVLJ+z+Yi0o1okcxJUsxP2tdna0aw8TEipSFiRlPYHDDxKAFCf5b
         fky+zSOwG4xyWSs2eGqhpED7JwoyagSETLHc0jAu+hrh6cNZmhKmqzAQqJIr+d78D6Km
         KnQKA4ENrY/EwsLdkag3hSKUxObD/kVYcnjPN0DmL1LUQgDc5Waj/ab+y7ti4u35g3ET
         wPPgtUJ0uCQXPLNmrarV6cre91JbWsKOyD7Fix3Qr13MfHO4vsFTytrBNvH+sAY1+pGs
         2AZCxxqQqL7TAtBq5WJg1iZ0zNfv2nS7ZytodKZIw4C4C7bFsKRbiPCn7tIgcFPhMcZ6
         JSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ea8eXEbDTB/SYuwLfJzfxPyqpl/zzxI98JJtyMRIl0g=;
        b=IggygGT0n5Swq3X1q2RFIILcjKyoSNV7ndFftMkhCNNPINw+vqFEHYoZ3V15iBtVrO
         FxnZZuy865xVj9B9G8nbIddAStUNA+fRVDQQBBHzrOnwS7AHCIgRnwrbtexbekWNtM3+
         53aG9MDcUtp0bbR2tpUMAT+985xkBJrgjXlDbzk7Ir/XM746GpI+1xy4d2v8pXO14FjE
         nfjRMNqOJ5EEHCdfwGwB5wFtWZXCox2YaGMA9rlpMm/ggnDbeCLPstL/iaOYkc/JMRHx
         +GcKebq1BAXFNy5elsiH4EUwzFM6vTZA1gZsbNrZqJHNb63Pvb/3HeyZnovx6c2M7+2f
         4S6g==
X-Gm-Message-State: AOAM5319tp5TTcTVSW8G+856ogWAmf9+LsG0Qfsk2SUqY2VfMz4iKPkT
        lW9Xi+w9W6JYogz4140gCNeAig==
X-Google-Smtp-Source: ABdhPJxH4vi3pKeS92yeXqqgNgVHsURldfa+KZ7dyE+oXIE0WVdx8jsMOhfOMYpJYJEbFyq6ieeBsQ==
X-Received: by 2002:a92:5407:: with SMTP id i7mr11931509ilb.264.1629411572397;
        Thu, 19 Aug 2021 15:19:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o15sm2245188ilo.73.2021.08.19.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:19:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: ipa: don't use ipa_clock_get() in "ipa_uc.c"
Date:   Thu, 19 Aug 2021 17:19:25 -0500
Message-Id: <20210819221927.3286267-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210819221927.3286267-1-elder@linaro.org>
References: <20210819221927.3286267-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ipa_clock_get() call in ipa_uc_clock() when taking the
"proxy" clock reference for the microcontroller with a call to
pm_runtime_get_sync().  Replace calls of ipa_clock_put() for the
microcontroller with pm_runtime_put() calls instead.

There is a chance we get an error when taking the microcontroller
power reference.  This is an unlikely scenario, where system suspend
is initiated just before we learn the modem is booting.  For now
we'll just accept that this could occur, and report it if it does.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_uc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 9c8818c390731..a0bdd25b65b4f 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -7,9 +7,9 @@
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "ipa.h"
-#include "ipa_clock.h"
 #include "ipa_uc.h"
 
 /**
@@ -154,7 +154,7 @@ static void ipa_uc_response_hdlr(struct ipa *ipa, enum ipa_irq_id irq_id)
 	case IPA_UC_RESPONSE_INIT_COMPLETED:
 		if (ipa->uc_clocked) {
 			ipa->uc_loaded = true;
-			(void)ipa_clock_put(ipa);
+			(void)pm_runtime_put(dev);
 			ipa->uc_clocked = false;
 		} else {
 			dev_warn(dev, "unexpected init_completed response\n");
@@ -182,25 +182,29 @@ void ipa_uc_deconfig(struct ipa *ipa)
 	ipa_interrupt_remove(ipa->interrupt, IPA_IRQ_UC_1);
 	ipa_interrupt_remove(ipa->interrupt, IPA_IRQ_UC_0);
 	if (ipa->uc_clocked)
-		(void)ipa_clock_put(ipa);
+		(void)pm_runtime_put(&ipa->pdev->dev);
 }
 
 /* Take a proxy clock reference for the microcontroller */
 void ipa_uc_clock(struct ipa *ipa)
 {
 	static bool already;
+	struct device *dev;
 	int ret;
 
 	if (already)
 		return;
 	already = true;		/* Only do this on first boot */
 
-	/* This clock reference dropped in ipa_uc_response_hdlr() above */
-	ret = ipa_clock_get(ipa);
-	if (WARN(ret < 0, "error %d getting proxy clock\n", ret))
-		(void)ipa_clock_put(ipa);
-
-	ipa->uc_clocked = ret >= 0;
+	/* This power reference dropped in ipa_uc_response_hdlr() above */
+	dev = &ipa->pdev->dev;
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		dev_err(dev, "error %d getting proxy power\n", ret);
+	} else {
+		ipa->uc_clocked = true;
+	}
 }
 
 /* Send a command to the microcontroller */
-- 
2.27.0


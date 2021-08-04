Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1983E0454
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhHDPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbhHDPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFCC06179A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:33 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c3so2045109ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qj5hg+/X071K3Vl+DCzlvkxK2DWvvHHp1jaLOqDGaMc=;
        b=p3DO1aCy81oCCZ6k0rsXq2geBf1UsmLcb09uL/xh/3AqDk4MpjWo8/6txzU+r0RDp7
         lUGvI14uMErll9NdUymXrDv+XbuDz+Ol4dTb4HKP6f9Yh/BfCgqmBTOUOpl3XrYBaFrm
         JfrjnqxYUsXU7pDMdviqwN+oqPpwFaXqIXOHbg3nDnDO1G3x28hP0wlNyzt8Lo3UVIi4
         ZEurnEeTU0Lr1XtJo2N20aHp5zk+Mm0wfL9kNvf9iVx2H6LpxipJXJPGDdd9/s/OYwDv
         J8IRRHSSpVj3gwLAwYkVfWi/1W0DLG93GZvJVrAtaj6Krn+FY4DMInzY06bF9O89amID
         tA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qj5hg+/X071K3Vl+DCzlvkxK2DWvvHHp1jaLOqDGaMc=;
        b=KLjESbzEMtltvpeTeRIEpM3PnEdxrrOtMzkyT9muDbAkSlOnjoqS7Mg5ci1eZ7FHGU
         jxE+FGz3cxNauEQSBgssX+OF+ctqqpGolyMVbhuAfVo7Zgk521nUeH/WJE0ABQ9fdK8y
         fLD1xqe+X0LNtyGvJJv1i5LdHSp1usw/HgCzMhAO4PN79XZzkPtYc0srHFl+Rg9HWI7T
         6/DwvTc9g2NlZBZ6Wvm7HVR2bsxGPjqhnQD2ZNdKAC/BbYg/KEyKNduuxzt2ifYmwFap
         R72R11A2nDs5R6fvHheHeBVcDFPUJLLK8XGkReE/xplNrRmevSEx0c00HU52Q+1OoE+4
         P1sw==
X-Gm-Message-State: AOAM532n3HOhRhizF0XfW267J8wCZphT1vlDgakArIts2SB/OdNfBIh2
        lmPzpRnnT0mQhtpKWJPi4vw+kA==
X-Google-Smtp-Source: ABdhPJwQCFmcmsU6JBdqBNiXQawokVykvnRcKuRrV6dZKcX5j9DLJHc0wzmgEit55eCl86fWDfAExg==
X-Received: by 2002:a92:cd41:: with SMTP id v1mr225635ilq.212.1628091393090;
        Wed, 04 Aug 2021 08:36:33 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: ipa: move IPA power operations to ipa_clock.c
Date:   Wed,  4 Aug 2021 10:36:24 -0500
Message-Id: <20210804153626.1549001-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804153626.1549001-1-elder@linaro.org>
References: <20210804153626.1549001-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ipa_suspend() and ipa_resume(), as well as the definition of
the ipa_pm_ops structure into "ipa_clock.c".  Make ipa_pm_ops public
and declare it as extern in "ipa_clock.h".

This is part of centralizing IPA power management functionality into
"ipa_clock.c" (the file will eventually get a name change).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 62 +++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_clock.h |  3 ++
 drivers/net/ipa/ipa_main.c  | 59 -----------------------------------
 3 files changed, 65 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 849b6ec671a4d..475ea6318cdb2 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -9,9 +9,12 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
 
 #include "ipa.h"
 #include "ipa_clock.h"
+#include "ipa_endpoint.h"
 #include "ipa_modem.h"
 #include "ipa_data.h"
 
@@ -334,3 +337,62 @@ void ipa_clock_exit(struct ipa_clock *clock)
 	kfree(clock);
 	clk_put(clk);
 }
+
+/**
+ * ipa_suspend() - Power management system suspend callback
+ * @dev:	IPA device structure
+ *
+ * Return:	Always returns zero
+ *
+ * Called by the PM framework when a system suspend operation is invoked.
+ * Suspends endpoints and releases the clock reference held to keep
+ * the IPA clock running until this point.
+ */
+static int ipa_suspend(struct device *dev)
+{
+	struct ipa *ipa = dev_get_drvdata(dev);
+
+	/* Endpoints aren't usable until setup is complete */
+	if (ipa->setup_complete) {
+		__clear_bit(IPA_FLAG_RESUMED, ipa->flags);
+		ipa_endpoint_suspend(ipa);
+		gsi_suspend(&ipa->gsi);
+	}
+
+	ipa_clock_put(ipa);
+
+	return 0;
+}
+
+/**
+ * ipa_resume() - Power management system resume callback
+ * @dev:	IPA device structure
+ *
+ * Return:	Always returns 0
+ *
+ * Called by the PM framework when a system resume operation is invoked.
+ * Takes an IPA clock reference to keep the clock running until suspend,
+ * and resumes endpoints.
+ */
+static int ipa_resume(struct device *dev)
+{
+	struct ipa *ipa = dev_get_drvdata(dev);
+
+	/* This clock reference will keep the IPA out of suspend
+	 * until we get a power management suspend request.
+	 */
+	ipa_clock_get(ipa);
+
+	/* Endpoints aren't usable until setup is complete */
+	if (ipa->setup_complete) {
+		gsi_resume(&ipa->gsi);
+		ipa_endpoint_resume(ipa);
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops ipa_pm_ops = {
+	.suspend	= ipa_suspend,
+	.resume		= ipa_resume,
+};
diff --git a/drivers/net/ipa/ipa_clock.h b/drivers/net/ipa/ipa_clock.h
index 1fe634760e59d..2f0310d5709ca 100644
--- a/drivers/net/ipa/ipa_clock.h
+++ b/drivers/net/ipa/ipa_clock.h
@@ -11,6 +11,9 @@ struct device;
 struct ipa;
 struct ipa_clock_data;
 
+/* IPA device power management function block */
+extern const struct dev_pm_ops ipa_pm_ops;
+
 /**
  * ipa_clock_rate() - Return the current IPA core clock rate
  * @ipa:	IPA structure
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index ae51109dea01b..28350b7c50c56 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -874,65 +874,6 @@ static void ipa_shutdown(struct platform_device *pdev)
 		dev_err(&pdev->dev, "shutdown: remove returned %d\n", ret);
 }
 
-/**
- * ipa_suspend() - Power management system suspend callback
- * @dev:	IPA device structure
- *
- * Return:	Always returns zero
- *
- * Called by the PM framework when a system suspend operation is invoked.
- * Suspends endpoints and releases the clock reference held to keep
- * the IPA clock running until this point.
- */
-static int ipa_suspend(struct device *dev)
-{
-	struct ipa *ipa = dev_get_drvdata(dev);
-
-	/* Endpoints aren't usable until setup is complete */
-	if (ipa->setup_complete) {
-		__clear_bit(IPA_FLAG_RESUMED, ipa->flags);
-		ipa_endpoint_suspend(ipa);
-		gsi_suspend(&ipa->gsi);
-	}
-
-	ipa_clock_put(ipa);
-
-	return 0;
-}
-
-/**
- * ipa_resume() - Power management system resume callback
- * @dev:	IPA device structure
- *
- * Return:	Always returns 0
- *
- * Called by the PM framework when a system resume operation is invoked.
- * Takes an IPA clock reference to keep the clock running until suspend,
- * and resumes endpoints.
- */
-static int ipa_resume(struct device *dev)
-{
-	struct ipa *ipa = dev_get_drvdata(dev);
-
-	/* This clock reference will keep the IPA out of suspend
-	 * until we get a power management suspend request.
-	 */
-	ipa_clock_get(ipa);
-
-	/* Endpoints aren't usable until setup is complete */
-	if (ipa->setup_complete) {
-		gsi_resume(&ipa->gsi);
-		ipa_endpoint_resume(ipa);
-	}
-
-	return 0;
-}
-
-static const struct dev_pm_ops ipa_pm_ops = {
-	.suspend	= ipa_suspend,
-	.resume		= ipa_resume,
-};
-
 static const struct attribute_group *ipa_attribute_groups[] = {
 	&ipa_attribute_group,
 	&ipa_feature_attribute_group,
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BC3E0450
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhHDPg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbhHDPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66DC06179C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m13so2868735iol.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHFa5uneH1vgnhwjmwIiYRoaj+badEIlp+PqhNvxBfY=;
        b=NbPemvyST8+o1EEm6g4AUqDNA4UOkufttCTvpmuvtoVSMvYMu33Xd9J/W6BQwhExRk
         cr6tmnNkQBVa5ORry17OcdY9xMAau76uDk5m5h6nWFOakKuwbX+fuOWgsTc3D7qdK6Pu
         OjWZOma8TSuQhuk2gXySr2+x06PqiAiNWQdktNeybjJ+c6TDcWUbQovRwldz/OPC9cOQ
         mtsXC09pZyFu5RrIDYPjLEWmOtv4jGuRomrLfPcUgyKD/ZlMxGrSSEbI5SX6iUvJX6Ka
         3T+voiuaSJthEOqVLQy/TLpgC3cWaw+DCw/PEFBswjB1x99w5zifGP7dE7Rm0P8P34aF
         1e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHFa5uneH1vgnhwjmwIiYRoaj+badEIlp+PqhNvxBfY=;
        b=B0RVjH7n0jEFim5CVcRgkM010zmOAKjhSdlB4cm6EE88FVIbx6EHSUYatWqo6Ph6kA
         SFqJn1cU3eiQUtlWCjcFjdTVtCBLa08icRtLr2sK4eBt/pEYqyc6+6Eos5WTu2NVbQET
         KVIZpCYaX3MzyF2FC0oHHGlVR5blLyIN5m/GrPePUJtoY3xy1EUwozjhTB6FRH6ou4fG
         90925To3xlmvd6ZR2NKmyeKHZy1WzGwOmA4f6+r0oYkyMAtUU6I3qRtQV5uqhk5PPkhF
         iTp1+3yGO+RVhliKABUQzAy5gBdNzI3sTZyOv78f31847+sPZ72rOfNqFXKLf7cuFDa0
         DbQQ==
X-Gm-Message-State: AOAM532+i54n0I7RHxkKDMP4jhsne2+1XRXuW6imsbXrNVrdDvfWstZG
        g6JqKYyQ4/Flc5bKcgoPM5R2HA==
X-Google-Smtp-Source: ABdhPJyGK9nAp6yitWYvBXlJg5Pf++WJSVN5DwWCgY98JKpNt+pT2bVX6ZHyRxC8duvoYpFWpZ5yHA==
X-Received: by 2002:a5e:9747:: with SMTP id h7mr789038ioq.92.1628091394745;
        Wed, 04 Aug 2021 08:36:34 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:34 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: ipa: move IPA flags field
Date:   Wed,  4 Aug 2021 10:36:26 -0500
Message-Id: <20210804153626.1549001-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804153626.1549001-1-elder@linaro.org>
References: <20210804153626.1549001-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipa->flags field is only ever used in "ipa_clock.c", related to
suspend/resume activity.

Move the definition of the ipa_flag enumerated type to "ipa_clock.c".
And move the flags field from the ipa structure and to the ipa_clock
structure.  Rename the type and its values to include "power" or
"POWER" in the name.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa.h       | 12 ------------
 drivers/net/ipa/ipa_clock.c | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 71ba996096bb9..34152fe02963d 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -27,20 +27,9 @@ struct ipa_clock;
 struct ipa_smp2p;
 struct ipa_interrupt;
 
-/**
- * enum ipa_flag - IPA state flags
- * @IPA_FLAG_RESUMED:	Whether resume from suspend has been signaled
- * @IPA_FLAG_COUNT:	Number of defined IPA flags
- */
-enum ipa_flag {
-	IPA_FLAG_RESUMED,
-	IPA_FLAG_COUNT,		/* Last; not a flag */
-};
-
 /**
  * struct ipa - IPA information
  * @gsi:		Embedded GSI structure
- * @flags:		Boolean state flags
  * @version:		IPA hardware version
  * @pdev:		Platform device
  * @completion:		Used to signal pipeline clear transfer complete
@@ -83,7 +72,6 @@ enum ipa_flag {
  */
 struct ipa {
 	struct gsi gsi;
-	DECLARE_BITMAP(flags, IPA_FLAG_COUNT);
 	enum ipa_version version;
 	struct platform_device *pdev;
 	struct completion completion;
diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 9e77d4854fe03..a67b6136e3c01 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -45,11 +45,22 @@ struct ipa_interconnect {
 	u32 peak_bandwidth;
 };
 
+/**
+ * enum ipa_power_flag - IPA power flags
+ * @IPA_POWER_FLAG_RESUMED:	Whether resume from suspend has been signaled
+ * @IPA_POWER_FLAG_COUNT:	Number of defined power flags
+ */
+enum ipa_power_flag {
+	IPA_POWER_FLAG_RESUMED,
+	IPA_POWER_FLAG_COUNT,		/* Last; not a flag */
+};
+
 /**
  * struct ipa_clock - IPA clocking information
  * @count:		Clocking reference count
  * @mutex:		Protects clock enable/disable
  * @core:		IPA core clock
+ * @flags:		Boolean state flags
  * @interconnect_count:	Number of elements in interconnect[]
  * @interconnect:	Interconnect array
  */
@@ -57,6 +68,7 @@ struct ipa_clock {
 	refcount_t count;
 	struct mutex mutex; /* protects clock enable/disable */
 	struct clk *core;
+	DECLARE_BITMAP(flags, IPA_POWER_FLAG_COUNT);
 	u32 interconnect_count;
 	struct ipa_interconnect *interconnect;
 };
@@ -295,7 +307,7 @@ static void ipa_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	 * More than one endpoint could signal this; if so, ignore
 	 * all but the first.
 	 */
-	if (!test_and_set_bit(IPA_FLAG_RESUMED, ipa->flags))
+	if (!test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->clock->flags))
 		pm_wakeup_dev_event(&ipa->pdev->dev, 0, true);
 
 	/* Acknowledge/clear the suspend interrupt on all endpoints */
@@ -388,7 +400,7 @@ static int ipa_suspend(struct device *dev)
 
 	/* Endpoints aren't usable until setup is complete */
 	if (ipa->setup_complete) {
-		__clear_bit(IPA_FLAG_RESUMED, ipa->flags);
+		__clear_bit(IPA_POWER_FLAG_RESUMED, ipa->clock->flags);
 		ipa_endpoint_suspend(ipa);
 		gsi_suspend(&ipa->gsi);
 	}
-- 
2.27.0


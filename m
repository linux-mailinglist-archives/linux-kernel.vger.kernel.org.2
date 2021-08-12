Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF23EAB50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhHLTvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhHLTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:51:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41AC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:50:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x7so8278707ilh.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykKBXMHcKlze21MzZB0cs6PrhHYH3qk79ar7nof85s0=;
        b=l/aqAk+WNRToSdjo2CK40zg+wckqOyG7PwGgkUPgMKFA1FHo2wYIQVDlGX4Y83H4a0
         x/OOo7oVfDiYJj690UK3Ysd9QUV2O1GEn+Kamyd7Sr5+ahn5Vq3VVqRJ6l6Cy4FhMeNl
         vin/3Y8SoX9vUxVJB0DA/3kZfwMfBRDhK5599555gcsaKa+XEqnqmLdAKy1toBNWdU3M
         QxbKkC2Aklg1M89GfEwV1NBGZEmRVl4nekGL5S+pizYn6Vty0cqJDr0EJgO67NfbFxD6
         U7qxc76v2yIBy7cpR5bphvyDZg5q6KKCPAtx+ZCMpARSpUD3i5dKYeMx1R+JcHG9/kG2
         FYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykKBXMHcKlze21MzZB0cs6PrhHYH3qk79ar7nof85s0=;
        b=Fe5P7ynr+a2lQMG+3jMREyv0OKpuFU8qdeyVuWKTDTTln/7k6ShBo3oFa2Y6QH4akl
         EKEe/VnziFM1oFt++S58WWIXJC+jrm+MMF6IQEiaXFvnhld9zuaHcc2hJbGg1NSg1eLo
         hUXargPFOovPbu4j8jOlEY4z37pFd4Sowcc2HdqEthYnMnkUvuI5OMR9vt90VOyTe3wy
         Naq3nj9QWuNmbHuvjLG4JGhKFiBtVRtqMQJ88ZXjv8QZuA+P8PMsmNx9A1sjeiE2guYD
         8kpKwpURygZwhvkkr6wireNHUjjwJi3na0V7Zu9ILatczbwm+9Sz/dUkxHuB1k2tvSxD
         zbkQ==
X-Gm-Message-State: AOAM5333B1okvKf/2UmdL8bNXaFMv2BN6C6RQxUw38tKwyijMZQeYEiV
        kAO1D0WuCk/B/YvTtdgw7hGSLw==
X-Google-Smtp-Source: ABdhPJysLYOPsJaWOzNVC5xd4HfO+kBQL7NgT9cXcN2k29h3lzN5uyR1I2C8Fu26PAeW5yElk3j71w==
X-Received: by 2002:a05:6e02:d09:: with SMTP id g9mr187795ilj.153.1628797839417;
        Thu, 12 Aug 2021 12:50:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s16sm2058821iln.5.2021.08.12.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 12:50:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: ipa: enable wakeup in ipa_power_setup()
Date:   Thu, 12 Aug 2021 14:50:30 -0500
Message-Id: <20210812195035.2816276-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210812195035.2816276-1-elder@linaro.org>
References: <20210812195035.2816276-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to enable the IPA interrupt as a wakeup interrupt into
ipa_power_setup(), disable it in ipa_power_teardown().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 11 ++++++++++-
 drivers/net/ipa/ipa_clock.h |  4 +++-
 drivers/net/ipa/ipa_main.c  |  6 +-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 6df66c574d594..cdbaba6618e9e 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -310,14 +310,23 @@ static void ipa_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
 }
 
-void ipa_power_setup(struct ipa *ipa)
+int ipa_power_setup(struct ipa *ipa)
 {
+	int ret;
+
 	ipa_interrupt_add(ipa->interrupt, IPA_IRQ_TX_SUSPEND,
 			  ipa_suspend_handler);
+
+	ret = device_init_wakeup(&ipa->pdev->dev, true);
+	if (ret)
+		ipa_interrupt_remove(ipa->interrupt, IPA_IRQ_TX_SUSPEND);
+
+	return ret;
 }
 
 void ipa_power_teardown(struct ipa *ipa)
 {
+	(void)device_init_wakeup(&ipa->pdev->dev, false);
 	ipa_interrupt_remove(ipa->interrupt, IPA_IRQ_TX_SUSPEND);
 }
 
diff --git a/drivers/net/ipa/ipa_clock.h b/drivers/net/ipa/ipa_clock.h
index 5c118f2c42e7a..5c53241336a1a 100644
--- a/drivers/net/ipa/ipa_clock.h
+++ b/drivers/net/ipa/ipa_clock.h
@@ -25,8 +25,10 @@ u32 ipa_clock_rate(struct ipa *ipa);
 /**
  * ipa_power_setup() - Set up IPA power management
  * @ipa:	IPA pointer
+ *
+ * Return:	0 if successful, or a negative error code
  */
-void ipa_power_setup(struct ipa *ipa);
+int ipa_power_setup(struct ipa *ipa);
 
 /**
  * ipa_power_teardown() - Inverse of ipa_power_setup()
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index f332210ce5354..2f8ef831fa213 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -101,9 +101,7 @@ int ipa_setup(struct ipa *ipa)
 	if (ret)
 		return ret;
 
-	ipa_power_setup(ipa);
-
-	ret = device_init_wakeup(dev, true);
+	ret = ipa_power_setup(ipa);
 	if (ret)
 		goto err_gsi_teardown;
 
@@ -154,7 +152,6 @@ int ipa_setup(struct ipa *ipa)
 err_endpoint_teardown:
 	ipa_endpoint_teardown(ipa);
 	ipa_power_teardown(ipa);
-	(void)device_init_wakeup(dev, false);
 err_gsi_teardown:
 	gsi_teardown(&ipa->gsi);
 
@@ -181,7 +178,6 @@ static void ipa_teardown(struct ipa *ipa)
 	ipa_endpoint_disable_one(command_endpoint);
 	ipa_endpoint_teardown(ipa);
 	ipa_power_teardown(ipa);
-	(void)device_init_wakeup(&ipa->pdev->dev, false);
 	gsi_teardown(&ipa->gsi);
 }
 
-- 
2.27.0


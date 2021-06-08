Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514539F198
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFHJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFHJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:05:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 02:03:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z22so10067975ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnFHa21pMNW2jSUA5XLazyeCEAKZE26JFLYB4VhYyNQ=;
        b=IgmBj3uQF/Drcu204B+VWTFpSeocdqBPPSoxqws7142jumL25Uh5R6+dPP3v0J9iDm
         j5QqH9Ueia7WhFVQ1v7KZarY1H2h/Eq3xB25ZWAf+ABK2kLFWm3LoepZMmcAk1dj7kPJ
         46dqfwubP/ws+WPzvXo9LK6LFtc5lpDs+TabH+uCeUi+C5A0gGRZiLboqtFAWmVkmGVw
         w40ygOPUcdE2e6jgopsgKqAi6jk8FzXRZF/WwTCijJ1nYRib8SmANKg8IVxH+bHIs6Zb
         AGWWja740laEZ6wEwACI96rsf2teqI61gIyrMTRpymTewlClTj3Jq/AD5nJS9cz1cIos
         BYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnFHa21pMNW2jSUA5XLazyeCEAKZE26JFLYB4VhYyNQ=;
        b=hyyscQs/cgpHg1szYkisq7YyZ0BqCeGPz++YrdAmTHIGiKRnmgHfoh7CD1GSPaPHRH
         l4ta3eZ9ewfWr0YqEmBoac8pR9ptfOuOKRpQ9Z5MX4D01m1e+cZyMlpZLWOyYIJVy+Do
         ZqV2PjSV9fIy9hKeXG/x2g4CDv67+byz5VN4AsloKx+Vu8izk0PpelhJIui/DkVVhAow
         Xn9+IPP5cqKv167tKQzvsboF7rFqJPgg84aN7W7AVWt6IMLJveM+EvNS63KkR2U6LgHj
         rXvTB+BfLsfSDHd8YIsWsiEndhG66ZFfntim4qVv5GY6auCfb/53iJEoyqNQ+MIzLwle
         LkQQ==
X-Gm-Message-State: AOAM532crGYkepSKmLn9Cs9D8NOJWlZWk2ThWD3YcF3zs+mUZK9IGLfE
        pP3n6zOFrSg7TL5uGvCijZrcLA==
X-Google-Smtp-Source: ABdhPJwI7y00opt25k6XFPvLGoi/PJ+2CRkZfM2+49l59Hp/hIZD5O6F5RgnDnBcP7p2eJIkt8skQg==
X-Received: by 2002:a05:651c:1138:: with SMTP id e24mr17675880ljo.403.1623142986144;
        Tue, 08 Jun 2021 02:03:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PM: runtime: Allow unassigned ->runtime_suspend|resume callbacks
Date:   Tue,  8 Jun 2021 11:02:49 +0200
Message-Id: <20210608090250.85256-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608090250.85256-1-ulf.hansson@linaro.org>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently allowing ->runtime_idle() callbacks to be unassigned
without returning an error code from rpm_idle(). This has been useful to
avoid boilerplate code in drivers. Let's take this approach a step further,
by allowing also unassigned ->runtime_suspend|resume() callbacks.

In this way, a consumer/supplier device link can be used to let a consumer
device be power managed through its supplier device, without requiring
assigned ->runtime_suspend|resume() callbacks for the consumer device, for
example.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Small updates to commit message.

---
 drivers/base/power/runtime.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 68bebbf81347..8a66eaf731e4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -345,7 +345,7 @@ static void rpm_suspend_suppliers(struct device *dev)
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval, idx;
+	int retval = 0, idx;
 	bool use_links = dev->power.links_count > 0;
 
 	if (dev->power.irq_safe) {
@@ -373,7 +373,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 		}
 	}
 
-	retval = cb(dev);
+	if (cb)
+		retval = cb(dev);
 
 	if (dev->power.irq_safe) {
 		spin_lock(&dev->power.lock);
@@ -484,9 +485,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 {
 	int retval;
 
-	if (!cb)
-		return -ENOSYS;
-
 	if (dev->power.memalloc_noio) {
 		unsigned int noio_flag;
 
-- 
2.25.1


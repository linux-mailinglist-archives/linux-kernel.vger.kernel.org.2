Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD484336F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhJSNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbhJSNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:24:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C87C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:22:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so47683501wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyXqSkaflhBOynk4JWAviQc2FGe0plZLbAljyNgc/ec=;
        b=IDuuBE5PJerEEsGkVNmK1+tAQyD4dB+lr9gR+1qkb+lhNgdvXpetUM11Su0KE6R9l+
         L2h27iM+9IOUexOR1P3LHrQ0En/xgYOe9pehIShvJTV7AYDJKIvrCVERAf1nuHnf0dv8
         XJ67alCfJn73ZliZmb3T96DeRp+adqydw85bAJCiTFAzNezJ0o9Lw5uXIRt1LO6H2VHz
         uGNzV/N335T2B9s7CggH+zt43b+f97uqyt8cnAt56nJr/7AsERl1OTffFq+2qUWMA/5T
         WgVParlC3dwhgqwkxjyn97a0Lw1jVzZtDn9xllErJq0kbYFhwiPG/syL181CGG/LXN1j
         R+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyXqSkaflhBOynk4JWAviQc2FGe0plZLbAljyNgc/ec=;
        b=mmjWEGYu1/2gjWIAn4QRn6ZIgZBcOSzBlUEV1n2uoCv4Vwsd/xSWbqWPNUr3H7PAg2
         pG8tinATmPqOB60LLYlltqk9Wko7m0Z8cHmNjHAi6dwnIHz17hBTSLEijo3CJq1j5ddb
         cow0yLMYrSRxXfl80/7Ch5vZdsnlnoMCPLPjDZQoqVkYbnTfNqWCn8a5iSA1gXSEKEPj
         jJshE+g4NdOEMRaFLIdHm94XU70MKMK8Si5u2LftAX7GPWgH7c2YkzK8t/+WmQBU+DnQ
         SwYjG9FKtgmSu2ChLKTB407BdBS5nEGa/M9ftj316iO8j2p4zScWypvnDwcqr06sWjZV
         KEFg==
X-Gm-Message-State: AOAM532LkC5qKoeya87hdw3lRI/TK5D8bKnYVcG+sDXoSKzjUROl3i4k
        0kWFqieuElN4qQi1iCC3ScDwqg==
X-Google-Smtp-Source: ABdhPJw3mH8IQAVcUb7en9F6AMw4ZI56RiK1Hh3nknPOaRj77lWZA8sRkfin940w3x4oYcyYQ0MQDw==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr44624008wrl.276.1634649753408;
        Tue, 19 Oct 2021 06:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.gmail.com with ESMTPSA id n7sm14982426wra.37.2021.10.19.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:22:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 2/2] thermal/core: Make deprecated cooling device state change from userspace
Date:   Tue, 19 Oct 2021 15:22:11 +0200
Message-Id: <20211019132211.2792475-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
References: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling devices have their cooling device set_cur_state
read-writable all the time in the sysfs directory, thus allowing the
userspace to act on it.

The thermal framework is wrongly used by userspace as a power capping
framework by acting on the cooling device opaque state. This one then
competes with the in-kernel governor decision.

We have seen in out-of-tree kernels, a big number of devices which are
abusely declaring themselves as cooling device just to act on their
power.

The role of the thermal framework is to protect the junction
temperature of the silicon. Letting the userspace to play with a
cooling device is wrong and potentially dangerous.

The powercap framework is the right framework to do power capping and
moreover it deals with the aggregation via the dev pm qos.

As the userspace governor is marked deprecated and about to be
removed, there is no point to keep this file writable also in the
future.

Emit a warning and deprecate the interface.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..3f4ea3a283ae 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
+	WARN_ON_ONCE(1, "Setting cooling device state is deprecated\n");
+	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
-- 
2.25.1


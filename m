Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D490453E29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhKQCGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKQCGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:06:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997FBC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:03:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s138so809948pgs.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvd3jTzXB/DRs319D01wGFBaQbcq6WLKKY13sbAJ7xw=;
        b=Gdme63th6UGhgjZrkJ6+vT/7LHFlh9yaVEwwCP+3IE+ckSVnS4zKeMhUJfV7lgMmCN
         1BXVQ9oG4VVhFf+lBmt7OQbLKPvgxXYxFVZf9ZMVbqea/DYDTqw1ktU3ZBzJW3mKbxWe
         9y/O/uCsISirvabA9blRtTKiqNsCYlvLZx2zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvd3jTzXB/DRs319D01wGFBaQbcq6WLKKY13sbAJ7xw=;
        b=cS5U+NC0oV8rzBPJjSbyc6rKrC1p38BYSoingwLQUoFZraobpkJWZE4GBiN5Kx+ZZm
         xfONg1L/RNxwiZDh+zXOztx8ff9rMOncRYlhPO5HErKTazuh6bDGbUvq82ToyCxKEEtT
         koRo6DsYEL4dt4z3r/8EOeAXornjHBzk9efYzGV8r26lK54GIqDbYjdQXs+po7QJ5mTB
         cbjdjV9xRWnMQu32pB3RjzM1QiQp7WnZRv2XnwhJCG7kax2xF84wjh8EOiGd7CN3zgzl
         KDaxlblfpGtlai9h3QG9BsA/aXO4MhAp9+H4nJonSr/w3T2yR6gqKQR85KDqS5Sh4fAP
         fEEA==
X-Gm-Message-State: AOAM530GrX0ATlh6VLy6P6gK62ceoh8PUncFwBrrY/QcsSHgshCKW3fW
        qtcmxhQxMOSevkfhic9q4w3/EFiy0GxAqQ==
X-Google-Smtp-Source: ABdhPJzpWbpbEWPoWC8osMQOghtahDqFjT7VArUcJ6XX3/bploZm9ZEMVTUF6cDj3D/ENk5amUtoCQ==
X-Received: by 2002:aa7:9acc:0:b0:4a2:b8b5:8813 with SMTP id x12-20020aa79acc000000b004a2b8b58813mr3833019pfp.4.1637114628027;
        Tue, 16 Nov 2021 18:03:48 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:47f8:c08f:374a:a54e])
        by smtp.gmail.com with ESMTPSA id h36sm16072370pgb.9.2021.11.16.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:03:47 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: Use optional irq API
Date:   Tue, 16 Nov 2021 18:03:46 -0800
Message-Id: <20211117020346.4088302-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform_get_irq_optional() to avoid a noisy error message when the
irq isn't specified. The irq is definitely optional given that we only
care about errors that are -EPROBE_DEFER here.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a2be0df7e174..b442d4983a22 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -382,9 +382,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 	 * Look for LMh interrupt. If no interrupt line is specified /
 	 * if there is an error, allow cpufreq to be enabled as usual.
 	 */
-	data->throttle_irq = platform_get_irq(pdev, index);
-	if (data->throttle_irq <= 0)
-		return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
+	data->throttle_irq = platform_get_irq_optional(pdev, index);
+	if (data->throttle_irq == -ENXIO)
+		return 0;
+	if (data->throttle_irq < 0)
+		return data->throttle_irq;
 
 	data->cancel_throttle = false;
 	data->policy = policy;

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
https://chromeos.dev


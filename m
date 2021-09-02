Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023073FEBF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhIBKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhIBKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:17:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B162C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:16:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g14so2556330ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZIDc5dNGmZMEuNI+q0RXZg7TDaDyQay2EJwpX2HagA=;
        b=tJEyqv27c0M36cBiuxle+CZcejlnP42BqHYMsy3HH6riiEJsG+YpXDhRCks2ozu/0a
         YuXG3Fxzldz55lhNT71K7+qRshz8IyqqVyz2HmYf9jTDKw0jCy3PgRM96IBxbT8uJCDb
         FQVEoXVjv2YkFdPzs8JyfoTvs9cqJ3lQ7T21yNoEulElXLMqg5O1cNT1JvuikDEN+XGW
         hmX8t8qOEAbSrLsXUqtGNgo0+zISQLbbiCO2S5f/X3qavwykZZwIrxOhKUcfqe0n/Ljl
         YUMPiD+oIuf656o4snFxWRQSvao9oyutvr3Jb/HwWKASY4i/vU8L9O3bhDBhVe6+oxeF
         IdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZIDc5dNGmZMEuNI+q0RXZg7TDaDyQay2EJwpX2HagA=;
        b=aFSk8oHZzqy9ROmn9Izx/zTbZyPo3kvn9LFp6pU1xzZFxQC15UpJK5w2MJTtfJ2iXC
         UPswS77rpkkzdWVDgmS5cYVBhnT34+7o48NkAFBjL7CSw3jhS//Uh1XVSUcpCtNx4x/s
         KEfxd8nlUBP8ap2DmrrBisBQGlSsQrmlEm1EXP1u+ZsQbwe0NMxO+RKK+fqCmWeXEc0m
         xCcoVUMvXx81Sb7IxNZ70/LE2XzEkUTj+NkZV0ZC1R8U8g8BqZjUen1aABpHSMRifpnP
         Uo7SH7NrM/P9Qu/UjA0W3D5+nHSCG6cENT8LFLZ9EAb8dYC8AqtHBGtaEy/ie0oGWcM+
         NTEA==
X-Gm-Message-State: AOAM531+VcRITZHe5i59Ers77+uSrpLT7pHAil1LsfNbWhg4AOtBMaPI
        p8plfPAYEBElx5FcVXuFZCQCQw==
X-Google-Smtp-Source: ABdhPJzNXuvX9XDTeaJ02yQt2BdTC2X0ZlUZgbJYnh+m6n9auTpgMAN6FyCEd7d8q4RZ8DQBiAQ5Aw==
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr1803113ljm.95.1630577800779;
        Thu, 02 Sep 2021 03:16:40 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM: domains: Restructure some code in __genpd_dev_pm_attach()
Date:   Thu,  2 Sep 2021 12:16:33 +0200
Message-Id: <20210902101634.827187-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902101634.827187-1-ulf.hansson@linaro.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To slightly improve readability of the code, but also to prepare for a
subsequent change on top, let's move the code that calls
of_get_required_opp_performance_state() into a new separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 278e040f607f..800adf831cae 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2640,6 +2640,17 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_get_default_performance_state(struct device *dev,
+					       unsigned int index)
+{
+	int pstate = of_get_required_opp_performance_state(dev->of_node, index);
+
+	if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
+		return 0;
+
+	return pstate;
+}
+
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
@@ -2690,8 +2701,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	}
 
 	/* Set the default performance state */
-	pstate = of_get_required_opp_performance_state(dev->of_node, index);
-	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
+	pstate = genpd_get_default_performance_state(dev, index);
+	if (pstate < 0) {
 		ret = pstate;
 		goto err;
 	} else if (pstate > 0) {
-- 
2.25.1


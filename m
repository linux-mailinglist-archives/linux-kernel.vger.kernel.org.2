Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C03E9022
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhHKMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhHKMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:07:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00EFC061798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:06:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so9183204pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZC+FP75mFAQwlcrfkbIZ+KkPc6ZyFBFhH1NecTG31o=;
        b=LkS+DJyCHnMxf56bNqFv4JSdLFaYjYrHiVV7mc3191cjFeYU3wHMqGpRM4gdjWsoAp
         MQJ4C/itAshvVXwGwO0e3Z2SG1ympyGA4sHg5fcQuGy769EMvr48vlOXEDlps+AMmvob
         2bTZAOPXVOSz7g8rruXoulxOthp3RA6tJlmz9SJLfipbJTG226hE+c+VVrzYKhZypikQ
         I5OU4VJ3PEwx0lqwyHjDNO9EoYf8i6Krx/tylt0uhBBd4eCiVZha55T4ptkfiWUxRe6E
         nQOTmEUtmsGA+4cjv2I6J7D3TKxjHdMSkKn3iu0fUmY+nlCfnYG0zRgwcFR3496FyTfu
         b0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZC+FP75mFAQwlcrfkbIZ+KkPc6ZyFBFhH1NecTG31o=;
        b=ICUqycV9vpGDpdGKaq0GGS+DYjbEs8rkTIYIRze4UzhTqpWEEhhElKipYDWKuKhwG3
         ngByYjIxrskarJ12FcomuWLhhO8uemIZcigM9HPHCEhhpWFlTAwzCqTK0qGURltEfjPH
         AFKacSmeKG0oLEGOl1U6BqxDFWoft5jfAaPTI7Oyy9NDvBgxKZr2z9Aj0iJ8EXTZ5zqo
         Zlsyph1i7ekKu03EaNGdbUdXNVflK9Va8tQ3IO4awBAdBVkGS/6VZyDjotNuKCaebUgY
         DBo10fj95nL8ER/tK823gda/ZoxuTeZeIZX6Wp70AslTxXpnDVybMJym2sdYmHmbrPIW
         Uf0g==
X-Gm-Message-State: AOAM530R2e2ghhmmK21frTq7UzFtXTthWryRKQQEAXKaT+UxlwnhNmYR
        05ROllTqwpDELHXHoMQJTQSDSw==
X-Google-Smtp-Source: ABdhPJzGHtxhmO400NQHWlqt2IjTlmDB9nqX4ApB7X9GkIcCGAOr8yD9hP2gPOMw9DkSYnZsAdZPGQ==
X-Received: by 2002:aa7:8889:0:b029:3bc:e8a5:50ea with SMTP id z9-20020aa788890000b02903bce8a550eamr28572168pfe.73.1628683597329;
        Wed, 11 Aug 2021 05:06:37 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id 23sm14538606pgk.89.2021.08.11.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/9] cpufreq: scpi: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:45 +0530
Message-Id: <29c65db2dfcbfebdb291a3056cc2adaca8b34cec.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to automatically register with the EM
core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index d6a698a1b5d1..bda3e7d42964 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -163,8 +163,6 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->fast_switch_possible = false;
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -200,6 +198,7 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
 	.target_index	= scpi_cpufreq_set_target,
+	.register_em	= cpufreq_register_em_with_opp,
 };
 
 static int scpi_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


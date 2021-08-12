Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521B13E9D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhHLEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhHLEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200FC0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:36:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b7so5619954plh.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOkHp31PCeB99M1dSxN1Du6uw4AQKsapMxFixRcFEa0=;
        b=Kh7hj4I7h5CBlthAjIqogCoHqEsTXGwRK33ywj/3LXMyBATvxFhFWnw3YPLcQN7O8w
         7QjH4GDLQShi7mobqrYD8nw0176v1Xpc5uvJUorIClB9Ym8UAEYjVryjjeHzLIYX9dpl
         XGvTT0EZ5f0r/28shwGhJzElGs0BnhohuWx5xkLbOaLjK1oS54dDiYl2A5x04CNBGlZu
         gvCRC/3zVpYzUhuhHpDUYiRT+01GNbz1NU8XhIgcTJJT62iN2wRbkCxN5P+svmojj6lk
         XezXTEQcRWc3vVYfXyVyRPh/4X/EwnCyDiMg69Rn7Hc5vqSuNtSqiH72uRlZNV8Lw1pE
         C9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOkHp31PCeB99M1dSxN1Du6uw4AQKsapMxFixRcFEa0=;
        b=R/2UnjvVoJAEOBHQ4Xt21UdWJq5uf35KkHNtx1HL3QfpckCN0ibjHOrLXF+dmwEbTE
         A/NHmtKPkBNDW7P9KtyLkV2D0wJltzNAAPFQuCC6Omkmd8pXTpCPRaQIdbgE24DcfPYj
         2V88lbsLF1mNzaJ+bRZOL7gsd/29VlFHEgjpRpEaP3wdYsLjupVzs3LMvM4JPjhvsYA6
         trLDOCGOG6ZlqxqfTZcAI5UjtRDwO2TwA4caR7ShqVtYwQHCFandnfssnqLzv8u9AgdR
         Asz6AdXxYtgEV6b0IErxmXtIrpfS0J3V9T2EScx/vy+5/fHIbUjuCeU9nu6YA01Ypsgp
         Ndrg==
X-Gm-Message-State: AOAM531a7NQhLkYrlxxmFWn9x848qTkb/qlX+IWzTNW3EXfZcTp3bsf+
        smfMQOMdczXGydiYAuy73IGsRw==
X-Google-Smtp-Source: ABdhPJyhc1Uy3xlMY0GVY5KMgo/dRuIuPuycji44bvvw6HvVyeQ3uW/K2q+eVg1ubLke2ab2XFSL1g==
X-Received: by 2002:a17:90a:4285:: with SMTP id p5mr2373269pjg.162.1628742962600;
        Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z131sm1353426pfc.159.2021.08.11.21.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/9] cpufreq: qcom-cpufreq-hw: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:19 +0530
Message-Id: <e96c2153d0fc0a1c218bf5ba149ccdf75d19a275.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to register with the EM core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..c2e71c430fbf 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -362,8 +362,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (policy_has_boost_freq(policy)) {
 		ret = cpufreq_enable_boost_support();
 		if (ret)
@@ -412,6 +410,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.get		= qcom_cpufreq_hw_get,
 	.init		= qcom_cpufreq_hw_cpu_init,
 	.exit		= qcom_cpufreq_hw_cpu_exit,
+	.register_em	= cpufreq_register_em_with_opp,
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
 	.attr		= qcom_cpufreq_hw_attr,
-- 
2.31.1.272.g89b43f80a514


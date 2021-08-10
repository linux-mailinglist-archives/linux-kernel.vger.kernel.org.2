Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81233E546B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhHJHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbhHJHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60FC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e19so6286435pla.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNVi1PJwomW2Lv5qQiFKSFJ6/Vv2aKjQw2zcbRmrKys=;
        b=GwAvGJKypx7dO1I0Quh1Zo3hfRBIgOhUAweuXo0i6JjHUCpYGk5+qJLXFbe9sLri1G
         P+WOkghCyhFndfyOID+H35Uf+VciyHQHnKrB9mVN4nbGeKfyEdpY8BXDBitOqCwCT+vx
         6CPzpG4vziCrjzO+Eztlu7jvoOMBI3oJjZKJILfLpxpIti5cJDfztxNKCtRnIZPuCD5q
         /BXgfXm5gexBx65NWelA9VY40xpGcO1xQU0MUlbeavFYL4HzuseUcuPG1z8uX5Lan4mN
         nj/5Gd33SFntKjuHOTGtTXO+SXADQdhJczErFnA8sHspqZ4y92OoOV7Wq/gcjxhEIm1W
         RnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNVi1PJwomW2Lv5qQiFKSFJ6/Vv2aKjQw2zcbRmrKys=;
        b=aBgosAH6ju0nxNwz155rhtbb1STJCG2fCGgKQknw+JMta7fC7Wq+jUoc0Fbv9NLfxK
         yK8HPHd4PyQSRDxYImmY8+ZO4NgBm1By1AoZezSITBVDhhZF85E0sE7cClF+Tjm50S+J
         AKWvPQ21WrHhFBtGQ0MQ1nusxZfPcr6qBEajeM0AwMapmF6lYyw+jel2vLyAzavVbf+5
         VQK2hVyK9CKrd61ibDcLk92Ti88pgDq+rLFydVDHNvXV2fo/nIqQ4/JuuzmSdGg7yt2D
         7KyEB7XGjAjOc53pTDzpk0dXc/Q1b0aYb7F26xsg1+CNZeqn2MNKSim2S2jbMNdnLOVp
         uZmQ==
X-Gm-Message-State: AOAM532qUSuAPOvMQK4S6OT+H6gzxodUpr71Z+t52Y/J58At2cD3HYDJ
        NPIbQnm/y9eC5Q8O1TkOYcoc4A==
X-Google-Smtp-Source: ABdhPJyts3rEp6+rLE6LLZhtES2W8EMmMA7guXfr/FSHBEYAYcFpqAHvl/PTW8hkBqm+wpQy4E5pXQ==
X-Received: by 2002:a17:902:7144:b029:12b:24ce:a83c with SMTP id u4-20020a1709027144b029012b24cea83cmr5859162plm.54.1628581040292;
        Tue, 10 Aug 2021 00:37:20 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id 20sm28187764pgg.36.2021.08.10.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/8] cpufreq: mediatek: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:51 +0530
Message-Id: <fe10f291210bfd16620f4be766e6647c8e577995.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
automatically register with the energy model.

This allows removal of boiler plate code from the driver and fixes the
unregistration part as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 87019d5a9547..4743f2e58b97 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -448,8 +448,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
-	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
-
 	return 0;
 }
 
@@ -465,7 +463,8 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV |
+		 CPUFREQ_REGISTER_WITH_EM,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
 	.get = cpufreq_generic_get,
-- 
2.31.1.272.g89b43f80a514


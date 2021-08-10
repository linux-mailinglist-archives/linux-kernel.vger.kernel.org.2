Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7A3E5471
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhHJHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhHJHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25507C061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b7so12394plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfMkvAhG2Hs471btmo38FaMbm1HPcKJf+JsWbgzrWXE=;
        b=RAtnkgZsWRTD84WtL3JO7CI+pzY0OF/z53Kk7V0xgxfFx13n058ztE9BwxTIrkzGBp
         kPjaJwZtNjaez286r1aOCJlCckLdIT/Xabvn8IQzeoKtTPCVuKCk5XKT1HV4oAWn3giR
         f+5fyJ8sMJBf6chcUCNJVNFwRbchgZxHFQ4qzf+mAzal54DwBZAEz2M5BQuBztC4GD0N
         quQR6pB0kLmNWtPytvbOrNw5irDf0j1DEyTg/wt9eI9YM4aGd5c56yJJjNr1grv0gWdz
         ZbwBYHG5HcgDDDsZbsQoNLCHKnyKKB+AaVjwDrBw/B/r/Iz9jomLVUrqWg3E8AM08X08
         jy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfMkvAhG2Hs471btmo38FaMbm1HPcKJf+JsWbgzrWXE=;
        b=Fw4w3roYt5XO8rRB7DcBlJWrXrQNY5IxHP/q+kGYhtsV7gPqfP7zzTsviy8BGJhVg4
         mb2uAlgs9PX8eX1gYMpbRDSzr2hH7yVF/KQKbznmogt2FPeEdNB01RZSOk/2JMRDKvMq
         /DkZyHDkCsZC0ntGL20wsm/Z+of7YZ5bRYEnobnW9u36QcOH3h23WU7UMAo1tw9D0g1A
         8O0+EzhrM+J1obgP8GYw9igusjUpwV8l6MiH3IjkkBNT2tPNUDGRZVG7wf1B+FtaUnIG
         1C0wWHfGlXxe5tVqzi1ku5fVXRQPAVMqfI4UwcieLJMia4+Xf0y5IsoYNE8HPH8gr6Si
         DM/w==
X-Gm-Message-State: AOAM530Nyy21FU/KtLTOpFruUvzBkC3dqCsQHPkERmcMWljoaOA8Fsm7
        p546to9AkQkfjD8DjSIWpCOG/A==
X-Google-Smtp-Source: ABdhPJwDXChLrfWBdNBlI/8ZER3OYqAXLoVn2KcaGlOns4uBsu5glJ9xoiEM+lXiZG49fKCbUakbRQ==
X-Received: by 2002:a17:902:f541:b029:12d:27cb:832e with SMTP id h1-20020a170902f541b029012d27cb832emr6159878plf.22.1628581048705;
        Tue, 10 Aug 2021 00:37:28 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j23sm1918452pjn.12.2021.08.10.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] cpufreq: scpi: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:54 +0530
Message-Id: <7809d747fecbaad46699a178f26288a015055b20.1628579170.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/scpi-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index d6a698a1b5d1..bc8c62b1beb5 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -163,8 +163,6 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->fast_switch_possible = false;
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -193,7 +191,8 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV,
+		  CPUFREQ_IS_COOLING_DEV |
+		  CPUFREQ_REGISTER_WITH_EM,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
-- 
2.31.1.272.g89b43f80a514


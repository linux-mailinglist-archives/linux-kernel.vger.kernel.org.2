Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED283E5468
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhHJHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhHJHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9822C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so3076544pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+OKnXMPuWjj4W4bJLq3zK2g9mX6oy/b+uBVNWEhoHA=;
        b=tDJZDgwt6Zksre0+Hb84Oaba+GoGOFFnBNTSeFFbIxWMY/kmyer6CIsG5m8Gy1g4kk
         ZPUAYeVRYBtzn0FBsxM4HhlemFAWLIb56qQo4pQnz6c5f7xENOK6is2MpgB5M1+OBV+S
         9Zm/29cSjLdXxi+vsEPSUIH6KgUXgXJsq0AylkYvvSZhObcjRBgiojCe/7Sj210pOp80
         B+rZ+ivfcTLYlFni4Hj2lO6nKUPI0+ITlM7b3vSLzNp2txKbP/hwxM67bbsz45XYtwBD
         0fFIr55WXt/JEs1cPOIdCNfXMztD8eqHJaqaBeHvwiddMhcl6kMq2iyk2VxenpTkoJfB
         SiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+OKnXMPuWjj4W4bJLq3zK2g9mX6oy/b+uBVNWEhoHA=;
        b=ZeQj2apcnI/KVrFGe+DHBWYdMRiJ18nFwDOnbldr6a8xL8/eHp9qtiw8RNubFAqTN4
         W94Rvz3itE/EotkppEPepONqUmMyLCOEP2CVa7DukTI8NC48GAl39+ten6BK17sMt6ve
         h2friN5d3A6/HO76YNq1UkLMowixGzJqsG/r2qkrv9EM0fhK0RfwuCz/yB9RKKX4w5fQ
         jO6P/eXU60UkwOY9uWOhJ4uwV8w87N63lHJG+d0fvqjhcZBpvHW51P068DesiLqn8pWU
         FMFOywm43nw32/JDKmM/1Eu23ZbOqmgnQKqi1SLX0Ox8doEnSKJ5sSF49/7415EtS+vK
         fWYQ==
X-Gm-Message-State: AOAM531O/eLfSzg7Q9aH1+e1rPwEH03+IvOYTJ5IgHkMG1sAgxq0SSu1
        PALRVxqMsi+enPBfFlyaw/pnVA==
X-Google-Smtp-Source: ABdhPJxsNfQtKMmDJCqfKBGePJ4HXpw4jtllLvQqCujxTBROh6Vo5ApG0dxLBFcfmn+AeKmqFYOShg==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr8527pgr.411.1628581037290;
        Tue, 10 Aug 2021 00:37:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id d9sm21546884pfv.161.2021.08.10.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] cpufreq: imx6q: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:50 +0530
Message-Id: <ba662b10e043e7734eb9d9e9bbc4c75afab9c2a4.1628579170.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/imx6q-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 5bf5fc759881..aa8df5b468d7 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -192,14 +192,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->clk = clks[ARM].clk;
 	cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = max_freq;
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	return 0;
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV |
+		 CPUFREQ_REGISTER_WITH_EM,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
-- 
2.31.1.272.g89b43f80a514


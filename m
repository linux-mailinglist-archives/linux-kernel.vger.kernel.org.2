Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF143E5474
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhHJHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhHJHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D95C061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q2so19795305plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0ESkgRNa4vkozA2GQvSw915d4fLi0hlNoHicBPRN6s=;
        b=Nyujgk1yu+B3QJtPf5p7mSBmBFCEaQpPsLB59ms9WRoRqV3eLEa842gRWTBEv2X1U9
         DHA9hNmS8GqvMQpR9KcSDwQctHDJvWygUdbdyvUwIH39Qrl56Gv2LQAFWty1biwLcA0J
         G0lWIQpVq5raGE8mPlFoc0Dr0x3dhAUUE+J5ja+wEgxMVjirZjxt2GMMq3/4G5g8r/+G
         +/a4XwLO9LfacMwqbUusG6SKOWuGz37wADkRImTe7GlkGCF98b6tqr3orw8QMocBaF88
         IrSwTVMYqvBxotei9lxjwdLUcqk1ovA3aj3bEUfdo4IGlDXf1JyM76tcRYC0LwL7jvDb
         VPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0ESkgRNa4vkozA2GQvSw915d4fLi0hlNoHicBPRN6s=;
        b=te7+olPEtHesOpQ8zhIldAFRXsz+8pTxugNbDEHmTnSAWDSkg+88SebLAeVXWNYw8d
         sgKaYAE7quKAJJaIrlWQ21iMrd/cLL5qCwfOzyXdKQwQwMRv1i5zY7ZH1kd04NS/wx99
         gXrZEBp+QQayFqNvl6lbVkJa5Ym/Oau4qCbvWiqoitJn97KLJgmUmBBB0dTEu1ncS6MK
         CRqPiH6rtDOAcfZfeovylTg5clv3uRmHbLScCmwCD1MSpxN6qspsWXWSpOhSop508HHg
         dyoA6eaT8M7dw5fOaKQZ2KE/sVOcIljKF1SOj5GaCsVaYV95FoQm7FZuIpHOGAZLJ4wU
         xEyw==
X-Gm-Message-State: AOAM533zCLFM3YrAIgAJhJ3HDx+sDFPWknCi5Jv0nFKhfQyz3RBaJ7fR
        UDf+fxU3UORYYTd4u3Ldc437xA==
X-Google-Smtp-Source: ABdhPJwVRmgoKnt3ij3/5KYJru9Y5sSV2ApKUBdMorjsp0bG8BMtxxQoHU07A2PF+eLCjDkZxSE+XA==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr3445658pjb.222.1628581051473;
        Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id q1sm23396172pfn.6.2021.08.10.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:55 +0530
Message-Id: <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 51dfa9ae6cf5..28c4c3254337 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -442,8 +442,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table[cur_cluster];
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) =
 						clk_get_cpu_rate(policy->cpu);
@@ -487,7 +485,8 @@ static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+				  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+				  CPUFREQ_REGISTER_WITH_EM,
 	.verify			= cpufreq_generic_frequency_table_verify,
 	.target_index		= ve_spc_cpufreq_set_target,
 	.get			= ve_spc_cpufreq_get_rate,
-- 
2.31.1.272.g89b43f80a514


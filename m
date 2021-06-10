Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565103A26F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFJI1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:27:32 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:37534 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFJI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:27:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id t9so21992419pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7B2ZK+wpxF4j3+qmLEZ4xXUKjyuONFX7C0C6Hmnb+s=;
        b=SvT3rRWlPJYK+5pRZfIdOS69PuLDlN+vLemcMKfxfEvZPAvgBg0a+oLjqkS0ZNb4XW
         /Tt2KQcPvnAsKzk5qOBYPfBNvR1ujyESsRd1uXJcSZe0hbF4DpgGYlS1EDIMUakxPvFL
         dXwaR1ygCUrSG9n0HfokdqT3TU6sNjot3TjJQmr4biXPxAL1PxHFtYU+SNED5ThZejmn
         Hc/UqMk/oju36bDipalENDyOQr504hK1fcQ6hruwr8P0hIb6/rPvDHzoeCVxKMXz1607
         W70h2N4N/qRObY9w9kdB4xLgLEYF7eoUAjx9g2Utl6h8SUf01655cTr2peUgp0I8g0D3
         CtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7B2ZK+wpxF4j3+qmLEZ4xXUKjyuONFX7C0C6Hmnb+s=;
        b=ctB4sboj4ts2pUTq+lWvoq2a4qBRKcv1CrVC1TU74BW1OMVM/l84mWxSua2oLRcZyH
         hMhe0p+Hjd9SgmgA/rnPkfDtMqLbUYIQt+Y3kPeU8GQeiz+aJ0QnfUpPpy/68fw8fMSe
         e8fxOdHqRdmXSKruLUiSuw/HIMCjZZUnC0+p+TvOc6XBySx/QODOVAOso4otv+hqCY94
         PiDXtc+P/0zB5NVk/jhR103DNrra/X5A1/r0+6aU7Kmkhvj9H2wlIV/y+gDKqYORD22X
         znvJ6rsru1UHZfgEpGgfL9a2yHLSqFCQkOjUcp+VHCk1LiKyeKisHl2drPqIknC2wkL3
         i9DQ==
X-Gm-Message-State: AOAM5310eQPubeC0Q873uvA+ZHPcc6sQad2Dm2w2aM9SXTqVkgdpI2Rh
        luNiDvCb7SijULzIvgWeeld4Ag==
X-Google-Smtp-Source: ABdhPJzKh6+W053F1SeGZVSKhG/Yk7QkfyteBY515xdU6z0An8lnFQKYZdkfj8hrGzdGcn/EnZI+iQ==
X-Received: by 2002:a62:804b:0:b029:2e9:c897:aa7c with SMTP id j72-20020a62804b0000b02902e9c897aa7cmr1904664pfd.12.1623313454836;
        Thu, 10 Jun 2021 01:24:14 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id m1sm1863638pfb.14.2021.06.10.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] cpufreq: intel_pstate: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Thu, 10 Jun 2021 13:53:58 +0530
Message-Id: <eb57f99bcd87ab4cb5971060fff57c3ee19ffbc3.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state cannot be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f0401064d7aa..9d3191663925 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2374,17 +2374,11 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
-{
-	pr_debug("CPU %d stopping\n", policy->cpu);
-
-	intel_pstate_clear_update_util_hook(policy->cpu);
-}
-
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
 	policy->fast_switch_possible = false;
 
 	return 0;
@@ -2451,7 +2445,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514


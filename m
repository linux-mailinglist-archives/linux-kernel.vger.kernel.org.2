Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD23E9D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhHLEgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhHLEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9530C0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:36:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q2so5591760plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wofbpP2XHH8vKqCJvAlC0rsCzyQ6IN16xqpsQAu78c=;
        b=kcTGTOMugFVsFi9+hhyJu2RhkTevTNPQoau6mbfxI1ob4Xd98YMMTlWa4HAVxbnYZF
         0zCmJXMZXbZw00yPhX2lYZyZua96iQxKSmxYzxFaQxfoHY2L3Ye9awQnnl4E874fpAvy
         TqV1TxaMgS0kcmXxjvAOJbK9Eryr8xabf7A5CjzFtJ2YM7UI8zxqXn0EpKJDfFGjGHWJ
         tf6goZyfThDvJNaFZRj008upYFfeQoE6+ngyRrnr910bX800SG1RDMvpXi7lK7uRfnK/
         PK08nYK1MomznKkiawoMEmkuE7JCXNp8mnV3w3z1Wlb2WwZYV6b6j6PMFIAQ8OfYaZrs
         jFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wofbpP2XHH8vKqCJvAlC0rsCzyQ6IN16xqpsQAu78c=;
        b=eNgUHiawSccFon8eDiKg2SEHACXk3qFl/Z4axKCHgD127DQHw9vOtu6RIsIz1ZWHfD
         WrSrRkztqIZ09+S2kasUG3d/EVArgHiReyL1bz7UP7KOc30hT63Losz3+iOUQu9EP2j8
         fkn/pgD4P66HIYOO1eVzNH8MNbYTIuPO8KcJk57jBlmZDtAd/weGyPlhVcofu8I9PELV
         i6it+8s9+F2HP+HpWj9LVyWVzWTx+O9BXMEsvOFNwSWUSkov1L+W5PUAjRyG7j8Q2AFP
         P2c0cJXdfWEuyg8I3E96Mmwl42d+FlhMTD35bNgt08/NPHePR1CbPDv7nWZtigPPfCu+
         iRKw==
X-Gm-Message-State: AOAM530DCGGpvLnlUZpz+rIPgnTd/dKiWs+ksLAT6CYAmiBpnpf/L3Tv
        xrhJYiLVqrf/vSVOGxUrZOz0XQ==
X-Google-Smtp-Source: ABdhPJxOyxfx5OgUlraC7cspL4slIMF78gy/l9Iz2XJBgeRFFX7HGChu5G1uG7HxFAKOJXmQPNG7RA==
X-Received: by 2002:a65:690c:: with SMTP id s12mr2110775pgq.401.1628742965215;
        Wed, 11 Aug 2021 21:36:05 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z15sm1402647pgc.13.2021.08.11.21.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/9] cpufreq: scpi: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:20 +0530
Message-Id: <a214649dfcbc812ddf6b3906315da166caf01964.1628742634.git.viresh.kumar@linaro.org>
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


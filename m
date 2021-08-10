Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40133E5467
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhHJHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbhHJHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3301C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so1260906pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXQZ6ZCwiAFsxkwkNz7ph1BRlARXOF8YuCGygV0SpXs=;
        b=Kn615fl51FeOD52lrtpgeS7SnpliWdUH/DpbmWYGWHk30G/nLAaMrllwgIn5weKJJC
         e5Jhdl9JeKyqspRiJ1kyUWv0qr/RxWMdiFtZnq269arO0CiT7hLub8mqmgBolBUvGgbN
         UVVVrZuv7+NYF5577lZCH+2wcgxlgAatlSl9AJeJW79wwirigzP/D3w5NLswTE+GCSGk
         DxPhctc5QEbB64l6CsM+7WK82AJK+8f7d2W+Q7OtzOgVemxGd+ejqT33WeJ9pzP4G7z2
         455pT63z/E0vj2VhGPMIBs9bR6GhK+90AqBXrhy67N6mk0KmD8QeAMGKmAlJcxatlxfc
         8txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXQZ6ZCwiAFsxkwkNz7ph1BRlARXOF8YuCGygV0SpXs=;
        b=Q4MwFSBczj9nSFrsbbd1tLlXa/GYAMSUKr6weXq+8NvfOei6MvdDEKTeuqjUGjfMKv
         7iuT3iTeRy6MZ9heKoYNFsx4T9lpunPfB/ZEWKn9cYuedbr8NYPBb3vyivH/BR9L6XT3
         mNiVxjeS3RAAv37cvMBlWcuQGaMkLtNGkmA/NCs/viJHcp/j+boJtWxpt9szXQWvFHcD
         E1EURlfKgI5/L9Z1WHAVAieoI2yGxkJuyN7nO5/bTQSZ2EwQUcDvLoyVrOoJYWSVze23
         0PBTLl9tARawYI/+qUaZiuFztUK3swNPiPbKX1Q7klvvk2eQIX3HssctGXnvgx3QbfV7
         b/jw==
X-Gm-Message-State: AOAM533amlu8598X0qO8YBOEEs+qouqCXgoyhu8zNLEUUtyIGjjizn5P
        YyUOB4ojgsvb46SVDDBF5scS4g==
X-Google-Smtp-Source: ABdhPJz4M+7oN3zx98+ymE5hz4EVwJIb0smowNcQ/TWXydtUkdirf22U89GfRYfsZ/Fg38eQj4/hKg==
X-Received: by 2002:aa7:8d94:0:b029:3a0:a513:e13a with SMTP id i20-20020aa78d940000b02903a0a513e13amr21899757pfr.56.1628581034296;
        Tue, 10 Aug 2021 00:37:14 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id hd21sm1912831pjb.7.2021.08.10.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] cpufreq: dt: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:49 +0530
Message-Id: <f66047fca65a2d368e881d62e1623dbeef2eacd2.1628579170.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ece52863ba62..b727006e85af 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -143,8 +143,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	return 0;
 
 out_clk_put:
@@ -176,7 +174,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV |
+		 CPUFREQ_REGISTER_WITH_EM,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
-- 
2.31.1.272.g89b43f80a514


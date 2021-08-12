Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30E3E9D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhHLEg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhHLEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4BC0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so5600682plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k48YyjS9KRlRanFe/kfIE1R2AlXiENKsFw9f6TRi87E=;
        b=tN9B5k4mmcraApnfbxQl5mSz8yiBDtzXSKYvcsLtFW80z4amA5SAE+BAn3vLkujR9+
         h6zMKm2sm9uZ6vPq+28lMbKGnA15WOdpBsJISdSfQlFz6KUqnD23F0EPiMzWr+SwfVX7
         b6R86wjg0a1B/sa8LZk3dGMu+dfC4uOdqvmtp0iD5blno6FxTLbA1RTQ3ZTapWpRJs5c
         7XFOCVVzhW+JA4lIHiag8SSj/2/blzgEFinlVw3ZZC2s4Y+QPTBY0qwBZaVuMZBAyUkE
         w0lqq9lop8oIL9zpQPXf3f+kNAttFKGQlCnSY43LI3lAlHGftrOxizAemBajMbeED1c2
         DhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k48YyjS9KRlRanFe/kfIE1R2AlXiENKsFw9f6TRi87E=;
        b=F9C7pp6gkiIG9pkWBBB6QUBKKFVrS5r8O1Ah1HkHauKMLHkCLUX8BWaojrjddP/ECe
         +bhxCozIvb0UuIlBDoqLB3U6YkcBiTshrs5ooeeYUZMezw+g4Ebso1xr79Yh8Wm9alGz
         xZ5XC/ldfyuw8zkPt1FTNGJIoOaTgv6+3yJ5iIfn+4rYSzq/dAhjqjET8+LRaQnK+DQR
         7g68WLvf6OIyUdlnQXchVlFjARLokhMA225iZk/P2TMt67IpKh1IF/1/MX1LTK/DkQgb
         y9bAhdZsE6kuEY2jMv614b0XkdTzOT/DC43xux7zeHVWqJlsjuqPJ/hfzbE9YEPXS3PQ
         DWFA==
X-Gm-Message-State: AOAM5326x3O3BOlks34y6M5GSWuCNPEbEhz/ksDgMr4IKdDEeSMan/pS
        D04eSw395QUQDY5VnrhZlOC53w==
X-Google-Smtp-Source: ABdhPJxQ/RMAbXOaeeOJaYTwrJRMfY6omMTxbMMfslsbb4PSdSk0wjXSP97pFx2+OdLJvlXjag8BGg==
X-Received: by 2002:a17:90a:4987:: with SMTP id d7mr4856388pjh.46.1628742951640;
        Wed, 11 Aug 2021 21:35:51 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id 128sm1330009pfe.55.2021.08.11.21.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/9] cpufreq: dt: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:15 +0530
Message-Id: <94ab4c3c259c7d00746e5cafb55b5f5125f34b71.1628742634.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ece52863ba62..8fcaba541539 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -143,8 +143,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	return 0;
 
 out_clk_put:
@@ -184,6 +182,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.exit = cpufreq_exit,
 	.online = cpufreq_online,
 	.offline = cpufreq_offline,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.31.1.272.g89b43f80a514


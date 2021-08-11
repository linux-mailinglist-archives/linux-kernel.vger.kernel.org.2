Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B43E9018
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhHKMHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhHKMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:06:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F04C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso5745157pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ufaB+OMXdYU7j7TBo3XtAZpCHOejyA+3wA93Op1lzU=;
        b=t8lLzjPFZAWIYgTJOrFd2HG+scMTfIhGn3oErjtmiM//ccrcySFz8JOOZKulU+EiNL
         OXO+8zbdgMhoqwmYzFPpIQvy4NwR+3xGy5J0bpgHy4m6WaA+Vf+QrgkpMTwpC5PcNtPD
         +3lIVvpcRqaoz4+sOPxLsf88Wq0iRFXBDSECTlXfjDnmdjovXDpk2WgY//lc1NDMlyiD
         OH+cO8WaQ/hiuH1bJmO6CiXIanr5Wlii23Zg8EHPNS8qNTCNeQvGb7mbutXNddc+MLFl
         bh2hLW7kZP4owycILCEv6xAz8aM45z9ROAHxGDHqSi3Dwf27fyvzFcDHRtXM4FVUR9Kw
         QHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ufaB+OMXdYU7j7TBo3XtAZpCHOejyA+3wA93Op1lzU=;
        b=EkvGRJAtdepY7kaxwz1iAe6M1pyUPjtItv5anuRFPlK1OL3w+ZJn6mTurTSiThzZ+F
         umVQlLT5s/oikVVd99JDaybC+6cez8KU7FrR5H0zUmlOD6ub9C5qslg9BpzLx0pP6ylB
         2CCzbpWvNAZlzuhKDS17ksv7LFHkp7deUOdJPnvPiOc599SKFBvJSzYVb2PYZz3V59Ms
         nhIns2YHPKOnlVR+81YXSnGaMqRr0VF/9Zj3TR12i8DqXmPzV8Q6V9u7mHLakQ7Zbsdc
         fuOf2/lBE098vPIQ7KvIDr++UTeTB/74V+AcGxA5LR56avHp6LTZs2DSbJw3hJ9YwnZk
         6PyA==
X-Gm-Message-State: AOAM532EIgrCDdx9AhBM7jhhH5IV1fLZBjYsF8LmLmYGvze3bgzRKzEl
        iexlcS/1jfkJaK16chtvFUbH2g==
X-Google-Smtp-Source: ABdhPJwMwN2fm97TlkXuwYPxuFuL4cxb2WPXC0Be7ZXZT7ga2QkHLotZZsNvgbZMaOm1uLqj8hwR+w==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr562898pgl.198.1628683587396;
        Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j22sm31239903pgb.62.2021.08.11.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH V2 4/9] cpufreq: mediatek: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:42 +0530
Message-Id: <c643714aa4e525aea4d54c2fd35950c046555621.1628682874.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/mediatek-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 87019d5a9547..866163883b48 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -448,8 +448,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
-	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
-
 	return 0;
 }
 
@@ -471,6 +469,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.31.1.272.g89b43f80a514


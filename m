Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF69326FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 02:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhB1BeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 20:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB1BeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 20:34:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B74C061756
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:33:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m6so8827685pfk.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uKgrFKJjppxflukU5myFTP3NdBmrSyJNhIZiE+dOu5o=;
        b=D1tLWT2CuzaThw5SeZyJof87G42d8JlGRrSBuFNhJfByh2Bs2Z28m0N12uzorxUHoz
         nekSuDHlRATAQCW7uNj0sH10TUkF6bEqUwMxD0VZyU1NcQTtwcsj0A/IWN75z6ywLjvl
         AN4qUo+wR8CNaUkaZoT6x9dULPxjQ5oTvHBV3TmtpJDfTsGVgJkSI2I7Ssc2W7PuTfSH
         TieDbo2BQwSmFdLK0MPuTXieDT3SDRyYG67V4oqQfM+GycOsEO+yqc5ao3yN01c/6EDd
         1qBXr7iN0xqXJBmvxPfrMRFcSoG1kkD4Dcw/X+rpIYxdgh59zgh1YzL0iXwirqbMwADw
         c3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uKgrFKJjppxflukU5myFTP3NdBmrSyJNhIZiE+dOu5o=;
        b=gh+HdN2mgQVeTDaXpYXv6Gcz2hhYc28v+a21wfyEJeor38QOQhvkXiZ514EO4VIryA
         /2d/zlBmqHitDohT82woVUZAKe5o6Yijwuz4L/DY5amD76oW8/mEonf3fRNanHl7s+sP
         9ogqA0V0Ed4IAkGdIAGQI+JNSnxFFXqKLtLK6i/Wev+lnFQNy0MKAmXJuQMQ3i1LwxfC
         iJDBd9boG04TwIuqIi985o+RmV4modOs5NY5lQsi/GCuynUAP31RQFN44E83jZvLugqc
         Ihjm2z7dvnN51ugB72jwR5WBTYztDWmGvPwNidWLw3sZzJiXEFoe9XOlPeR3bdLGYuA1
         8UyA==
X-Gm-Message-State: AOAM5337f06pA3fvBsM0TT8YOG7kAGLHRWKZ8iixVgb0oiafVGGfbefn
        ZqJPV8payN70G3upVa8j1mQIUg==
X-Google-Smtp-Source: ABdhPJz8e8eQY2YQ/Czffb59zk6I9Kh05peE4V2o764Mktl9Tf0Vp/eDkqpfZkbNKv6HwXMHzjAT/w==
X-Received: by 2002:aa7:8bd2:0:b029:1ee:1838:685f with SMTP id s18-20020aa78bd20000b02901ee1838685fmr9524727pfd.64.1614476017538;
        Sat, 27 Feb 2021 17:33:37 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x68sm13361827pfc.26.2021.02.27.17.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 17:33:37 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: fix dereferencing freed memory 'data'
Date:   Sun, 28 Feb 2021 09:33:19 +0800
Message-Id: <20210228013319.10469-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from
init/exit hooks") introduces an issue of dereferencing freed memory
'data'.  Fix it.

Fixes: 67fc209b527d ("cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Viresh,

The issue was introduced by v2 of "cpufreq: qcom-hw: drop devm_xxx()
calls from init/exit hooks", which misses the conversion of 'data->base'
in error path.  Sorry!

Shawn

 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d3c23447b892..bee5d67a8227 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -374,7 +374,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 error:
 	kfree(data);
 unmap_base:
-	iounmap(data->base);
+	iounmap(base);
 release_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF49F3489E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCYHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCYHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:13:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:13:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u19so872937pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3PfEwMCArOxnUrhQJLxkkNn5D8NefcAvx18jJ8NUm24=;
        b=Bxqwk/6a3lwZ0xF3/cYjbWfJlUN6oOgK3Ny70JVyJV4IiAbt/GzOuoD1XvRIuC7WvC
         +GviI/HiYXuDRP0nnVL9M6llsghry2JNeUQayNWnd5x3S1MPQdfSmygrDrPJ4yzAb2v5
         txyMOVFkh+sPYp84ek+Fe3kF27evyXlzzdgApcuY6Jof5HDJo84ZpxGmgxCdB4k4WmfY
         Teay7yC5JCC9gAqFSy+xkCAZzz5s+myxuJsR6RSW5Ps9w8NBGq3qQ0mTYrNJJ/eHtFOO
         Yvm6UKMNLY9MkkXrpJGyWtX47lLmSzXcDoKlNEpLKGZOojugB+kWSkyCkGotZGgf4ZqL
         0YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PfEwMCArOxnUrhQJLxkkNn5D8NefcAvx18jJ8NUm24=;
        b=sY+vOxlmIZ4E2EB53FT1QyQDykRrZUa7ZJHb1ObcbtUgvazR8fcchisYVM4WWnPZHO
         5tksg2ebnkrSPo6CI5EpAFoC/vEoVvkkhzKHZa2WKJJkvXNxcg10pte+zRV47kbuNle2
         Q6qzB2xUr1F6lAdW/U2YuzGwyTPFQRBE+kcgseSDd5eTTXm/Cq8bfmgIixj1VsPoyNxw
         2V3U6a0XJUrkkJq0B6KRhliEbjfqoGgki9JZjiVpiRddWlq2xOckXd2ftRZaat0J0TD9
         XpTmsRQCjeveZBF+pF0yH4k3WxR2R4DVpFBH4u7+kQy4jRTSRjfJQ/gIzv91eGz2lvvk
         yUWQ==
X-Gm-Message-State: AOAM531cFvBZz6jJAW8dIfYJPGGL0DjHMCXmUvy8mZE2zSeS0ImK0H2h
        Appz3pPz4GDkCP7KPaxyKwnW9Q==
X-Google-Smtp-Source: ABdhPJxWTsN6fQJMJ9RQRWF7kW+N5ElF+YhfBbyHEQXerKbXS87CGxIsW7qp84m/smCMwwQ9zhWIgQ==
X-Received: by 2002:a63:4441:: with SMTP id t1mr6500967pgk.124.1616656381281;
        Thu, 25 Mar 2021 00:13:01 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id l4sm4724039pgn.77.2021.03.25.00.12.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Mar 2021 00:12:56 -0700 (PDT)
Date:   Thu, 25 Mar 2021 12:42:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     quanyang.wang@windriver.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] cpufreq: dt: check the -EPROBE_DEFER error returned
 by dev_pm_opp_of_cpumask_add_table
Message-ID: <20210325071254.5f55i2dpsslkfwyz@vireshk-i7>
References: <20210325064208.2291413-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325064208.2291413-1-quanyang.wang@windriver.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-21, 14:42, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>

Made some changes and applied this:

Author: Quanyang Wang <quanyang.wang@windriver.com>
Date:   Thu Mar 25 14:42:08 2021 +0800

    cpufreq: dt: dev_pm_opp_of_cpumask_add_table() may return -EPROBE_DEFER
    
    The function dev_pm_opp_of_cpumask_add_table() may return -EPROBE_DEFER,
    which needs to be propagated to the caller to try probing the driver
    later on.
    
    Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
    [ Viresh: Massage changelog/subject, improve code. ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b1e1bdc63b01..ece52863ba62 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -255,10 +255,15 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
         * before updating priv->cpus. Otherwise, we will end up creating
         * duplicate OPPs for the CPUs.
         *
-        * OPPs might be populated at runtime, don't check for error here.
+        * OPPs might be populated at runtime, don't fail for error here unless
+        * it is -EPROBE_DEFER.
         */
-       if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
+       ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
+       if (!ret) {
                priv->have_static_opps = true;
+       } else if (ret == -EPROBE_DEFER) {
+               goto out;
+       }
 
        /*
         * The OPP table must be initialized, statically or dynamically, by this

-- 
viresh

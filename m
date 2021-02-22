Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1F5321CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhBVQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhBVQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:24:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:23:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b3so19702900wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbG3leYenVvfYzPUziVWcBviCvedu5Ddm0kc2wDnMx0=;
        b=Tp/ZA6CpFnf6yZsD9Eb/Ut7zndfT4awnGXXpdJjJ764Ubg9Zc75RxCupcuDKO3JtN8
         SRY7BpT8o9ZJlOSccysYdJ50IM9sz1g2lBdHntpv+5bdJadVDQsEoetwBSMLim10HzHT
         TFnBzH6CTmWkknkCMT9QXAyMWrHjMG/svW1JYBgScEaW5GQBUqPBQM9fb7TGKkc2DNQL
         vF4cGeZr+n2JVV3vSgpiepuhRcDaf48zK2BPhXrxSO9wvqdXiDdthw+XAQkqDIhkwZOu
         9JTPzgVpzDysNds5IEgEhoARszLhr4AAG0P+IAep2Z1hSpNGhsYRTTffV41XMm6Zbnla
         SBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbG3leYenVvfYzPUziVWcBviCvedu5Ddm0kc2wDnMx0=;
        b=Hin8a6GL4f1yrpajsSk3rqG4TvmV6K8vBdhBXdMCVJDKDG3RGBp/rk9HHDMvhQvlhK
         uF06AnxuMltQ4iG+bCCjytTOjBSpbI8YgVGVTg2yqFe90TpGxDpyXH76F8to6v/rBvfj
         4+/xsvJeeNDvMwL780vGiBvY2gwdjKpTcrvd93exL9dn5LIu+RuIwnfawzynBNbLfgSV
         mwDJ7Ta0FQuHujxKUR0xAeuyjhbKtOLGC++Ip4UClZldzv7ZxV2VBP0+5EQ/buRst4Xu
         8A378zsK0yW/P4q19NgQ3x/8k6tSo2lHX897Uilfzr7Qr1g8EORBcLe/Ns+GZsLuXUJA
         oTPA==
X-Gm-Message-State: AOAM5329FNLB0qkXy2FrSlFNKQXQn3VdPw/u4GENKVpKgIFyy6nGoA+2
        O4zfLpMOziBA5eOYfmwaJXS8jA==
X-Google-Smtp-Source: ABdhPJzP+qabd4wnSkwbRyQ6G6KjShybuGft6ua89veTSg0v6lGiNGucGUxVPJ1SWq4Jf2XvStf/EA==
X-Received: by 2002:adf:ee84:: with SMTP id b4mr21874880wro.339.1614011025407;
        Mon, 22 Feb 2021 08:23:45 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id o10sm22800324wrx.5.2021.02.22.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:23:45 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:23:42 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDPajlnvgkonocpp@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDPUwKKYgZfzzCJm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Feb 2021 at 15:58:56 (+0000), Quentin Perret wrote:
> But in any case, if we're going to address this, I'm still not sure this
> patch will be what we want. As per my first comment we need to keep the
> frequency estimation right.

Totally untested, but I think in principle you would like something like
the snippet below. Would that work?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..6594d875c6ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6534,8 +6534,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
         * its pd list and will not be accounted by compute_energy().
         */
        for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-               unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
+               unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
+               unsigned long util_running = cpu_util_without(cpu, p);
                struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
+               unsigned long cpu_util;
+
+               if (cpu == dst_cpu)
+                       util_running += task_util_est();

                /*
                 * Busy time computation: utilization clamping is not
@@ -6543,7 +6548,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
                 * is already enough to scale the EM reported power
                 * consumption at the (eventually clamped) cpu_capacity.
                 */
-               sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+               sum_util += schedutil_cpu_util(cpu, util_running, cpu_cap,
                                               ENERGY_UTIL, NULL);

                /*
@@ -6553,7 +6558,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
                 * NOTE: in case RT tasks are running, by default the
                 * FREQUENCY_UTIL's utilization can be max OPP.
                 */
-               cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+               cpu_util = schedutil_cpu_util(cpu, util_freq, cpu_cap,
                                              FREQUENCY_UTIL, tsk);
                max_util = max(max_util, cpu_util);
        }


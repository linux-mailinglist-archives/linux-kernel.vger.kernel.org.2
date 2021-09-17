Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9B40F07B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbhIQDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbhIQDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:45:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:44:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 203so37936pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZYlWPceWZLWKp4g1hxk6A2mQLx1AGzFzlWru98tv7c=;
        b=SkCmrAMXvA7D6ZoiFri2Z3o4Mw98PHUFC4rWhXs1xd9ADrfkU/MAzSGTdBaQWMOrkG
         HMG9xniojWpEiRff2NA54WIiPCthoPLOl1FDUX5CM8mAz5nnZj5/sSvy300ygtkX39MY
         fO2p7epA2CmOqd1nb8YUu80sJ7fNbeY5PZQ8WOiAODQpffe4PPcy4pwIN3DdbQ2zUzeF
         WWfJDj3JWW0EOaEK7zT6d9ehwxyNeL3azYKnZlisacHd7bNc/zrysIklKWCbA5/Wk87/
         FdcRr7WmnH/kQthi/9e+7OtP+yrd0oY+vvV+yqNgyvYgRyqutHasjUwCYVxLWD9RQLHp
         vccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZYlWPceWZLWKp4g1hxk6A2mQLx1AGzFzlWru98tv7c=;
        b=RIlXGmbISD98Pfn85jA2bz2kxbAYJl8M1fxlbWfbZwKsr+ghvxi21CncW1nG+DckOM
         SiyS1dL5iNAlyUmE6cyq3GJR/7oR7ACZh0Xh57EzEAOfAATpJ1LmN99MN9bFtN/rIwGW
         S9+QJUNvUvWrwea8IGDa/S5twTIXHBS1z8gMCsrXdV0sGl6uMhr2Yn8V3P09cWn0DJ9D
         xZS1fIt1fYdoMK2KrxfWj5E9eOhsTdT3ViEgRFglxC0AC9T0i1g2ySPZYuVYRAQp5cRK
         9fBuYVpnohcBj2GAsFrGTtgegAd6hBRby5DgZQcx+GB4qbkjhLWw+oaqPyHoBmRSnA1k
         C8lQ==
X-Gm-Message-State: AOAM533b4J/HPdaHTZz72+miyf5SVdGoWTYN5/HwsWZ67cTA3/WHP7Tx
        HX4l7lkVOtesqVSRSdTbGeY=
X-Google-Smtp-Source: ABdhPJxrocAX2wIbWKoicvBcEf49VX4r89zi6dzTHFVetdtEtsCdw1pckEtBASOPXj9+x3ifwukiMw==
X-Received: by 2002:a65:47cd:: with SMTP id f13mr8048406pgs.439.1631850252594;
        Thu, 16 Sep 2021 20:44:12 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id y4sm4007752pjw.57.2021.09.16.20.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:44:12 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     aubrey.li@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, peterz@infradead.org, song.bao.hua@hisilicon.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        yangyicong@huawei.com
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for task wakeup
Date:   Fri, 17 Sep 2021 11:44:00 +0800
Message-Id: <20210917034400.7620-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
References: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Aubrey wrote]
> The idle core information is already in idle cpu mask, do we have a quick
> and cheap way to extract out?

seems hard.

since we need an intermediate cpumask memory to save the result of cpumask
bitmap operations, the only way i can get the idle core and make sure "cpus"
isn't broken is:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 361927803e31..abd844bcfb86 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6187,8 +6187,14 @@ void __update_idle_core(struct rq *rq)
  */
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-       bool idle = true;
-       int cpu;
+       bool idle = true, possible_idle;
+       int cpu, wb, wa;
+
+       wb = cpumask_weight(cpus);
+       cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+       wa = cpumask_weight(cpus);
+
+       possible_idle = (wa - wb == cpumask_weight(cpu_smt_mask(core)));
 
        if (!static_branch_likely(&sched_smt_present))
                return __select_idle_cpu(core, p);
@@ -6212,7 +6218,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
        if (idle)
                return core;
 
-       cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
        return -1;
 }

but the questions are:
1. is it really cheap?
2. how to use possible_idle? right now, select_idle_core() is also selecting idle cpu. we shouldn't simply return when possible_idle is false.

Thanks
Barry

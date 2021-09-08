Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB5403D96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhIHQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhIHQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:30:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:29:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l11so1646024plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kNVo0qh9MTWbPC3PadsYf8Y/pn65A10GpuX8pbuQI9k=;
        b=e35rgEOnpH/s7Tw2/4HppThD6Io0+OFEe71MRzevWCkzjuhA+3gaj1JvmKizwOI6W1
         9pqr5ge31hytDPPB13wN4mgBJnYU/g514qDuMm4OgbeKC/ZYxN0Owy/aqewpOI9Ngnk3
         xA/esTa/t1EYpqPpLUizhElL8gHhwqxHRZxvF9LNvv2orvOZrxwh/1u5nHs8/L9omfsV
         B2wrjm0a5Q9hmdiOW9pzpgtTwbCuNUcqDMF9yEWLNMajiuasGqzHJ7OZIhU/UwFo4UW5
         7K7GGiEYqw9x6fyUP1CqqqLuhnkLi+3lt/tECT+GH1eeimQBXzp/dT96L+Ehhi0GfnE3
         sWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kNVo0qh9MTWbPC3PadsYf8Y/pn65A10GpuX8pbuQI9k=;
        b=7EbdgvSq1ksBewkd8swm4DAWhq+5y8Fha2CAaUNam5NAPjTigU2J5v9wA7no9FpCu6
         0WxLuzGA5z13f1tHSd3kPPTo0rB1IKlNseTrgjn0ytFLU4URoaNnFOPFfJ3jegeETk6C
         4NcbQnHbY8AsIlHYfMRV/cV7IVb6rtlidwS+kBVXjqD6P7RikBdcf4mFtGDQWWhZO4Z8
         PZr2EUIUH4Vj5oEOQ60qws+JFrYXIb7Zep95OGgG7N5OItrZk7SiS94FMCf+JsezBQGw
         xHJxqOKFeK5KkN7h9FkFoqLCEVhMPj3LOOWk0DrUfQSXutcGddAv5IBh2xllsLv/rhy7
         pl9w==
X-Gm-Message-State: AOAM532tiolJRJOgM8+OKHNOQ41qozAqb4AgkGSdrYfbkwwul1+F3s6N
        kHIPmiUKvj5XRg7NpMRVHSc=
X-Google-Smtp-Source: ABdhPJx/D6pDPbsBLzhOxj3aJzivrrO+yk2FkOYdDOS4G7xN7bwtjcJcyzJwHMJq79tkxcvR9ppTCg==
X-Received: by 2002:a17:90a:6503:: with SMTP id i3mr5257895pjj.22.1631118580052;
        Wed, 08 Sep 2021 09:29:40 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x10sm3105435pfj.174.2021.09.08.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:29:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Sep 2021 06:29:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YTjk8oiFa5EfDPn9@slm.duckdns.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
 <YS60T2bfLpxb6SUY@slm.duckdns.org>
 <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
 <YS+uEmQRmQqAbkmG@slm.duckdns.org>
 <3df62791-d123-db9b-ec9c-092c47a941cc@huawei.com>
 <YTea0kK9yL5+GoKt@slm.duckdns.org>
 <be0bdf5a-479c-51bb-6d51-42739c11710d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0bdf5a-479c-51bb-6d51-42739c11710d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 08, 2021 at 07:32:06PM +0800, Zhang Qiao wrote:
> I will update this patch by following the steps below:
> 1)rename cgroup_subsys->fork() to cgroup_subsys->post_fork();
> 2)add cgroup_subsys->fork() and the cpu_cgroup_fork() callback like this:
> 
> void cpu_cgroup_fork(struct task_struct *task) {
> ....
> 	p->sched_task_group = task_group(current);
> 	__set_task_cpu(p, smp_processor_id());
> 	if (p->sched_class->task_fork)
> 		p->sched_class->task_fork(p);
> ....
> 
> 
> 3)call cgroup_subsys->fork() after cgroup_can_fork().
> 
> Do you have any suggestion?

I'm not following why it needs to shuffle the callbacks. Can't you just
relocate the fectching of task_group after can_fork?

Thanks.

-- 
tejun

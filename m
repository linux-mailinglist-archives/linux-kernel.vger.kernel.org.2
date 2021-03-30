Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7634E4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhC3Jpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhC3Jpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:45:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3869C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:45:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so15547641wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyeWZx63Re9KiS8wVurTuqgEPIkOl3yZwdtiNQUUJqU=;
        b=SJBQdhgjAnJToTFR6CjeywJHipkWVO9KZF/bBePjDyUycoy2UQxldKZVEmj4R7aQvI
         CqJ5qgAkQtljJxDdZ6VQ4HIEe9eJvAMSJ3XfxX1vQ7X2jfX5Ed42cjWvjfH9cOMgUbUp
         rzyztCalDpOYiqtXXKQ9nFy4jpRUVXn2Mn2ct1VhPNajPtUOxEkNZpHdmJWTyXJ7UE8r
         +OByxpv8uj5RmVmalEIvwCAZoU7BxNiHcmIN81ldYlKYaVmzjRoy1sPOx0WhRNlvusHn
         kUtGoiCs2HvCT3+qy3Ryd4Hj/zgbJ12eCie1YIGqabAYW7Pu/jUVIgEmlA+zB7+m9MJP
         t0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyeWZx63Re9KiS8wVurTuqgEPIkOl3yZwdtiNQUUJqU=;
        b=FyGO5ACa8WxrI7A5Bk5hAxJQe5ADXn3gwpmzUc1mk5TNlXa7K4CzqRbgyWQKk+DPiu
         wsM6VFw/RAob0XWv2Ztj2S5XpV8m3OUb1fnMjHiMcRtmYWPRBK3R6wXtxxiijG9sEWuw
         DHw0tXV0FaOhrypm9si6ivyMf5I3gOK8RvYosRIni/d5CKPtkpbc4HQoPKC9lNxSLVc9
         wE3wF0mlJNBY3JVSqCHdWsJgoxlMJa06D8Uc5iK8sN3XzAqQNI/cSRJxnctpgXAs04zc
         GJJ3r0DQhCIht0wnCa1/SEZ5GCHX0U87PzXoCm0PVKX1K63lMRmyAPlPmJqZ1q0J/Hk6
         ThQw==
X-Gm-Message-State: AOAM5334E+iQ9NR1d9lQ1/NXD4xXzgFYmxQqEK4I/Q5TVniGUMLuXrQi
        /XFiHQ3XM22VJ++/ovkglUROOQ==
X-Google-Smtp-Source: ABdhPJwFjxIyu6CEz3kHMuVU8Y2DEF75HinlZIhpypO6l4DBg+rJmvRAs9Nt3a7KC2sXwad/9YrPVQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr33614643wrd.156.1617097539344;
        Tue, 30 Mar 2021 02:45:39 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id a4sm34319167wrx.86.2021.03.30.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:45:39 -0700 (PDT)
Date:   Tue, 30 Mar 2021 09:45:36 +0000
From:   Quentin Perret <qperret@google.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        quentin.perret@arm.com, zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
Message-ID: <YGLzQAvVqlrKb8AB@google.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330052154.26861-1-xuewen.yan94@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 30 Mar 2021 at 13:21:54 (+0800), Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> now the energy delta compute as follow:
> 
> base_energy_pd = compute_energy(p, -1, pd);
> 	--->Traverse all CPUs in pd
> 	--->em_pd_energy()
> ----------------------------------------------------- \
> search for the max_sapre_cap_cpu                       \
> ---------------------------------                       search time
> cur_delta = compute_energy(p, max_spare_cap_cpu, pd);  /
> 	--->Traverse all CPUs in pd                   /
> ---------------------------------------------------- /
> 	--->em_pd_energy()
> cur_delta -= base_energy_pd;
> 
> During the search_time, or when calculate the cpu_util in
> compute_energy(), there may occurred task dequeue or cpu_util change,
> it may cause the cur_energy < base_energy_pd, so the cur_delta
> would be negative. But the cur_delta is unsigned long, at this time,
> the cur_delta would always bigger than best_delta of last pd.
> 
> Change the vars to signed long.

Is that really helping though?

Yes you will not overflow, but the decision is still 'wrong' if the util
values are not stable for the entire wake-up. I think folks on the Arm
side had patches to try and cache the util values upfront, and then use
them throughout feec() and compute_energy(), which I think would be a
better fix.

Dietmar, wdyt?

Thanks,
Quentin

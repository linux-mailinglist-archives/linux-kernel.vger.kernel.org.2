Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EB13217BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBVM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBVMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:23:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC80C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:23:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v62so14125076wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7SDXGUBiQi4h2HvY9cK08vZS2jwK85xZ930e3fkTHuI=;
        b=IzKBY469kDikkQuk7qOc56oZV76eW5IdTFjsnoed/tfLuz8CnBjEgTTPvyTLhVfhOP
         wopA67cgEGylkOF3ygRHjqCkt42Ol4me5rlzhLKbvDB/Bta+W87XkgWfe4/n2x0GWMpn
         AiiQBIPtjvj9ndyPeeQ5WJG1Eo04ZnQGyIxQqyrxBjHmBg8AxixfHeMI7uKqN/PhYLxZ
         7Uvw4cDuw2V6Q+0fxCjrSNyGepCLO/h+Tf8lvd/0P96n0vRBkrgkfYIca7EXe8gp1K8e
         +orkBSeCPCOivRMza1Tuem2j2sEb9BNoWvOcZ2Vz0y9UDN6P2p9wxX8w1GBm4d9FmllS
         2wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7SDXGUBiQi4h2HvY9cK08vZS2jwK85xZ930e3fkTHuI=;
        b=mqYDdJfChojTq8cJQcz0IDYF/341HuuP7kORi4U4khqmzZog3tuL09DkWC0QscZKq2
         p5rpEw95Pk6kG4WxX68k50Jg375ExreiBQhSnvIKLbAz7oqFchKh7S35O7ZsDq0VsHrv
         VJDZP1dIdPOUaMB5CAy/EhyU3r0skkkNJ8+C6LAkzieQ/TVs+cpam5N+E7ggHz5FUkxQ
         Y3lrqXUB4fesy8PCtB4CUntJ1yojAIAAHZFK9BqpL2lFMx018ONX7zMZ+x8JZFVoaU7b
         VA8GpB6zPskZjooGa5+UFEBe+EqFgvSXAy7ggMCeKd2hXgxHinNsTkbtP2wUwGWj8F2s
         Z2Dg==
X-Gm-Message-State: AOAM532dQOTl9qNrAnE6GLTCkhNl+SSAqtl7S/9DOp6qSY+RxGnl5YCI
        TqZTJpj788Es0AddytrEbkiejw==
X-Google-Smtp-Source: ABdhPJwvPKOZ92308u2obk73vmCah5qafXApTj5YxzmiktYZk7gUG36YJS6iu5c92Z+mNj5FN6Zmhg==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr17013757wmj.185.1613996587567;
        Mon, 22 Feb 2021 04:23:07 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id c3sm6777007wrw.80.2021.02.22.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:23:07 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:23:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDOiKH/XQDUKcrPU@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Feb 2021 at 11:36:03 (+0000), Vincent Donnefort wrote:
> Here's with real life numbers.
> 
> The task: util_avg=3 (1) util_est=11 (2)
> 
> pd0 (CPU-0, CPU-1, CPU-2)
> 
>  cpu_util_next(CPU-0, NULL): 7
>  cpu_util_next(CPU-1, NULL): 3
>  cpu_util_next(CPU-2, NULL): 0 <- Most capacity, try to place task here.
> 
>  cpu_util_next(CPU-2, task): 0 + 11 (2)
> 
> 
> pd1 (CPU-3):
> 
>  cpu_util_next(CPU-3, NULL): 77
> 
>  cpu_util_next(CPU-3, task): 77 + 3 (1)
> 
> 
> On pd0, the task contribution is 11. On pd1, it is 3.

Yes but that accurately reflects what the task's impact on frequency
selection of those CPUs if it was enqueued there, right?

This is an important property we should aim to keep, the frequency
prediction needs to be in sync with the actual frequency request, or
the energy estimate will be off.

> When computing the energy
> deltas, pd0's is likely to be higher than pd1's, only because the task
> contribution is higher for one comparison than the other.

You mean the contribution to sum_util right? I think I see what you mean
but I'm still not sure if this really is an issue. This is how util_est
works, and the EM stuff is just consistent with that.

The issue you describe can only happen (I think) when a rq's util_avg is
larger than its util-est emwa by some margin (that has to do with the
ewma-util_avg delta for the task?). But that means the ewma is not to be
trusted to begin with, so ...

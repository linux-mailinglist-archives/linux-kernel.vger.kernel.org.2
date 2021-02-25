Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0E324C44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhBYIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhBYIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:53:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:53:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so4408577wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rUiLoop38AlOsLfZWuojTXlff96R6RtCoXKr4/NKOzc=;
        b=MuLd6UbnmdDuDR2MWEicQiLUykhzFE9EWXfx5fWMwFaglcKGmRm2I8x0mapWEbTbfo
         L0b+hDE+m2Afe0tRWlX0Wtv/gi2JlRUV57X4V6Xa9iVT06cUQfal2bC1BkQz9yolglX5
         GFDCmevbl9JNKFm+4MukHqGAjiz1BLmjVyWxX04MltQ4MIXIPxjhiuIN05kz1MfVQ7p0
         tcfhdx8NHCaaWV/3996jRryhh6Hs4jiqWVvKc3tzlESBz5I385iUG8slR0YhdFc3gJ1G
         hkp4Tw+w4+c1wIbwpqOiMJwRz6rAYwA6XN2QtmVZaN42zbf52CvUAHhUfX2jrVhrwdrY
         1CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rUiLoop38AlOsLfZWuojTXlff96R6RtCoXKr4/NKOzc=;
        b=Te6S2Eu9KhCy4UWEoL6Od3Yji+cQk2HNJQs9OZjD9xITaY+buhjbAC1Zo+mxwiWHdZ
         9RoGSuo0S/bv1uwdsMlW8RnWhZaNwXxQP7WKSwqUsEpZcZuJmj+4vxsk4FGK0WHVHq6t
         Us+c3naejYu+5ZY7sV9z1baSCHL0dydL/DGoz3UwGRRB03HzFk617EhZzCrwR/svwyOR
         4KHWl+njGSTmFlxQBCaEQWOoZJHOiOq+eFH8rq0X5fuvIn4mzKVwINYXKi9Lg1EQZna6
         K+Ed0kAfm9wnfev3BoBniCuVr8PsCNhmzmJpVu2Oh2eyRO3cCiS28GjtnY5GPuKtjj/5
         gDug==
X-Gm-Message-State: AOAM531Vd5um86jaQU08dNs66rMsECXYCXXMSVBJKUhETFJztxj3JyAc
        zfw9DWyw7I+yReXJcA8QV4rjNQ==
X-Google-Smtp-Source: ABdhPJz6KiT+yKAUN9Ic8Rbw1L4xQt3RH5Bzf5rqHPe1nZ+7+7+amOub+K2HcRQ64DGRVh5OLpW10g==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr2397942wrt.63.1614243179475;
        Thu, 25 Feb 2021 00:52:59 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id q25sm6405526wmq.15.2021.02.25.00.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 00:52:59 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:52:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     vincent.donnefort@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix task utilization accountability
 in compute_energy()
Message-ID: <YDdlaLjOvGH+VLBh@google.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
 <20210225083612.1113823-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225083612.1113823-2-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Feb 2021 at 08:36:11 (+0000), vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> find_energy_efficient_cpu() (feec()) computes for each perf_domain (pd) an
> energy delta as follows:
> 
>   feec(task)
>     for_each_pd
>       base_energy = compute_energy(task, -1, pd)
>         -> for_each_cpu(pd)
>            -> cpu_util_next(cpu, task, -1)
> 
>       energy_delta = compute_energy(task, dst_cpu, pd)
>         -> for_each_cpu(pd)
>            -> cpu_util_next(cpu, task, dst_cpu)
>       energy_delta -= base_energy
> 
> Then it picks the best CPU as being the one that minimizes energy_delta.
> 
> cpu_util_next() estimates the CPU utilization that would happen if the
> task was placed on dst_cpu as follows:
> 
>   max(cpu_util + task_util, cpu_util_est + _task_util_est)
> 
> The task contribution to the energy delta can then be either:
> 
>   (1) _task_util_est, on a mostly idle CPU, where cpu_util is close to 0
>       and _task_util_est > cpu_util.
>   (2) task_util, on a mostly busy CPU, where cpu_util > _task_util_est.
> 
>   (cpu_util_est doesn't appear here. It is 0 when a CPU is idle and
>    otherwise must be small enough so that feec() takes the CPU as a
>    potential target for the task placement)
> 
> This is problematic for feec(), as cpu_util_next() might give an unfair
> advantage to a CPU which is mostly busy (2) compared to one which is
> mostly idle (1). _task_util_est being always bigger than task_util in
> feec() (as the task is waking up), the task contribution to the energy
> might look smaller on certain CPUs (2) and this breaks the energy
> comparison.
> 
> This issue is, moreover, not sporadic. By starving idle CPUs, it keeps
> their cpu_util < _task_util_est (1) while others will maintain cpu_util >
> _task_util_est (2).
> 
> Fix this problem by always using max(task_util, _task_util_est) as a task
> contribution to the energy (ENERGY_UTIL). The new estimated CPU
> utilization for the energy would then be:
> 
>   max(cpu_util, cpu_util_est) + max(task_util, _task_util_est)
> 
> compute_energy() still needs to know which OPP would be selected if the
> task would be migrated in the perf_domain (FREQUENCY_UTIL). Hence,
> cpu_util_next() is still used to estimate the maximum util within the pd.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin

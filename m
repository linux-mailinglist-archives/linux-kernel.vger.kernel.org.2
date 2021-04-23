Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40793696B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhDWQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhDWQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:15:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:14:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p6so42258493wrn.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T8nzkoqSamRPp7A4QaxPSAbpm6f1NH1k+4r5xkN7k04=;
        b=abtA2faEaJkNTEFp3QAeOTBdNOk5s0ZXzo8UrPxrVa5L2YTQ4urnKRIYxMr2XG7YT/
         enWjNzDEg8wXcomSU8tD3W4N9ZpIthJNPxL4Ium45fbdOLhz8TgflrWLWd9ecDTU4Dgf
         hMLcNhfLpXtvwSNgO26vtgisgL8AY/223MNB8MLR/dtGUIv17vqBHdlqSsdpAcLQUxXg
         ihz0l0jyYITX6UN+ccAO7vk++/hjdQTd7Pr3bCBubMRp1KwFuaJGhy2Sy9velF2DQyYz
         M6x+HQ4vdR/0LuAVAj/1Vi9Xc6FDIOkq7MumhQ0oZdEybtCdDhYXzclIK5KDXdF2KhXE
         XDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T8nzkoqSamRPp7A4QaxPSAbpm6f1NH1k+4r5xkN7k04=;
        b=iOWW9qKkucqDdyVLkH4s8F8r9rxldmHAYG5SzoQFQa0OunOaO82fHlKsvK1asyAWru
         xyn4SHKcOm3MhkksTDwa5uTb0CpJjEWSkJelo/FtP5f14a+wHPodgannYFykAa0MhmK2
         teSNTv/gACVfx6bHlcy6MLuiQin/Efio4TYJAy8oLF+vmhQOHqOoi6tv0G+8LzBLWLFL
         VS2uW78K4R+hg1oOWgKTzvE+EKI4PqxUaA22qf1TyDJpHgjDycvIyFhI7kzT5Eur7sr9
         bkKLGEmJ+jA6swo70p9Zict+Ojon+q755h09OYeFiPLhaTkxX0LNL22p07N4kfEmrnoF
         sK1Q==
X-Gm-Message-State: AOAM533Vl/rFQ+v+uxhhzrHgQrzpWnc3v6BGna2kCQHO7nqegACyVekr
        R+zraI3Yc0PGJGIlFt+nCtRbmA==
X-Google-Smtp-Source: ABdhPJzrZUfQIJER3cppKNrzl0/h+eiAicNwnFjSC3gGqjz7QPVXsA1FtVPHu/SPOlbl/23ub6yPDw==
X-Received: by 2002:adf:e381:: with SMTP id e1mr5494207wrm.323.1619194487661;
        Fri, 23 Apr 2021 09:14:47 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id f8sm8337953wmc.8.2021.04.23.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:14:47 -0700 (PDT)
Date:   Fri, 23 Apr 2021 16:14:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YILydL1QDxvuiFde@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
 <20210422153644.GA316798@e124901.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210422153644.GA316798@e124901.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Apr 2021 at 16:36:44 (+0100), Vincent Donnefort wrote:
> > > As used in the hot-path, the efficient table is a lookup table, generated
> > > dynamically when the perf domain is created. The complexity of searching
> > > a performance state is hence changed from O(n) to O(1). This also
> > > speeds-up em_cpu_energy() even if no inefficient OPPs have been found.
> > 
> > Interesting. Do you have measurements showing the benefits on wake-up
> > duration? I remember doing so by hacking the wake-up path to force tasks
> > into feec()/compute_energy() even when overutilized, and then running
> > hackbench. Maybe something like that would work for you?
> > 
> > Just want to make sure we actually need all that complexity -- while
> > it's good to reduce the asymptotic complexity, we're looking at a rather
> > small problem (max 30 OPPs or so I expect?), so other effects may be
> > dominating. Simply skipping inefficient OPPs could be implemented in a
> > much simpler way I think.
> > 
> > Thanks,
> > Quentin
> 
> On the Pixel4, I used rt-app to generate a task whom duty cycle is getting
> higher for each phase. Then for each rt-app task placement, I measured how long
> find_energy_efficient_cpu() took to run. I repeated the operation several
> times to increase the count. Here's what I've got: 
> 
> ┌────────┬─────────────┬───────┬────────────────┬───────────────┬───────────────┐
> │ Phase  │ duty-cycle  │  CPU  │     w/o LUT    │    w/  LUT    │               │
> │        │             │       ├────────┬───────┼───────┬───────┤      Diff     │
> │        │             │       │ Mean   │ count │ Mean  │ count │               │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │   0    │    12.5%    │ Little│ 10791  │ 3124  │ 10657 │ 3741  │  -1.2% -134ns │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │   1    │    25%      │  Mid  │ 2924   │ 3097  │ 2894  │ 3740  │  -1%  -30ns   │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │   2    │    37.5%    │  Mid  │ 2207   │ 3104  │ 2162  │ 3740  │  -2%  -45ns   │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │   3    │    50%      │  Mid  │ 1897   │ 3119  │ 1864  │ 3717  │  -1.7% -33ns  │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │        │             │  Mid  │ 1700   │  396  │ 1609  │ 1232  │  -5.4% -91ns  │
> │   4    │    62.5%    ├───────┼────────┼───────┼───────┼───────┼───────────────┤
> │        │             │  Big  │ 1187   │ 2729  │ 1129  │ 2518  │  -4.9% -58ns  │
> ├────────┼─────────────┼───────┼────────┼───────┼───────┼───────┼───────────────┤
> │   5    │    75%      │  Big  │  984   │ 3124  │  900  │ 3693  │  -8.5% -84ns  │
> └────────┴─────────────┴───────┴────────┴───────┴───────┴───────┴───────────────┘

Thanks for that. Do you have the stddev handy?

> Notice:
> 
>   * The CPU column describes which CPU ran the find_energy_efficient()
>     function.
> 
>   * I modified my patch so that no inefficient OPPs are reported. This is to
>     have a fairer comparison between the original table walk and the lookup
>     table.

You mean to avoid the impact of the frequency selection itself? Maybe
pinning the frequencies in the cpufreq policy could do?

> 
>   * I removed from the table results that didn't have enough count to be
>     statistically significant.


Anyways, this looks like a small but consistent gain throughout, so it's a
win for the LUT :)

Thanks,
Quentin

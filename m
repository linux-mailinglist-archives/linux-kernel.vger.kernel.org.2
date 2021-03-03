Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE332BF0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhCCRtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbhCCO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:58:53 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850BC0613E8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:57:46 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j3so1998480qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j7/BRFveM1y09hb1VH1ITCBiQfybwUMVyrYKD7X1lLg=;
        b=Gt94H0c7cWXv59/dBmL/E73Cm4gP+iyknhhTviwccKk8XRfkdVDfDICX17I4XI0VJq
         K00H6n+MiD1X8Yw+aT/2x6gP5Q2HYiuSX2eSZOMVw1KKJA8ZcmlFNLctR9u6jmyFRwUq
         g9QFIrRqgfBZ3urZP/hQrOOfEgbJTKZCRbZuBtOpWKCA/uBFj1FAMtSEcvOStPGoiEJm
         DP3qc/3sm0EdXV674qjxSWgMzJpdXNJnUdTo1vOdpwWwE0DJmPMcylHcdDIqTtr4dE6l
         JWfnKPpj6b4TuggrizmVY7q1+WHTfRpQ1yFdaWqXBDc2PDBpVhf9kYWjbt98828NeByn
         dbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7/BRFveM1y09hb1VH1ITCBiQfybwUMVyrYKD7X1lLg=;
        b=dEygCf89vAg40CxwJ/uf5w/yzPUHWDz35NSXoX64ygDeFrUB3oKbk4YsJaGV3ftKm2
         RWNEHST4hJA7D1hbBVhV1XwgQAQ/NZLd7ejoEqrvPCTbgFd1CvY+MRZZcP8mBkE/QqI6
         VtYZTiS67q2k3i9nUkUUPCsFLmpRF4/3L3g0tm3ZLrmJb9CPwN1ZjJyR6wgMAP5dG0B0
         r1pZLCCke6wwDp0wmP9XfHGaQiseEIY1QxwAZoezsVvTQeerv7JNr6cfshNMfrf1Oakn
         Ed9Pw6dxmfneWaa6375ntWJufjWpAsEhwW6S1/tAaiMYLmmra6QgCBAULHIaEpPr1Ehm
         V4Aw==
X-Gm-Message-State: AOAM530w+BI4gPuVCqSbvpbhHIAqdxL3+QaTE3znFdYtZSuZoVU4j0kd
        +OjZDsKtR4rEfpup3E7b6AT2xA==
X-Google-Smtp-Source: ABdhPJw9wEzb5Gotz5Io/lsw3Oe4dUrQkh9ImPPKEEFHtjNwwIGUOQJzWpVaf4hiH92D0jpmr5SPDw==
X-Received: by 2002:ac8:1494:: with SMTP id l20mr23566295qtj.151.1614783465688;
        Wed, 03 Mar 2021 06:57:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5636])
        by smtp.gmail.com with ESMTPSA id 79sm2529960qki.37.2021.03.03.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:57:45 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:57:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 4/4] psi: Optimize task switch inside shared cgroups
Message-ID: <YD+j56JtFTfOjNjt@cmpxchg.org>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <20210303034659.91735-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303034659.91735-5-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:46:59AM +0800, Chengming Zhou wrote:
> The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
> cgroups") only update cgroups whose state actually changes during a
> task switch only in task preempt case, not in task sleep case.
> 
> We actually don't need to clear and set TSK_ONCPU state for common cgroups
> of next and prev task in sleep case, that can save many psi_group_change
> especially when most activity comes from one leaf cgroup.
> 
> sleep before:
> psi_dequeue()
>   while ((group = iterate_groups(prev)))  # all ancestors
>     psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
> psi_task_switch()
>   while ((group = iterate_groups(next)))  # all ancestors
>     psi_group_change(next, .set=TSK_ONCPU)
> 
> sleep after:
> psi_dequeue()
>   nop
> psi_task_switch()
>   while ((group = iterate_groups(next)))  # until (prev & next)
>     psi_group_change(next, .set=TSK_ONCPU)
>   while ((group = iterate_groups(prev)))  # all ancestors
>     psi_group_change(prev, .clear=common?TSK_RUNNING:TSK_RUNNING|TSK_ONCPU)
> 
> When a voluntary sleep switches to another task, we remove one call of
> psi_group_change() for every common cgroup ancestor of the two tasks.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE05444EBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhKLQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhKLQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:56:13 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2AC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:53:22 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id bu11so6723167qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXN/InKDLcVFhftmg71/uzj4mXtyJ4mSib4dm3LbTMs=;
        b=uVV9jQyTI3Dldw10dlYaqvprb8FjQfjLihPy9YhnwMbGm3tMJ2i31r4tXv+C80JywR
         X2HLcORCqzidNkOihUSQI0XBXLDT0NMOcaj//NDefEbbTtFhqtwO1/iJFuNo/JacXmib
         YNWCKWDaWXdfGLoLKiduRRurMaS56zOrFgeQxVbC1wKsxSKNLhInjKFk3yx6R83syXsU
         kfpiODMQbsr7wJHSzKgJz1nJ2s8krCYZy4ytNt8nzoDs+qK9T0mpdupVOADZJUADu5zj
         SA38LLOGiIck6EF/ntEmY2WdoG2vj9Wp979Z/loVQOLJrq6YGAPL0SH1yzm1pyoDaAgN
         FPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXN/InKDLcVFhftmg71/uzj4mXtyJ4mSib4dm3LbTMs=;
        b=SlHSaw+FcPXjQ7k8fZLxDNgIXaPCPjeWV2ouyWu7I+qRhWoPzHRV90om54bhGZZzuo
         zyZ5Ub/JmE1qu2pJsLFtJOzMiZJ5GujIVndhOi3ytM6Qtm4j/0Uhj+nJZInsTihQ7wdf
         65jDUkqS3YKx4gd29/4TPF4z++mREIcy+OtmqAHMT7iVHPXwAtgxmEb2zOj7F6r/6KEW
         r2en9pY0UbQDlu2CMCXGhsRmUDfN40QZ9GQBBj5nho36/awXsSYhVYVCAIIRUzYbv6JZ
         51zK0xw/s7K90Q2BeN19OtOAoqdN7TBZz/pqKUjRBxNgj0r9nBi4e5vHwe6m06XjHYMi
         M3+w==
X-Gm-Message-State: AOAM533oYLvGh6t8d0xH4jmMz4+LPseCCTiJamYycfmwzt+LJ7NRkYIX
        BADJPSwvk70uUmZWJ8u0vRdt3Q==
X-Google-Smtp-Source: ABdhPJwvaafkczf6rQCeU8cEKeO2K4Mvr9kL9k1usFm1S/TxVMTHKizoocGS51SJhIEk+SdLuKdgmg==
X-Received: by 2002:a05:6214:2b05:: with SMTP id jx5mr15981769qvb.9.1636736001684;
        Fri, 12 Nov 2021 08:53:21 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j8sm3472797qta.79.2021.11.12.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:53:21 -0800 (PST)
Date:   Fri, 12 Nov 2021 11:53:20 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Brian Chen <brianchen118@gmail.com>
Cc:     brianc118@fb.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psi: fix PSI_MEM_FULL state when tasks are in memstall
 and doing reclaim
Message-ID: <YY6cAFtHOhw2zEc7@cmpxchg.org>
References: <20211110213312.310243-1-brianchen118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110213312.310243-1-brianchen118@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:33:12PM +0000, Brian Chen wrote:
> We've noticed cases where tasks in a cgroup are stalled on memory but
> there is little memory FULL pressure since tasks stay on the runqueue
> in reclaim.
> 
> A simple example involves a single threaded program that keeps leaking
> and touching large amounts of memory. It runs in a cgroup with swap
> enabled, memory.high set at 10M and cpu.max ratio set at 5%. Though
> there is significant CPU pressure and memory SOME, there is barely any
> memory FULL since the task enters reclaim and stays on the runqueue.
> However, this memory-bound task is effectively stalled on memory and
> we expect memory FULL to match memory SOME in this scenario.
> 
> The code is confused about memstall && running, thinking there is a
> stalled task and a productive task when there's only one task: a
> reclaimer that's counted as both. To fix this, we redefine the
> condition for PSI_MEM_FULL to check that all running tasks are in an
> active memstall instead of checking that there are no running tasks.
> 
>         case PSI_MEM_FULL:
> -               return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
> +               return unlikely(tasks[NR_MEMSTALL] &&
> +                       tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
> 
> This will capture reclaimers. It will also capture tasks that called
> psi_memstall_enter() and are about to sleep, but this should be
> negligible noise.
> 
> Signed-off-by: Brian Chen <brianchen118@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This bug essentially causes us to count memory-some in walltime and
memory-full in tasktime, which can be quite confusing and misleading
in combined CPU and memory pressure situations.

The fix looks good to me, thanks Brian.

The bug's been there since the initial psi commit, so I don't think a
stable backport is warranted.

Peter, absent objections, can you please pick this up through -tip?

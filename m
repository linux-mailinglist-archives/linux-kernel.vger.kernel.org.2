Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72B364091
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhDSLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:30:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D00DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:30:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id h13so16653344qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A+mm51vGTXzOmiUCjFEhDBK8/JcrUadz4xDgZ/TwNDU=;
        b=dUESOmKG4BhV9yoNqyZ+rPFuA6ZJNVCyLq0MBtbBEpguJs0KxAyclPrumFY6aFywgL
         hWItjKHzWWx/CJTyPW7+54hRKbepqpT2Sg8m6hAovRcW+zKfxxA6nSvamny1yapuFVH3
         hCpYwnQjYKGFIQQLUpXKr/wwOckoakBhkN0HlrhmXEfRxXVfEYMCS0T9WYVKX74h1qQB
         xrjeBiZHFrhnh371QnUFxcX+8f6NIwRbRIJoqy7FtVZyUVagk2xNXrtwY9WS/xwlBsmx
         N+k305qyWCIyWb+I8b+fA/LVKEytbrh1TQSUq0oPXiXwFrnUFPaFEt/eCl04wytmflu2
         cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A+mm51vGTXzOmiUCjFEhDBK8/JcrUadz4xDgZ/TwNDU=;
        b=MFavtpTL+pWUaM9Ll+woeWwXu6uDxso1wzV+TumKvIU6nPyz6WKA833XzM0MFJmFd2
         NQ964TxNz9ogFdKIfsc1m+hQfgz9suAhX9ZMIios9mPFcMl0dgenXiCzYV+jfkhFIyKT
         Yam5PQj2sLdYrhcjxgC47nvXr0JlXYpsP7SF9mSEx5FzpIw8KfyzRwbelaOK4rfM8+WU
         faHXoWxOMSz+ej1B+OBb9+lWd0EqvDy2Wp8GBZvtVCmJKzPcHjfxweXXMmVlW8TEmc8W
         3rfoPQ69vdsB/zzFb1qkKUNuyTIrIzV6aPUn83m8khlhQqJfNtRpv4Aak3zdju3obSDY
         8YJg==
X-Gm-Message-State: AOAM532xkavM4g0sxoaJRb4WNDVMQD/xJ9ZXXkwQYc1pJ/DA8nUj4wHc
        L+To45IeqzFEQpUMZ+mKUU8=
X-Google-Smtp-Source: ABdhPJxokABlNGFbwhhqfqHDqpNwgPTQ+FkAh7bDq1t2WHZy4UOcp4qY6yUQDchzB9nk58/jzXZLKQ==
X-Received: by 2002:a37:6f41:: with SMTP id k62mr11617824qkc.262.1618831820325;
        Mon, 19 Apr 2021 04:30:20 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id v3sm3641613qkb.124.2021.04.19.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Apr 2021 07:30:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YH1pygTubJHh3R9m@slm.duckdns.org>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook>
 <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry about late reply.

On Wed, Apr 07, 2021 at 08:34:24PM +0200, Peter Zijlstra wrote:
> > Given the existence of prctl and clone APIs, I don't see the reason to
> > have a separate cgroup-bound interface too (as argued by Tejun). 
> 
> IMO as long as cgroups have that tasks file, you get to support people
> using it. That means that tasks joining your cgroup need to 'inherit'

This argument doesn't really make sense to me. We don't just add things to
make interfaces orthogonal. It can be a consideration but not the only or
even one of the most important ones. There are many cases we say to not
shoot oneself in the foot and also many interfaces which are fading away or
in the process of being deprecated.

I'm not planning to deprecate the dynamic migration interfaces given the
history and usefulness in testing but the usage model of cgroup2 is clearly
defined and documented in this regard - whether the initial population of
the cgroup happens through CLONE_INTO_CGROUP or migration, for resource
tracking and control purposes, cgroup2 does not support dynamic migration
with the exception of migrations within threaded domains.

Anything is a possibility but given how this requirement is intertwined with
achieveing comprehensive resource control, a core goal of cgroup2, and
widely adopted by all the new fangled things as you put it, changing this
wouldn't be easy. Not just because some people including me are against it
but because there are inherent technical challenges and overheads to
supporting dynamic charge migration for stateful controllers and the
cost-benefit balance doesn't come out in favor.

So, the current "policy" is something like this:

* cgroupfs interface is for cgroup core features of organizing cgroups and
  processes and configuring resource configurations which preferably follow
  one of the control models defined in the doc.

* The hierarchical organization is semi-static in the sense that once a
  cgroup is populated tasks shouldn't be moved in or out of the cgroup with
  the exception of threaded domains.

* Non-resource control usages can hook into cgroup for identification /
  tagging purposes but should use the originating interface for
  interactions.

This has been consistently applied over the years now. There of course can
be exceptions but I haven't seen anything outstanding in this round of
discussion so am pretty skeptical. The actual use cases don't seem to need
it and the only argument for it is it'd be nice to have it and involves
violating the usage model.

My suggestion is going ahead with the per-process interface with cgroup
extension on mind in case actual use cases arise. Also, when planning cgroup
integration, putting dynamic migration front and center likely isn't a good
idea.

Thanks.

-- 
tejun

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D138C90E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhEUOUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhEUOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:20:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:18:55 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o59so10463286qva.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gcSoVT89qSXe4nocYLRW9MS4sDsxKKhTOScHTkeBN9Y=;
        b=urgTtW/xnWHaz7doLQYtYSq8D11lzxo8voThMcA/ItQg9p0MUqK3zFRmVHZfDLoVJN
         xDgjxoEO1qsKyZ4JKL3K2r7y6bnfXNao4rhHObeliVF82qAwed+nIg2F04MlUdzweOaW
         /7xlhn6yB8vE9mopJZlAitT/ui1FlPZp818IEpxPJuaVrHFoEthSsbGOx2l/TY+ZN99H
         bUnCXw+PNShGFexwqF1vbgsf4UMs1JNq0B879xhXW16YOk2vLXaECTp8i2Urr0bWt5+0
         XsPR+1Uts2yljjhC7vsUQ9262vHJ+vpzIu6iXLXMEdDJ/6OHRzdNNqYUmjwLGQAgYsD2
         65VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gcSoVT89qSXe4nocYLRW9MS4sDsxKKhTOScHTkeBN9Y=;
        b=f4V107YAEdfWKUq8JNYpdYZm+z0Rt4RUCb32a8ST2D1Sv+FkASXeE5p1VF/u13cs+I
         9LxqGvrEAAikzBqS1D//h90PA5R8g8hkpKG6GZ9Jjc1E8OfScDLUTVrUJwZsh8qzr6aT
         mvj+tSHXxeun626KSqm1jK7PbzJ2iH2ubwGQ+hkAZlFjvbZfm1LIfZezULjUAaAqQhA0
         rDuF2q4C80ohrNPgr6SdAiVnTrLZ9luqGKCMdjYnuxwK8cRL5tKw+nFvRM3WjrzsZWy1
         XEa2k3KByxSePtRvVKUl6Vugqn33EdlaW8yz/Tui3CDKzQ/4hXEdnIOJwmc1b3y/Vkwe
         LMiA==
X-Gm-Message-State: AOAM530lPyZZ7BB0LmkrwujD50K8HWkYQcQHdMv9Q1k59XZMeCyY4g29
        fiTaneOybnhL20TH27lGUOOcaQ==
X-Google-Smtp-Source: ABdhPJw4MI4acTVfXewYAndlKqhVsHVvyOukBFv6QRye8taCKIp9rWwsCkqHpyADxE09DC7BNs3Aig==
X-Received: by 2002:a05:6214:e82:: with SMTP id hf2mr13102543qvb.22.1621606735044;
        Fri, 21 May 2021 07:18:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7ec])
        by smtp.gmail.com with ESMTPSA id p14sm4927260qki.27.2021.05.21.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 07:18:54 -0700 (PDT)
Date:   Fri, 21 May 2021 10:18:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6] psi: fix race between psi_trigger_create/destroy
Message-ID: <YKfBTWQxPkI5jKUe@cmpxchg.org>
References: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:05:54AM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Race detected between psi_trigger_destroy/create as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. Under this modification, the
> race window is removed by initialising poll_wait and poll_timer in
> group_init which are executed only once at beginning.
> 
> psi_trigger_destroy                      psi_trigger_create
> mutex_lock(trigger_lock);
> rcu_assign_pointer(poll_task, NULL);
> mutex_unlock(trigger_lock);
> 					mutex_lock(trigger_lock);
> 					if (!rcu_access_pointer(group->poll_task)) {
> 
> 						timer_setup(poll_timer, poll_timer_fn, 0);
> 
> 						rcu_assign_pointer(poll_task, task);
> 					}
> 					mutex_unlock(trigger_lock);
> 
> synchronize_rcu();
> del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> psi_trigger_create
> 
> So, trigger_lock/RCU correctly protects destruction of group->poll_task but
> misses this race affecting poll_timer and poll_wait.
> 
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> scheduling mechanism")
> 
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

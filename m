Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657F538C56D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhEULMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEULMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:12:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A09C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dveRi8qXK4S7Aqj22wKeIeoH5nCdLs5ianbPWuy39fQ=; b=L2VxvYelKHVRJ6huw7XbvW4Wt7
        GOtFQVQ2kn4YiaqPTRlD19SSm2NzMzF3WM6KjLf14D8rSSn/1HB7NEfiUk26eE9/tDNdIKohR8/X8
        QaTZonlhsNB7OqbjZWsa9xBuuIb6IUTjrQQgl3uWnmq0xxkk0mzlx6uteInq4blh7/I4kePWNrHOl
        K1jxcDxuTbwCl1XZ1zQRuf9vpc6CEfvyseTyccwlS5YzXWnJgspbXMJCJPM6JS4XoRwascY5qAtb0
        M0amu3jwAa8BysZeCQXVSJnldK1pl98eaz3Xblu59Ke76As4xD86Dp1MVLkKqq+3zTJZ7+QxlUvRt
        tE6PyV2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk32o-0056gw-My; Fri, 21 May 2021 11:10:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DEA9300103;
        Fri, 21 May 2021 13:10:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 260803119BA4E; Fri, 21 May 2021 13:10:17 +0200 (CEST)
Date:   Fri, 21 May 2021 13:10:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6] psi: fix race between psi_trigger_create/destroy
Message-ID: <YKeVGVBavjWUFH0N@hirez.programming.kicks-ass.net>
References: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
 <CAJuCfpFOXgN8gQUv2RkqMNbDBEjHs3uaxDPWd3wD-qM6zXeAsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFOXgN8gQUv2RkqMNbDBEjHs3uaxDPWd3wD-qM6zXeAsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:11:08PM -0700, Suren Baghdasaryan wrote:
> On Thu, May 20, 2021 at 7:07 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Race detected between psi_trigger_destroy/create as shown below, which
> > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > and psi_system->poll_timer->entry->next. Under this modification, the
> > race window is removed by initialising poll_wait and poll_timer in
> > group_init which are executed only once at beginning.
> >
> > psi_trigger_destroy                      psi_trigger_create
> > mutex_lock(trigger_lock);
> > rcu_assign_pointer(poll_task, NULL);
> > mutex_unlock(trigger_lock);
> >                                         mutex_lock(trigger_lock);
> >                                         if (!rcu_access_pointer(group->poll_task)) {
> >
> >                                                 timer_setup(poll_timer, poll_timer_fn, 0);
> >
> >                                                 rcu_assign_pointer(poll_task, task);
> >                                         }
> >                                         mutex_unlock(trigger_lock);
> >
> > synchronize_rcu();
> > del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> > psi_trigger_create
> >
> > So, trigger_lock/RCU correctly protects destruction of group->poll_task but
> > misses this race affecting poll_timer and poll_wait.
> >
> > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> > scheduling mechanism")
> >
> > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This is not a valid SoB chain though; please (re)read Documentation/process/submitting-patches.rst.

> Looks good. Thanks!
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

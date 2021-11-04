Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F04459FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhKDSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:52:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKDSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:52:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5000218B8;
        Thu,  4 Nov 2021 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636051780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cISVSjvwqDLujAz5Z+uiLWh+60f+gnszz/+vLf1ax3o=;
        b=AbUx1NCNl9mQYLw8KKWsFyMBJKGikp9HL9ZM5MQCHrper+TA+X+34c36xTzm5+AYa/NgX8
        xQODDLmPBPh4zOdCrPjEGCzxf4wreKJeeMvphUWzQTXp0GhVFRw3x2GllPgN4x4La5k+wc
        6whVHU6rOyFG13tTrvNqqjPa0fL+e78=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DFC913F28;
        Thu,  4 Nov 2021 18:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p907HkQrhGG5TAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 04 Nov 2021 18:49:40 +0000
Date:   Thu, 4 Nov 2021 19:49:39 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <20211104184939.GA23576@blackbody.suse.cz>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103190613.3595047-1-minipli@grsecurity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, Nov 03, 2021 at 08:06:13PM +0100, Mathias Krause <minipli@grsecurity.net> wrote:
> When unregister_fair_sched_group() unlinks all cfs_rq's from the dying
> task group, it doesn't protect itself from getting interrupted. If the
> timer interrupt triggers while we iterate over all CPUs or after
> unregister_fair_sched_group() has finished but prior to unlinking the
> task group, sched_cfs_period_timer() will execute and walk the list of
> task groups, trying to unthrottle cfs_rq's, i.e. re-add them to the
> dying task group. These will later -- in free_fair_sched_group() -- be
> kfree()'ed while still being linked, leading to the fireworks Kevin and
> Michal are seeing.

[...]
 
>     CPU1:                                      CPU2:
>       :                                        timer IRQ:
>       :                                          do_sched_cfs_period_timer():
>       :                                            :
>       :                                            distribute_cfs_runtime():
>       :                                              rcu_read_lock();
>       :                                              :
>       :                                              unthrottle_cfs_rq():
>     sched_offline_group():                             :
>       :                                                walk_tg_tree_from(…,tg_unthrottle_up,…):
>       list_del_rcu(&tg->list);                           :
>  (1)  :                                                  list_for_each_entry_rcu(child, &parent->children, siblings)
>       :                                                    :
>  (2)  list_del_rcu(&tg->siblings);                         :
>       :                                                    tg_unthrottle_up():
>       unregister_fair_sched_group():                         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>         :                                                    :
>         list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);               :
>         :                                                    :
>         :                                                    if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
>  (3)    :                                                        list_add_leaf_cfs_rq(cfs_rq);
>       :                                                      :
>       :                                                    :
>       :                                                  :
>       :                                                :
>       :                                              :
>  (4)  :                                              rcu_read_unlock();

The list traversal (1) may happen in some scenarios (quota on non-leaf
task_group) but in the presented reproducer, the quota is set on the
leaf task_group. That means it has no children and this list iteration
is irrelevant.
The cause is that walk_tg_tree_from includes `from` task_group and
calls tg_unthrottle_up() on it too.
What I mean is that the unlinking of tg->list and tg->siblings is
irrelevant in this case.

The timer can still fire after
sched_offline_group()/unregister_fair_sched_group() finished (i.e. after
synchronize_rcu())


> This patch survives Michal's reproducer[2] for 8h+ now, which used to
> trigger within minutes before.

Note that the reproducer is sensitive to the sleep between last task
exit and cgroup rmdir. I assume that the added synchronize_rcu() before
list_del_leaf_cfs_rq() shifted the list removal after the last timer
callback and prevented re-adding of the offlined task_group in
unthrottle_cfs_rq().

(Of course, it'd more convincing if I backed this theory by results from
the reproducer with the increased interval to crash again. I may get
down to that later.)

Does your patch fix the crashes also in your real workload?

Michal

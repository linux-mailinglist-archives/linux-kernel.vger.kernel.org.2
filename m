Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5635305B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDBUkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBUkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:40:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407906115A;
        Fri,  2 Apr 2021 20:40:16 +0000 (UTC)
Date:   Fri, 2 Apr 2021 16:40:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/debug: Use sched_debug_lock to serialize use
 of cgroup_path[] only
Message-ID: <20210402164014.53c84f05@gandalf.local.home>
In-Reply-To: <20210401181030.7689-1-longman@redhat.com>
References: <20210401181030.7689-1-longman@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:10:30 -0400
Waiman Long <longman@redhat.com> wrote:

> The handling of sysrq key can be activated by echoing the key to
> /proc/sysrq-trigger or via the magic key sequence typed into a terminal
> that is connected to the system in some way (serial, USB or other mean).
> In the former case, the handling is done in a user context. In the
> latter case, it is likely to be in an interrupt context.
> 
> There should be no more than one instance of sysrq key processing via
> a terminal, but multiple instances of /proc/sysrq-trigger is possible.
> 
> Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is
> taken with interrupt disabled for the whole duration of the calls to
> print_*_stats() and print_rq() which could last for the quite some time
> if the information dump happens on the serial console.
> 
> If the system has many cpus and the sched_debug_lock is somehow busy
> (e.g. parallel sysrq-t), the system may hit a hard lockup panic
> depending on the actually serial console implementation of the
> system. For instance,

Wouldn't placing strategically located "touch_nmi_watchdog()"s around fix
this?

-- Steve

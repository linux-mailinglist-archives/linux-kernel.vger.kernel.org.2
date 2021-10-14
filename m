Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2442DC03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJNOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhJNOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:50:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB0660EE2;
        Thu, 14 Oct 2021 14:48:13 +0000 (UTC)
Date:   Thu, 14 Oct 2021 10:48:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Message-ID: <20211014104811.356e11ae@gandalf.local.home>
In-Reply-To: <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
References: <20211010102429.99577-4-laoar.shao@gmail.com>
        <20211014072707.GA18719@xsang-OptiPlex-9020>
        <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
        <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
        <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
        <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
        <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
        <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
        <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 22:40:04 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > mount -t tracefs nodev /sys/kernel/tracing
> > cat /sys/kernel/tracing/events/sched/sched_switch/format
> >
> > name: sched_switch
> > ID: 314
> > format:
> > [...]
> >         field:char prev_comm[16];       offset:8;       size:16;        signed:1;
> > [...]
> >         field:char next_comm[16];       offset:40;      size:16;        signed:1;
> >
> > Both of those fields expose a fixed-size of 16 bytes.
> >
> > AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
> > changes in the event field layout. Unfortunately, there have been cases where
> > trace viewers had a hard expectation on the field layout. Hopefully those have
> > all been fixed a while ago.
> >  
> 
> I don't have a clear idea what will happen to trace viewers if we
> extend task comm.

There shouldn't be any doing a hard coded read of the events. That happened
once with powertop, but they broke when they ran 32 bit userspace on a 64
bit kernel, and they switched to libtraceevent to fix it. Which handles
these updates.

> 
> Steven, do you have any suggestions ?

The "Don't break user space" is a "tree in the forest" argument. We break
user space all the time. But if no user space tool is around to hear it,
did it really break? The answer is "no".

-- Steve

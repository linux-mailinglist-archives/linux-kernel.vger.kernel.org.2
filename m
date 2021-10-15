Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2D42E664
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhJOCQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhJOCQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC20C60FDA;
        Fri, 15 Oct 2021 02:14:11 +0000 (UTC)
Date:   Thu, 14 Oct 2021 22:14:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        acme <acme@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20211014221409.5da58a42@oasis.local.home>
In-Reply-To: <CALOAHbAQ06+G776+7WqWBag+Q1gO5M+Qg3axYd4=Tpbzx1i=tg@mail.gmail.com>
References: <20211010102429.99577-4-laoar.shao@gmail.com>
        <20211014072707.GA18719@xsang-OptiPlex-9020>
        <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
        <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
        <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com>
        <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com>
        <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
        <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
        <CALOAHbAhT1bTAThrmA1zYE5q8shR4dxZf5fqcq_9wVrV+XwVEQ@mail.gmail.com>
        <202110140910.295E856@keescook>
        <CALOAHbAQ06+G776+7WqWBag+Q1gO5M+Qg3axYd4=Tpbzx1i=tg@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 10:05:56 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > I'd say we need a TASK_COMM_LEN_V1 to use in all the old hard-coded
> > places.
> >  
> 
> Sure, it will be easy to grep then.

Just because I'm picky about my bikeshed colors...


Perhaps have it called TASK_COMM_LEN_16 ?

The reason being, I have no idea what "V1" is. Version 1? What's that
mean? And now TASK_COMM_LEN can be either 16 or 24. Perhaps we can have
it be:

#define TASK_COMM_LEN_16	16
#define TASK_COMM_LEN_24	24

if CONFIG_BASE_SMALL
#define TASK_COMM_LEN			TASK_COMM_LEN_16
#else
#define TASK_COMM_LEN			TASK_COMM_LEN_24
#endif

or call it TASK_COMM_LEN_SMALL and TASK_COMM_LEN_LARGE

??

It's still "grepable"

-- Steve

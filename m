Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48842D056
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNC01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhJNC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:26:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E6A610E5;
        Thu, 14 Oct 2021 02:24:20 +0000 (UTC)
Date:   Wed, 13 Oct 2021 22:24:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in
 proc_comm_connector
Message-ID: <20211013222418.7ea9727d@oasis.local.home>
In-Reply-To: <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
        <20211013102346.179642-3-laoar.shao@gmail.com>
        <20211013101921.0843aaf0@gandalf.local.home>
        <CALOAHbCt+rLiPE4_zZO_f5sKybKwYntqupx_L9V_J+yByoFvOw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 09:48:09 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > __get_task_comm() uses strncpy() which my understanding is, does not add
> > the nul terminating byte when truncating. Which changes the functionality
> > here. As all task comms have a terminating byte, the old method would copy
> > that and include it. This won't add the terminating byte if the buffer is
> > smaller than the comm, and that might cause issues.
> >  
> 
> Right, that is a problem.
> It seems that we should add a new helper get_task_comm_may_truncated().

Or simply change __get_task_comm() to:

char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
{
	task_lock(tsk);
	strncpy(buf, tsk->comm, buf_size);
	/* The copied value is always nul terminated */
	buf[buf_size - 1] = '\0';
	task_unlock(tsk);
	return buf;
}

But that should probably be a separate patch.

-- Steve

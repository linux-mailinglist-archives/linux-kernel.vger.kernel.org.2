Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273DB41FF7B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJCDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 23:45:39 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41982 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCDpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:45:38 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWsNV-009Xb4-JT; Sun, 03 Oct 2021 03:41:29 +0000
Date:   Sun, 3 Oct 2021 03:41:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kthread: increase the size of kthread's comm
Message-ID: <YVkmaSUxbg/JtBHb@zeniv-ca.linux.org.uk>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:31AM +0000, Yafang Shao wrote:

> That motivates me to do this improvement.
> 
> This patch increases the size of ktread's comm from 16 to 24, which is
> the same with workqueue's. After this change, the name of kthread can be
> fully displayed in /proc/[pid]/comm, for example,
>     
>     rcu_tasks_kthread
>     rcu_tasks_rude_kthread
>     rcu_tasks_trace_kthread
>     ecryptfs-kthread
>     vfio-irqfd-cleanup
>     ext4-rsv-conversion
>     jbd2/nvme0n1p2-8
>     ...
>     
> Because there're only a few of kthreads, so it won't increase too much
> memory consumption.

That's a bloody massive overkill.  If you care about /proc/*/comm, you
might want to take a look at the function that generates its contents:

void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
{
        char tcomm[64];

        if (p->flags & PF_WQ_WORKER)
                wq_worker_comm(tcomm, sizeof(tcomm), p);
        else   
                __get_task_comm(tcomm, sizeof(tcomm), p);

        if (escape)
                seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
        else   
                seq_printf(m, "%.64s", tcomm);
}

Hint: it's not always p->comm verbatim...

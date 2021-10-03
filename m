Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397A941FF77
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 05:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhJCDdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 23:33:39 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41872 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCDdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:33:37 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWsDz-009XUP-Fx; Sun, 03 Oct 2021 03:31:39 +0000
Date:   Sun, 3 Oct 2021 03:31:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] kernel: replace sizeof(task->comm) with TASK_COMM_LEN
Message-ID: <YVkkG+KOV6GQBAUf@zeniv-ca.linux.org.uk>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-2-laoar.shao@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:32AM +0000, Yafang Shao wrote:

> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2265,7 +2265,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
>  	struct task_struct *me = current;
> -	unsigned char comm[sizeof(me->comm)];
> +	unsigned char comm[TASK_COMM_LEN];
>  	long error;
>  
>  	error = security_task_prctl(option, arg2, arg3, arg4, arg5);

Slightly below you have this:
        case PR_SET_NAME:
                comm[sizeof(me->comm) - 1] = 0;
                if (strncpy_from_user(comm, (char __user *)arg2,
                                      sizeof(me->comm) - 1) < 0)
                        return -EFAULT;
                set_task_comm(me, comm);
                proc_comm_connector(me);
                break;

How had that been tested?

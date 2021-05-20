Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DAA38ACD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbhETLt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241613AbhETL1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621509975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqNfPIxIDmqFlBeVEmMp4wkx0fm6Zo+X3532NE3LEc4=;
        b=SU6XlUHSjsUKY9kB25dfVXQOqOY1IQ2sWs77YhL2HANF3qiNJNgUC3QRsbQnosBqxLWV9K
        1l9MF2P059V77UXwJQQcZ8eMUUxj+R4WqJ66BK+qb2aD650bsM9h+g8E91PTecH4hXcxw5
        Oe40taPMTPJOn/LjXWhG7cNnyxXrdek=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7879AAC85;
        Thu, 20 May 2021 11:26:15 +0000 (UTC)
Date:   Thu, 20 May 2021 13:26:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Martin Liu <liumartin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com, www@google.com,
        davidchao@google.com, jenhaochen@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-ID: <YKZHV7TIZ0QALfWd@alley>
References: <20210513065458.941403-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513065458.941403-1-liumartin@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-13 14:54:57, Martin Liu wrote:
> We encountered a system hang issue while doing the tests. The callstack
> is as following
> 
> 	schedule+0x80/0x100
> 	schedule_timeout+0x48/0x138
> 	wait_for_common+0xa4/0x134
> 	wait_for_completion+0x1c/0x2c
> 	kthread_flush_work+0x114/0x1cc
> 	kthread_cancel_work_sync.llvm.16514401384283632983+0xe8/0x144
> 	kthread_cancel_delayed_work_sync+0x18/0x2c
> 	xxxx_pm_notify+0xb0/0xd8
> 	blocking_notifier_call_chain_robust+0x80/0x194
> 	pm_notifier_call_chain_robust+0x28/0x4c
> 	suspend_prepare+0x40/0x260
> 	enter_state+0x80/0x3f4
> 	pm_suspend+0x60/0xdc
> 	state_store+0x108/0x144
> 	kobj_attr_store+0x38/0x88
> 	sysfs_kf_write+0x64/0xc0
> 	kernfs_fop_write_iter+0x108/0x1d0
> 	vfs_write+0x2f4/0x368
> 	ksys_write+0x7c/0xec
> 
> When we started investigating, we found race between
> kthread_mod_delayed_work vs kthread_cancel_delayed_work_sync. The race's
> result could be simply reproduced as a kthread_mod_delayed_work with
> a following kthread_flush_work call.
> 
> Thing is we release kthread_mod_delayed_work kspin_lock in
> __kthread_cancel_work so it opens a race window for
> kthread_cancel_delayed_work_sync to change the canceling count used to
> prevent dwork from being requeued before calling kthread_flush_work.
> However, we don't check the canceling count after returning from
> __kthread_cancel_work and then insert the dwork to the worker. It
> results the following kthread_flush_work inserts flush work to dwork's
> tail which is at worker's dealyed_work_list. Therefore, flush work will
> never get moved to the worker's work_list to be executed. Finally,
> kthread_cancel_delayed_work_sync will NOT be able to get completed and
> wait forever. The code sequence diagram is as following
> 
> Thread A                Thread B
> kthread_mod_delayed_work
>   spin_lock
>    __kthread_cancel_work
>     canceling = 1
>     spin_unlock
>                         kthread_cancel_delayed_work_sync
>                           spin_lock
>                             kthread_cancel_work
>                           canceling = 2
>                           spin_unlock
>     del_timer_sync
>     spin_lock
>     canceling = 1 // canceling count gets update in ThreadB before
>   queue_delayed_work // dwork is put into the woker’s dealyed_work_list
>                         without checking the canceling count
>  spin_unlock
>                           kthread_flush_work
>                             spin_lock
>                             Insert flush work // at the tail of the
> 			                         dwork which is at
> 						 the worker’s
> 						 dealyed_work_list
>                             spin_unlock
>                             wait_for_completion // Thread B stuck here as
> 			                           flush work will never
> 						   get executed
> 
> The canceling count could change in __kthread_cancel_work as the spinlock
> get released and regained in between, let's check the count again before
> we queue the delayed work to avoid the race.
> 
> Fixes: 37be45d49dec2 ("kthread: allow to cancel kthread work")
> Tested-by: David Chao <davidchao@google.com>
> Signed-off-by: Martin Liu <liumartin@google.com>

Great catch! The patch makes perfect sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Andrew, could you please queue it via -mm tree?

Best Regards,
Petr

PS: I am sorry for the late review. I was somehow busy last week
    it it has fallen too low in the mailbox :-(

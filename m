Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5938AD09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbhETLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240774AbhETLpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621511070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28mF/7bespDFnYavsMGSNSGY5smp1fCtQdpn6i6oUOs=;
        b=utRS91/SokUL5RPDZ62P88VybSKGSjU1zpF0XQpfa2kPhcJGRNTCZGap6N7yKV7kvMe0q2
        ZF0z0TzkV8BVr94IXSiHklVN2sh1bHfrsOlasUphaeUb04yrCh24AJt983ETG/fCAD3Lrw
        09ACTyc76dttMFhksgdRHH7oFAgCdyM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36253ABCD;
        Thu, 20 May 2021 11:44:30 +0000 (UTC)
Date:   Thu, 20 May 2021 13:44:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Martin Liu <liumartin@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, minchan@google.com, www@google.com,
        davidchao@google.com, jenhaochen@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-ID: <YKZLnTNOlUQ85F2s@alley>
References: <20210513065458.941403-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

One more thing.

This scenario might mean that the kthread_worker API is used a wrong way.

kthread_cancel_delayed_work_sync() is typically called when the work
should never run any longer. But the parallel
kthread_mod_delayed_work() might queue it right after
kthread_cancel_delayed_work_sync() succeded. As a result that work
might get procced even when it was cancelled.

The API caller should prevent this race. It should have its own logic
around kthread_worker_queue*() and kthread_worker_mod_delayed_work()
calls that will prevent calling these when the work should
stay cancelled. For example, see

	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
		kthread_queue_delayed_work(w_data->worker,
					   &w_data->idle_injection_work,
					   sleeptime);

in clamp_idle_injection_func().

Best Regards,
Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9AF389357
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355158AbhESQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347757AbhESQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:13:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF14C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:11:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so7302070plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t7n0Ls+OtKwvCY7O6AjIzNmvldq33XzdrqIXKag52q8=;
        b=ZxP4q+E8k0wlFjr0hizaM2R8U0kd8vrNRzf/qYI90sUefFPNcNiGFnIZOQZ1pr9pOx
         lIeTY/n/h+zulZC2jbuBL22jwgGRBIqp32raPZvhC1UgO1pftAMSwUYG2ZRoA4jG8oNs
         uvpBKhiFaD6h/QUK0oeBMGbKhchgyGs/AzYi+TwiW/VL9AmEu0Y8p8tJSPTfvBqeE7p2
         uB+yFcTz0e6MClKKNC1HN2/Hvp/UbB9BifFdTsaiOs2aeN6gdNmocRhLnXGyHPp1wZCe
         DwJLC4Jvd54bB7kA3I9AxWiI9Hh7Tm3WxBqxOtZrqZNlir6cIVE6a+ol1TquiPlcope4
         UBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t7n0Ls+OtKwvCY7O6AjIzNmvldq33XzdrqIXKag52q8=;
        b=PmPU5wSgKahNvtdmF78nkYaBcQXxjEBcBqcDELyHeRmfIsqf4A0XVt2F48QSjQYjnu
         FnVLqbpgDdZKeHZBcHTvUCwxY/0bqx3yfL2tXjr3+hJ+FQdwjtyJG0pq/z9tYnjWdOGE
         hnawQecIxoiCmiVvh8qlSo8xT0bw3syF56JTiFbf4Dog7uofmFE9uPhcKQN/+NFAopKd
         nV7qaY3xL/gESs1x5SGgQFfjRZ3+DhHvj+iNBMY+3jAyQGtcNrHc/EMuZ4hPe2OdESzd
         ULFyv/82VU8OmJmv8PvPnlHU7H48N1bschwyjy+LT3qIIxVimu45W6MZS9qLdPLLdkuY
         Z0+Q==
X-Gm-Message-State: AOAM530l47LOuNN/7EHR30SlxokWDaqhUj/04cNkAmJ2VclGaMAHUGLQ
        E6ahT8dFi9ZjTHWp2auwVHuiJA==
X-Google-Smtp-Source: ABdhPJwwwzGsDlN4StBk8yx5XRScKgYCkoDGGRjp43WnI1bi8x3zWp2MKDmIrKj4V9+Xoooi/t5MZQ==
X-Received: by 2002:a17:90a:8688:: with SMTP id p8mr71425pjn.37.1621440714988;
        Wed, 19 May 2021 09:11:54 -0700 (PDT)
Received: from google.com ([2401:fa00:fc:202:761b:68c0:185b:8860])
        by smtp.gmail.com with ESMTPSA id t7sm8487221pjr.29.2021.05.19.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:11:54 -0700 (PDT)
Date:   Thu, 20 May 2021 00:11:47 +0800
From:   Martin Liu <liumartin@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     minchan@google.com, www@google.com, davidchao@google.com,
        jenhaochen@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-ID: <YKU4w9pDWn3lj1V+@google.com>
References: <20210513065458.941403-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513065458.941403-1-liumartin@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Could I get some help for reviewing this patch? Thank you.

On Thu, May 13, 2021 at 02:54:57PM +0800, Martin Liu wrote:
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
> ---
>  kernel/kthread.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index fe3f2a40d61e..064eae335c1f 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1181,6 +1181,19 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>  		goto out;
>  
>  	ret = __kthread_cancel_work(work, true, &flags);
> +
> +	/*
> +	 * Canceling could run in parallel from kthread_cancel_delayed_work_sync
> +	 * and change work's canceling count as the spinlock is released and regain
> +	 * in __kthread_cancel_work so we need to check the count again. Otherwise,
> +	 * we might incorrectly queue the dwork and further cause
> +	 * cancel_delayed_work_sync thread waiting for flush dwork endlessly.
> +	 */
> +	if (work->canceling) {
> +		ret = false;
> +		goto out;
> +	}
> +
>  fast_queue:
>  	__kthread_queue_delayed_work(worker, dwork, delay);
>  out:
> -- 
> 2.31.1.607.g51e8a6a459-goog
> 

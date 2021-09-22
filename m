Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20A541408F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhIVE2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhIVE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632284843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuPNzSc1xq7ojG5bGphV95EXs7lOrOu+HqPJxaJcYAs=;
        b=Aig1Ng8njS9cvS6CwFZmNqjN7bXXfXY73DmoLTKiOYJN2WBYOeAyzbW3oed5GdHG06DpSq
        PlCB7qKcivlzpRI4N3GCiznS6z60IvTKZQvHm6lcgbPnJH/PzNf/WHZ1mix0lHOvJl5fAC
        aFiEAWxsaFxNtjdukCj7Yektp8pYUGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-mbnnFDW_NUe9kp-mY2F35A-1; Wed, 22 Sep 2021 00:27:21 -0400
X-MC-Unique: mbnnFDW_NUe9kp-mY2F35A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA19802936;
        Wed, 22 Sep 2021 04:27:18 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50917380;
        Wed, 22 Sep 2021 04:27:00 +0000 (UTC)
Date:   Wed, 22 Sep 2021 12:26:57 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface
 for async model
Message-ID: <YUqwkXkIu9Wx+Btg@piliu.users.ipa.redhat.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-4-kernelfans@gmail.com>
 <YUMAUE5RFJAtAS/z@alley>
 <YUMB+ghuYiuhNm2D@alley>
 <YUS3K4D6OlGybQ9G@piliu.users.ipa.redhat.com>
 <YUhEXj88J3olXRB1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUhEXj88J3olXRB1@alley>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:20:46AM +0200, Petr Mladek wrote:
> On Fri 2021-09-17 23:41:31, Pingfan Liu wrote:
[...]
> > 
> > I had thought about queue_work_on() in watchdog_nmi_enable(). But since
> > this work will block the worker kthread for this cpu. So finally,
> > another worker kthread should be created for other work.
> 
> This is not a problem. workqueues use a pool of workers that are
> already created and can be used when one worker gets blocked.
> 
Yes, you are right. The creation is dynamic and immune to blocking.

> > But now, I think queue_work_on() may be more neat.
> > 
> > > must wait in a loop until someone else stop it and read
> > > the exit code.
> > > 
> > Is this behavior mandotory? Since this kthread can decide the exit
> > condition by itself.
> 
> I am pretty sure. Unfortunately, I can't find it in the documentation.
> 
> My view is the following. Each process has a task_struct. The
> scheduler needs task_struct so that it can switch processes.
> The task_struct must still exist when the process exits.
> The scheduler puts the task into TASK_DEAD state.
> Another process has to read the exit code and destroy the
> task struct.
> 
Thanks for bringing up this, and I have an opportunity to think about it.

The core of the problem is put_task_struct(), and who releases the
last one.
It should be: finish_task_switch()->put_task_struct_rcu_user()->delayed_put_task_struct()->put_task_struct(),
if (unlikely(prev_state == TASK_DEAD)). It does not depend on another task.

> See, do_exit() in kernel/exit.c. It ends with do_dead_task().
> It is the point when the process goes into TASK_DEAD state.
> 
> For a good example, see lib/test_vmalloc.c. The kthread waits
> until anyone want him to stop:
> 
> static int test_func(void *private)
> {
> [...]
> 
> 	/*
> 	 * Wait for the kthread_stop() call.
> 	 */
> 	while (!kthread_should_stop())
> 		msleep(10);
> 
> 	return 0;
> }
> 
> The kthreads are started and stopped in:
> 
> static void do_concurrent_test(void)
> {
> [...]
> 	for (i = 0; i < nr_threads; i++) {
> [...]
> 		t->task = kthread_run(test_func, t, "vmalloc_test/%d", i);
> [...]
> 	/*
> 	 * Sleep quiet until all workers are done with 1 second
> 	 * interval. Since the test can take a lot of time we
> 	 * can run into a stack trace of the hung task. That is
> 	 * why we go with completion_timeout and HZ value.
> 	 */
> 	do {
> 		ret = wait_for_completion_timeout(&test_all_done_comp, HZ);
> 	} while (!ret);
> [...]
> 	for (i = 0; i < nr_threads; i++) {
> [...]
> 		if (!IS_ERR(t->task))
> 			kthread_stop(t->task);
> [...]
> }

They are good and elegant examples.
> 
> 
> You do not have to solve this if you use the system workqueue
> (system_wq).
> 
Yes, workqueue is a better choice.

Thanks for your great patience.


Regards,

	Pingfan



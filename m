Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC673A3319
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhFJSbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:31:01 -0400
Received: from foss.arm.com ([217.140.110.172]:38938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhFJSbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:31:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99DFC106F;
        Thu, 10 Jun 2021 11:29:03 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DCD73F719;
        Thu, 10 Jun 2021 11:29:02 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from being inherited by various init system threads")
In-Reply-To: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 10 Jun 2021 19:28:57 +0100
Message-ID: <8735tpd15i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 10:04, Paul E. McKenney wrote:

Hi,
> Hello, Frederic,
>
> This commit works well, but has the unfortunate side-effect of making
> smp_processor_id() complain when used in a preemptible region even
> though the kthread has been pinned onto a single CPU by a call to
> set_cpus_allowed_ptr().  (Which did return success.)
>

On which tree are you encountering this?

Looking at check_preemption_disabled() and CPU affinity, v5.13-rc5 has:

        /*
         * Kernel threads bound to a single CPU can safely use
         * smp_processor_id():
         */
        if (current->nr_cpus_allowed == 1)
                goto out;

tip/sched/core additionally hinges that on PF_NO_SETAFFINITY:

  570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")

The former shouldn't be affected by Frederic's patch, and the latter should
only cause warnings if the pinned task isn't a "proper" kthread (thus
doesn't have PF_NO_SETAFFINITY)... Exceptions that come to mind are things
like UMH which doesn't use kthread_create().

> This isn't a big deal -- I can easily switch to raw_smp_processor_id(),
> which is arguably a better choice anyway because it prevents the
> complaints from flooding out any real warnings due to error returns
> from set_cpus_allowed_ptr() or something else unpinning the kthread.
> Which I am in the process of doing:
>
> 516e52e9f5ec ("scftorture: Avoid excess warnings")
> 475d6d49f21d ("refscale: Avoid excess warnings in ref_scale_reader()")
>
> But I figured that I should check to see if this change was in fact
> intentional.
>
>                                                       Thanx, Paul

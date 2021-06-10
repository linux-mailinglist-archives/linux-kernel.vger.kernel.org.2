Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76DB3A34B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFJUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFJUTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:19:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1BE96139A;
        Thu, 10 Jun 2021 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623356233;
        bh=nhEn6DbWrwaK255UgkRjv7t7Hm+VJsFrnmQKWYlFQTc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VLZmoep3lo4evx0jYG0euA5dEpwIkS0KwTCiK83JkcoTvTApqQtoutG9uLVHJTjWY
         RHh1Lc+KpehDi7+aon62xUTzqTlEeGjkrStw40IKyvhsFbCZ90tddzkpsKV58o2ANc
         SJF9tdMSh0ylkK4x8/hHyT9srwmoVxgfer5buWvvnC/me441m8PHdwpj5Lj6IwdPyA
         LD2kBVmd3qA/7HXX2BMxeEkHII+pvE3ss6av3IYCjbtGmv9gs8HASUXxzTflB/SBBy
         pt4s3habv5FVkcsl9CYd6AjaFlaLTfTMiJTdKNG0zY65EgvGttNkH1yQZT99Hw5nyI
         ize0X2cHb6H5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B9345C04C6; Thu, 10 Jun 2021 13:17:13 -0700 (PDT)
Date:   Thu, 10 Jun 2021 13:17:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from
 being inherited by various init system threads")
Message-ID: <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
 <8735tpd15i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735tpd15i.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:28:57PM +0100, Valentin Schneider wrote:
> On 10/06/21 10:04, Paul E. McKenney wrote:
> 
> Hi,
> > Hello, Frederic,
> >
> > This commit works well, but has the unfortunate side-effect of making
> > smp_processor_id() complain when used in a preemptible region even
> > though the kthread has been pinned onto a single CPU by a call to
> > set_cpus_allowed_ptr().  (Which did return success.)
> >
> 
> On which tree are you encountering this?

I bisected to this commit in -next tag next-20210609, and this commit
could of course be an innocent bystander caught in the crossfire.

> Looking at check_preemption_disabled() and CPU affinity, v5.13-rc5 has:
> 
>         /*
>          * Kernel threads bound to a single CPU can safely use
>          * smp_processor_id():
>          */
>         if (current->nr_cpus_allowed == 1)
>                 goto out;
> 
> tip/sched/core additionally hinges that on PF_NO_SETAFFINITY:
> 
>   570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
> 
> The former shouldn't be affected by Frederic's patch, and the latter should
> only cause warnings if the pinned task isn't a "proper" kthread (thus
> doesn't have PF_NO_SETAFFINITY)... Exceptions that come to mind are things
> like UMH which doesn't use kthread_create().

And reverting 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread()
instead of nr_cpus_allowed") causes the kernel to once again be OK with
smp_processor_id(), so thank you!  And apologies to Frederic for the
false alarm.

Added Yejune on CC.  Thoughts?

							Thanx, Paul

> > This isn't a big deal -- I can easily switch to raw_smp_processor_id(),
> > which is arguably a better choice anyway because it prevents the
> > complaints from flooding out any real warnings due to error returns
> > from set_cpus_allowed_ptr() or something else unpinning the kthread.
> > Which I am in the process of doing:
> >
> > 516e52e9f5ec ("scftorture: Avoid excess warnings")
> > 475d6d49f21d ("refscale: Avoid excess warnings in ref_scale_reader()")
> >
> > But I figured that I should check to see if this change was in fact
> > intentional.
> >
> >                                                       Thanx, Paul

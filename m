Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021B23A422D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFKMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhFKMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:44:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D9F613EA;
        Fri, 11 Jun 2021 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623415335;
        bh=GTGqCNvv+zgEh7y/tQSHhbtsrEkz7+mSU0+uhfVNAcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAi7+dvfGCaFhklZ7xvXMZscHDQSnVXu58LgwTsv/WSe3LXDvmhoD8HguGptZl5CP
         Y+37XdC5Z+ByKDMKl/nKPdgkE2Gqna/eJkcv5x/Y33P9ESsx1o55RSdsTc2o3cMO0Z
         LkHeI48EbaOkiiuapB9Wzw/VqbSuaHyYzIK/ukHbJv3B1xkSVNnC6xFanQ10t3Xg4W
         DAonK8Q1e7rhvlhK/M+7G3bucULySsNiMtBRG9uFftI2lnyGffZfgANjSuFM1ZxoTL
         hcIl9YltYG3gU//d3Ftyl7NsAQlibMBFeV0zOCjOLydkoPCE36xrZ22UjizOahdmV1
         VaX/P2HaeuViQ==
Date:   Fri, 11 Jun 2021 14:42:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from
 being inherited by various init system threads")
Message-ID: <20210611124212.GB143945@lothringen>
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
 <8735tpd15i.mognet@arm.com>
 <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 01:17:13PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 10, 2021 at 07:28:57PM +0100, Valentin Schneider wrote:
> > On 10/06/21 10:04, Paul E. McKenney wrote:
> > 
> > Hi,
> > > Hello, Frederic,
> > >
> > > This commit works well, but has the unfortunate side-effect of making
> > > smp_processor_id() complain when used in a preemptible region even
> > > though the kthread has been pinned onto a single CPU by a call to
> > > set_cpus_allowed_ptr().  (Which did return success.)
> > >
> > 
> > On which tree are you encountering this?
> 
> I bisected to this commit in -next tag next-20210609, and this commit
> could of course be an innocent bystander caught in the crossfire.
> 
> > Looking at check_preemption_disabled() and CPU affinity, v5.13-rc5 has:
> > 
> >         /*
> >          * Kernel threads bound to a single CPU can safely use
> >          * smp_processor_id():
> >          */
> >         if (current->nr_cpus_allowed == 1)
> >                 goto out;
> > 
> > tip/sched/core additionally hinges that on PF_NO_SETAFFINITY:
> > 
> >   570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
> > 
> > The former shouldn't be affected by Frederic's patch, and the latter should
> > only cause warnings if the pinned task isn't a "proper" kthread (thus
> > doesn't have PF_NO_SETAFFINITY)... Exceptions that come to mind are things
> > like UMH which doesn't use kthread_create().
> 
> And reverting 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread()
> instead of nr_cpus_allowed") causes the kernel to once again be OK with
> smp_processor_id(), so thank you!  And apologies to Frederic for the
> false alarm.
> 
> Added Yejune on CC.  Thoughts?

There is also that:

      15faafc6b449777a85c0cf82dd8286c293fed4eb ("sched,init: Fix DEBUG_PREEMPT
      vs early boot")

Not sure if that will help but just in case.

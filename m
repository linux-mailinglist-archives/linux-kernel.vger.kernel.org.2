Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC32417F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 04:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347468AbhIYCkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 22:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhIYCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 22:40:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E3C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 19:39:02 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d11so12529374ilc.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWAYMVNHtXup5aPwH6prT1Pq6F0TRS7iB3SGBeiqB1Q=;
        b=L2zITUTB/YeIDUuvlQdAApm5xokDkN4/EYkZCZota2eOtbrPUCcsA0dp0Re9clkgmi
         jVAFvVPeVV41ESr2BojS1QY42VM2+xUcJk2MTdU5ngJnH8xGrQWWw0eHfN1YsuE1P523
         0XbWa36h6Adwb6jWW2bOgm/8fQ3mMW1LTCzTLjkxmRISOVq4ikrnGBT+iZe3fqUV2iY3
         rYPaTko19cGJjGhoPMyGQT4eu/Mc447t++OuhRKIFBkxPwLv5CGPXhiXN2lkfcwf9jpu
         2zORPh2DpHV+aKvVQHE4nvnRYE4BsFGHw3g2/rQw3wYT3hWU2jHLUc9AS1s/u8lvUun0
         z+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWAYMVNHtXup5aPwH6prT1Pq6F0TRS7iB3SGBeiqB1Q=;
        b=7cIMpq8VIhQ3S13AgOCxar/7ZGqE2KvwGdAoTY3PcMjbC0aip9Wg1LNEUJlGIWqp09
         1MIgMjqz60sQXzg9Og4HHzmxA9nrLCVgUWKJdEurTIxHI7JUtExpoyVt2JFXj3IurTQ9
         GfdGebePryJS4XqXRXH8PIKL6UjXKGujSgdU9rdRI1izPFEkXW0epoKoYCh4gOEDBvij
         nDIqhslirWUGojLhZm/i4omRitg6MgWYwy9e+Oh1KA34beWhAYtVAQUml4ZeAJvcJffS
         F9G+cJoOHaVhfxrSomoOfldVhqUBdUjwiJgjNWrEWWIbfyvwiBmzIZbY+WVjqofJmFqK
         w8GQ==
X-Gm-Message-State: AOAM530K7T1eJ2lN26QpKKjcXHlDzb1IQsVXdfeoTRdthkAy+8hj3iAO
        6fvLQ0Ear5di7Vk6QS0tVVs=
X-Google-Smtp-Source: ABdhPJw7LHIObpNGoSZM08pcfzMVMRbCXLTKSqCwUp0LEJg0EdGMamRhXfxdt2IXJYuIhMIYgxKeNQ==
X-Received: by 2002:a05:6e02:1887:: with SMTP id o7mr10563076ilu.12.1632537541991;
        Fri, 24 Sep 2021 19:39:01 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e10sm4902532ili.53.2021.09.24.19.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 19:39:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id C8CE027C0054;
        Fri, 24 Sep 2021 22:38:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 Sep 2021 22:38:59 -0400
X-ME-Sender: <xms:wotOYUlfAP2aznsCHxNscaJkNEoqYLLFspNqR3kAoCmwTGELAYwTZQ>
    <xme:wotOYT1EBnzG-b9Rn9XVQ6geHFGH4FtpWum2zQKSKFvXR2uj5T8Arh1rAaU7FiFFZ
    Pi6fEcITOZOHX9L7w>
X-ME-Received: <xmr:wotOYSo0ljX_DnhcgZiI7DYqb9cMD3L139JCxhrvvcmbSJnU4hHMhmUCb5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:wotOYQlebYsurLMBAQdU3Glrz3ZythDel71ftcLBbSwhXsAumfURog>
    <xmx:wotOYS3knFpamQaI1eQIuyzMNusSy44O2rYCmSAqmw-jEUN8PEZb0g>
    <xmx:wotOYXsxMGqHifHDkgkn-aF4kjRJYIAdleYUxmpQyTPfPHcZnnaOgg>
    <xmx:w4tOYcooWHY0fhZsgh093YL1SlNLZzoQmOd3k0WSpWV74XRYOpoGnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Sep 2021 22:38:58 -0400 (EDT)
Date:   Sat, 25 Sep 2021 10:38:28 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        richard@nod.at
Subject: Re: Confusing lockdep splat
Message-ID: <YU6LpI+nSmFcVP4G@boqun-archlinux>
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
 <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
 <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:43:37PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 24, 2021 at 05:41:17PM -0400, Waiman Long wrote:
> > On 9/24/21 5:02 PM, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > I got the lockdep splat below from an SRCU-T rcutorture run, which uses
> > > a !SMP !PREEMPT kernel.  This is a random event, and about half the time
> > > it happens within an hour or two.  My reproducer (on current -rcu "dev"
> > > branch for a 16-CPU system) is:
> > > 
> > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
> > > 
> > > My points of confusion are as follows:
> > > 
> > > 1.	The locks involved in this deadlock cycle are irq-disabled
> > > 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
> > > 	There is only one CPU.	There is no possibility of preemption
> > > 	or interrupts.	So how can this deadlock actually happen?
> > > 
> > > 2.	If there was more than one CPU, then yes, there would be
> > > 	a deadlock.  The PI lock is acquired by the wakeup code after
> > > 	acquiring the workqueue lock, and rcutorture tests the new ability
> > > 	of the scheduler to hold the PI lock across rcu_read_unlock(),
> > > 	and while it is at it, across the rest of the unlock primitives.
> > > 
> > > 	But if there was more than one CPU, Tree SRCU would be used
> > > 	instead of Tiny SRCU, and there would be no wakeup invoked from
> > > 	srcu_read_unlock().
> > > 
> > > 	Given only one CPU, there is no way to complete the deadlock
> > > 	cycle.
> > > 
> > > For now, I am working around this by preventing rcutorture from holding
> > > the PI lock across Tiny srcu_read_unlock().
> > > 
> > > Am I missing something subtle here?
> > 
> > I would say that the lockdep code just doesn't have enough intelligence to
> > identify that deadlock is not possible in this special case. There are
> > certainly false positives, and it can be hard to get rid of them.
> 
> Would it make sense for lockdep to filter out reports involving more
> than one CPU unless there is at least one sleeplock in the cycle?
> 

I think SRCU is special here, because it has different implementations
in SMP and UP. For other code, if the implemenation in SMP and UP is the
same, we want lockdep to detect the deadlock even if it's not in UP.

We can provide an annotation similar to data_race() for SRCU to mark
UP-only code

	#define LOCKDEP_UP_ONLY(expr) ({			\
		BUILD_BUG_ON(IS_ENABLED(CONFIG_SMP));		\

		<disable lockdep>
		<...> v = expr;
		<enable lockdep>
		v
	})

and in __srcu_read_unlock():

	LOCKDEP_UP_ONLY(swake_up_one(...));

Thoughts?

Regards,
Boqun

> Of course, it gets more complicated when interrupts are involved...
> 
> 							Thanx, Paul

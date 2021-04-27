Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9036C743
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhD0NuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:50:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42677 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236347AbhD0Ntx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:49:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 60E3DFB2;
        Tue, 27 Apr 2021 09:48:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 27 Apr 2021 09:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=b5wS/V0vTP6vNmB11i0KyHFvJOb
        Cf57C/oZYcJ4cqJY=; b=6uwTs8Qi5kJXxXKXrFMn5xsdAhX/28iA7BjY1nWjh3X
        N7QyolRzmcnM+72P/VJrYNyhtcitbMd6vWVf2sImQytOpPFTDZMAEJux9luWrVUW
        KoY0evfCjktmUonK4MD14B/xU28NNHzdRd3oNm6ztZzxU/locgTuvHLo10/luUCe
        epi1B54FOsg6OY8SMNZ3w8kvvqMShvcJ1eZ2j2Cvvj059s9o97a2cD+raXl+qB9K
        Paya/cx2XL4Ne1O25FjqX3x+nMlFiz2kAiTcGDaBePd9pG8g66APxDTsXvcygl1b
        OkEZuHtQPbcls74/A/Qk2cwyYwcFMrMplyuUpWyOghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b5wS/V
        0vTP6vNmB11i0KyHFvJObCf57C/oZYcJ4cqJY=; b=IPF6WClQh8pi/fB3lqyG6O
        pf3x0MZLcYoRl5jA2IZ634Nq5s3nowBpbxHCG5tUCm1Xbx9c355FLViHPR1UWffQ
        wS0wA+I//PuZSPdiFF3bhpUBhGd2w3VU2RKYR03QFIyu4kX4spZMc6uCXH+SUVgQ
        RXus1g3eGipu+jnfweW3fwAdbfjD4xIOp9urMfejIegRllirUUlq9anpnM/plSnR
        NV27SOrjpGqAg996hl8bhWKFPi4Ohs+ojEiVcDz5D3D4Ai4I62ijHhK0/qsusnv8
        S9Y9E6JbAZShDHctPbmbz9e7w1dWnoLN4IyoqxgyGscxPdeh6vssuL42fcSs8gKQ
        ==
X-ME-Sender: <xms:RxaIYJe2VLf1gCBY4S6AdgH59EY1iR3RhUVDVVSpaRXk21b8UB_bIQ>
    <xme:RxaIYHOER7hHTg9ITcFXskbtqITetLAvfVtBjX8bfLgFeUgET1wR5bR3dtesjpbyH
    fwatrDNnynK52glgnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvtddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepudejfedrfeekrdduudejrdejjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:RxaIYCgP14I1mxqOOiPpg1rpkIqo3qYDuPwAdxg-K8qr4Id28JLP7g>
    <xmx:RxaIYC_Q8trqgZcrx0a1_DeFYILij634rc1Bbom9BHDd8sAcLfqRcg>
    <xmx:RxaIYFuiBEpmN1RB77LECZr2iib60sAWrP-td03_pxfuvFnXg2JRnw>
    <xmx:SBaIYLARiPyU9I4CHZZA4F5PTHzFPR7vPbA3_qqzsZuww5Ut18iksmtGcco>
Received: from cisco (unknown [173.38.117.77])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 27 Apr 2021 09:48:54 -0400 (EDT)
Date:   Tue, 27 Apr 2021 07:48:53 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to
 seccomp user notifier
Message-ID: <20210427134853.GA1746081@cisco>
References: <20210426180610.2363-1-sargun@sargun.me>
 <20210426180610.2363-3-sargun@sargun.me>
 <20210426190229.GB1605795@cisco>
 <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426221527.GA30835@ircssh-2.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:15:28PM +0000, Sargun Dhillon wrote:
> On Mon, Apr 26, 2021 at 01:02:29PM -0600, Tycho Andersen wrote:
> > On Mon, Apr 26, 2021 at 11:06:07AM -0700, Sargun Dhillon wrote:
> > > @@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
> > >  	 * This is where we wait for a reply from userspace.
> > >  	 */
> > >  	do {
> > > +		interruptible = notification_interruptible(&n);
> > > +
> > >  		mutex_unlock(&match->notify_lock);
> > > -		err = wait_for_completion_interruptible(&n.ready);
> > > +		if (interruptible)
> > > +			err = wait_for_completion_interruptible(&n.ready);
> > > +		else
> > > +			err = wait_for_completion_killable(&n.ready);
> > >  		mutex_lock(&match->notify_lock);
> > > -		if (err != 0)
> > > +
> > > +		if (err != 0) {
> > > +			/*
> > > +			 * There is a race condition here where if the
> > > +			 * notification was received with the
> > > +			 * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
> > > +			 * non-fatal signal was received before we could
> > > +			 * transition we could erroneously end our wait early.
> > > +			 *
> > > +			 * The next wait for completion will ensure the signal
> > > +			 * was not fatal.
> > > +			 */
> > > +			if (interruptible && !notification_interruptible(&n))
> > > +				continue;
> > 
> > I'm trying to understand how one would hit this race,
> > 
> 
> I'm thinking:
> P: Process that "generates" notification
> S: Supervisor
> U: User
> 
> P: Generated notification
> S: ioctl(RECV...) // With wait_killable flag.
> ...complete is called in the supervisor, but the P may not be woken up...
> U: kill -SIGTERM $P
> ...signal gets delivered to p and causes wakeup and
> wait_for_completion_interruptible returns 1...
> 
> Then you need to check the race

I see, thanks. This seems like a consequence of having the flag be
per-RECV-call vs. per-filter. Seems like it might be simpler to have
it be per-filter?

Tycho

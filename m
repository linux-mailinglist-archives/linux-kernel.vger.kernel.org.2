Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F235250D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 03:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhDBBTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 21:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhDBBTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 21:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73509610CB;
        Fri,  2 Apr 2021 01:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617326372;
        bh=VNME0AJQzU6QnW2UEONjpgm1HHH7KDxcmg99McaHxxU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O0pTs4SO44CPio0ttjR5zBeRLKe8eZ194Jx+Lib+ZXbI9fDc2RXKiUdLbQfPoUHIh
         GH4pfrOcKTz/iORapWC18evo9ro2woDTnDK6XuVE7+JBpZC2S42c9xqIAcoxwFfhqP
         8/LQ60w5U6dsrgXKBIaIPpajalH0LSpqMuj6zPTMGoK8/bJ7uhz9Vj3a/spIWL5rpv
         NunIi/ewjtvnV/Q9jSy3MNIt0NQs76VVNZEFIA21I5ctmM7ViAgkREVu3bU0AirAT6
         R51+OK7SP6uNJFqFvdy7NM0LanYtfHjcpH4u89eCxZaQn90I2BlFmvOQq19zVaFf+r
         Kj2BIlVp8EYXQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 385C13523A03; Thu,  1 Apr 2021 18:19:32 -0700 (PDT)
Date:   Thu, 1 Apr 2021 18:19:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] srcu: Remove superfluous ssp initialization on
 deferred work queue
Message-ID: <20210402011932.GP2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-2-frederic@kernel.org>
 <20210402004856.GM2696@paulmck-ThinkPad-P72>
 <20210402005813.GE116405@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402005813.GE116405@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 02:58:13AM +0200, Frederic Weisbecker wrote:
> On Thu, Apr 01, 2021 at 05:48:56PM -0700, Paul E. McKenney wrote:
> > On Fri, Apr 02, 2021 at 01:47:02AM +0200, Frederic Weisbecker wrote:
> > > When an ssp has already started a grace period and queued an early work
> > > to flush after SRCU workqueues are created, we expect the ssp to be
> > > properly initialized already. So we can skip this step at this stage.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/srcutree.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 036ff5499ad5..7197156418e4 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1396,7 +1396,6 @@ void __init srcu_init(void)
> > >  	while (!list_empty(&srcu_boot_list)) {
> > >  		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> > >  				      work.work.entry);
> > > -		check_init_srcu_struct(ssp);
> > 
> > You lost me on this one.  What happens if the only pre-initialization
> > invocation on the statically allocated srcu_struct pointed to by ssp
> > was call_srcu()?  I am not seeing how the initialization has already
> > happened in that case.
> > 
> > What am I missing here?
> 
> call_srcu() -> __call_srcu() -> srcu_gp_start_if_needed() ->
> check_init_srcu_struct() ?
> 
> Or is it me missing something?

Nope, me getting confused between Tree SRCU's and Tiny SRCU's
call_srcu() implementation.  :-/

I have queued this patch and started testing.

							Thanx, Paul

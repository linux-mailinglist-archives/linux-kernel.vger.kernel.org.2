Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281ED31A087
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBLOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhBLOTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:19:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 600B664DF0;
        Fri, 12 Feb 2021 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613139499;
        bh=IrzkKovhWTgaZbrcMe840lSYJH/ANV2GqSQ7EtYOXa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnYzn5xPd4hkgplyeplliedG++v+FtIh/YOZshc+s4AMkdGGA/WafEadyJtVnSrmT
         RpGWHMYZUwSVEocXEdf2wUyy9C45T6QDQpKH2uiJgGkixJLgQ3uqAHFhFvu999Vuok
         E1LXL/TSf/Vw7sgIQdLCeDrfgJrdjcDao+yd19ls+tzev/01CLWcm+BSwArDlPW2f6
         kNuocseZrTuRTtzEQwCGw/XnCeg+J1/KLgEii4aDgDCom7yaNr+P6XuUMHBLX8Tske
         IulxZMtAf7oe8YEGtyw2+s/sJMv35jAaZhp+M8uf7CzT7yFwTlLI421FBRgYJXw1Ry
         JCQr+EAFzOa+g==
Date:   Fri, 12 Feb 2021 15:18:17 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] nohz: change signal tick dependency to wakeup CPUs
 of member tasks
Message-ID: <20210212141817.GA94816@lothringen>
References: <20210128202134.608115362@fuller.cnet>
 <20210128202235.849263653@fuller.cnet>
 <20210212122521.GA90839@lothringen>
 <20210212140041.GA182392@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212140041.GA182392@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:00:41AM -0300, Marcelo Tosatti wrote:
> On Fri, Feb 12, 2021 at 01:25:21PM +0100, Frederic Weisbecker wrote:
> > On Thu, Jan 28, 2021 at 05:21:36PM -0300, Marcelo Tosatti wrote:
> > > Rather than waking up all nohz_full CPUs on the system, only wakeup 
> > > the target CPUs of member threads of the signal.
> > > 
> > > Reduces interruptions to nohz_full CPUs.
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > Index: linux-2.6/kernel/time/tick-sched.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/time/tick-sched.c
> > > +++ linux-2.6/kernel/time/tick-sched.c
> > > @@ -444,9 +444,20 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
> > >   * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
> > >   * per process timers.
> > >   */
> > > -void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits
> > > bit)
> > 
> > Why not keeping the signal struct as a parameter?
> > 
> > Thanks.
> 
> All callers use "struct signal_struct *sig = tsk->signal" as
> signal parameter anyway...

Sure, but that makes more sense with the function role and name.

> 
> Can change parameters to (task, signal, bit) if you prefer.

That's ok I can do it, just wanted to make sure I wasn't missing
a reason behind it.

Thanks!

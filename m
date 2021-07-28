Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A123D977D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhG1VWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhG1VWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:22:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19AD260462;
        Wed, 28 Jul 2021 21:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627507369;
        bh=mC6lLtZPy3lFUz2DCHyydD1HsrkcO+Ge8lfn/foE4Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJO4cfSwqJD3300iyEpLW8xUHz0MfRNetJzAmgA/z36ZOMuEp3jEA8la4CNC/vdg1
         cqTCO/vOpcB16aV03AuQd+YtERggVRIQR+kbI08YFj7RrPVEsNqhwHzzsHyTmT5ZhX
         EGcbJcYsMpynfkb13HQkx6qw9AHtt3nFxcO0Q5WZw4cunP1TGdwdOv+shb0jaHh6K8
         XjqcPC+j2MUCHiKk3M/22CSQYxFJCujDJsNQw1cdkgi1eMrf5KPy0QFnUaFihyC/9H
         JqgRvRex3jyOg/5Er/gaTYOPfJ5/h9bEAPg90czA0bpMFwmU9OQAd2gsf1JbbMWL5D
         I6cZdHOJj08BA==
Date:   Wed, 28 Jul 2021 23:22:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210728212247.GC293265@lothringen>
References: <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
 <20210727234539.GH283787@lothringen>
 <20210728093707.GA3242@fuller.cnet>
 <20210728114548.GA293265@lothringen>
 <20210728132134.GA10515@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728132134.GA10515@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:21:34AM -0300, Marcelo Tosatti wrote:
> > > ISOL_FEATURES is just the "command" type (which you can get and set).
> > > 
> > > The bitmask would include ISOL_F_QUIESCE_ON_URET, so:
> > > 
> > > - bitmask = ISOL_F_QUIESCE_ON_URET;
> > > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > > the bitmask.
> > 
> > But does it quiesce once or for every further uret?
> 
> For every uret, while ISOL_F_QUIESCE_ON_URET is enabled through 
> prctl(PR_ISOL_ENABLE, enabled_bitmask, 0, 0, 0).

Ok.

> 
> > > - quiesce_bitmap = prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0)
> > >   (1)
> > > 
> > >   (returns the supported actions to be quiesced).
> > > 
> > > - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) _sets_
> > > the actions to be quiesced (2)
> > > 
> > > If an application does not modify "quiesce_bitmask" between 
> > > points (1) and (2) above, it will enable quiescing of all
> > > "features" the kernel supports.
> > 
> > I don't get the difference between ISOL_FEATURES and PR_ISOL_QUIESCE_CFG.
> 
> prctl(PR_ISOL_SET, cmd, ...) is intented to accept different types of "command" 
> variables (including ones for new features which are not known at this
> time).
> 
>  - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
>    the bitmask
> 
>    (which might now be superceded by 
> 
>    prctl(PR_ISOL_ENABLE, ISOL_F_QUIESCE_ON_URET, 0, 0, 0))
> 
> - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, bitmask, 0, 0) configures
> quiescing of which subsystem/feature is performed:
> 
> 	#define ISOL_F_QUIESCE_VMSTAT_SYNC      (1<<0)
> 	#define ISOL_F_QUIESCE_NOHZ_FULL        (1<<1)
> 	#define ISOL_F_QUIESCE_DEFER_TLB_FLUSH  (1<<2)

Ok but...I still don't get the difference between ISOL_FEATURES and
PR_ISOL_QUIESCE_CFG :-)

> > So PR_ISOL_ENABLE is a way to perform action when some sort of kernel entry
> > happens. Then we take actions when that happens (signal, warn, etc...).
> > 
> > I guess we'll need to define what kind of kernel entry, and what kind of
> > response need to happen. Ok that's a whole issue of its own that we'll need
> > to handle seperately.
> > 
> > Thanks.
> 
> In fact, why one can't use SECCOMP for syscall blocking?

Heh! Good point!

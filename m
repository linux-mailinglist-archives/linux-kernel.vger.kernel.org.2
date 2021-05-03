Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3937204E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhECTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhECTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:20:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6509DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lE2vP08X6IJ3m7govexvoLdskHFUlMsx3rR6kOZ0Tfg=; b=SdMZLKMbVy0LaukGsj38wZsqVb
        ksvJLzM7y2/LZaaUtzyrvrn89lxgo7QJwLgel6JGjRGupHGVaW/agE9uQ5tVh3o7aP09Tz7H/dwio
        KH3A2BUcOCkwuq9O1c3m3FuwSgWGtSl9o/BPJ5y+bVZqA7RCiFkFsHG1DFmzamPO5J9gGjwKhZRmm
        HgJpaM8pU5k7GjQkDBH6kLBJqmpJKCyUapl+q6xthWT16/JICvlIchHnk00y5hw+SFjgHb/TTLzvO
        jSVMfTH0Z5a7dMSdIERIebnwiMDZY2+jY0qnMKOeyhfPHE78B2cRteUaMN7TW32RV36ymkdykOaHl
        G1x7rElw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lde4F-00FWTA-5q; Mon, 03 May 2021 19:17:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E9D6300036;
        Mon,  3 May 2021 21:17:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 776B42C1AA720; Mon,  3 May 2021 21:17:17 +0200 (CEST)
Date:   Mon, 3 May 2021 21:17:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YJBMPWsSTKhi13wd@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
 <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
 <CABk29Nu84zOGexUdT41MLssxnh1wN_1bGvEa699-gfuZtBj12Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nu84zOGexUdT41MLssxnh1wN_1bGvEa699-gfuZtBj12Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 01:11:54PM -0700, Josh Don wrote:
> On Wed, Apr 28, 2021 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 04:30:02PM -0700, Josh Don wrote:
> >
> > > Also, did you mean to have a preempt_enable_no_resched() rather than
> > > prempt_enable() in raw_spin_rq_trylock?
> >
> > No, trylock really needs to be preempt_enable(), because it can have
> > failed, at which point it will not have incremented the preemption count
> > and our decrement can hit 0, at which point we really should reschedule.
> 
> Ah yes, makes sense. Did you want to use preempt_enable_no_resched()
> at all then? No chance of preempt_count() being 1 at the point of
> enable, as you comment below.

preempt_enable_no_resched() avoids the branch which we know we'll never
take. It generates slightly saner code. It's not much, but every little
bit helps, right? ;-)

> > ( I'm suffering a cold and am really quite slow atm )
> 
> No worries, hope it's a mild one.

It's not the super popular one from '19, and the family seems to be
mostly recovered again, so all's well.

> > How's this then?
> 
> Looks good to me (other than the synchronize_sched()->synchronize_rcu()).
> 
> For these locking patches,
> Reviewed-by: Josh Don <joshdon@google.com>

Thanks!, I'll go fold them into the proper place and update the repo.

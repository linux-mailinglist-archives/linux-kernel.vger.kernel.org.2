Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC944DC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhKKUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:42:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B51C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eZrKU4XAxmFPpZ7WS1zULwbEpXo1G+fFywa6sfODi+o=; b=Df3fSRy9bOpz1W23lxavwxoAyo
        NwCT5g+ZBdvIgSmC47QdUIWLsc0kNHM4b/fVMjmMDR/47UQf0QM4TroUN2y3hSvfrsOthIdkZpY/4
        0dlOzQumCY3r2yu8xJDJkVW7cd/QZod+4/U7ROhnXFoUaDBapikfXgGSUrFPXalMv/h+TLndDzSJy
        NqG0oBy6jdNBu5xziI22eKfoLgyRGmG15OC7yhgbRBPsOIJBJfUSqIpeOvXEbs4f62+RQptf1k6MT
        rzbRns8Tu98NB1mJWrADPvukb0/0kfoyLC+UpVB9OhskfOjs32HAnMr6aCFmcW4H0+6WHklVQFeOA
        48y3X5Yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlGrG-00FWTT-Gy; Thu, 11 Nov 2021 20:39:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2133A986981; Thu, 11 Nov 2021 21:39:42 +0100 (CET)
Date:   Thu, 11 Nov 2021 21:39:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <20211111203942.GJ174730@worktop.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111203500.GI174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111203500.GI174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 09:35:00PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
> > 
> > On 11/11/21 14:20, Peter Zijlstra wrote:
> > > On Thu, Nov 11, 2021 at 02:14:48PM -0500, Waiman Long wrote:
> > > > As for the PHASE_CHANGE name, we have to be consistent in both rwsem and
> > > > mutex. Maybe a follow up patch if you think we should change the
> > > > terminology.
> > > Well, that's exactly the point, they do radically different things.
> > > Having the same name for two different things is confusing.
> > > 
> > > Anyway, let me go read that patch you sent.
> > 
> > My understanding of handoff is to disable optimistic spinning to let waiters
> > in the wait queue have an opportunity to acquire the lock. There are
> > difference in details on how to do that in mutex and rwsem, though.
> 
> Ah, but the mutex does an actual hand-off, it hands the lock to a
> specific waiting task. That is, unlock() sets owner, as opposed to
> trylock().
> 
> The rwsem code doesn't, it just forces a phase change. Once a waiter has
> been blocked too long, the handoff bit is set, causing new readers to be
> blocked. Then we wait for existing readers to complete. At that point,
> any next waiter (most likely a writer) should really get the lock (and
> in that regards the rwsem code is a bit funny).

And this is I think the thing you tried in your earlier inherit patch.
Keep the quescent state and simply let whatever next waiter is in line
have a go.

I suspect that change is easier now. But I've not tried.


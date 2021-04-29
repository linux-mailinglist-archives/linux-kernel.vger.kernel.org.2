Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBA36F316
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhD2X5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhD2X5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:57:20 -0400
X-Greylist: delayed 118687 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Apr 2021 16:56:32 PDT
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB21C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619740591; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=DHof6otQeyq3kPdCHUB3Te2GYUAs+CCH3DH/j9hxypY=;
 b=gs7x6dJ8vx6PTqvvqdwyHRMG/pO6+U0GhwzIR0Fn4QvNHBX48vgCkUdvF8GSPoehHrH5+
 Z2dV3Y/OVFm+lAuAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619740591; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=DHof6otQeyq3kPdCHUB3Te2GYUAs+CCH3DH/j9hxypY=;
 b=mXotcxjzULnIIDf3BYVw2kgfwHN2xHsAzbN/7NwWDrQbqLEY5OlVf7uE083PyzV4kBZZu
 dLygHm4w03H4sAIkeO7Q5vlDa+Rk+baQDdXOSLRDXHJd555UfFJ9o3XJBvXB7zDhbqSXZ2Y
 ZEAsKHtONfdO0BUOkEEx/EDV9Ib/vUmn2cuEHVXQvTmbnkCfGGtMvBlvtM41T90eB9Y6Dyv
 VMDSzx9GnnmPHUm/e8SBrVxDipiQL/2jM23HKI1Keh5EaVxWy3CPAr0IoMXm4YGdZ1Tc77c
 Wy9kNUMlrx0Kl23crZMUS99Iitm+xFqOKKpqw+299l5FMpbpkDlu1oP8LihA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id E69DA160309; Thu, 29 Apr 2021 16:56:31 -0700 (PDT)
Date:   Thu, 29 Apr 2021 16:56:31 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210429235631.GG10973@lespinasse.org>
References: <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <CALCETrWybk8k8Z=9+x3Ns7zMUPMzganzPY47pqOJCbB3LkfQ+A@mail.gmail.com>
 <20210429161234.GG1847222@casper.infradead.org>
 <20210429191428.GD10973@lespinasse.org>
 <20210429193456.GI1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429193456.GI1847222@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 08:34:56PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 29, 2021 at 12:14:28PM -0700, Michel Lespinasse wrote:
> > On Thu, Apr 29, 2021 at 05:12:34PM +0100, Matthew Wilcox wrote:
> > > One of the worst things we can do while holding a spinlock is take a
> > > cache miss because we then delay for several thousand cycles to wait for
> > > the cache line.  That gives every other CPU a really long opportunity
> > > to slam into the spinlock and things go downhill fast at that point.
> > > We've even seen patches to do things like read A, take lock L, then read
> > > A to avoid the cache miss while holding the lock.
> > 
> > I understand the effect your are describing, but I do not see how it
> > applies here - what cacheline are we likely to miss on when using
> > local_irq_disable() that we wouldn't touch if using rcu_read_lock() ?
> 
> It's the same cache lines in both cases.  The difference is that in one
> case we have interrupts disabled (and a spinlock held?  i wasn't clear
> on that) and in the other case, we just have preemption disabled.

To add some context - the problem we are trying to solve here (and a
different instance of it in the next commit) is that we are trying to
map and/or lock the page table, but need to prevent it from being
freed while we are trying to do so. Disabling interrupts or taking an
rcu read lock are two mechanisms for preventing that race, but the
structures accessed are the same in either case.

> > > What sort of performance effect would it have to free page tables
> > > under RCU for all architectures?  It's painful on s390 & powerpc because
> > > different tables share the same struct page, but I have to believe that's
> > > a solvable problem.
> > 
> > I agree using RCU to free page tables would be a good thing to try.
> > I am afraid of adding that to this patchset though, as it seems
> > somewhate unrelated and adds risk. IMO we are most likely to find
> > justification for pushing this if/when we try accessing remote mm's without
> > taking the mmap lock, since disabling IPIs clearly wouldn't work there.
> 
> I think that needs to happen _before_ this patchset.  Creating a mess and
> then trying to clean it up later isn't a great way to do development.

Agree we don't want to create a mess... but I see that as an argument for
not hastily changing the way page tables are reclaimed...

--
Michel "walken" Lespinasse

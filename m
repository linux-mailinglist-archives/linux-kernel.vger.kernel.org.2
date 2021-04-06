Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B355354E16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbhDFHlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhDFHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:41:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216ECC0613D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NtENhIIYkJVIk6ChrHzMySoRycyrB0BINANzaoAFd3Y=; b=hhGShFz/7GeyDv/OFgPmJe24Zo
        0dHRAKmhDb48t3MAMjMfI15Ybh5nnhUe/CM5i7RyIvwoFVEXNT0SvqfmKw2imfZMYpNB/cDgSzyIb
        LQO3KFGoB0CmYAOYgeZ3dwBrWF7WSCddD53SWkdmY7QDTGe25BzuMdbj3xsTrl9YTioxGdQSptwyn
        5FhPlzruu69FUfuEOBQBlovGgaZVoWnqNl8/aMGUfOdD65SglPWkghlH18dEqOi143r66m6l1rHF6
        PYU4ygXiOcBJU+fOYitT2fEJIRrUkj2vr/WPPr0UQSh841wSQWuq60oDMq1oNoz8if3vOohfhCRdd
        9VoNI2qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTgKk-001oZr-Ve; Tue, 06 Apr 2021 07:41:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EA6F304D58;
        Tue,  6 Apr 2021 09:41:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BF732BAE8C28; Tue,  6 Apr 2021 09:41:10 +0200 (CEST)
Date:   Tue, 6 Apr 2021 09:41:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in copy_page_range
Message-ID: <YGwQlnpKBbUrGaZm@hirez.programming.kicks-ass.net>
References: <00000000000086695705bec87c9f@google.com>
 <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
 <YGQlHvte0BeKx0uV@hirez.programming.kicks-ass.net>
 <CACT4Y+b1NsdnC1hqk54Y8zEs7r3y7+EnAqbG1eBmuhji_bfFqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b1NsdnC1hqk54Y8zEs7r3y7+EnAqbG1eBmuhji_bfFqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:57:23AM +0200, Dmitry Vyukov wrote:
> On Wed, Mar 31, 2021 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 31, 2021 at 08:11:38AM +0200, Dmitry Vyukov wrote:
> > > On Wed, Mar 31, 2021 at 12:26 AM syzbot
> > > <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com
> > >
> > > I think this is a LOCKDEP issue. +LOCKDEP maintainers.
> > >
> > > Another bug happened on another thread ("WARNING: possible circular
> > > locking dependency detected"). Lockdep disabled lock tracking
> > > ("debug_locks = 0" in the report), which probably made it miss
> > > rcu_unlock somewhere, but it did not turn off reporting yet and
> > > produced the false positive first.
> > >
> > > I think if LOCKDEP disables lock tracking, it must also disable
> > > reporting of issues that require lock tracking. That would avoid false
> > > positives.
> >
> > Still early and brain hasn't really booted yet, but features that
> > require lock tracking are supposed to check debug_locks.
> >
> > And afaict debug_lockdep_rcu_enabled(), which is called by
> > RCU_LOCKDEP_WARN(), which is called by rcu_sleep_check() does just that.
> 
> Right... yet it somehow happens.
> Looking at a dozen of reports, all with 2 concurrent lockdep splats
> and "debug_locks = 0" in the report, I am pretty sure there is some
> kind of race in lockdep.

Aah, concurrent splats. Yes, that was per design. The theory was that
concurrent splats are rare and this is much simpler code.

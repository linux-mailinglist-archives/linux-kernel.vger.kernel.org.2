Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052DA34FA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhCaHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhCaHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:32:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dkzu4DMt6FWa6R1PXgA2donJuIwD/gU2RVBrtv9nBm8=; b=AJ17EukJxEHAPJnU8pTMCx5og9
        1uaKR9zz8RZNGUewMeRVMiPTvSzED+YXIPV1lKNUvEsdww+xYt1fuU1+JathXlOAX9wedA3r1vAEx
        43UPZMdZjHot0mUXQwe/c1qOVJRAyI8zLHZBE1HuJx5tTmfLRhvbXPXDI5UZXimlShYdxa8gAXG1d
        Xho1MNfeLjcYMw7v17x1wTgjoYvgP7SYrkTH4qVW6vNSiHLkd50XIu8IGnFszUZnd+8mYAqaEWX8f
        JOr9ykgMbthAejTEwvB8KuX7x9mvPQBvG96CdkqF3KN5Td6MPZNFs6tNrGTFw/A0bZxww947GjOQM
        hUFCUqJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRVJH-004Bqy-TE; Wed, 31 Mar 2021 07:30:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E7D830015A;
        Wed, 31 Mar 2021 09:30:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE882B85BA0B; Wed, 31 Mar 2021 09:30:38 +0200 (CEST)
Date:   Wed, 31 Mar 2021 09:30:38 +0200
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
Message-ID: <YGQlHvte0BeKx0uV@hirez.programming.kicks-ass.net>
References: <00000000000086695705bec87c9f@google.com>
 <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 08:11:38AM +0200, Dmitry Vyukov wrote:
> On Wed, Mar 31, 2021 at 12:26 AM syzbot
> <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com
> 
> I think this is a LOCKDEP issue. +LOCKDEP maintainers.
> 
> Another bug happened on another thread ("WARNING: possible circular
> locking dependency detected"). Lockdep disabled lock tracking
> ("debug_locks = 0" in the report), which probably made it miss
> rcu_unlock somewhere, but it did not turn off reporting yet and
> produced the false positive first.
> 
> I think if LOCKDEP disables lock tracking, it must also disable
> reporting of issues that require lock tracking. That would avoid false
> positives.

Still early and brain hasn't really booted yet, but features that
require lock tracking are supposed to check debug_locks.

And afaict debug_lockdep_rcu_enabled(), which is called by
RCU_LOCKDEP_WARN(), which is called by rcu_sleep_check() does just that.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE733F853
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhCQSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:46:11 -0400
Received: from foss.arm.com ([217.140.110.172]:43648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhCQSpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3501ED6E;
        Wed, 17 Mar 2021 11:45:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6F53F70D;
        Wed, 17 Mar 2021 11:45:44 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:45:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     maz@kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm64 syzbot instances
Message-ID: <20210317184538.GB2508@C02TD0UTHF1T.local>
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <20210311123315.GF37303@C02TD0UTHF1T.local>
 <CACT4Y+ZPO7D1hGHZvuBQ52Vy2W7UUSW+YFE-Ax6-NMDnmrKTBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZPO7D1hGHZvuBQ52Vy2W7UUSW+YFE-Ax6-NMDnmrKTBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 05:56:46PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 11, 2021 at 1:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > FWIW, I keep my fuzzing config fragment in my fuzzing/* branches on
> > git.kernel.org, and for comparison my fragment for v5.12-rc1 is:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.12-rc1&id=6d9f7f8a2514fe882823fadbe7478228f71d7ab1
> >
> > ... I'm not sure whether there's anything in that which is novel to you.
> 
> Hi Mark,
> 
> I've learned about DEBUG_TIMEKEEPING which we had disabled. I am enabling it.
> We also have CONTEXT_TRACKING_FORCE disabled. I don't completely
> understand what it's doing. Is it also "more debug checks" type of
> config?

Context tracking tracks user<->kernel transitions, and tries to disable
RCU when it is not needed (e.g. while a CPU is in usersspace), to avoid
the need to perturb that CPU with IPIs and so on. Normally this is not
enabled unless CPUs are set aside for NOHZ usage, as there's some
expense in doing this tracking. I haven't measured how expensive it is
in practice.

CONTEXT_TRACKING_FORCE enables that tracking regardless of whether any
CPUs are set aside for NOHZ usage, and makes it easier to find bugs in
that tracking code, or where it is not being used correctly (e.g. missed
calls, or called in the wrong places).

I added it to my debug fragment back when I fixed the arm64 entry code
accounting for lockdep, and I keep it around to make sure that we don't
accidentally regress any of that.

Thanks,
Mark.

> FWIW we have more debug configs:
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/debug.yml
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/base.yml
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kasan.yml
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kmemleak.yml

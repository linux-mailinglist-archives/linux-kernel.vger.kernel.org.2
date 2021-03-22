Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84725344D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCVRW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:22:58 -0400
Received: from foss.arm.com ([217.140.110.172]:35788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhCVRWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:22:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A7A1063;
        Mon, 22 Mar 2021 10:22:46 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05CB23F719;
        Mon, 22 Mar 2021 10:22:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:22:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream boot error: WARNING in __context_tracking_enter
Message-ID: <20210322172241.GB80352@C02TD0UTHF1T.local>
References: <0000000000004f14c105bde08f75@google.com>
 <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
 <20210319101043.GU1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319101043.GU1463@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Mar 19, 2021 at 10:10:43AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Mar 19, 2021 at 10:54:48AM +0100, Dmitry Vyukov wrote:
> > .On Fri, Mar 19, 2021 at 10:44 AM syzbot
> > <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com> wrote:
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    8b12a62a Merge tag 'drm-fixes-2021-03-19' of git://anongit..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e815aed00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfeed364fc353c32
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f09a12b2c77bfbbf51bd
> > > userspace arch: arm
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com
> > 
> > 
> > +Mark, arm
> > It did not get far with CONFIG_CONTEXT_TRACKING_FORCE (kernel doesn't boot).
> 
> It seems that the path:
> 
> context_tracking_user_enter()
> user_enter()
> context_tracking_enter()
> __context_tracking_enter()
> vtime_user_enter()
> 
> expects preemption to be disabled. It effectively is, because local
> interrupts are disabled by context_tracking_enter().
> 
> However, the requirement for preemption to be disabled is not
> documented... so shrug. Maybe someone can say what the real requirements
> are here.

From dealing with this recently on arm64, theis is a bit messy. To
handle this robustly we need to do a few things in sequence, including
using the *_irqoff() variants of the context_tracking_user_*()
functions.

I wrote down the constraints in commit:
  
  23529049c6842382 ("arm64: entry: fix non-NMI user<->kernel transitions")

For user->kernel transitions, the arch code needs the following sequence
before invoking arbitrary kernel C code:

	lockdep_hardirqs_off(CALLER_ADDR0);
	user_exit_irqoff();
	trace_hardirqs_off_finish();

For kernel->user transitions, the arch code needs the following sequence
once it will no longer invoke arbitrary kernel C code, just before
returning to userspace:

	trace_hardirqs_on_prepare();
	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
	user_enter_irqoff();
	lockdep_hardirqs_on(CALLER_ADDR0);

Thanks,
Mark.

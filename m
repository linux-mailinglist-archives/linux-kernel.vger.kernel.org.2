Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DEA3613CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhDOVA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:00:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51209 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235569AbhDOVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:00:22 -0400
Received: (qmail 20064 invoked by uid 1000); 15 Apr 2021 16:59:57 -0400
Date:   Thu, 15 Apr 2021 16:59:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <20210415205957.GA19917@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <CACT4Y+YEw4iJPxY4b6LPXrU91TODfu09dG=53exvQkwjPBg23w@mail.gmail.com>
 <20210413165724.GD1454681@rowland.harvard.edu>
 <CACT4Y+aX-cMJxMYmWms3MG-4=Rb9eG_N+pOjorRHoV1MGQXtkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aX-cMJxMYmWms3MG-4=Rb9eG_N+pOjorRHoV1MGQXtkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:11:11PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 13, 2021 at 6:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Apr 13, 2021 at 06:47:47PM +0200, Dmitry Vyukov wrote:
> > > On Tue, Apr 13, 2021 at 6:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > Hopefully this patch will make the race a lot more likely to occur.  Is
> > > > there any way to tell syzkaller to test it, despite the fact that
> > > > syzkaller doesn't think it has a reproducer for this issue?
> > >
> > > If there is no reproducer the only way syzbot can test it is if it's
> > > in linux-next under CONFIG_DEBUG_AID_FOR_SYZBOT:
> > > http://bit.do/syzbot#no-custom-patches
> >
> > There _is_ a theoretical reproducer: the test that provoked syzkaller's
> > original bug report.  But syzkaller doesn't realize that it is (or may
> > be) a reproducer.
> >
> > It ought to be possible to ask syzkaller to run a particular test that
> > it has done before, with a patch applied -- and without having to add
> > anything to linux-next.
> 
> Yes, this is possible:
> http://bit.do/syzbot#syzkaller-reproducers

That's not really what I had in mind.  I don't want to spend the time 
and effort installing syskaller on my own system; I want to tell syzbot 
to run a particular syzkaller program (the one that originally led to 
this bug report) on a patched kernel.

The syzbot instructions say that it can test bugs with reproducers.  The 
problem here is that there doesn't seem to be any way to tell it to use 
a particular syzkaller program as a reproducer.

Alan Stern

> The log of tests executed before the crash is available under the
> "console output" link:
> console output: https://syzkaller.appspot.com/x/log.txt?x=124adbf6d00000
> And this log can be replayed using syz-execprog utility.

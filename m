Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBC3623F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbhDPPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:30:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43149 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1343674AbhDPPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:30:14 -0400
Received: (qmail 44011 invoked by uid 1000); 16 Apr 2021 11:29:49 -0400
Date:   Fri, 16 Apr 2021 11:29:49 -0400
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
Message-ID: <20210416152949.GC42403@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
 <CACT4Y+YEw4iJPxY4b6LPXrU91TODfu09dG=53exvQkwjPBg23w@mail.gmail.com>
 <20210413165724.GD1454681@rowland.harvard.edu>
 <CACT4Y+aX-cMJxMYmWms3MG-4=Rb9eG_N+pOjorRHoV1MGQXtkA@mail.gmail.com>
 <20210415205957.GA19917@rowland.harvard.edu>
 <CACT4Y+aYfVxcXYOHwheW7Wp2oYcKm_zumeASo57Dy7deDfZJKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aYfVxcXYOHwheW7Wp2oYcKm_zumeASo57Dy7deDfZJKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:21:12AM +0200, Dmitry Vyukov wrote:
> On Thu, Apr 15, 2021 at 10:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Apr 13, 2021 at 07:11:11PM +0200, Dmitry Vyukov wrote:
> > > Yes, this is possible:
> > > http://bit.do/syzbot#syzkaller-reproducers
> >
> > That's not really what I had in mind.  I don't want to spend the time
> > and effort installing syskaller on my own system; I want to tell syzbot
> > to run a particular syzkaller program (the one that originally led to
> > this bug report) on a patched kernel.
> >
> > The syzbot instructions say that it can test bugs with reproducers.  The
> > problem here is that there doesn't seem to be any way to tell it to use
> > a particular syzkaller program as a reproducer.
> 
> Hi Alan,
> 
> This makes sense and I've found an existing feature request:
> https://github.com/google/syzkaller/issues/1611
> I've added a reference to this thread there.

Great!  Thank you.

Alan Stern

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0423C62EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhGLSuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:50:54 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50791 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230199AbhGLSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:50:53 -0400
Received: (qmail 326727 invoked by uid 1000); 12 Jul 2021 14:48:04 -0400
Date:   Mon, 12 Jul 2021 14:48:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <20210712184804.GA326369@rowland.harvard.edu>
References: <20210711155345.GB293743@rowland.harvard.edu>
 <00000000000068b24405c6db3249@google.com>
 <20210712140004.GA316776@rowland.harvard.edu>
 <YOxf0OvoGOvWf14m@hovoldconsulting.com>
 <YOxk0URZrLYv8SNU@hovoldconsulting.com>
 <20210712161445.GA321728@rowland.harvard.edu>
 <CACT4Y+biD8AdKncmvqmaz3dytV-zoeo==rdkTSJvaZ9=RUs=UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+biD8AdKncmvqmaz3dytV-zoeo==rdkTSJvaZ9=RUs=UA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 06:24:43PM +0200, Dmitry Vyukov wrote:
> On Mon, 12 Jul 2021 at 18:14, Alan Stern <stern@rowland.harvard.edu> wrote:

> > > It looks like the second patch you submitted was hand-edited and still
> > > quoted.
> > >
> > > And looking at the dashboard it seems like no patch was applied for your
> > > second test attempt:
> > >
> > >       https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
> >
> > Yes, that explains it.  Funny how easy it is to miss those "> "
> > markings -- you just get too used to them.
> >
> > > I've been bitten by something like this before when erroneously thinking
> > > that a test command could be submitted as a reply to a patch.
> > >
> > > Perhaps the report mail could include the patch tested or something so
> > > we don't spend time investigating syzbot interface failures.
> >
> > Good idea.
> 
> The email always include the patch tested (as syzbot parsed it), see
> e.g. earlier reply in this thread:
> https://lore.kernel.org/lkml/00000000000074f06705c6ccd2a4@google.com/

The email doesn't include the patch; it includes a _link_ to the patch.

And the email does not contain any indication when no patch was parsed, 
other than the missing "patch:" link -- which is not particularly 
obvious if you aren't looking for it specifically:

	https://marc.info/?l=linux-usb&m=162602190812912&w=2

> > Anyway, here's the patch again, this time properly formatted.  Hopefully
> > now it will work.
> 
> syzbot parsed this patch successfully:
> https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b

Yes, and it worked.  Time to submit it.

Alan Stern

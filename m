Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F1377268
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEHOav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 10:30:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45905 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229586AbhEHOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 10:30:49 -0400
Received: (qmail 811116 invoked by uid 1000); 8 May 2021 10:29:47 -0400
Date:   Sat, 8 May 2021 10:29:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     dave penkler <dpenkler@gmail.com>
Cc:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210508142947.GB810516@rowland.harvard.edu>
References: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
 <CAL=kjP0xOQ32xLytyVm9=d+9rnKzV2dW2VJQ6c8MAwTK7rg2Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL=kjP0xOQ32xLytyVm9=d+9rnKzV2dW2VJQ6c8MAwTK7rg2Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 10:14:41AM +0200, dave penkler wrote:
> On Thu, 6 May 2021 at 22:31, Guido Kiener
> <Guido.Kiener@rohde-schwarz.com> wrote:
> >
> > > -----Original Message-----
> > > From: Alan Stern
> > > Sent: Thursday, May 6, 2021 8:32 PM
> > > To: Kiener Guido 14DS1
> > >
> > > On Thu, May 06, 2021 at 05:44:55PM +0000, Guido Kiener wrote:
> > > > > -----Original Message-----
> > > > > From: Alan Stern
> > > > > Sent: Thursday, May 6, 2021 3:49 PM
> > > > > To: Kiener Guido 14DS1 <Guido.Kiener@rohde-schwarz.com>
> > > > > >
> > > > > > Thanks for your assessment. I agree with the general feeling. I
> > > > > > counted about hundred specific usb drivers, so wouldn't it be
> > > > > > better to fix the
> > > > > problem in some of the host drivers (e.g. urb.c)?
> > > > > > We could return an error when calling usb_submit_urb() on an erroneous
> > > pipe.
> > > > > > I cannot estimate the side effects and we need to check all
> > > > > > drivers again how they deal with the error situation. Maybe there
> > > > > > are some special driver
> > > > > that need a specialized error handling.
> > > > > > In this case these drivers could reset the (new?) error flag to
> > > > > > allow calling usb_submit_urb() again without error. This could work, isn't it?
> > > > >
> > > > > That is feasible, although it would be an awkward approach.  As you
> > > > > said, the side effects aren't clear.  But it might work.
> > > >
> > > > Otherwise I see only the other approach to change hundred drivers and
> > > > add the cases EPROTO, EILSEQ and ETIME in each callback handler. The
> > > > usbtmc driver already respects the EILSEQ and ETIME, and only EPROTO is
> > > missing.
> > > > The rest should be more a management task.
> > > > BTW do you assume it is only a problem for INT pipes or is it also a
> > > > problem for isochronous and bulk transfers?
> > >
> > > All of them.  Control too.
> > >
> > > > > Will you be able to test patches?
> > > >
> > > > I only can test the USBTMC function in some different PCs. I do not
> > > > have automated regression tests for USB drivers or Linux kernels.
> > > > Maybe there is company who could do that.
> > >
> > > Well then, if I do find time to write a patch, I'll ask you to try it out with the usbtmc
> > > driver.
> >
> > You mean that you will do a patch in urb.c or a host driver? Or just add a line in usbtmc.c?
> > Anyhow there is no hurry. On May 20 I will send you a mail if I'm able to
> > provoke one of these hardware errors EPROTO, EILSQ, or ETIME. Otherwise
> > it doesn't make sense to test it.
> >
> > -Guido
> 
> EPROTO is a link level issue and needs to be handled by the host driver.

Are you referring to the host controller driver, or to the class device 
driver running on the host?  The host controller driver is responsible 
for creating the -EPROTO error code in the first place.  The class 
device driver is responsible for taking an appropriate action in 
response.

> When the host driver detects a protocol error while processing an URB
> it completes the URB with EPROTO status and marks the endpoint as
> halted.

Not true.  It does not mark the endpoint as halted, not unless it 
receives a STALL handshake from the device.  A STALL is not a protocol 
error.

> When the class driver resubmits the URB and the if the host driver
> finds the endpoint still marked as halted it should return EPIPE
> status on the resubmitted URB

Irrelevant.

> When the class driver and usbtmc in particular receives an URB with
> EPIPE status it cleans up and does not resubmit.
> Can someone from syzbot land please confirm whether usbtmc running on
> the xhci host driver causes an RCU stall to be detected ?

That is not an easy thing to test, and syzbot is not capable of testing 
it.  You would need a USB device which could deliberately be set to 
create a protocol error; I don't know of any devices like that.

Alan Stern

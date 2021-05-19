Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6493D3894B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhESRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:37:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46621 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229589AbhESRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:37:05 -0400
Received: (qmail 1174008 invoked by uid 1000); 19 May 2021 13:35:45 -0400
Date:   Wed, 19 May 2021 13:35:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>
Cc:     dave penkler <dpenkler@gmail.com>,
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
Subject: Re: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210519173545.GA1173157@rowland.harvard.edu>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 04:14:20PM +0000, Guido Kiener wrote:
> > On Wed, May 19, 2021 at 10:48:29AM +0200, dave penkler wrote:
> > > On Sat, 8 May 2021 at 16:29, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sat, May 08, 2021 at 10:14:41AM +0200, dave penkler wrote:
> > > > > When the host driver detects a protocol error while processing an
> > > > > URB it completes the URB with EPROTO status and marks the endpoint
> > > > > as halted.
> > > >
> > > > Not true.  It does not mark the endpoint as halted, not unless it
> > > > receives a STALL handshake from the device.  A STALL is not a
> > > > protocol error.
> > > >
> > > > > When the class driver resubmits the URB and the if the host driver
> > > > > finds the endpoint still marked as halted it should return EPIPE
> > > > > status on the resubmitted URB
> > > >
> > > > Irrelevant.
> > > Not at all. The point is that when an application is talking to an
> > > instrument over the usbtmc driver, the underlying host controller and
> > > its driver will detect and silence a babbling endpoint.
> > 
> > No, they won't.  That is, they will detect a babble error and return an error status, but
> > they won't silence the endpoint.  What makes you think they will?
> 
> Maybe there is a misunderstanding. I guess that Dave wanted to propose:
> "EPROTO is a link level issue and needs to be handled by the host driver.
> When the host driver detects a protocol error while processing an
> URB it SHOULD complete the URB with EPROTO status

The host controller drivers _do_ complete URBs with -EPROTO (or similar) 
status when a link-level error occurs...

> and SHOULD mark the endpoint
> as halted."

but they don't mark the endpoint as halted.  Even if they did, it 
wouldn't fix anything because the kernel allows URBs to be submitted to 
halted endpoints.  In fact, it doesn't even keep track of which 
endpoints are or are not halted.

> Is this a realistic fix for all host drivers?

No, it isn't.

An endpoint shouldn't be marked as halted unless it really is halted.  
Otherwise a driver might be tempted to clear the Halt feature, and 
some devices do not like to receive a Clear-Halt request for an endpoint 
that isn't halted.

What we could do is what you suggested earlier: Note the fact that the 
endpoint is in some sort of fault condition and disallow further 
communication with the endpoint until the fault condition has been 
cleared.  (It isn't entirely obvious exactly what actions should clear 
such a fault...  I guess resetting or re-enabling the endpoint, or 
resetting the entire device.)

Alan Stern

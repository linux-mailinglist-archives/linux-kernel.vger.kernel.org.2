Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905E338911A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbhESOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:37:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33637 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S243400AbhESOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:37:34 -0400
Received: (qmail 1166645 invoked by uid 1000); 19 May 2021 10:36:13 -0400
Date:   Wed, 19 May 2021 10:36:13 -0400
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
Message-ID: <20210519143613.GA1165692@rowland.harvard.edu>
References: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
 <CAL=kjP0xOQ32xLytyVm9=d+9rnKzV2dW2VJQ6c8MAwTK7rg2Kw@mail.gmail.com>
 <20210508142947.GB810516@rowland.harvard.edu>
 <CAL=kjP1WegRkxuYuKSmvA6rZ1BrC5wE5KvLe0JjjE+wN4up8Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL=kjP1WegRkxuYuKSmvA6rZ1BrC5wE5KvLe0JjjE+wN4up8Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:48:29AM +0200, dave penkler wrote:
> On Sat, 8 May 2021 at 16:29, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sat, May 08, 2021 at 10:14:41AM +0200, dave penkler wrote:
> > > When the host driver detects a protocol error while processing an URB
> > > it completes the URB with EPROTO status and marks the endpoint as
> > > halted.
> >
> > Not true.  It does not mark the endpoint as halted, not unless it
> > receives a STALL handshake from the device.  A STALL is not a protocol
> > error.
> >
> > > When the class driver resubmits the URB and the if the host driver
> > > finds the endpoint still marked as halted it should return EPIPE
> > > status on the resubmitted URB
> >
> > Irrelevant.
> Not at all. The point is that when an application is talking to an
> instrument over the usbtmc driver, the underlying host controller and
> its driver will detect and silence a babbling endpoint.

No, they won't.  That is, they will detect a babble error and return an 
error status, but they won't silence the endpoint.  What makes you think 
they will?

> Hence no EPROTO loop will ensue in this case and therefore no changes
> are needed in usbtmc.

Since this conclusion relies on the incorrect assumption above, it also 
is incorrect.

Alan Stern

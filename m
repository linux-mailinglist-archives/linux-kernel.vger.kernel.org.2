Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAEB375A37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhEFSdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:33:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36961 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234481AbhEFSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:33:13 -0400
Received: (qmail 748263 invoked by uid 1000); 6 May 2021 14:32:14 -0400
Date:   Thu, 6 May 2021 14:32:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
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
Subject: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210506183213.GA748114@rowland.harvard.edu>
References: <be62c93e1e384f49865915b9bda1f12e@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be62c93e1e384f49865915b9bda1f12e@rohde-schwarz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 05:44:55PM +0000, Guido Kiener wrote:
> > -----Original Message-----
> > From: Alan Stern
> > Sent: Thursday, May 6, 2021 3:49 PM
> > To: Kiener Guido 14DS1 <Guido.Kiener@rohde-schwarz.com>
> > >
> > > Thanks for your assessment. I agree with the general feeling. I
> > > counted about hundred specific usb drivers, so wouldn't it be better to fix the
> > problem in some of the host drivers (e.g. urb.c)?
> > > We could return an error when calling usb_submit_urb() on an erroneous pipe.
> > > I cannot estimate the side effects and we need to check all drivers
> > > again how they deal with the error situation. Maybe there are some special driver
> > that need a specialized error handling.
> > > In this case these drivers could reset the (new?) error flag to allow
> > > calling usb_submit_urb() again without error. This could work, isn't it?
> > 
> > That is feasible, although it would be an awkward approach.  As you said, the side
> > effects aren't clear.  But it might work.
> 
> Otherwise I see only the other approach to change hundred drivers and add the
> cases EPROTO, EILSEQ and ETIME in each callback handler. The usbtmc driver
> already respects the EILSEQ and ETIME, and only EPROTO is missing.
> The rest should be more a management task.
> BTW do you assume it is only a problem for INT pipes or is it also a problem
> for isochronous and bulk transfers?

All of them.  Control too.

> > Will you be able to test patches?
> 
> I only can test the USBTMC function in some different PCs. I do not have automated
> regression tests for USB drivers or Linux kernels.
> Maybe there is company who could do that.

Well then, if I do find time to write a patch, I'll ask you to try it 
out with the usbtmc driver.

Alan Stern

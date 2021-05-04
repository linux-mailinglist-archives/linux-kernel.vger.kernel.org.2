Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D7372CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEDPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:14:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57623 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230246AbhEDPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:14:27 -0400
Received: (qmail 660129 invoked by uid 1000); 4 May 2021 11:13:31 -0400
Date:   Tue, 4 May 2021 11:13:31 -0400
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
Subject: Re: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210504151331.GB657070@rowland.harvard.edu>
References: <a4f1b9d202c5445e8c714b3181b84830@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f1b9d202c5445e8c714b3181b84830@rohde-schwarz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 09:56:05PM +0000, Guido Kiener wrote:
> Hi all,
> 
> Dave and I discussed the "self-detected stall on CPU" caused by the usbtmc driver.
> 
> What happened?
> The callback handler usbtmc_interrupt(struct urb *urb) for the INT pipe receives an erroneous urb with status -EPROTO (-71).
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/class/usbtmc.c?h=v5.12#n2340
> -EPROTO does not abort/shutdown the pipe and the urb is resubmitted to receive the next packet. However the callback handler usbtmc_interrupt is called again with the same erroneous status -EPROTO and this seems to result in an endless loop.
> According to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/usb/error-codes.rst?h=v5.12#n177
> the error -EPROTO indicates a hardware problem or a bad cable.
> 
> Most usb drivers do not react in a specific way on this hardware problems and resubmit the urb. We assume these drivers will run into the same endless loop. Some other driver samples are:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/class/cdc-acm.c?h=v5.12#n379
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/usbhid/usbmouse.c?h=v5.12#n65
> 
> Possible solutions:
> Hardware defects or bad cables seems to be a common problem for most usb drivers and I assume we do not want to fix this problem in all class specific drivers, but in lower level host drivers, e.g:
> 1. Using a counter and close the pipe after some detected errors
> 2. Delay the resubmission of the urb to avoid high cpu usage
> 3. Do nothing, since it is just a rare problem.
> 
> We've never seen this problem in our products and we do not dare to change anything.

Drivers are not consistent in the way they handle these errors, as you 
have seen.  A few try to take active measures, such as retrys with 
increasing timeouts.  Many drivers just ignore them, which is not a very 
good idea.

The general feeling among kernel USB developers is that a -EPROTO, 
-EILSEQ, or -ETIME error should be regarded as fatal, much the same as 
an unplug event.  The driver should avoid resubmitting URBs and just 
wait to be unbound from the device.

If you would like to audit drivers and fix them up to behave this way, 
that would be great.

(FYI, by far the most common causes of these errors are: The user has 
unplugged the USB cable, or the device's firmware has crashed.  It is 
quite rare for the cause to be intermittent, although not entirely 
unheard of -- for example, someone once reported errors resulting from 
EM or power-line interference caused by flickering fluorescent lights or 
something of that sort.  It's pretty safe to ignore this possibility.)

Alan Stern

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708B7389B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhETCCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:02:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35939 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230192AbhETCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:02:39 -0400
Received: (qmail 1187164 invoked by uid 1000); 19 May 2021 22:01:17 -0400
Date:   Wed, 19 May 2021 22:01:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        dave penkler <dpenkler@gmail.com>,
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
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210520020117.GA1186755@rowland.harvard.edu>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
 <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 07:38:52PM +0000, Thinh Nguyen wrote:
> Hi Alan,
> 
> Sorry if this diverges from the thread, but I've been wondering whether
> to add a change for this also.
> 
> For xHCI hosts, after transactions errors, the endpoint will enter
> halted state.

No.  You are misreading the xHCI spec.  Section 4.6.8 says:

	... the state of the associated Endpoint Context is set to 
	Halted...

Note this carefully.  It says "Endpoint Context", not "endpoint".

The endpoint is part of the device, whereas the endpoint context is part 
of the host controller.  The device doesn't know when a transaction 
error has occurred; consequently such errors do not affect the endpoint.  
The host controller does know, and consequently such errors do affect 
the endpoint context.

> The driver will attempt a few soft-retries before giving
> up. According to the xHCI spec (section 4.6.8), a host may send a
> ClearFeature(endpoint_halt) to recover and restart the transfer (see

Not quite.  The section of the spec you're talking about says:

	Software shall execute the following sequence to “reset a 
	pipe”....  Issue a ClearFeature(ENDPOINT_HALT) request to 
	device.

It does not say the host controller will do this; it says that software 
will do it.

> "reset a pipe" in xhci spec), and the class driver can handle this after
> receiving something like -EPROTO from xhci.
> 
> However, as you've pointed out, some devices don't like
> ClearFeature(ep_halt) and may not properly synchronize with the host on
> where it should restart.
> 
> Some OS (such as Windows) do this. Not sure if we also want this?

In general we should do the same thing as Windows does, because most 
hardware designers test their equipment on Windows systems but 
relatively few test on Linux systems.

> Currently the recovery is just a timeout and a port reset from the class

This depends on the driver.  Some perform no recovery at all.

> driver, but the timeout is usually defaulted to a long time (e.g. 30
> seconds for storage class driver).

That 30-second timeout in the mass-storage driver applies in situations 
where a command fails to complete, not in situations where it completes 
quickly but with a -EPROTO or -EPIPE error.

The fact is that only a small percentage of -EPROTO errors are 
recoverable.  Some of them can be handled by a port reset, which can be 
pretty awkward to perform but does occasionally work.  A lot of them 
occur because the USB cable has been unplugged; obviously there's no way 
to recover from that.  With only a few exceptions, the best and simplest 
approach is not to try to recover at all.

For the case in question (the syzbot bug report that started this 
thread), the class driver doesn't try to perform any recovery.  It just 
resubmits the URB, getting into a tight retry loop which consumes too 
much CPU time.  Simply giving up would be preferable.

Alan Stern

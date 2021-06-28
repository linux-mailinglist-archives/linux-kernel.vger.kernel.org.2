Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7D3B59F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhF1HtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:49:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:61410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhF1HtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:49:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="204898890"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="204898890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 00:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="446458597"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2021 00:46:43 -0700
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
To:     Jung Daehwan <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
 <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
 <YNJAZDwuFmEoTJHe@kroah.com> <20210628022548.GA69289@ubuntu>
 <YNlxzj7KXG43Uyrp@kroah.com> <20210628065553.GA83203@ubuntu>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <496c9d86-70d7-1050-5bbb-9f841e4b464a@intel.com>
Date:   Mon, 28 Jun 2021 10:49:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210628065553.GA83203@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2021 9.55, Jung Daehwan wrote:
> On Mon, Jun 28, 2021 at 08:53:02AM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
>>> On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
>>>> On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
>>>>> It seems 10 secs timeout is too long in general case. A core would wait for
>>>>> 10 secs without doing other task and it can be happended on every device.
>>>>
>>>> Only if the handshake does not come back sooner, right?
>>>
>>> Yes, right.
>>>
>>>> What is causing your device to timeout here?
>>>
>>> Host Controller doesn't respond handshake. I don't know why and I ask HW team
>>> to debug it.
>>
>> Please work to fix your hardware, that feels like the root of the
>> problem here.  If you require the timeout for xhci_reset() to happen,
>> then how do you know that the hardware really did reset properly in the
>> reduced amount of time you just provided?
>>
> 
> I continue fixing this issue with hardware engineer, but currently just
> host controller can crash whole system and that's why I want to fix it.
> How about adding some error logs in this situation for recognizing this issue?
> We can add error log in xhci_stop as xhci_reset can returns error like below.
> 
> static void xhci_stop(struct usb_hcd *hcd)
> {
>         u32 temp;
>         struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +       int ret;
> 
>         mutex_lock(&xhci->mutex);
> 
> @@ -733,6 +734,9 @@ static void xhci_stop(struct usb_hcd *hcd)
>         xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
>         xhci_halt(xhci);
>         xhci_reset(xhci);
> +       if (ret)
> +               xhci_err(xhci, "%s: Error while reset xhci Host controller - ret = %d\n"
> +                       , __func__, ret);
>         spin_unlock_irq(&xhci->lock);
> 

We can check the xhci_reset() return value here and print a message, makes sense.

The original reason for the 10 second timeout was because a host actually took 9 seconds:

commit 22ceac191211cf6688b1bf6ecd93c8b6bf80ed9b

    xhci: Increase reset timeout for Renesas 720201 host.
    
    The NEC/Renesas 720201 xHCI host controller does not complete its reset
    within 250 milliseconds.  In fact, it takes about 9 seconds to reset the
    host controller, and 1 second for the host to be ready for doorbell
    rings.  Extend the reset and CNR polling timeout to 10 seconds each.

-Mathias

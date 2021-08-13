Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39E73EB32B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhHMJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:07:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:11965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239035AbhHMJHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:07:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215523443"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="215523443"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 02:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="508072260"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2021 02:07:26 -0700
Subject: Re: [PATCH] usb: xhci-ring: set all cancelled_td's cancel_status to
 TD_CLEARING_CACHE
To:     wat@codeaurora.org, Ikjoon Jang <ikjn@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
 <CAATdQgDWPqoSyPxQpvdhupjWVKHDy6SqBy2kgitNLjaioPRviQ@mail.gmail.com>
 <a87c1d9563c03afb609543e7abe63708@codeaurora.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <39525c12-e8f3-8587-5714-5a22ca1e8e4f@linux.intel.com>
Date:   Fri, 13 Aug 2021 12:09:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a87c1d9563c03afb609543e7abe63708@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.8.2021 11.44, wat@codeaurora.org wrote:
> On 2021-08-13 15:25, Ikjoon Jang wrote:
>> Hi,
>>
>> On Fri, Aug 13, 2021 at 10:44 AM Tao Wang <wat@codeaurora.org> wrote:
>>>
>>> USB SSD may fail to unmount if disconnect during data transferring.
>>>
>>> it stuck in usb_kill_urb() due to urb use_count will not become zero,
>>> this means urb giveback is not happen.
>>> in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
>>> equal to TD_CLEARING_CACHE,
>>> but in xhci_invalidate_cancelled_tds(), only last canceled td's
>>> cancel_status change to TD_CLEARING_CACHE,
>>> thus giveback only happen to last urb.
>>>
>>> this change set all cancelled_td's cancel_status to TD_CLEARING_CACHE
>>> rather than the last one, so all urb can giveback.
>>>
>>> Signed-off-by: Tao Wang <wat@codeaurora.org>
>>> ---
>>>  drivers/usb/host/xhci-ring.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>>> index 8fea44b..c7dd7c0 100644
>>> --- a/drivers/usb/host/xhci-ring.c
>>> +++ b/drivers/usb/host/xhci-ring.c
>>> @@ -960,19 +960,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
>>>                         td_to_noop(xhci, ring, td, false);
>>>                         td->cancel_status = TD_CLEARED;
>>>                 }
>>> -       }
>>> -       if (cached_td) {
>>> -               cached_td->cancel_status = TD_CLEARING_CACHE;
>>> -
>>> -               err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
>>> -                                               cached_td->urb->stream_id,
>>> -                                               cached_td);
>>> -               /* Failed to move past cached td, try just setting it noop */
>>> -               if (err) {
>>> -                       td_to_noop(xhci, ring, cached_td, false);
>>> -                       cached_td->cancel_status = TD_CLEARED;
>>> +               if (cached_td) {
>>> +                       cached_td->cancel_status = TD_CLEARING_CACHE;
>>> +
>>> +                       err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
>>> +                                                       cached_td->urb->stream_id,
>>> +                                                       cached_td);
>>> +                       /* Failed to move past cached td, try just setting it noop */
>>> +                       if (err) {
>>> +                               td_to_noop(xhci, ring, cached_td, false);
>>> +                               cached_td->cancel_status = TD_CLEARED;
>>> +                       }
>>> +                       cached_td = NULL;
>>>                 }
>>> -               cached_td = NULL;
>>
>> I think we can call xhci_move_dequeue_past_td() just once to
>> the last halted && cancelled TD in a ring.
>>
>> But that might need to compare two TDs to see which one is
>> the latter, I'm not sure how to do this well. :-/
>>
>> if (!cached_td || cached_td < td)
>>   cached_td = td;
>>
> 
> thanks, I think you are correct that we can call xhci_move_dequeue_past_td() just once to
>  the last halted && cancelled TD in a ring,
> but the set status "cached_td->cancel_status = TD_CLEARING_CACHE;" should be every cancelled TD.
> I am not very good at td and ring, I have a question why we need to
> compare two TDs to see which one is the latter.

I'm debugging the exact same issue.
For normal endpoints (no streams) it should be enough to set cancel_td->cancel_status = TD_CLEARING_CACHE
in the TD_DIRTY and TD_HALTED case.

We don't need to move the dq past the last cancelled TD as other cancelled TDs are set to no-op, and
the command to move the dq will flush the xHC controllers TD cache and read the no-ops.
(just make sure we call xhci_move_dequeue_past_td() _after_ overwriting cancelled TDs with no-op)

Streams get trickier as each endpoint has several rings, and we might need to move the dq pointer for
many stream rings on that endpoint. This needs more work as we shouldn't start the endpoint before all
the all move dq commands complete. i.e. the current  ep->ep_state &= ~SET_DEQ_PENDING isn't enough.

-Mathias

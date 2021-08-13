Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237023EB3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbhHMKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:02:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47099 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239221AbhHMKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:02:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628848935; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=P2//6qY2qBL9H15tqXfsToYxN/pKSnZWVqda89Yawsk=; b=S4xhCr7eEl8TSgkbgOw230MNAtEaPl6MzQDpmxTfG9Hm7FSIJ1phVfB/E2x8+LZMk8aep/xm
 VjAwOP7DwJjjgmAqe/UZEGv2Vyhq5lBl0U/a+3PMoBMpNNTwb3DO9Fv2cDAG/6wAd0lWzMbe
 r2WV0bQnwxplVHrUn31kCk50PRY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611642c576c3a9a17217f644 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 10:00:37
 GMT
Sender: wat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 049D3C4338A; Fri, 13 Aug 2021 10:00:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10E49C433F1;
        Fri, 13 Aug 2021 10:00:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Aug 2021 18:00:34 +0800
From:   wat@codeaurora.org
To:     undisclosed-recipients:;
Subject: Re: [PATCH] usb: xhci-ring: set all cancelled_td's cancel_status to
 TD_CLEARING_CACHE
In-Reply-To: <39525c12-e8f3-8587-5714-5a22ca1e8e4f@linux.intel.com>
References: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
 <CAATdQgDWPqoSyPxQpvdhupjWVKHDy6SqBy2kgitNLjaioPRviQ@mail.gmail.com>
 <a87c1d9563c03afb609543e7abe63708@codeaurora.org>
 <39525c12-e8f3-8587-5714-5a22ca1e8e4f@linux.intel.com>
Message-ID: <e1feb74fa95ca1f19729bf959f73f30f@codeaurora.org>
X-Sender: wat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 17:09, Mathias Nyman wrote:
> On 13.8.2021 11.44, wat@codeaurora.org wrote:
>> On 2021-08-13 15:25, Ikjoon Jang wrote:
>>> Hi,
>>> 
>>> On Fri, Aug 13, 2021 at 10:44 AM Tao Wang <wat@codeaurora.org> wrote:
>>>> 
>>>> USB SSD may fail to unmount if disconnect during data transferring.
>>>> 
>>>> it stuck in usb_kill_urb() due to urb use_count will not become 
>>>> zero,
>>>> this means urb giveback is not happen.
>>>> in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
>>>> equal to TD_CLEARING_CACHE,
>>>> but in xhci_invalidate_cancelled_tds(), only last canceled td's
>>>> cancel_status change to TD_CLEARING_CACHE,
>>>> thus giveback only happen to last urb.
>>>> 
>>>> this change set all cancelled_td's cancel_status to 
>>>> TD_CLEARING_CACHE
>>>> rather than the last one, so all urb can giveback.
>>>> 
>>>> Signed-off-by: Tao Wang <wat@codeaurora.org>
>>>> ---
>>>>  drivers/usb/host/xhci-ring.c | 24 ++++++++++++------------
>>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>> 
>>>> diff --git a/drivers/usb/host/xhci-ring.c 
>>>> b/drivers/usb/host/xhci-ring.c
>>>> index 8fea44b..c7dd7c0 100644
>>>> --- a/drivers/usb/host/xhci-ring.c
>>>> +++ b/drivers/usb/host/xhci-ring.c
>>>> @@ -960,19 +960,19 @@ static int 
>>>> xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
>>>>                         td_to_noop(xhci, ring, td, false);
>>>>                         td->cancel_status = TD_CLEARED;
>>>>                 }
>>>> -       }
>>>> -       if (cached_td) {
>>>> -               cached_td->cancel_status = TD_CLEARING_CACHE;
>>>> -
>>>> -               err = xhci_move_dequeue_past_td(xhci, slot_id, 
>>>> ep->ep_index,
>>>> -                                               
>>>> cached_td->urb->stream_id,
>>>> -                                               cached_td);
>>>> -               /* Failed to move past cached td, try just setting 
>>>> it noop */
>>>> -               if (err) {
>>>> -                       td_to_noop(xhci, ring, cached_td, false);
>>>> -                       cached_td->cancel_status = TD_CLEARED;
>>>> +               if (cached_td) {
>>>> +                       cached_td->cancel_status = 
>>>> TD_CLEARING_CACHE;
>>>> +
>>>> +                       err = xhci_move_dequeue_past_td(xhci, 
>>>> slot_id, ep->ep_index,
>>>> +                                                       
>>>> cached_td->urb->stream_id,
>>>> +                                                       cached_td);
>>>> +                       /* Failed to move past cached td, try just 
>>>> setting it noop */
>>>> +                       if (err) {
>>>> +                               td_to_noop(xhci, ring, cached_td, 
>>>> false);
>>>> +                               cached_td->cancel_status = 
>>>> TD_CLEARED;
>>>> +                       }
>>>> +                       cached_td = NULL;
>>>>                 }
>>>> -               cached_td = NULL;
>>> 
>>> I think we can call xhci_move_dequeue_past_td() just once to
>>> the last halted && cancelled TD in a ring.
>>> 
>>> But that might need to compare two TDs to see which one is
>>> the latter, I'm not sure how to do this well. :-/
>>> 
>>> if (!cached_td || cached_td < td)
>>>   cached_td = td;
>>> 
>> 
>> thanks, I think you are correct that we can call 
>> xhci_move_dequeue_past_td() just once to
>>  the last halted && cancelled TD in a ring,
>> but the set status "cached_td->cancel_status = TD_CLEARING_CACHE;" 
>> should be every cancelled TD.
>> I am not very good at td and ring, I have a question why we need to
>> compare two TDs to see which one is the latter.
> 
> I'm debugging the exact same issue.
> For normal endpoints (no streams) it should be enough to set
> cancel_td->cancel_status = TD_CLEARING_CACHE
> in the TD_DIRTY and TD_HALTED case.
> 
> We don't need to move the dq past the last cancelled TD as other
> cancelled TDs are set to no-op, and
> the command to move the dq will flush the xHC controllers TD cache and
> read the no-ops.
> (just make sure we call xhci_move_dequeue_past_td() _after_
> overwriting cancelled TDs with no-op)
> 
> Streams get trickier as each endpoint has several rings, and we might
> need to move the dq pointer for
> many stream rings on that endpoint. This needs more work as we
> shouldn't start the endpoint before all
> the all move dq commands complete. i.e. the current  ep->ep_state &=
> ~SET_DEQ_PENDING isn't enough.
> 
> -Mathias
ok, thanks, please tell me if you have a great solution after debugging, 
I still need to learn from you.

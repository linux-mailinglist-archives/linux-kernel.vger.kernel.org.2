Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C493EB2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhHMIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:45:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49919 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239458AbhHMIpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:45:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628844281; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Hcc2FxmHIY2GdiFcXl5MMCZnhwtJVytw2Sr5LMIcmR8=;
 b=a1L5TC6yCP0xzXxYWBnMiPtMyPww1Wq83CW0XbnG6v/y8oIMa7QSsUlVN8CU2sT4FTSeOHQD
 kwiMXiHr/V99VpqGMrNV60U7m5BYVHuAJ0ozwvVaiZ6iDjBdnCQMLw545ntTNVfz43lQt61j
 0zjNoQzhjL1lycCUqGd2Zb2S/wY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 611630f791487ad52072eaa1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 08:44:39
 GMT
Sender: wat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7A48C43217; Fri, 13 Aug 2021 08:44:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E49CC433D3;
        Fri, 13 Aug 2021 08:44:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Aug 2021 16:44:37 +0800
From:   wat@codeaurora.org
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci-ring: set all cancelled_td's cancel_status to
 TD_CLEARING_CACHE
In-Reply-To: <CAATdQgDWPqoSyPxQpvdhupjWVKHDy6SqBy2kgitNLjaioPRviQ@mail.gmail.com>
References: <1628822604-29239-1-git-send-email-wat@codeaurora.org>
 <CAATdQgDWPqoSyPxQpvdhupjWVKHDy6SqBy2kgitNLjaioPRviQ@mail.gmail.com>
Message-ID: <a87c1d9563c03afb609543e7abe63708@codeaurora.org>
X-Sender: wat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 15:25, Ikjoon Jang wrote:
> Hi,
> 
> On Fri, Aug 13, 2021 at 10:44 AM Tao Wang <wat@codeaurora.org> wrote:
>> 
>> USB SSD may fail to unmount if disconnect during data transferring.
>> 
>> it stuck in usb_kill_urb() due to urb use_count will not become zero,
>> this means urb giveback is not happen.
>> in xhci_handle_cmd_set_deq() will giveback urb if td's cancel_status
>> equal to TD_CLEARING_CACHE,
>> but in xhci_invalidate_cancelled_tds(), only last canceled td's
>> cancel_status change to TD_CLEARING_CACHE,
>> thus giveback only happen to last urb.
>> 
>> this change set all cancelled_td's cancel_status to TD_CLEARING_CACHE
>> rather than the last one, so all urb can giveback.
>> 
>> Signed-off-by: Tao Wang <wat@codeaurora.org>
>> ---
>>  drivers/usb/host/xhci-ring.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/usb/host/xhci-ring.c 
>> b/drivers/usb/host/xhci-ring.c
>> index 8fea44b..c7dd7c0 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -960,19 +960,19 @@ static int xhci_invalidate_cancelled_tds(struct 
>> xhci_virt_ep *ep)
>>                         td_to_noop(xhci, ring, td, false);
>>                         td->cancel_status = TD_CLEARED;
>>                 }
>> -       }
>> -       if (cached_td) {
>> -               cached_td->cancel_status = TD_CLEARING_CACHE;
>> -
>> -               err = xhci_move_dequeue_past_td(xhci, slot_id, 
>> ep->ep_index,
>> -                                               
>> cached_td->urb->stream_id,
>> -                                               cached_td);
>> -               /* Failed to move past cached td, try just setting it 
>> noop */
>> -               if (err) {
>> -                       td_to_noop(xhci, ring, cached_td, false);
>> -                       cached_td->cancel_status = TD_CLEARED;
>> +               if (cached_td) {
>> +                       cached_td->cancel_status = TD_CLEARING_CACHE;
>> +
>> +                       err = xhci_move_dequeue_past_td(xhci, slot_id, 
>> ep->ep_index,
>> +                                                       
>> cached_td->urb->stream_id,
>> +                                                       cached_td);
>> +                       /* Failed to move past cached td, try just 
>> setting it noop */
>> +                       if (err) {
>> +                               td_to_noop(xhci, ring, cached_td, 
>> false);
>> +                               cached_td->cancel_status = TD_CLEARED;
>> +                       }
>> +                       cached_td = NULL;
>>                 }
>> -               cached_td = NULL;
> 
> I think we can call xhci_move_dequeue_past_td() just once to
> the last halted && cancelled TD in a ring.
> 
> But that might need to compare two TDs to see which one is
> the latter, I'm not sure how to do this well. :-/
> 
> if (!cached_td || cached_td < td)
>   cached_td = td;
> 

thanks, I think you are correct that we can call 
xhci_move_dequeue_past_td() just once to
  the last halted && cancelled TD in a ring,
but the set status "cached_td->cancel_status = TD_CLEARING_CACHE;" 
should be every cancelled TD.
I am not very good at td and ring, I have a question why we need to
compare two TDs to see which one is the latter.

>>         }
>>         return 0;
>>  }
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

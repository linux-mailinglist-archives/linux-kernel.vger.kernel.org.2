Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201983EAE5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHMCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:04:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10481 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236979AbhHMCER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:04:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628820231; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=9IWAWjMaRHIXrrMkXgx/7do+OxEmc5WZak/I6rUevmw=; b=JByXkFCTVsj3nDQ/vg76lXIrwHvn4N7rNG8Wvgb56o1SrqaD6Cxfss6Z1Dx1/TR/VfSjfaQk
 D1Ouh9k90GHB734UJM8C+tg3KQJ/3YfwlzKD3yHoBAbCkhOI/+BqIAy7ktSzh+bSDjLYaJWs
 eO4D1+ghgUqDZ5wrrdnOJWioiDQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6115d30066ff107904645adb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 02:03:44
 GMT
Sender: wat=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5507C43460; Fri, 13 Aug 2021 02:03:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wat)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 501CEC433F1;
        Fri, 13 Aug 2021 02:03:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Aug 2021 10:03:41 +0800
From:   wat@codeaurora.org
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci-ring: USB SSD may fail to unmount if disconnect
 during data transferring.
In-Reply-To: <83812530fbe1ba6f93c0978019bf118b@codeaurora.org>
References: <1628769727-45046-1-git-send-email-wat@codeaurora.org>
 <83812530fbe1ba6f93c0978019bf118b@codeaurora.org>
Message-ID: <a23f3eb7f63290968af3c42bbe5935da@codeaurora.org>
X-Sender: wat@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry， This email is invalid because some reason, I will submit another 
email for it.


On 2021-08-13 09:44, wat@codeaurora.org wrote:
> Hi usb teams,
> 
> I have a patch about xhci-ring, can you help me to check?
> 
> you can contact me if you have any question.
> 
> 
> On 2021-08-12 20:02, Tao Wang wrote:
>> From: Tao Wang <quic_wat@quicinc.com>
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
>> Signed-off-by: Tao Wang <quic_wat@quicinc.com>
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
>>  			td_to_noop(xhci, ring, td, false);
>>  			td->cancel_status = TD_CLEARED;
>>  		}
>> -	}
>> -	if (cached_td) {
>> -		cached_td->cancel_status = TD_CLEARING_CACHE;
>> -
>> -		err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
>> -						cached_td->urb->stream_id,
>> -						cached_td);
>> -		/* Failed to move past cached td, try just setting it noop */
>> -		if (err) {
>> -			td_to_noop(xhci, ring, cached_td, false);
>> -			cached_td->cancel_status = TD_CLEARED;
>> +		if (cached_td) {
>> +			cached_td->cancel_status = TD_CLEARING_CACHE;
>> +
>> +			err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
>> +							cached_td->urb->stream_id,
>> +							cached_td);
>> +			/* Failed to move past cached td, try just setting it noop */
>> +			if (err) {
>> +				td_to_noop(xhci, ring, cached_td, false);
>> +				cached_td->cancel_status = TD_CLEARED;
>> +			}
>> +			cached_td = NULL;
>>  		}
>> -		cached_td = NULL;
>>  	}
>>  	return 0;
>>  }

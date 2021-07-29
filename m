Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544253D9FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhG2IqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:46:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22335 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234878AbhG2IqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:46:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627548358; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lKuAAk8F0oxV9TYCasggJHyecJyxjeqW5tMXFtGCbEI=; b=PeVkAWOsDwx6d0gEEspduh2DcLa3VRDcC1+PBwCz2Tp92pShynO4JkxizCCptF7TCV1g9HSc
 5bsMBUMy9SHvR3tUmbS10Ca6wy+W/pLNkLqXcxUk4JZRX/DV5fN5X5OQtD/LXlCB6zSl3i31
 Ef+7pNL3iaDaVrPxmxGdKcNiRX0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61026abce81205dd0aed5123 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 08:45:48
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7800C4338A; Thu, 29 Jul 2021 08:45:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.37.24] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 790FBC4338A;
        Thu, 29 Jul 2021 08:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 790FBC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Use list_replace_init() before
 traversing lists
To:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jackp@codeaurora.org
References: <1627543994-20327-1-git-send-email-wcheng@codeaurora.org>
 <87zgu5v8om.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <4e06452a-080f-a2be-ab88-9ac992740ee0@codeaurora.org>
Date:   Thu, 29 Jul 2021 01:45:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87zgu5v8om.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 7/29/2021 1:09 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
>> The list_for_each_entry_safe() macro saves the current item (n) and
>> the item after (n+1), so that n can be safely removed without
>> corrupting the list.  However, when traversing the list and removing
>> items using gadget giveback, the DWC3 lock is briefly released,
>> allowing other routines to execute.  There is a situation where, while
>> items are being removed from the cancelled_list using
>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>> routine is running in parallel (due to UDC unbind).  As the cleanup
>> routine removes n, and the pullup disable removes n+1, once the
>> cleanup retakes the DWC3 lock, it references a request who was already
>> removed/handled.  With list debug enabled, this leads to a panic.
>> Ensure all instances of the macro are replaced where gadget giveback
>> is used.
>>
>> Example call stack:
>>
>> Thread#1:
>> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>>     ->list_for_each_entry_safe()
>>     ->dwc3_gadget_giveback(n)
>>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>>       ->spin_unlock
>>       ->Thread#2 executes
>>       ...
>>     ->dwc3_gadget_giveback(n+1)
>>       ->Already removed!
>>
>> Thread#2:
>> dwc3_gadget_pullup()
>>   ->waiting for dwc3 spin_lock
>>   ...
>>   ->Thread#1 released lock
>>   ->dwc3_stop_active_transfers()
>>     ->dwc3_remove_requests()
>>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>>       ->dwc3_gadget_giveback()
>>         ->dwc3_gadget_del_and_unmap_request()- n+1
>> deleted[cancelled_list]
>>         ->spin_unlock
>>
>> Fix this condition by utilizing list_replace_init(), and traversing
>> through a local copy of the current elements in the endpoint lists.
>> This will also set the parent list as empty, so if another thread is
>> also looping through the list, it will be empty on the next iteration.
>>
>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>
>> ---
>> Previous patchset:
>> https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/
>> ---
>>  drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index a29a4ca..3ce6ed9 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1926,9 +1926,13 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>>  {
>>  	struct dwc3_request		*req;
>>  	struct dwc3_request		*tmp;
>> +	struct list_head		local;
>>  	struct dwc3			*dwc = dep->dwc;
>>  
>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>> +restart:
>> +	list_replace_init(&dep->cancelled_list, &local);
> 
> hmm, if the lock is held and IRQs disabled when this runs, then no other
> threads will be able to append requests to the list which makes the
> "restart" label unnecessary, no?

We do still call dwc3_gadget_giveback() which would release the lock
briefly, so if there was another thread waiting on dwc->lock, it would
be able to add additional items to that list.

> 
> I wonder if we should release the lock and reenable interrupts after
> replacing the head. The problem is that
> dwc3_gadget_ep_cleanup_cancelled_requests() can run from the IRQ
> handler.
> 

We would also need to consider that some of the APIs being called in
these situations would also have the assumption that the dwc->lock is
held, ie dwc3_gadget_giveback()

Thanks
Wesley Cheng

> Alan, could you provide your insight here? Do you think we should defer
> this to a low priority tasklet or something along those lines?
> 
>> +	list_for_each_entry_safe(req, tmp, &local, list) {
>>  		dwc3_gadget_ep_skip_trbs(dep, req);
>>  		switch (req->status) {
>>  		case DWC3_REQUEST_STATUS_DISCONNECTED:
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACD3D805B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhG0VBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:01:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19993 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234447AbhG0VAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:00:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627419630; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Kq1881QGwVFiiS4S0da3eS/MhMFX22cv5dovHiGH+eE=; b=Zda9VcE8dWFbW+AJuNe17Bdx4DSoZDcBD1V/Z8O47hJuNvoJzmGa4WyUHWgNGSF+qqo3WedT
 gV2TOOh7HaChP7ScaFAabCIPu9PxObCMp+TNjmlHPEYQBpc4Q78SYf4FedeLf3QOUayLJ0On
 IUkf7YDty1AhRIgusn7agiG6tHA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 610073e417c2b4047d539d4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Jul 2021 21:00:20
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A45A0C43152; Tue, 27 Jul 2021 21:00:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.37.24] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DC5CC43148;
        Tue, 27 Jul 2021 21:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DC5CC43148
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Replace list_for_each_entry_safe()
 if using giveback
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
 <87tun9g01v.fsf@kernel.org>
 <2675db9e-0cab-06b5-2986-0b4456a1f040@codeaurora.org>
 <5156238d-c1d8-a0d3-47af-8b52467fd071@codeaurora.org>
 <fc346f3c-6e3d-b96c-d64a-2ae4cf4218d4@codeaurora.org>
 <87v954xjoz.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <3c55dd4f-5ebd-3730-7428-cb15235465a7@codeaurora.org>
Date:   Tue, 27 Jul 2021 14:00:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87v954xjoz.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 7/20/2021 11:30 PM, Felipe Balbi wrote:
> 
> Hi Wesley,
> 
> (first of all, sorry for the super long delay. This really fell through
> the cracks)
> 

No problem, I understand that you probably get a whole bunch of things
all at once, so its hard to keep track of each one :).

> Wesley Cheng <wcheng@codeaurora.org> writes:
>> Hi Felipe,
>>
>> On 6/9/2021 1:57 PM, Wesley Cheng wrote:
>>> Hi Felipe,
>>>
>>> On 5/19/2021 1:52 AM, Wesley Cheng wrote:
>>>>
>>>>
>>>> On 5/11/2021 1:13 AM, Felipe Balbi wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>>>> The list_for_each_entry_safe() macro saves the current item (n) and
>>>>>> the item after (n+1), so that n can be safely removed without
>>>>>> corrupting the list.  However, when traversing the list and removing
>>>>>> items using gadget giveback, the DWC3 lock is briefly released,
>>>>>> allowing other routines to execute.  There is a situation where, while
>>>>>> items are being removed from the cancelled_list using
>>>>>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>>>>>> routine is running in parallel (due to UDC unbind).  As the cleanup
>>>>>> routine removes n, and the pullup disable removes n+1, once the
>>>>>> cleanup retakes the DWC3 lock, it references a request who was already
>>>>>> removed/handled.  With list debug enabled, this leads to a panic.
>>>>>> Ensure all instances of the macro are replaced where gadget giveback
>>>>>> is used.
>>>>>>
>>>>>> Example call stack:
>>>>>>
>>>>>> Thread#1:
>>>>>> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>>>>>>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>>>     ->list_for_each_entry_safe()
>>>>>>     ->dwc3_gadget_giveback(n)
>>>>>>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>>>>>>       ->spin_unlock
>>>>>>       ->Thread#2 executes
>>>>>>       ...
>>>>>>     ->dwc3_gadget_giveback(n+1)
>>>>>>       ->Already removed!
>>>>>>
>>>>>> Thread#2:
>>>>>> dwc3_gadget_pullup()
>>>>>>   ->waiting for dwc3 spin_lock
>>>>>>   ...
>>>>>>   ->Thread#1 released lock
>>>>>>   ->dwc3_stop_active_transfers()
>>>>>>     ->dwc3_remove_requests()
>>>>>>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>>>>>>       ->dwc3_gadget_giveback()
>>>>>>         ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_list]
>>>>>>         ->spin_unlock
>>>>>>
>>>>>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>>> Reviewed-by: Peter Chen <peter.chen@kernel.org>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>>  - Updated commit message with context call stack of an example scenario
>>>>>>    seen on device.
>>>>>>
>>>>>>  drivers/usb/dwc3/gadget.c | 8 ++++----
>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>> index dd80e5c..efa939b 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
>>>>>>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>>>>>>  {
>>>>>>  	struct dwc3_request		*req;
>>>>>> -	struct dwc3_request		*tmp;
>>>>>>  	struct dwc3			*dwc = dep->dwc;
>>>>>>  
>>>>>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>>>>>> +	while (!list_empty(&dep->cancelled_list)) {
>>>>>> +		req = next_request(&dep->cancelled_list);
>>>>>
>>>>> couldn't this be solved list_replace_init() instead? Then we can keep
>>>>> using the regular list_for_each_entry_safe() which has an added semantic
>>>>> meaning due to its name.
>>>>>
>>>>
>>>> Hi Felipe,
>>>>
>>>> Sorry for the late response.  So I tried with a list_replace_init() to
>>>> within the list_for_each_entry_safe() loop to update tmp w/ the
>>>> cancelled_list list head, but the issue was still observed.  This is
>>>> because we can't replace the reference the loop already has stored in
>>>> tmp, which is simply updated as the current item on the next iteration.
>>>>
>>>> I believe this is what you were trying to achieve?
>>>>
>>> Was wondering if you had any further inputs on this change?  As
>>> mentioned, I tried a few things with list_replace_init(), which did not
>>> work.
>>>
>>
>> Sorry for the ping.  Is this change OK to add as is?  We've been running
>> into this instance pretty frequently during our testing, so just wanted
>> to close on the proper changes being merged upstream.
> 
> The idea is this:
> 
> 	struct list_head	local;
> 
>         spin_lock_irq(&lock);
>         list_replace_init(&dwc->cancelled_list, &local);
>         spin_unlock_irq(&lock);
> 
> 	list_for_each_entry_safe(req, tmp, &local, list) {
>         	/* ... */
> 	}
> 
> It looks to me this should work fine, no? You can also follow what
> drivers/usb/core/hcd.c is doing in usb_giveback_urb_bh() and restarting
> if dwc->cancelled_list is not empty after list_for_each_entry_safe().
> 
> Can you give that one a shot?
> 

Great, thanks for this suggestion!  Now I understand what you were
referring to.  I gave this a try and it works well.  Will prepare a
change to replace both places with list_replace_init()

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

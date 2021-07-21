Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1E3D08CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhGUFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:41:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38741 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhGUFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:33:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626848065; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=2DNS7PaOJ14OdE1UldO2f9tBpLwpV8ZcD+vWyrU+j5s=; b=SjAfbMGGpe2Lr/MTMieP4qYNvdc+Y5foci42MrYQgb1xsxmBwzQZxIK/FseQN/x9ZPOuL6Dx
 D336+3P+8CwiednDhusjB4TAbSsdlrt+82pjI0NiiV1lwG1zPrwdEuXIiiUv9S/sEOsW23/q
 Gfz68ZGQcJWBX1bLdj5JjgTI52E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f7bb3a1dd16c878850ce78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 06:14:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02A89C43460; Wed, 21 Jul 2021 06:14:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.40.148] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50F49C433F1;
        Wed, 21 Jul 2021 06:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50F49C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Replace list_for_each_entry_safe()
 if using giveback
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
 <87tun9g01v.fsf@kernel.org>
 <2675db9e-0cab-06b5-2986-0b4456a1f040@codeaurora.org>
 <5156238d-c1d8-a0d3-47af-8b52467fd071@codeaurora.org>
Message-ID: <fc346f3c-6e3d-b96c-d64a-2ae4cf4218d4@codeaurora.org>
Date:   Tue, 20 Jul 2021 23:14:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5156238d-c1d8-a0d3-47af-8b52467fd071@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 6/9/2021 1:57 PM, Wesley Cheng wrote:
> Hi Felipe,
> 
> On 5/19/2021 1:52 AM, Wesley Cheng wrote:
>>
>>
>> On 5/11/2021 1:13 AM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>> The list_for_each_entry_safe() macro saves the current item (n) and
>>>> the item after (n+1), so that n can be safely removed without
>>>> corrupting the list.  However, when traversing the list and removing
>>>> items using gadget giveback, the DWC3 lock is briefly released,
>>>> allowing other routines to execute.  There is a situation where, while
>>>> items are being removed from the cancelled_list using
>>>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>>>> routine is running in parallel (due to UDC unbind).  As the cleanup
>>>> routine removes n, and the pullup disable removes n+1, once the
>>>> cleanup retakes the DWC3 lock, it references a request who was already
>>>> removed/handled.  With list debug enabled, this leads to a panic.
>>>> Ensure all instances of the macro are replaced where gadget giveback
>>>> is used.
>>>>
>>>> Example call stack:
>>>>
>>>> Thread#1:
>>>> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>>>>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>     ->list_for_each_entry_safe()
>>>>     ->dwc3_gadget_giveback(n)
>>>>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>>>>       ->spin_unlock
>>>>       ->Thread#2 executes
>>>>       ...
>>>>     ->dwc3_gadget_giveback(n+1)
>>>>       ->Already removed!
>>>>
>>>> Thread#2:
>>>> dwc3_gadget_pullup()
>>>>   ->waiting for dwc3 spin_lock
>>>>   ...
>>>>   ->Thread#1 released lock
>>>>   ->dwc3_stop_active_transfers()
>>>>     ->dwc3_remove_requests()
>>>>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>>>>       ->dwc3_gadget_giveback()
>>>>         ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_list]
>>>>         ->spin_unlock
>>>>
>>>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>> Reviewed-by: Peter Chen <peter.chen@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>>  - Updated commit message with context call stack of an example scenario
>>>>    seen on device.
>>>>
>>>>  drivers/usb/dwc3/gadget.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index dd80e5c..efa939b 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
>>>>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>>>>  {
>>>>  	struct dwc3_request		*req;
>>>> -	struct dwc3_request		*tmp;
>>>>  	struct dwc3			*dwc = dep->dwc;
>>>>  
>>>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>>>> +	while (!list_empty(&dep->cancelled_list)) {
>>>> +		req = next_request(&dep->cancelled_list);
>>>
>>> couldn't this be solved list_replace_init() instead? Then we can keep
>>> using the regular list_for_each_entry_safe() which has an added semantic
>>> meaning due to its name.
>>>
>>
>> Hi Felipe,
>>
>> Sorry for the late response.  So I tried with a list_replace_init() to
>> within the list_for_each_entry_safe() loop to update tmp w/ the
>> cancelled_list list head, but the issue was still observed.  This is
>> because we can't replace the reference the loop already has stored in
>> tmp, which is simply updated as the current item on the next iteration.
>>
>> I believe this is what you were trying to achieve?
>>
> Was wondering if you had any further inputs on this change?  As
> mentioned, I tried a few things with list_replace_init(), which did not
> work.
> 

Sorry for the ping.  Is this change OK to add as is?  We've been running
into this instance pretty frequently during our testing, so just wanted
to close on the proper changes being merged upstream.

Thanks
Wesley Cheng


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

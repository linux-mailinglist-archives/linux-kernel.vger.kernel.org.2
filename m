Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9767A3889DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhESIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:54:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43520 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344044AbhESIyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:54:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621414363; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=NZyAntkG5h7vLjy6bsXrV6/J4Qb+kuYpdE+eTcZ/D9k=; b=SnzMT5yfkVqcaNHkmAUks6T19jBkckDAXsjIWYVl6lR+YbFpfgZ6F2PYlsEScyr4AX59m1ou
 Pz0nMnuLMaGM4ILcnifEEkirg8jzN3F+y7cQyT5g0YvvfY/ryia2/zlC4xejrP/oly4Ev25R
 teuVMkWvo1585o4Z2xW3Nk26HG0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60a4d1da1449805ea28b2d1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 08:52:42
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4BB9AC433F1; Wed, 19 May 2021 08:52:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.96.176] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91B64C433D3;
        Wed, 19 May 2021 08:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91B64C433D3
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
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <2675db9e-0cab-06b5-2986-0b4456a1f040@codeaurora.org>
Date:   Wed, 19 May 2021 01:52:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87tun9g01v.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2021 1:13 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
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
>>         ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_list]
>>         ->spin_unlock
>>
>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> Reviewed-by: Peter Chen <peter.chen@kernel.org>
>> ---
>> Changes in v2:
>>  - Updated commit message with context call stack of an example scenario
>>    seen on device.
>>
>>  drivers/usb/dwc3/gadget.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index dd80e5c..efa939b 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
>>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
>>  {
>>  	struct dwc3_request		*req;
>> -	struct dwc3_request		*tmp;
>>  	struct dwc3			*dwc = dep->dwc;
>>  
>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>> +	while (!list_empty(&dep->cancelled_list)) {
>> +		req = next_request(&dep->cancelled_list);
> 
> couldn't this be solved list_replace_init() instead? Then we can keep
> using the regular list_for_each_entry_safe() which has an added semantic
> meaning due to its name.
> 

Hi Felipe,

Sorry for the late response.  So I tried with a list_replace_init() to
within the list_for_each_entry_safe() loop to update tmp w/ the
cancelled_list list head, but the issue was still observed.  This is
because we can't replace the reference the loop already has stored in
tmp, which is simply updated as the current item on the next iteration.

I believe this is what you were trying to achieve?

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

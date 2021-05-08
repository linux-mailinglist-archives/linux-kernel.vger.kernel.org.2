Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33137709C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEHIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:16:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56187 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhEHIQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:16:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620461753; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0KPm7oGzmL0q2aWv65LlrmKsUkDV5qha/CX/tq0j1zM=; b=BA1xC97KHfkE4b8gMiiv8LcsxN99MDlXhIHusYxz5KxB918RU5J+Q7EEiamLIzJqN6K7W8+N
 uE0Xp4aDP4bvtFrsR3EC/DuffwMLc2nKSoyj+/7D3JP5ebak299WbxksXU153KzFeg55PqZd
 46L6BqOsHUXRvSqUVIv17GfDJ0E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 609648b987ce1fbb563eaca5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 08 May 2021 08:15:53
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FEC7C43145; Sat,  8 May 2021 08:15:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.52.184] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D568CC4338A;
        Sat,  8 May 2021 08:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D568CC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Replace list_for_each_entry_safe() if
 using giveback
To:     Peter Chen <peter.chen@kernel.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
References: <1620412923-11990-1-git-send-email-wcheng@codeaurora.org>
 <20210508034551.GA2728@nchen>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <cec4b493-ff09-4543-661e-68c0c4d44e0f@codeaurora.org>
Date:   Sat, 8 May 2021 01:15:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508034551.GA2728@nchen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2021 8:45 PM, Peter Chen wrote:
> On 21-05-07 11:42:03, Wesley Cheng wrote:
>> The list_for_each_entry_safe() macro saves the current item (n) and
>> the item after (n+1), so that n can be safely removed without
>> corrupting the list.  However, when traversing the list and removing
>> items using gadget giveback, the DWC3 lock is briefly released,

Hi Peter,

Thanks for the review.

> 
> I see dwc3_gadget_del_and_unmap_request remove the list, the lock is
> still held there. Am I something wrong?
> 

The scenario the issue happens in is say the follow thread is running
the sequence below:

Thread#1:
__dwc3_gadget_ep_set_halt() - CLEAR HALT
  -> dwc3_gadget_ep_cleanup_cancelled_requests()
    ->list_for_each_entry_safe()
    ->dwc3_gadget_giveback()
      ->dwc3_gadget_del_and_unmap_request()-n deleted cancelled_list
      ->spin_unlock

Thread#2:
dwc3_gadget_pullup()
  ->waiting for dwc3 spin_lock
  ->Thread#1 released lock
  ->dwc3_stop_active_transfers()
    ->dwc3_remove_requests()
      ->fetches n+1 item from cancelled_list (n removed by thread#1)
      ->dwc3_gadget_giveback()
        ->dwc3_gadget_del_and_unmap_request()-n+1 deleted cancelled_list
        ->spin_unlock

So now, if thread#1 takes the DWC3 lock again, it will continue to item
n+1, which was already removed by thread#2, leading to a double list
removal.  We saw this issue on our platform after enabling list debug.

Thanks
Wesley Cheng

> Peter
>        
>> allowing other routines to execute.  There is a situation where while
>> items are being removed from the cancelled_list using
>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>> routine is running in parallel (due to UDC unbind).  As the cleanup
>> routine removes n, and the pullup disable removes n+1, once the
>> cleanup retakes the DWC3 lock, it references a request who was already
>> removed/handled.  With list debug enabled, this leads to a panic.
>> Ensure all instances of the macro are replaced where gadget giveback
>> is used.
>>
>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
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
>>  		dwc3_gadget_ep_skip_trbs(dep, req);
>>  		switch (req->status) {
>>  		case DWC3_REQUEST_STATUS_DISCONNECTED:
>> @@ -2935,11 +2935,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
>>  		const struct dwc3_event_depevt *event, int status)
>>  {
>>  	struct dwc3_request	*req;
>> -	struct dwc3_request	*tmp;
>>  
>> -	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
>> +	while (!list_empty(&dep->started_list)) {
>>  		int ret;
>>  
>> +		req = next_request(&dep->started_list);
>>  		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
>>  				req, status);
>>  		if (ret)
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0431D33C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 01:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBQAIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 19:08:36 -0500
Received: from z11.mailgun.us ([104.130.96.11]:34671 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhBQAId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:08:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613520493; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sOL58otYVbO9KpkCVWoE3Hr3GQzXRXCnoq1WEZdF9WM=; b=Swkb+nhnUJ9I5carBKQTHzjHsraomeJEdSCmQVxRyCAlfdHOash5WM+6YmV9kj8w8TVnrgiE
 CEj8Eze4Lot531McRBPbXJ57Khuh2L4G7ByblxxEbF26YtDAK4AwjCrvZQO9oF2zjcXhuPX+
 Wyq1aV3N7ACFVHfji0IG66Bxzbs=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 602c5e4d24187d7bf210de3c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 00:07:41
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83620C43461; Wed, 17 Feb 2021 00:07:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.74.71] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED0FAC433C6;
        Wed, 17 Feb 2021 00:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED0FAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
To:     eg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
 <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
 <20210215174145.GA960831@rowland.harvard.edu> <20210216013052.GA37172@ubuntu>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <d725315a-de98-aa77-fb81-65df19757954@codeaurora.org>
Date:   Tue, 16 Feb 2021 16:07:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210216013052.GA37172@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2021 5:30 PM, Jung Daehwan wrote:
> Hello, Alan
> 
> On Mon, Feb 15, 2021 at 12:41:45PM -0500, Alan Stern wrote:
>> On Mon, Feb 15, 2021 at 11:38:58AM +0900, Daehwan Jung wrote:
>>> It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.
>>
>> How is this fact related to your patch?
> 
> I think we should cause dwc3_runtime_suspend at the time.
> That's why I use pm_runtime_put_sync_suspend.
> 
>>
>>> It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.
>>
>> Why do you think it is better?  The advantage of pm_runtime_put is that 
>> it allows the suspend to occur at a later time in a workqueue thread, so 
>> the caller doesn't have to wait for the device to go into suspend.
>>
> 
> We can assume DWC3 was already in suspend state if pm_runtime_get_sync
> returns 0. DWC3 resumes due to pm_rumtime_get_sync but it doesn't
> re-enter runtime_suspend but runtime_idle. pm_runtime_put decreases
> usage_count but doesn't cause runtime_suspend.
> 
> 1. USB disconnected
> 2. UDC unbinded
> 3. DWC3 runtime suspend
> 4. UDC binded unexpectedly
> 5. DWC3 runtime resume (pm_runtime_get_sync)
> 6. DWC3 runtime idle (pm_runtime_put)
>    -> DWC3 runtime suspend again (pm_runtime_put_sync_suspend)
> 
> I've talked with Wesley in other patch.
> 
> usbb: dwc3: gadget: skip pullup and set_speed after suspend
> patchwork.kernel.org/project/linux-usb/patch/1611113968-102424-1-git-send-email-dh10.jung@samsung.com
> 
> @ Wesley
> 
> I think We should guarantee DWC3 enters suspend again at the time.
> How do you think?
> 
Hi Daehwan,

Even if we call runtime idle versus suspend, if the device is still in
the disconnected state, it should call the runtime PM suspend routine
after the autosuspend timer expires.  As Alan mentioned already, this
allows not blocking the caller for the entire DWC3 suspend sequence to
execute. (DWC3 core will suspend other components as well, such as PHYs)

Also, for legitimate cases where pullup is actually called to start
enumeration from a suspended state, I'm not sure if the short duration
between RS set and re-suspend (due to your patch) is enough time for the
host to actually detect the device connected.

Thanks
Wesley Cheng

> Best Regards,
> Jung Daehwan
> 
>> Alan Stern
>>
> 
> 
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index aebcf8e..4a4b93b 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2229,7 +2229,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>  	 */
>>>  	ret = pm_runtime_get_sync(dwc->dev);
>>>  	if (!ret || ret < 0) {
>>> -		pm_runtime_put(dwc->dev);
>>> +		pm_runtime_put_sync_suspend(dwc->dev);
>>>  		return 0;
>>>  	}
>>>  
>>> -- 
>>> 2.7.4
>>>
>>
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0C372726
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEDIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:25:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64096 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhEDIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:25:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620116701; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=hGiADiVYbn1GAyE0o74yZslVUqdaLzGRe9aZ/mqTyvQ=; b=I9NB4W4nFejx2msUGoy7cGLR0Ana4IJDXsmtuSypiqj7Y+IHs0H8l9fCJtWZcwL3GptW+w07
 PGZoAl7WoDU1lllHJpjwO01zsaQplEk5bhqc79v+Qb28QqKZNprhAJhCk7GH82A4B3RfR63+
 i0V7YWY9BB7pNtJ5BqJaDUsYkZo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 609104cd8166b7eff79b17de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 08:24:45
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0DF3C4323A; Tue,  4 May 2021 08:24:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.61.52] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F360C433D3;
        Tue,  4 May 2021 08:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F360C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <e12fc396-76e6-9506-31c8-cfdee3fb7577@synopsys.com>
 <7ef627cf-3f8f-8a52-52c4-ac67ab48b87d@codeaurora.org>
 <5c06dc0a-4274-b6f0-3844-bd8afa1a59f9@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <be826457-bcd5-3dc3-0f71-faa3ac60ac63@codeaurora.org>
Date:   Tue, 4 May 2021 01:24:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5c06dc0a-4274-b6f0-3844-bd8afa1a59f9@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2021 10:22 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>>
>>
>> On 5/3/2021 8:12 PM, Thinh Nguyen wrote:
>>> Hi Wesley,
>>>
>>> Wesley Cheng wrote:
>>>>
>>>>
>>>> On 5/3/2021 7:20 PM, Thinh Nguyen wrote:
>>>>> Hi,
>>>>>
>>>>> Wesley Cheng wrote:
>>>>>> If an error is received when issuing a start or update transfer
>>>>>> command, the error handler will stop all active requests (including
>>>>>> the current USB request), and call dwc3_gadget_giveback() to notify
>>>>>> function drivers of the requests which have been stopped.  Avoid
>>>>>> having to cancel the current request which is trying to be queued, as
>>>>>> the function driver will handle the EP queue error accordingly.
>>>>>> Simply unmap the request as it was done before, and allow previously
>>>>>> started transfers to be cleaned up.
>>>>>>
>>>>
>>>> Hi Thinh,
>>>>
>>>>>
>>>>> It looks like you're still letting dwc3 stopping and cancelling all the
>>>>> active requests instead letting the function driver doing the dequeue.
>>>>>
>>>>
>>>> Yeah, main issue isn't due to the function driver doing dequeue, but
>>>> having cleanup (ie USB request free) if there is an error during
>>>> usb_ep_queue().
>>>>
>>>> The function driver in question at the moment is the f_fs driver in AIO
>>>> mode.  When async IO is enabled in the FFS driver, every time it queues
>>>> a packet, it will allocate a io_data struct beforehand.  If the
>>>> usb_ep_queue() fails it will free this io_data memory.  Problem is that,
>>>> since the DWC3 gadget calls the completion with -ECONNRESET, the FFS
>>>> driver will also schedule a work item (within io_data struct) to handle
>>>> the completion.  So you end up with a flow like below
>>>>
>>>> allocate io_data (ffs)
>>>>  --> usb_ep_queue()
>>>>    --> __dwc3_gadget_kick_transfer()
>>>>    --> dwc3_send_gadget_ep_cmd(EINVAL)
>>>>    --> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>    --> dwc3_gadget_giveback(ECONNRESET)
>>>> ffs completion callback
>>>> queue work item within io_data
>>>>  --> usb_ep_queue returns EINVAL
>>>> ffs frees io_data
>>>> ...
>>>>
>>>> work scheduled
>>>>  --> NULL pointer/memory fault as io_data is freed
>>
>> Hi Thinh,
>>
>>>
>>> sounds like a race issue.
>>>
>>
>> It'll always happen if usb_ep_queue() fails with an error. Sorry for not
>> clarifying, but the "..." represents executing in a different context
>> :). Anything above the "..." is in the same context.
>>>>
>>>>> BTW, what kinds of command and error do you see in your setup and for
>>>>> what type endpoint? I'm thinking of letting the function driver to
>>>>> dequeue the requests instead of letting dwc3 automatically
>>>>> ending/cancelling the queued requests. However, it's a bit tricky to do
>>>>> that if the error is -ETIMEDOUT since we're not sure if the controller
>>>>> had already cached the TRBs.
>>>>>
>>>>
>>>> Happens on bulk EPs so far, but I think it wouldn't matter as long as
>>>> its over the FFS interface. (and using async IO transfers)
>>>
>>> Do you know which command and error code? It's strange if
>>> UPDATE_TRANSFER command failed.
>>>
>>
>> Sorry for missing that part of the question.  It is a no xfer resource
>> error on a start transfer command.  So far this happens on low system
>> memory test cases, so there may be some sequences that were missed,
>> which led to this particular command error.
>>
>> Thanks
>> Wesley Cheng

Hi Thinh,

> 
> No xfer resource usually means that the driver attempted to send
> START_TRANSFER without waiting for END_TRANSFER command to complete.
> This may be a dwc3 driver issue. Did you check this?
> 
> Thanks,
> Thinh
> 
> 

Yes, we know the reason why this happens, and its due to one of the
downstream changes we had that led to the scenario above.  Although,
that has been fixed, I still believe the error path is a potential
scenario we'd still want to address.

I think the returning success always on dwc3_gadget_ep_queue(), and
allowing the error in the completion handler/giveback at the function
driver level to do the cleanup is a feasible solution.  Doesn't change
the flow of the DWC3 gadget, and so far all function drivers we've used
handle this in the correct manner.

Thanks
Wesley Cheng

>>
>>>>
>>>>> This seems to add more complexity and I don't have a good solution to
>>>>> it. Since you're already cancelling all the active request anyway, what
>>>>> do you think of always letting dwc3_gadget_ep_queue() to go through with
>>>>> success, but report failure through request completion?
>>>>>
>>>>
>>>> We do have something similar as well downstream (returning success
>>>> always on dwc3_gadget_ep_queue()) and its been working for us also.
>>>> Problem is we don't test the ISOC path much, so this is the only type of
>>>> EP that might come into question...
>>>>
>>>
>>> It should be similiar with isoc. I can't think of a potential issue yet.
>>>
>>>> Coming up with a way to address the concerns you brought up was a bit
>>>> difficult as there were scenarios we needed to consider.  next_request()
>>>> doesn't always have to be the request being queued (even if ep queue
>>>> triggered it).  There was no easy way to determine if kick transfer was
>>>> due to ep queue, but even if there was, we'd need to remember the
>>>> previous point as well.
>>>>
>>>
>>> Yeah, there are a few pitfalls. I don't have a good solution to it if we
>>> want to return failure immediately and let the function driver handle
>>> the dequeue (if it wants to).
>>>
>>> Thanks,
>>> Thinh
>>>
>>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E983E7E07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhHJRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:12:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25369 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHJRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:12:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628615529; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=plpxrD4kIxF9fIBxxFmf2PnbVDKTvqRX6FCReVS+x4o=; b=jpfSRFlqcLLxmgC6LGBHRpEIFgcZwRTMKgAYWHlnGwFbl4P8vmR31Pa/cNz95HdUc/5ZlIy7
 FSn2tMSUVIdN1RTG9D1xiqAdAx4rK3Fwx7ZeeWSGuKXGd7A4sgdYWaOWpwiX51eBF0TTthGv
 G/cqb4cEsi5qhxgHBtWlw8tub/M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6112b35991487ad520aa04e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 17:11:53
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 268D4C43217; Tue, 10 Aug 2021 17:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.9] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2514BC433F1;
        Tue, 10 Aug 2021 17:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2514BC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
 <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <b025412f-c27a-a59b-cd8f-aec0faa98928@codeaurora.org>
Date:   Tue, 10 Aug 2021 10:11:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 8/9/2021 3:57 PM, Thinh Nguyen wrote:
> John Stultz wrote:
>> On Mon, Aug 9, 2021 at 3:44 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>>>
>>> John Stultz wrote:
>>>> In commit d25d85061bd8 ("usb: dwc3: gadget: Use
>>>> list_replace_init() before traversing lists"), a local list_head
>>>> was introduced to process the started_list items to avoid races.
>>>>
>>>> However, in dwc3_gadget_ep_cleanup_completed_requests() if
>>>> dwc3_gadget_ep_cleanup_completed_request() fails, we break early,
>>>> causing the items on the local list_head to be lost.
>>>>
>>>> This issue showed up as problems on the db845c/RB3 board, where
>>>> adb connetions would fail, showing the device as "offline".
>>>>
>>>> This patch tries to fix the issue by if we are returning early
>>>> we splice in the local list head back into the started_list
>>>> and return (avoiding an infinite loop, as the started_list is
>>>> now non-null).
>>>>
>>>> Not sure if this is fully correct, but seems to work for me so I
>>>> wanted to share for feedback.
>>>>
>>>> Cc: Wesley Cheng <wcheng@codeaurora.org>
>>>> Cc: Felipe Balbi <balbi@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>>> Cc: Jack Pham <jackp@codeaurora.org>
>>>> Cc: Thinh Nguyen <thinh.nguyen@synopsys.com>
>>>> Cc: Todd Kjos <tkjos@google.com>
>>>> Cc: Amit Pundir <amit.pundir@linaro.org>
>>>> Cc: YongQin Liu <yongqin.liu@linaro.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: Petri Gynther <pgynther@google.com>
>>>> Cc: linux-usb@vger.kernel.org
>>>> Fixes: d25d85061bd8 ("usb: dwc3: gadget: Use list_replace_init() before traversing lists")
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>>  drivers/usb/dwc3/gadget.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index b8d4b2d327b23..a73ebe8e75024 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -2990,6 +2990,12 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
>>>>                       break;
>>>>       }
>>>>
>>>> +     if (!list_empty(&local)) {
>>>> +             list_splice_tail(&local, &dep->started_list);
>>>> +             /* Return so we don't hit the restart case and loop forever */
>>>> +             return;
>>>> +     }
>>>> +
>>>>       if (!list_empty(&dep->started_list))
>>>>               goto restart;
>>>>  }
>>>>
>>>
>>> No, we should revert the change for
>>> dwc3_gadget_ep_cleaup_completed_requests(). As I mentioned previously,
>>> we don't cleanup the entire started_list. If the original problem is due
>>> to disconnection in the middle of request completion, then we can just
>>> check for pullup_connected and exit the loop and let the
>>> dwc3_remove_requests() do the cleanup.
>>
>> Ok, sorry, I didn't read your mail in depth until I had this patch
>> sent out. If a revert of d25d85061bd8 is the better fix, I'm fine with
>> that too.
>>
>> thanks
>> -john
>>
> 
> IMO, we should revert this patch for now since it will cause regression.
> We can review and test a proper fix at a later time.
> 
> Thanks,
> Thinh
> 

Another suggestion would just be to replace the loop with a while() loop
and using list_entry() instead.  That was what was discussed in the
earlier patch series which also addresses the problem as well.  Issue
here is the tmp variable still carries a stale request after the dwc3
giveback is called.  We can avoid that by always fetching the
list_entry() instead of relying on list_for_each_safe()

https://lore.kernel.org/linux-usb/1620716636-12422-1-git-send-email-wcheng@codeaurora.org/

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

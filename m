Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACC374799
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhEESAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:00:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46934 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhEESAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:00:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620237553; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+BjkNn+3Ba4ARGu+ji5DOjmbN1E4+hK1wXgxOFBY4Rs=; b=LkjZoY3Fs7F5oYCC6zMi/MGr1gOf9TGHIuGWqgsDiB0O6T4ACMPEMdbDqzJktyUq0C9qzzCX
 cfA2zDKTFd9GoTs0BgFAXUfcfcI1es3YZRl5LCns2vblps8hi4Kron+Nmvf426ItBys9QDSi
 ipKQlT18cM1aqCTxqdbGJ+Zd+BE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6092dceb853c0a2c46b88485 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 17:59:07
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C271BC43146; Wed,  5 May 2021 17:59:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.53.212] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23338C4338A;
        Wed,  5 May 2021 17:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23338C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <49c5e3eb-7c2b-a83b-2406-a620d91b827a@codeaurora.org>
Date:   Wed, 5 May 2021 10:59:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8735v1ibj4.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2021 5:57 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
>> On 5/3/2021 7:20 PM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> Wesley Cheng wrote:
>>>> If an error is received when issuing a start or update transfer
>>>> command, the error handler will stop all active requests (including
>>>> the current USB request), and call dwc3_gadget_giveback() to notify
>>>> function drivers of the requests which have been stopped.  Avoid
>>>> having to cancel the current request which is trying to be queued, as
>>>> the function driver will handle the EP queue error accordingly.
>>>> Simply unmap the request as it was done before, and allow previously
>>>> started transfers to be cleaned up.
>>>>
>>
>> Hi Thinh,
>>
>>>
>>> It looks like you're still letting dwc3 stopping and cancelling all the
>>> active requests instead letting the function driver doing the dequeue.
>>>
>>
>> Yeah, main issue isn't due to the function driver doing dequeue, but
>> having cleanup (ie USB request free) if there is an error during
>> usb_ep_queue().
>>
>> The function driver in question at the moment is the f_fs driver in AIO
>> mode.  When async IO is enabled in the FFS driver, every time it queues
>> a packet, it will allocate a io_data struct beforehand.  If the
>> usb_ep_queue() fails it will free this io_data memory.  Problem is that,
>> since the DWC3 gadget calls the completion with -ECONNRESET, the FFS
>> driver will also schedule a work item (within io_data struct) to handle
>> the completion.  So you end up with a flow like below
>>
>> allocate io_data (ffs)
>>  --> usb_ep_queue()
>>    --> __dwc3_gadget_kick_transfer()
>>    --> dwc3_send_gadget_ep_cmd(EINVAL)
>>    --> dwc3_gadget_ep_cleanup_cancelled_requests()
>>    --> dwc3_gadget_giveback(ECONNRESET)
>> ffs completion callback
>> queue work item within io_data
>>  --> usb_ep_queue returns EINVAL
>> ffs frees io_data
>> ...
>>
>> work scheduled
>>  --> NULL pointer/memory fault as io_data is freed
> 
> I have some vague memory of discussing (something like) this with Alan
> Stern long ago and the conclusion was that the gadget driver should
> handle cases such as this. OTOH, we're returning failure during
> usb_ep_queue() which tells me there's something with dwc3 (perhaps not
> exclusively, but that's yet to be shown).
> 

Hi Felipe,

> If I understood the whole thing correctly, we want everything except the
> current request (the one that failed START or UPDATE transfer) to go
> through giveback(). This really tells me that we're not handling error
> case in kick_transfer and/or prepare_trbs() correctly.
> 

We don't want the request passed in usb_ep_queue() to be calling
giveback() IF DONE IN the usb_ep_queue() context only.

> I also don't want to pass another argument to kick_transfer because it
> should be unnecessary: the current request should *always* be the last
> one in the list. Therefore we should rely on something like
> list_last_entry() followed by list_for_each_entry_safe_reverse() to
> handle this without a special case.
> 
> ret = dwc3_send_gadget_ep_cmd();
> if (ret < 0) {
> 	current = list_last_entry();
> 
> 	unmap(current);
>         for_each_trb_in(current) {
>         	clear_HWO(trb);
>         }
> 
> 	list_for_entry_safe_reverse() {
>         	move_cancelled();
>         }
> }
>
Nice, thanks for the suggestion and info!  Problem we have is that kick
transfer is being used elsewhere, for example, during the TRB complete path:

static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
		const struct dwc3_event_depevt *event, int status)
{
...
	else if (dwc3_gadget_ep_should_continue(dep))
		if (__dwc3_gadget_kick_transfer(dep) == 0)
			no_started_trb = false;

So in these types of calls, we would still want ALL requests to be
cancelled w/ giveback() called, so that the completion() callbacks can
cleanup/free those requests accordingly.

If we went and only unmapped the last entry (and removed it from any
list), then no one would clean it up as it is outside of the
usb_ep_queue() context, and not within any of the DWC3 lists.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665093F251D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhHTDGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:06:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51846 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhHTDGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:06:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629428767; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MjmFggYS7qH9PXrSVYM4MCwUzYBkkJt8nYIWY3Zm7Bw=; b=qcWzzBTxOrLTzlxRyZklnF59TIIrkXTZn97dFAznLBda+sP/urpoJcV/ULnFm91EZnDObN31
 2vQwRRh9rwF1SygxUVcR+V7/sQbhWQYJxsOLXqDp1+0jofyqnsaqM8ilNel2VyQ0sxyeTmr9
 u8z5AxSLEuTJy/gNb2NO4pKz9EI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 611f1c0d1a9008a23e1f73a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 03:05:49
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E975C4360C; Fri, 20 Aug 2021 03:05:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.9] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B708C4338F;
        Fri, 20 Aug 2021 03:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0B708C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
 <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
 <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
 <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
 <00952bdc-acc2-f373-9286-6a8380e0b7d1@synopsys.com>
 <875yw7jkz6.fsf@kernel.org>
 <89b4d57c-f44a-ceff-45f3-a308e1d8d135@synopsys.com>
 <4c5ee1be-5cda-f56b-7f69-73124a16abba@codeaurora.org>
 <278cc2b5-9f0d-840e-372a-7949b79e858d@codeaurora.org>
 <096a03e0-a913-7188-2c2e-d801d9617160@synopsys.com>
 <cdd9d624-00c6-1be3-5aad-e6f923d1e8d8@codeaurora.org>
 <f2cdd897-dc8d-a506-9ce4-6d38ef355420@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <1ca09ee0-d415-bbc5-98bf-458162e471d2@codeaurora.org>
Date:   Thu, 19 Aug 2021 20:05:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2cdd897-dc8d-a506-9ce4-6d38ef355420@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 8/19/2021 6:52 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 8/18/2021 5:40 PM, Thinh Nguyen wrote:
>>> Wesley Cheng wrote:
>>>> Hi Thinh/Felipe,
>>>>
>>>> On 8/16/2021 12:13 PM, Wesley Cheng wrote:
>>>>> Hi Thinh,
>>>>>
>>>>> On 8/15/2021 5:33 PM, Thinh Nguyen wrote:
>>>>>> Felipe Balbi wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>>>>>>>>>>>>>> If this occurs, then the entire pullup disable routine is skipped and
>>>>>>>>>>>>>>>> proper cleanup and halting of the controller does not complete.
>>>>>>>>>>>>>>>> Instead of returning an error (which is ignored from the UDC
>>>>>>>>>>>>>>>> perspective), do what is mentioned in the comments and force the
>>>>>>>>>>>>>>>> transaction to complete and put the ep0state back to the SETUP phase.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>  drivers/usb/dwc3/ep0.c    | 4 ++--
>>>>>>>>>>>>>>>>  drivers/usb/dwc3/gadget.c | 6 +++++-
>>>>>>>>>>>>>>>>  drivers/usb/dwc3/gadget.h | 3 +++
>>>>>>>>>>>>>>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>>>>> index 6587394..abfc42b 100644
>>>>>>>>>>>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>>>>> @@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>>>>>>>>>>>>>>>  	return ret;
>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>>>>>>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>  	struct dwc3_ep		*dep;
>>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>> @@ -1073,7 +1073,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>>>>>>>>>>>>>>>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>>>>>>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>  	struct dwc3_gadget_ep_cmd_params params;
>>>>>>>>>>>>>>>>  	u32			cmd;
>>>>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>>>> index 54c5a08..a0e2e4d 100644
>>>>>>>>>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>>>>> @@ -2437,7 +2437,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>>>>>>>>>>>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>>>>>>>>>>>>>>>  		if (ret == 0) {
>>>>>>>>>>>>>>>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>>>>>>>>>>>>>>>> -			return -ETIMEDOUT;
>>>>>>>>>>>>>>>> +			spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[0]);
>>>>>>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> End transfer command takes time, need to wait for it to complete before
>>>>>>>>>>>>>>> issuing Start transfer again. Also, why restart again when it's about to
>>>>>>>>>>>>>>> be disconnected.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I can try without restarting it again, and see if that works.  Instead
>>>>>>>>>>>>>> of waiting for the command complete event, can we set the ForceRM bit,
>>>>>>>>>>>>>> similar to what we do for dwc3_remove_requests()?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> ForceRM=1 means that the controller will ignore updating the TRBs
>>>>>>>>>>>>> (including not clearing the HWO and remain transfer size). The driver
>>>>>>>>>>>>> still needs to wait for the command to complete before issuing Start
>>>>>>>>>>>>> Transfer command. Otherwise Start Transfer won't go through. If we know
>>>>>>>>>>>>> that we're not going to issue Start Transfer any time soon, then we may
>>>>>>>>>>>>> be able to get away with ignoring End Transfer command completion.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I see.  Currently, in the place that we do use
>>>>>>>>>>>> dwc3_ep0_end_control_data(), its followed by
>>>>>>>>>>>> dwc3_ep0_stall_and_restart() which would execute start transfer.  For
>>>>>>>>>>>
>>>>>>>>>>> That doesn't look right. You can try to see if it can recover from a
>>>>>>>>>>> control write request. Often time we do control read and not write.
>>>>>>>>>>> (i.e. try to End Transfer and immediately Start Transfer on the same
>>>>>>>>>>> direction control endpoint).
>>>>>>>>>>>
>>>>>>>>>> OK, I can try, but just to clarify, I was referring to how it was being
>>>>>>>>>> done in:
>>>>>>>>>>
>>>>>>>>>> static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
>>>>>>>>>> 		const struct dwc3_event_depevt *event)
>>>>>>>>>> {
>>>>>>>>>> ...
>>>>>>>>>> 		if (dwc->ep0_expect_in != event->endpoint_number) {
>>>>>>>>>> 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
>>>>>>>>>>
>>>>>>>>>> 			dev_err(dwc->dev, "unexpected direction for Data Phase\n");
>>>>>>>>>> 			dwc3_ep0_end_control_data(dwc, dep);
>>>>>>>>>> 			dwc3_ep0_stall_and_restart(dwc);
>>>>>>>>>> 			return;
>>>>>>>>>> 		}
>>>>>>>>>>
>>>>>>>>
>>>>>>>> Looking at this snippet again, it looks wrong. For control write
>>>>>>>> unexpected direction, if the driver hasn't setup and started the DATA
>>>>>>>> phase yet, then it's fine, but there is a problem if it did.
>>>>>>>>
>>>>>>>> Since dwc3_ep0_end_control_data() doesn't issue End Transfer command to
>>>>>>>> ep0 due to the resource_index check, it doesn't follow the control
>>>>>>>
>>>>>>> IIRC resource_index is always non-zero, so the command should be
>>>>>>
>>>>>> No, resource_index for ep0out is 0, ep0in is 1. You can check from any
>>>>>> of the driver tracepoint log for the return value of Start Transfer
>>>>>> command for the resource index of ep0. There could be a mixed up with
>>>>>> the undocumented return value of Set Endpoint Transfer Resource command
>>>>>> before when this code was written, don't mix up with that.
>>>>>>
>>>>>>> triggered. If you have access to a Lecroy USB Trainer, could you script
>>>>>>> this very scenario for verification?
>>>>>>
>>>>>> For anyone who wants to work on this, we don't need a LeCroy USB
>>>>>> trainer. If you use xhci host, just modify the xhci-ring.c to queue a
>>>>>> wrong direction DATA phase TRB of a particular control write request
>>>>>> test, and continue with the next control requests.
>>>>>>
>>>>> Let me give this a try since I already have a modified (broken :)) XHCI
>>>>> stack.
>>>>>
>>>>> Thanks
>>>>> Wesley Cheng
>>>>
>>>> Sorry for the late response.  I was trying to get a reliable change to
>>>> get the issue to reproduce.  I think I was able to find a set up which
>>>> will generate the unexpected direction issue.  I'll try my best to
>>>> summarize the traces here:
>>>>
>>>> Set up:
>>>> - Modified XHCI stack to queue an IN TRB for a three stage CONTROL OUT
>>>> transaction (OUT data stage)
>>>> - Device is using RNDIS, as that has interface specific commands (ie
>>>> SEND_ENCAPSUALTED messages)
>>>>
>>>> Kernel Log:
>>>> [ 1255.312870] msm-usb-hsphy 88e3000.hsphy: Avail curr from USB = 900
>>>> [ 1255.315300] dwc3_ep0_xfernotready event status = 1
>>>> [ 1255.315429] dwc3_ep0_xfernotready event status = 2
>>>> [ 1255.316390] android_work: sent uevent USB_STATE=CONFIGURED
>>>> [ 1255.317467] dwc3_ep0_xfernotready event status = 1
>>>> [ 1255.317588] dwc3_ep0_xfernotready event status = 2
>>>> [ 1255.334196] dwc3_ep0_xfernotready event status = 1
>>>> [ 1255.334217] dwc3 a600000.dwc3: unexpected direction for Data Phase
>>>> [ 1255.334311] rndis_msg_parser: unknown RNDIS message 0x0052033A len
>>>> 4456526
>>>> [ 1255.334328] RNDIS command error -524, 0/24
>>>> [ 1255.334369] ------------[ cut here ]------------
>>>> [ 1255.334377] dwc3 a600000.dwc3: No resource for ep0out
>>>> [ 1255.334440] WARNING: CPU: 0 PID: 8364 at
>>>> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x3c4/0x96c
>>>> ...
>>>>  1255.336163] WARNING: CPU: 0 PID: 8364 at drivers/usb/dwc3/ep0.c:281
>>>> dwc3_ep0_out_start+0x108/0x144
>>>>
>>>> So the kernel log does indeed show the concern mentioned by Thinh, where
>>>> after ending the transfer, we do see the dwc3_ep0_out_start() fail due
>>>> to no xfer resource.
>>>>
>>>
>>> No, there's no end transfer command seen, and it's expected from code
>>> review.
>>>
>> Sorry, yes that's correct.
>>>> ftrace:
>>>> <...>-8364    [000] d..1  1255.333988: dwc3_ctrl_req: Get Interface
>>>> Status(Intf = 0, Length = 24)
>>>> <...>-8364    [000] d..1  1255.334115: dwc3_prepare_trb: ep0out: trb
>>>> ffffffc01bffd000 (E1:D0) buf 00000000efb76000 size 24 ctrl 00000455
>>>> (HlCs:Sc:data)
>>>> <...>-8364    [000] d..1  1255.334128: dwc3_prepare_trb: ep0out: trb
>>>> ffffffc01bffd010 (E1:D0) buf 00000000efff9000 size 488 ctrl 00000c53
>>>> (HLcs:SC:data)
>>>> <...>-8364    [000] d..1  1255.334166: dwc3_gadget_ep_cmd: ep0out: cmd
>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>> Successful
>>>> <...>-8364    [000] d..1  1255.334239: dwc3_gadget_ep_cmd: ep0out: cmd
>>>> 'Set Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>> <...>-8364    [000] d..1  1255.334291: dwc3_gadget_giveback: ep0out: req
>>>> ffffff8891724e00 length 0/24 zsI ==> -104
>>>
>>> It detected wrong direction and sets STALL here, but no End Transfer
>>> command.
>>>
>>>> <...>-8364    [000] d..1  1255.334339: dwc3_prepare_trb: ep0out: trb
>>>> ffffffc01bffd010 (E1:D0) buf 00000000efffa000 size 8 ctrl 00000c23
>>>> (HLcs:SC:setup)
>>>
>>> The driver overwrote the active TRB with a new SETUP TRB.
>>>
>>>> <...>-8364    [000] d..1  1255.336099: dwc3_gadget_ep_cmd: ep0out: cmd
>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: No
>>>> Resource
>>>
>>> The dep->flags DWC3_EP_TRANSFER_STARTED got cleared. When it tries to
>>> issue a Start Transfer a SETUP transfer, the command will fail with no
>>> resource because the endpoint never ended properly.
>>>
>>>> <...>-8364    [000] d..1  1255.357594: dwc3_ctrl_req: 00 60 b7 ef 00 00
>>>> 00 00
>>>
>>> Here is iffy because the behavior is undefined. The driver overwrote the
>>> previous TRB. The Start Transfer command didn't go through, so the
>>> controller still has the old TRB setup in its cache. It gets the next
>>> SETUP request completion anyway because the SETUP stage is a short
>>> packet. The driver updated its state that it's expecting the SETUP
>>> stage, and it doesn't check the TRB write back buffer size for more or
>>> less than 8 bytes or whether this is valid data.
>>>
>>> Wesley, is this SETUP packet the correct RNDIS control request?
>>>
>> That doesn't look to be a RNDIS control packet.  I collected a bus
>> analyzer log as well w/ this snippet, and nothing was transmitted from
>> the host side during the data stage.  Subsequent SETUP transactions were
>> standard USB descriptors (GET string descriptors).
> 
> Ok.
> 
>>>> <...>-8364    [000] d..1  1255.357680: dwc3_gadget_ep_cmd: ep0out: cmd
>>>> 'Set Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>
>>> The device Set Stall on an unrecognized request, probably from the
>>> application, which can be normal.
>>>
>>>> <...>-8364    [000] d..1  1255.357696: dwc3_prepare_trb: ep0out: trb
>>>> ffffffc01bffd010 (E1:D0) buf 00000000efffa000 size 8 ctrl 00000c23
>>>> (HLcs:SC:setup)
>>>> <...>-8364    [000] d..1  1255.357722: dwc3_gadget_ep_cmd: ep0out: cmd
>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>> Successful
>>>> <...>-224     [005] d..1  1266.313014: dwc3_gadget_ep_cmd: ep2out: cmd
>>>> 'End Transfer' [40c08] params 00000000 00000000 00000000 --> status:
>>>> Timed Out
>>>>
>>>> Thanks
>>>> Wesley Cheng
>>>>
>>>
>>> Thanks for the test Wesley
>>>
>>> BR,
>>> Thinh
>>>
>>
>> So back to the original issue, which was the SETUP timeout during pullup
>> disable, I went ahead and collected the ftrace w/ a change to just
>> remove the return statement:
>>
>> ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
>> 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>> if (ret == 0) {
>> 	dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>> 	return -ETIMEDOUT;
>> }
>>
>> This would allow the __dwc3_gadget_stop() to disable EP0/1, which would
>> call dwc3_gadget_stop_active_transfer() to send the end xfer command:
>>
>> //Packet which will not queue a data stage (injected failure)
>> <...>-7098    [003] d..1   346.560711: dwc3_ctrl_req: Get String
>> Descriptor(Index = 3, Length = 2)
>>
>> //Prepare IN data stage TRB
>> <...>-7098    [003] d..1   346.560865: dwc3_prepare_trb: ep0in: trb
>> ffffffc011edd000 (E0:D0) buf 00000000effcc000 size 2 ctrl 00000c53
>> (HLcs:SC:data)
>> <...>-7098    [003] d..1   346.560915: dwc3_gadget_ep_cmd: ep0in: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>>
>> //Pullup disable here kicks in - __dwc3_gadget_stop()
>> <...>-224     [006] d..1   348.607367: dwc3_gadget_ep_disable: ep0out:
>> mps 64/512 streams 0 burst 1 ring 0/0 flags E:swbp:>
>> <...>-224     [006] d..1   348.607430: dwc3_gadget_giveback: ep0out: req
>> ffffff884e5f5500 length 0/2 zsI ==> -108
>> <...>-224     [006] d..1   348.607444: dwc3_gadget_ep_disable: ep0in:
>> mps 64/512 streams 0 burst 1 ring 0/0 flags E:swBp:<
>>
>> //End transfer on the pending EP0 in TRB queued previously
>> <...>-224     [006] d..1   348.607484: dwc3_gadget_ep_cmd: ep0in: cmd
>> 'End Transfer' [10c08] params 00000000 00000000 00000000 --> status:
>> Successful
>> <...>-224     [006] dN.1   348.607788: usb_gadget_vbus_draw: speed 3/6
>> state 6 0mA [sg:self-powered:activated:disconnected] --> 0
>> <...>-224     [006] ....   348.616888: usb_gadget_disconnect: speed 3/6
>> state 6 0mA [sg:self-powered:activated:disconnected] --> 0
>>
>> Does this look ok, Thinh?
>>
> 
> It should be fine.
> 
> The way we're handling soft-connect and soft-disconnect in dwc3 is
> different than what the programming guide suggested. We're not doing
> soft-reset on soft-connect. Our HW testing didn't show a problem in
> quick soft-connect/disconnect succession before, but can you test doing
> soft-connect immediately after this scenario?
> 

Thanks Thinh.

I can try.  Currently, the Android USB framework will immediately rebind
to the UDC if I run the below command from the console:
echo "" > /config/usb_gadget/g1/UDC

So that will be a quick pullup disable (due to the command) and then a
subsequent pullup enable from the Android USB framework.  I'll run a
script overnight to keep doing the echo command above.
> Also, maybe we can change dev_err() print to dev_warn() on timeout instead?
> 
Sure, will do.

Thanks
Wesley Cheng
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

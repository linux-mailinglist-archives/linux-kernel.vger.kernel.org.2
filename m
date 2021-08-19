Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACE3F1534
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhHSIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhHSIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86DB61101;
        Thu, 19 Aug 2021 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361797;
        bh=Wq0VmYnpHzvRWZUGmZhLwuFC3EL1FSS6HwLPGRVYwr8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=aY426uCUA2f/iXYASPbA/nZ6q1E4Biq/QHZ+++rwPYOVeIOvQXEGVZ7WCj/vaNcVu
         in4efyX9gx4BDDyc0ybQKb8f9LrMCjAsX1vsZd1xcTrRxxXYkK46/SUTnDdhpz4Sbc
         /fk/1zLSaIvdq6MrvXlztmiMyW+betwR6Zu3fNXoMxBhczNFVDGgv/5KpNkwBA+K/P
         jzBaqbMExtQSOaRbbCBH3OgUcL2EXJTE6mejCkbMsa0a6vSRP5FecgyGT1Uwye2oju
         BoTsi8flY0vkaEOqxwJh2mCyssZEltok4yupNs6o3V+GEXCNkLqE+7NCTI3FJqznsZ
         CStRQhLkyAV3g==
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
User-agent: mu4e 1.6.3; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Date:   Thu, 19 Aug 2021 08:36:46 +0300
In-reply-to: <278cc2b5-9f0d-840e-372a-7949b79e858d@codeaurora.org>
Message-ID: <87eeapg7lq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Wesley Cheng <wcheng@codeaurora.org> writes:
>>>> Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>>>>>>>>>>> If this occurs, then the entire pullup disable routine is skipped and
>>>>>>>>>>>>> proper cleanup and halting of the controller does not complete.
>>>>>>>>>>>>> Instead of returning an error (which is ignored from the UDC
>>>>>>>>>>>>> perspective), do what is mentioned in the comments and force the
>>>>>>>>>>>>> transaction to complete and put the ep0state back to the SETUP phase.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  drivers/usb/dwc3/ep0.c    | 4 ++--
>>>>>>>>>>>>>  drivers/usb/dwc3/gadget.c | 6 +++++-
>>>>>>>>>>>>>  drivers/usb/dwc3/gadget.h | 3 +++
>>>>>>>>>>>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>> index 6587394..abfc42b 100644
>>>>>>>>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>>>>>>>>> @@ -218,7 +218,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>>>>>>>>>>>>  	return ret;
>>>>>>>>>>>>>  }
>>>>>>>>>>>>>  
>>>>>>>>>>>>> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>>>> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>>>>>>>>>>>>  {
>>>>>>>>>>>>>  	struct dwc3_ep		*dep;
>>>>>>>>>>>>>  
>>>>>>>>>>>>> @@ -1073,7 +1073,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>>>>>>>>>>>>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>>>>>>>>>>>>>  }
>>>>>>>>>>>>>  
>>>>>>>>>>>>> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>>>> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>>>>>>>>>>>>  {
>>>>>>>>>>>>>  	struct dwc3_gadget_ep_cmd_params params;
>>>>>>>>>>>>>  	u32			cmd;
>>>>>>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>> index 54c5a08..a0e2e4d 100644
>>>>>>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>>>>>>> @@ -2437,7 +2437,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>>>>>>>>>  				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>>>>>>>>>>>>>  		if (ret == 0) {
>>>>>>>>>>>>>  			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
>>>>>>>>>>>>> -			return -ETIMEDOUT;
>>>>>>>>>>>>> +			spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[0]);
>>>>>>>>>>>>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
>>>>>>>>>>>>
>>>>>>>>>>>> End transfer command takes time, need to wait for it to complete before
>>>>>>>>>>>> issuing Start transfer again. Also, why restart again when it's about to
>>>>>>>>>>>> be disconnected.
>>>>>>>>>>>
>>>>>>>>>>> I can try without restarting it again, and see if that works.  Instead
>>>>>>>>>>> of waiting for the command complete event, can we set the ForceRM bit,
>>>>>>>>>>> similar to what we do for dwc3_remove_requests()?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ForceRM=1 means that the controller will ignore updating the TRBs
>>>>>>>>>> (including not clearing the HWO and remain transfer size). The driver
>>>>>>>>>> still needs to wait for the command to complete before issuing Start
>>>>>>>>>> Transfer command. Otherwise Start Transfer won't go through. If we know
>>>>>>>>>> that we're not going to issue Start Transfer any time soon, then we may
>>>>>>>>>> be able to get away with ignoring End Transfer command completion.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I see.  Currently, in the place that we do use
>>>>>>>>> dwc3_ep0_end_control_data(), its followed by
>>>>>>>>> dwc3_ep0_stall_and_restart() which would execute start transfer.  For
>>>>>>>>
>>>>>>>> That doesn't look right. You can try to see if it can recover from a
>>>>>>>> control write request. Often time we do control read and not write.
>>>>>>>> (i.e. try to End Transfer and immediately Start Transfer on the same
>>>>>>>> direction control endpoint).
>>>>>>>>
>>>>>>> OK, I can try, but just to clarify, I was referring to how it was being
>>>>>>> done in:
>>>>>>>
>>>>>>> static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
>>>>>>> 		const struct dwc3_event_depevt *event)
>>>>>>> {
>>>>>>> ...
>>>>>>> 		if (dwc->ep0_expect_in != event->endpoint_number) {
>>>>>>> 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
>>>>>>>
>>>>>>> 			dev_err(dwc->dev, "unexpected direction for Data Phase\n");
>>>>>>> 			dwc3_ep0_end_control_data(dwc, dep);
>>>>>>> 			dwc3_ep0_stall_and_restart(dwc);
>>>>>>> 			return;
>>>>>>> 		}
>>>>>>>
>>>>>
>>>>> Looking at this snippet again, it looks wrong. For control write
>>>>> unexpected direction, if the driver hasn't setup and started the DATA
>>>>> phase yet, then it's fine, but there is a problem if it did.
>>>>>
>>>>> Since dwc3_ep0_end_control_data() doesn't issue End Transfer command to
>>>>> ep0 due to the resource_index check, it doesn't follow the control
>>>>
>>>> IIRC resource_index is always non-zero, so the command should be
>>>
>>> No, resource_index for ep0out is 0, ep0in is 1. You can check from any
>>> of the driver tracepoint log for the return value of Start Transfer
>>> command for the resource index of ep0. There could be a mixed up with
>>> the undocumented return value of Set Endpoint Transfer Resource command
>>> before when this code was written, don't mix up with that.
>>>
>>>> triggered. If you have access to a Lecroy USB Trainer, could you script
>>>> this very scenario for verification?
>>>
>>> For anyone who wants to work on this, we don't need a LeCroy USB
>>> trainer. If you use xhci host, just modify the xhci-ring.c to queue a
>>> wrong direction DATA phase TRB of a particular control write request
>>> test, and continue with the next control requests.
>>>
>> Let me give this a try since I already have a modified (broken :)) XHCI
>> stack.
>> 
>> Thanks
>> Wesley Cheng
>
> Sorry for the late response.  I was trying to get a reliable change to
> get the issue to reproduce.  I think I was able to find a set up which
> will generate the unexpected direction issue.  I'll try my best to
> summarize the traces here:
>
> Set up:
> - Modified XHCI stack to queue an IN TRB for a three stage CONTROL OUT
> transaction (OUT data stage)
> - Device is using RNDIS, as that has interface specific commands (ie
> SEND_ENCAPSUALTED messages)
>
> Kernel Log:
> [ 1255.312870] msm-usb-hsphy 88e3000.hsphy: Avail curr from USB = 900
> [ 1255.315300] dwc3_ep0_xfernotready event status = 1
> [ 1255.315429] dwc3_ep0_xfernotready event status = 2
> [ 1255.316390] android_work: sent uevent USB_STATE=CONFIGURED
> [ 1255.317467] dwc3_ep0_xfernotready event status = 1
> [ 1255.317588] dwc3_ep0_xfernotready event status = 2
> [ 1255.334196] dwc3_ep0_xfernotready event status = 1
> [ 1255.334217] dwc3 a600000.dwc3: unexpected direction for Data Phase
> [ 1255.334311] rndis_msg_parser: unknown RNDIS message 0x0052033A len
> 4456526
> [ 1255.334328] RNDIS command error -524, 0/24
> [ 1255.334369] ------------[ cut here ]------------
> [ 1255.334377] dwc3 a600000.dwc3: No resource for ep0out
> [ 1255.334440] WARNING: CPU: 0 PID: 8364 at
> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x3c4/0x96c
> ...
>  1255.336163] WARNING: CPU: 0 PID: 8364 at drivers/usb/dwc3/ep0.c:281
> dwc3_ep0_out_start+0x108/0x144
>
> So the kernel log does indeed show the concern mentioned by Thinh, where
> after ending the transfer, we do see the dwc3_ep0_out_start() fail due
> to no xfer resource.

Right, we also don't see an end transfer in the traces that
follow. Thanks for confirming.

-- 
balbi

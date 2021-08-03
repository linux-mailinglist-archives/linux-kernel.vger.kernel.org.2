Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CB3DE7AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhHCH7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234362AbhHCH7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:59:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB6860EC0;
        Tue,  3 Aug 2021 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627977530;
        bh=dHqQvrHfB89vZZ6ULf4Ow80grXVuG6Vtb/OOiiZYaWI=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Dn1UWWTZNkuf6+PFxSMzmgHNrz2jwoSuZMv0L7kD3I4O0a9fr9VDhv83uf1YxvsFf
         w/yiZqSR68toU24IwNvPe1ZgXGPTmqg87bWnddq+iFGoBFRBIeY7C09OOjTpTSHMRL
         0g7XbuVpPS0LWefiIwRY7SxtEj4bctfkNgLR19WLDgpg6ZqtcjpfSP5wGojKOgEloi
         cuzmt6NJVausN3ONBWk//xTYwC7I1VspS+t+HRz4go2ZznExmBdMFeHrEjmjq7jWat
         B5wXKBNFx1k0uEDi5BvLVn+wXdiZdunwx2GU7Kj69egE1txyU5UlB7Kx5cgrpe69/f
         MAHOGUr9ZcbiA==
References: <1627691374-15711-1-git-send-email-wcheng@codeaurora.org>
 <20210802213301.GG25299@jackp-linux.qualcomm.com>
User-agent: mu4e 1.6.1; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid runtime resume if disabling
 pullup
Date:   Tue, 03 Aug 2021 10:58:37 +0300
In-reply-to: <20210802213301.GG25299@jackp-linux.qualcomm.com>
Message-ID: <87tuk7558p.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jack Pham <jackp@codeaurora.org> writes:

> Hi Wesley,
>
> On Fri, Jul 30, 2021 at 05:29:34PM -0700, Wesley Cheng wrote:
>> If the device is already in the runtime suspended state, any call to
>> the pullup routine will issue a runtime resume on the DWC3 core
>> device.  If the USB gadget is disabling the pullup, then avoid having
>> to issue a runtime resume, as DWC3 gadget has already been
>> halted/stopped.
>> 
>> This fixes an issue where the following condition occurs:
>> 
>> usb_gadget_remove_driver()
>> -->usb_gadget_disconnect()
>>  -->dwc3_gadget_pullup(0)
>>   -->pm_runtime_get_sync() -> ret = 0
>>   -->pm_runtime_put() [async]
>> -->usb_gadget_udc_stop()
>>  -->dwc3_gadget_stop()
>>   -->dwc->gadget_driver = NULL
>> ...
>> 
>> dwc3_suspend_common()
>> -->dwc3_gadget_suspend()
>>  -->DWC3 halt/stop routine skipped, driver_data == NULL
>> 
>> This leads to a situation where the DWC3 gadget is not properly
>> stopped, as the runtime resume would have re-enabled EP0 and event
>> interrupts, and since we avoided the DWC3 gadget suspend, these
>> resources were never disabled.
>> 
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index a29a4ca..5d08454 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2435,6 +2435,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  	}
>>  
>>  	/*
>> +	 * Avoid issuing a runtime resume if the device is already in the
>> +	 * suspended state during gadget disconnect.  DWC3 gadget was already
>> +	 * halted/stopped during runtime suspend.
>> +	 */
>> +	if (!is_on) {
>> +		pm_runtime_barrier(dwc->dev);
>> +		if (pm_runtime_suspended(dwc->dev))
>> +			return 0;
>> +	}
>> +
>> +	/*
>>  	 * Check the return value for successful resume, or error.  For a
>>  	 * successful resume, the DWC3 runtime PM resume routine will handle
>>  	 * the run stop sequence, so avoid duplicate operations here.
>
> Should this also go to stable with Fixes: 77adb8bdf422 ("usb: dwc3:
> gadget: Allow runtime suspend if UDC unbinded") ?

sounds like a good idea.

-- 
balbi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E93B4BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 03:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFZBS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 21:18:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36905 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhFZBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 21:18:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624670194; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=usxB2fTMPZ0wlWrn+jFkba6X4DkXnAbk3HG4iu9PnVE=;
 b=li8a1uomeqNnfFSI54Sbjt9KPxd4FRa+i9H0SqR77VF0MBMA5PuT2UU/rhYaaAutFGroYICY
 LC83tgjLiu0motJfni6cupJnVq+acJqp0uRiMUWl8BeRbnv9h99FQuCgaxrNtp2HQXkOuIxG
 J+OpAFv34kwsS7IVXPpEXANOP6w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d67febd2559fe392f59b32 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 26 Jun 2021 01:16:27
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1118C43460; Sat, 26 Jun 2021 01:16:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8D96C433D3;
        Sat, 26 Jun 2021 01:16:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Jun 2021 09:16:25 +0800
From:   linyyuan@codeaurora.org
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: fix race of usb_gadget_driver operation
In-Reply-To: <20210625163707.GC574023@rowland.harvard.edu>
References: <20210625104415.8072-1-linyyuan@codeaurora.org>
 <20210625163707.GC574023@rowland.harvard.edu>
Message-ID: <b24825113327c72c742d55e89ec2726e@codeaurora.org>
X-Sender: linyyuan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-26 00:37, Alan Stern wrote:
> On Fri, Jun 25, 2021 at 06:44:15PM +0800, Linyu Yuan wrote:
>> there is following race condition,
>> 
>>       CPU1                         CPU2
>> dwc3_runtime_suspend()        dwc3_gadget_stop()
>> spin_lock(&dwc->lock)
>> dwc3_gadget_suspend()
>> dwc3_disconnect_gadget()
>> dwc->gadget_driver != NULL
>> spin_unlock(&dwc->lock)
>>                               spin_lock(&dwc->lock)
>>                               dwc->gadget_driver = NULL
>>                               spin_unlock(&dwc->lock)
>> dwc->gadget_driver->disconnect(dwc->gadget);
>> 
>> system will crash when access NULL gadget_driver.
>> 
>> 7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')
>> suggest a common way to avoid such kind of race.
>> 
>> this change implment the callback in dwc3 and
>> change related functions which have callback to UDC core.
>> 
>> Signed-off-by: Linyu Yuan <linyyuan@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/core.h   |  1 +
>>  drivers/usb/dwc3/ep0.c    |  5 +++--
>>  drivers/usb/dwc3/gadget.c | 39 
>> +++++++++++++++++++++++----------------
>>  3 files changed, 27 insertions(+), 18 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index dccdf13b5f9e..5991766239ba 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1279,6 +1279,7 @@ struct dwc3 {
>>  	unsigned		dis_metastability_quirk:1;
>> 
>>  	unsigned		dis_split_quirk:1;
>> +	unsigned		async_callbacks:1;
>> 
>>  	u16			imod_interval;
>>  };
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 3cd294264372..26419077c7c9 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -597,10 +597,11 @@ static int dwc3_ep0_set_address(struct dwc3 
>> *dwc, struct usb_ctrlrequest *ctrl)
>> 
>>  static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct 
>> usb_ctrlrequest *ctrl)
>>  {
>> -	int ret;
>> +	int ret = 0;
>> 
>>  	spin_unlock(&dwc->lock);
>> -	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
>> +	if (dwc->async_callbacks)
>> +		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
>>  	spin_lock(&dwc->lock);
> 
> Here and in the other places, you should test dwc->async_callbacks
> _before_ dropping the spinlock.  Otherwise there is a race (the flag
> could be written at about the same time it is checked).
thanks for your comments,

if you think there is race here, how to make sure gadget_driver pointer 
is safe,
this is closest place where we can confirm it is non-NULL by checking 
async_callbacks ?
> 
> Alan Stern
> 
>>  	return ret;
>>  }
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index af6d7f157989..d868f30007cc 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2585,6 +2585,16 @@ static int dwc3_gadget_vbus_draw(struct 
>> usb_gadget *g, unsigned int mA)
>>  	return ret;
>>  }
>> 
>> +static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool 
>> enable)
>> +{
>> +	struct dwc3		*dwc = gadget_to_dwc(g);
>> +	unsigned long		flags;
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	dwc->async_callbacks = enable;
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +}
>> +
>>  static const struct usb_gadget_ops dwc3_gadget_ops = {
>>  	.get_frame		= dwc3_gadget_get_frame,
>>  	.wakeup			= dwc3_gadget_wakeup,
>> @@ -2596,6 +2606,7 @@ static const struct usb_gadget_ops 
>> dwc3_gadget_ops = {
>>  	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
>>  	.get_config_params	= dwc3_gadget_config_params,
>>  	.vbus_draw		= dwc3_gadget_vbus_draw,
>> +	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
>>  };
>> 
>>  /* 
>> -------------------------------------------------------------------------- 
>> */
>> @@ -3231,29 +3242,26 @@ static void dwc3_endpoint_interrupt(struct 
>> dwc3 *dwc,
>> 
>>  static void dwc3_disconnect_gadget(struct dwc3 *dwc)
>>  {
>> -	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
>> -		spin_unlock(&dwc->lock);
>> +	spin_unlock(&dwc->lock);
>> +	if (dwc->async_callbacks && dwc->gadget_driver->disconnect)
>>  		dwc->gadget_driver->disconnect(dwc->gadget);
>> -		spin_lock(&dwc->lock);
>> -	}
>> +	spin_lock(&dwc->lock);
>>  }
>> 
>>  static void dwc3_suspend_gadget(struct dwc3 *dwc)
>>  {
>> -	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
>> -		spin_unlock(&dwc->lock);
>> +	spin_unlock(&dwc->lock);
>> +	if (dwc->async_callbacks && dwc->gadget_driver->suspend)
>>  		dwc->gadget_driver->suspend(dwc->gadget);
>> -		spin_lock(&dwc->lock);
>> -	}
>> +	spin_lock(&dwc->lock);
>>  }
>> 
>>  static void dwc3_resume_gadget(struct dwc3 *dwc)
>>  {
>> -	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
>> -		spin_unlock(&dwc->lock);
>> +	spin_unlock(&dwc->lock);
>> +	if (dwc->async_callbacks && dwc->gadget_driver->resume)
>>  		dwc->gadget_driver->resume(dwc->gadget);
>> -		spin_lock(&dwc->lock);
>> -	}
>> +	spin_lock(&dwc->lock);
>>  }
>> 
>>  static void dwc3_reset_gadget(struct dwc3 *dwc)
>> @@ -3585,11 +3593,10 @@ static void 
>> dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
>>  	 * implemented.
>>  	 */
>> 
>> -	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
>> -		spin_unlock(&dwc->lock);
>> +	spin_unlock(&dwc->lock);
>> +	if (dwc->async_callbacks && dwc->gadget_driver->resume)
>>  		dwc->gadget_driver->resume(dwc->gadget);
>> -		spin_lock(&dwc->lock);
>> -	}
>> +	spin_lock(&dwc->lock);
>>  }
>> 
>>  static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
>> --
>> 2.25.1
>> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2347F43BEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhJ0BVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:21:05 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22741 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhJ0BVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635297520; x=1666833520;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CiUcwr+Yg1b8BpUQefDDhnEVBo+pE6kk9p9NELtogrY=;
  b=kXb+p3vwHmLdi8NJzF9gBDiBO1qOurV1LJQUKfHOuyHSUoRZXKW9oM/e
   MeOzbsBwlY+ZAw3ib8lvTPziOPZo2q/OO2wR3vxupmBqw25B1HYTHmxX+
   Rn/9qKopKXthRc7A1mHYk+O/FkWq4X6VJ6AORr5Opc5tvwB68rmbRXFBq
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 18:18:39 -0700
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 18:18:39 -0700
Received: from [10.110.50.18] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 26 Oct 2021
 18:18:38 -0700
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Disable eps during
 disconnect
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
References: <20211026004456.23054-1-quic_wcheng@quicinc.com>
 <20211026144140.GA1288435@rowland.harvard.edu>
 <81fc3f6d-f747-736b-32db-aecbca77dd31@quicinc.com>
 <20211026205701.GA1300692@rowland.harvard.edu>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
Message-ID: <5737f9b3-14e0-8a83-f298-f44dcb57455a@quicinc.com>
Date:   Tue, 26 Oct 2021 18:18:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211026205701.GA1300692@rowland.harvard.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 10/26/2021 1:57 PM, Alan Stern wrote:
> On Tue, Oct 26, 2021 at 12:40:04PM -0700, Wesley Cheng wrote:
>> Hi Alan,
>>
>> On 10/26/2021 7:41 AM, Alan Stern wrote:
>>> On Mon, Oct 25, 2021 at 05:44:56PM -0700, Wesley Cheng wrote:
>>>> From: Wesley Cheng <wcheng@codeaurora.org>
>>>>
>>>> When receiving a disconnect event from the UDC, the mass storage
>>>> function driver currently runs the handle_exception() routine
>>>> asynchronously.  For UDCs that support runtime PM, there is a
>>>> possibility the UDC is already suspended by the time the
>>>> do_set_interface() is executed.  This can lead to HW register access
>>>> while the UDC is already suspended.
>>>>
>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>> ---
>>>>  drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
>>>> index 3cabf7692ee1..752439690fda 100644
>>>> --- a/drivers/usb/gadget/function/f_mass_storage.c
>>>> +++ b/drivers/usb/gadget/function/f_mass_storage.c
>>>> @@ -2342,6 +2342,16 @@ static void fsg_disable(struct usb_function *f)
>>>>  {
>>>>  	struct fsg_dev *fsg = fsg_from_func(f);
>>>>  
>>>> +	/* Disable the endpoints */
>>>> +	if (fsg->bulk_in_enabled) {
>>>> +		usb_ep_disable(fsg->bulk_in);
>>>
>>> According to the kerneldoc, this routine must be called in process 
>>> context.
>>>
>>>> +		fsg->bulk_in_enabled = 0;
>>>> +	}
>>>> +	if (fsg->bulk_out_enabled) {
>>>> +		usb_ep_disable(fsg->bulk_out);
>>>> +		fsg->bulk_out_enabled = 0;
>>>> +	}
>>>> +
>>>>  	__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
>>>>  }
>>>
>>> Looks like you'll have to find a different way to avoid the problem.  
>>> For example, if an exception is pending then you might prevent the 
>>> gadget from going into runtime suspend until the exception has been 
>>> handled.
>>>
>> Thanks for the suggestion.  I noticed that a lot of other FDs currently
>> call usb_ep_disable() in the disable/disconnect path as well.  Actually,
>> f_mass_storage seems to be the only one that doesn't do so.  Maybe we
>> should change the kerneldoc :)
> 
> You're right; I don't see any real reason why the usb_ep_{en,dis}able 
> routines can't run in an atomic context.  So if you to make this change 
> to f_mass_storage, you should first submit a patch changing the 
> kerneldoc.
> 
Sure, will do that and include it in the next rev.

Thanks
Wesley Cheng

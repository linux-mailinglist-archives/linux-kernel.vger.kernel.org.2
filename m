Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36530EFA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhBDJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:26:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhBDJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:26:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l7atV-00084c-3Y; Thu, 04 Feb 2021 09:25:45 +0000
Subject: Re: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" ->
 "delegate"
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210203111239.18313-1-colin.king@canonical.com>
 <20210203130440.GV2696@kadam>
 <BYAPR07MB5381361C15E436BE54D25C93DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
 <YBuUnyFPvPNhkXEu@kroah.com>
 <BYAPR07MB5381A2E0731A9B982FD28B51DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <708b783e-8e3b-03ed-7039-3b8208bba747@canonical.com>
Date:   Thu, 4 Feb 2021 09:25:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB5381A2E0731A9B982FD28B51DDB39@BYAPR07MB5381.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 09:25, Pawel Laszczak wrote:
> 
> I've sent the patch that remove this one and others similar printk from driver.

Thanks Pawel.

Colin

> 
>>
>>
>> On Thu, Feb 04, 2021 at 05:07:16AM +0000, Pawel Laszczak wrote:
>>> Hi Dan,
>>>
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> There is a spelling mistake in a literal string. Fix it.
>>>>>
>>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>>> ---
>>>>>  drivers/usb/cdns3/cdnsp-ep0.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
>>>>> index e2b1bcb3f80e..e30931ebc870 100644
>>>>> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>>>>> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>>>>> @@ -45,7 +45,7 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
>>>>>  {
>>>>>  	int ret;
>>>>>
>>>>> -	trace_cdnsp_ep0_request("delagete");
>>>>> +	trace_cdnsp_ep0_request("delegate");
>>>>>
>>>>
>>>> This printk is useless and should just be deleted.  Use ftrace instead.
>>>
>>> Maybe this printk is redundant but it's more comfortable in use.
>>> To debug I can simply enable cdns-dev events (echo cdnsp-dev:* > set_event)
>>> and I will get the full  picture of what the driver is doing.
>>>
>>> Otherwise, I must remember which function I need to add to set_ftrace_filter.
>>> Of course, by default I can simply add all cdnsp* functions (echo cdnsp* > set_ftrace_filter) but it
>>> increases the trace log and makes it a little more difficult to analyze.
>>>
>>> So maybe in some cases we shouldn't complain for such printk ?
>>>
>>> It's my private opinion and not necessarily correct :)
>>
>> Please don't have duplicate tracepoints for something like "this
>> function is now called", it's redundant.
>>
> 
> Thanks,
> Pawel Laszczak
> 


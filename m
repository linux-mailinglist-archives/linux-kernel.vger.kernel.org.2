Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D443D1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhJ0UAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:00:31 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23865 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhJ0UAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635364685; x=1666900685;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=H2NYlCoOt3nBgxdOmGtgfQb5dmruMmm1A94+8kx0Ygw=;
  b=EAmZYfzGvWO/Pi5zINNUcq4M8PmgA/EVyQXsb7W8iFnNZNqR6yQkv+1X
   QJ8kWPzb8tvz21DT3Dp3IrayLBp3Bfa7gmF8EBRMlYNyGc+eTbsb3TjKR
   CUbmjJSnQ56dGJpLCyoVgJA78t15UtSKNTmKqw9bqexp6zPkCzi0Ewzpe
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 12:58:05 -0700
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:58:04 -0700
Received: from [10.110.61.160] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 12:58:03 -0700
Subject: Re: [PATCH v2 1/2] usb: gadget: udc: core: Revise comments for
 usb_ep_disable()
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>
References: <1635303025-772-1-git-send-email-quic_wcheng@quicinc.com>
 <1635303025-772-2-git-send-email-quic_wcheng@quicinc.com>
 <20211027142422.GA1319606@rowland.harvard.edu>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
Message-ID: <2c39336e-289e-b0c7-66a3-7aa844a0b252@quicinc.com>
Date:   Wed, 27 Oct 2021 12:58:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211027142422.GA1319606@rowland.harvard.edu>
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

On 10/27/2021 7:24 AM, Alan Stern wrote:
> On Tue, Oct 26, 2021 at 07:50:24PM -0700, Wesley Cheng wrote:
>> The usb_ep_disable() routine is being widely used directly in the
>> disconnect callback path by function drivers.  Hence, the statement
>> about it being able to only run in process context may not be true.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>  drivers/usb/gadget/udc/core.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index d626511..e1f90d8 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -136,8 +136,6 @@ EXPORT_SYMBOL_GPL(usb_ep_enable);
>>   * gadget drivers must call usb_ep_enable() again before queueing
>>   * requests to the endpoint.
>>   *
>> - * This routine must be called in process context.
>> - *
>>   * returns zero, or a negative error code.
>>   */
>>  int usb_ep_disable(struct usb_ep *ep)
> 
> You should also change the kerneldoc for usb_ep_enable.  Neither routine 
> needs to be called in process context.
> 
> In fact, it might be good to change both comments to:
> 
>  * This routine may be called in an atomic (interrupt) context.
> 
> just to be totally explicit.
> 
Ah, missed the ep enable case as well, thanks for the catch.  Sounds
good, I'll add that statement.

Thanks
Wesley Cheng

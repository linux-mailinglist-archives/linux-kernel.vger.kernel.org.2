Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8D342993
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCTBIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:08:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23040 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:07:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616202468; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2l8Ck/OcKx5qO7gLfc9ccllEr4/gISugeMnGy0cBO8A=; b=h2yfPNMnW1T6Hyvg1HeHvzfeMFP1omKg18GmkTp39fopD3lOtPqSgbAQq5/cqo3dxLFHAVw6
 QWJL/yc7ZTizkjkzN2RWzRsinv9skQuW2xBvzeg46GEKM72CHSaZNF/r7Y6dcZhMn4FFc1Zn
 HaI2SiM4fB3fhla2bI1ssBBLyFQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60554adbe2200c0a0de1c118 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 20 Mar 2021 01:07:39
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BD4CC43463; Sat, 20 Mar 2021 01:07:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.100.126] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6968C433C6;
        Sat, 20 Mar 2021 01:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6968C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
 <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
Date:   Fri, 19 Mar 2021 18:07:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2021 5:40 PM, Thinh Nguyen wrote:
> Hi,
> 
> Wesley Cheng wrote:
>> The current dwc3_gadget_reset_interrupt() will stop any active
>> transfers, but only addresses blocking of EP queuing for while we are
>> coming from a disconnected scenario, i.e. after receiving the disconnect
>> event.  If the host decides to issue a bus reset on the device, the
>> connected parameter will still be set to true, allowing for EP queuing
>> to continue while we are disabling the functions.  To avoid this, set the
>> connected flag to false until the stop active transfers is complete.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/gadget.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 6e14fdc..d5ed0f69 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -3327,6 +3327,15 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  	u32			reg;
>>  
>>  	/*
>> +	 * Ideally, dwc3_reset_gadget() would trigger the function
>> +	 * drivers to stop any active transfers through ep disable.
>> +	 * However, for functions which defer ep disable, such as mass
>> +	 * storage, we will need to rely on the call to stop active
>> +	 * transfers here, and avoid allowing of request queuing.
>> +	 */
>> +	dwc->connected = false;
>> +
>> +	/*
>>  	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
>>  	 * would cause a missing Disconnect Event if there's a
>>  	 * pending Setup Packet in the FIFO.
>>
> 
> This doesn't look right. Did you have rebase issue with your local
> change again?
> 
> BR,
> Thinh
> 
Hi Thinh,

This was rebased on Greg's usb-linus branch, which has commit
f09ddcfcb8c5 ("usb: dwc3: gadget: Prevent EP queuing while stopping
transfers") merged.

commit f09ddcfcb8c5  moved the dwc->connected = true to after we have
finished stop active transfers.  However, this change will also ensure
that the connected flag is set to false to ensure that when we call stop
active transfers, nothing can prepare TRBs.  (previous commit only
addresses the case where we get the reset interrupt when coming from a
disconnected state)

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4950A34DA03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhC2WS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:18:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34119 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhC2WR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:17:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617056278; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tUu2ZQk0gPltxUnwP13tDodfdocjEk967Z7tb4j5tSU=; b=ElBjpE0xkElmd/KfIoN7CNz8Ptr6YpCdffnyX3a4tXmRYUgGP3onMdxlC1LZdqtiaVRqql0f
 ig2oKzhrSsynOZv0Mo13bWcizIJDHvfpgiXK5yYAwocD3hF8ASLVwt4Sd7vC6YZ5vemHfH1x
 AdTjvaUTDhGHn/ShS4wxHM3KMGE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 606252153f4005d07537cd21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Mar 2021 22:17:57
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCF1BC433C6; Mon, 29 Mar 2021 22:17:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.60.140] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3186C433CA;
        Mon, 29 Mar 2021 22:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3186C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following
 programming guide
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <20210108015115.27920-2-john.stultz@linaro.org>
 <eb4b8540-a57c-53cc-a371-cf68178bec15@codeaurora.org>
 <e696b018-b310-5811-5c80-3c50dde297e7@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <b08386c0-503d-a333-46be-9df77122ec4e@codeaurora.org>
Date:   Mon, 29 Mar 2021 15:17:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e696b018-b310-5811-5c80-3c50dde297e7@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2021 3:39 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>>
>> On 1/7/2021 5:51 PM, John Stultz wrote:
>>> In reviewing the previous patch, Thinh Nguyen pointed out that
>>> the DRD mode change sequence should be like the following when
>>> switching from host -> device according to the programming guide
>>> (for all DRD IPs):
>>> 1. Reset controller with GCTL.CoreSoftReset
>>> 2. Set GCTL.PrtCapDir(device)
>>> 3. Soft reset with DCTL.CSftRst
>>> 4. Then follow up with the initializing registers sequence
>>>
>>> The current code does:
>>> a. Soft reset with DCTL.CSftRst on driver probe
>>> b. Reset controller with GCTL.CoreSoftReset (added in previous
>>>    patch)
>>> c. Set GCTL.PrtCapDir(device)
>>> d. < missing DCTL.CSftRst >
>>> e. Then follow up with initializing registers sequence
>>>
>>> So this patch adds the DCTL.CSftRst soft reset that was currently
>>> missing from the dwc3 mode switching.
>>>
>>> Cc: Felipe Balbi <balbi@kernel.org>
>>> Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
>>> Cc: Yang Fei <fei.yang@intel.com>
>>> Cc: YongQin Liu <yongqin.liu@linaro.org>
>>> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>> Cc: Thinh Nguyen <thinhn@synopsys.com>
>>> Cc: Jun Li <lijun.kernel@gmail.com>
>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: linux-usb@vger.kernel.org
>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>> ---
>>> Feedback would be appreciated. I'm a little worried I should be
>>> conditionalizing the DCTL.CSftRst on DRD mode controllers, but
>>> I'm really not sure what the right thing to do is for non-DRD
>>> mode controllers.
>>> ---
>>>  drivers/usb/dwc3/core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index b6a6b90eb2d5..71f8b07ecb99 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -40,6 +40,8 @@
>>>  
>>>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>>>  
>>> +static int dwc3_core_soft_reset(struct dwc3 *dwc);
>>> +
>>>  /**
>>>   * dwc3_get_dr_mode - Validates and sets dr_mode
>>>   * @dwc: pointer to our context structure
>>> @@ -177,6 +179,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>  
>>>  	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
>>>  
>>> +	dwc3_core_soft_reset(dwc);
>> Hi John/Thinh/Felipe,
>>
>> I actually added this change into my local branch, because we were
>> seeing an issue when switching from host mode --> peripheral mode.  What
>> was happening was that the RXFIFO register did not update back to the
>> expected value for peripheral mode by the time
>> dwc3_gadget_init_out_endpoint() was executed.  With the logic to
>> calculate the EP max packet limit based on RXFIFO reg, this caused all
>> EPs to be set with an EP max limit of 0.
>>
>> With this change, it seemed to help with the above issue.  However, can
>> we consider moving the core soft reset outside the spinlock?  At least
>> with our PHY init routines, we have some msleep() calls for waiting for
>> the PHYs to be ready, which will end up as a sleeping while atomic bug.
>> (not sure if PHY init is required to be called in atomic context)
>>
>> Thanks
>> Wesley Cheng
> 
> Hi Wesley,
> 
> Thanks for letting us know the issue you're having also.
> 
> Yes, you need to wait a certain amount of time to synchronize with the
> PHY (at least 50ms for dwc_usb32 and dwc_usb31 v1.80a and above, and
> less for older versions). When removing the spinlock to use msleep(),
> just make sure that there's no race issue. BTW, how long does your setup
> need to msleep()?
> 
Hi Thinh,

Sorry for the late response.  My mistake, its actually just a usleep()
for a less than 100uS (polling for a status bit change, so it will exit
early if possible).  For this change, can we just move the
dwc3_core_soft_reset() outside of the spinlock?

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

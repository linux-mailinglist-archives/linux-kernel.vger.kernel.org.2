Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7532F914
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCFJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:04:27 -0500
Received: from z11.mailgun.us ([104.130.96.11]:29725 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhCFJEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:04:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615021453; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QO3yPqzvtDZ9RjENPYRAVbzJD3mYDqyCSyxNAHWUCHM=; b=WiCNoslBxJqzQ4r53WAAuCSUxSwFolEFQs2F+o2Ft6y/FpWAKOfDSQ2g/d7KoPBxLq6uIl+7
 d5KcJcYrMA5M7+Qq4+lJhaFBO97t6FD2U8RrOWh1sHSlRq9yFf2288KsamLJPgqSA0vrogct
 +xtKkeOpS0ILn+scH1w0cQnSwfs=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 604345862a5e6d1bfa4e796f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Mar 2021 09:04:06
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C577C43466; Sat,  6 Mar 2021 09:04:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.25.174] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D64F6C433C6;
        Sat,  6 Mar 2021 09:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D64F6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <87bldzwr6x.fsf@kernel.org>
 <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
 <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <06a44245-4f2f-69ba-fe46-b88a19f585c2@codeaurora.org>
Date:   Sat, 6 Mar 2021 01:04:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2021 4:44 PM, Thinh Nguyen wrote:
> Hi,
> 
> John Stultz wrote:
>> On Fri, Jan 8, 2021 at 4:26 AM Felipe Balbi <balbi@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> John Stultz <john.stultz@linaro.org> writes:
>>>> From: Yu Chen <chenyu56@huawei.com>
>>>>
>>>> Just resending this, as discussion died out a bit and I'm not
>>>> sure how to make further progress. See here for debug data that
>>>> was requested last time around:
>>>>   https://urldefense.com/v3/__https://lore.kernel.org/lkml/CALAqxLXdnaUfJKx0aN9xWwtfWVjMWigPpy2aqsNj56yvnbU80g@mail.gmail.com/__;!!A4F2R9G_pg!LNzuprAeg-O80SgolYkIkW4-ne-M-yLWCDUY9MygAIrQC398Z6gRJ9wnsnlqd3w$ 
>>>>
>>>> With the current dwc3 code on the HiKey960 we often see the
>>>> COREIDLE flag get stuck off in __dwc3_gadget_start(), which
>>>> seems to prevent the reset irq and causes the USB gadget to
>>>> fail to initialize.
>>>>
>>>> We had seen occasional initialization failures with older
>>>> kernels but with recent 5.x era kernels it seemed to be becoming
>>>> much more common, so I dug back through some older trees and
>>>> realized I dropped this quirk from Yu Chen during upstreaming
>>>> as I couldn't provide a proper rational for it and it didn't
>>>> seem to be necessary. I now realize I was wrong.
>>>>
>>>> After resubmitting the quirk, Thinh Nguyen pointed out that it
>>>> shouldn't be a quirk at all and it is actually mentioned in the
>>>> programming guide that it should be done when switching modes
>>>> in DRD.
>>>>
>>>> So, to avoid these !COREIDLE lockups seen on HiKey960, this
>>>> patch issues GCTL soft reset when switching modes if the
>>>> controller is in DRD mode.
>>>>
>>>> Cc: Felipe Balbi <balbi@kernel.org>
>>>> Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
>>>> Cc: Yang Fei <fei.yang@intel.com>
>>>> Cc: YongQin Liu <yongqin.liu@linaro.org>
>>>> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>>> Cc: Thinh Nguyen <thinhn@synopsys.com>
>>>> Cc: Jun Li <lijun.kernel@gmail.com>
>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-usb@vger.kernel.org
>>>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>> v2:
>>>> * Rework to always call the GCTL soft reset in DRD mode,
>>>>   rather then using a quirk as suggested by Thinh Nguyen
>>>>
>>>> v3:
>>>> * Move GCTL soft reset under the spinlock as suggested by
>>>>   Thinh Nguyen
>>> Because this is such an invasive change, I would prefer that we get
>>> Tested-By tags from a good fraction of the users before applying these
>>> two changes.
>> I'm happy to reach out to folks to try to get that. Though I'm
>> wondering if it would be better to put it behind a dts quirk flag, as
>> originally proposed?
>>    https://urldefense.com/v3/__https://lore.kernel.org/lkml/20201021181803.79650-1-john.stultz@linaro.org/__;!!A4F2R9G_pg!LNzuprAeg-O80SgolYkIkW4-ne-M-yLWCDUY9MygAIrQC398Z6gRJ9wnRWITZfc$ 
>>
>> That way folks can enable it for devices as they need?
>>
>> Again, I'm not trying to force this in as-is, just mostly sending it
>> out again for discussion to understand what other approach might work.
>>
>> thanks
>> -john
> 
> A quirk would imply something is broken/diverged from the design right?
> But it's not the case here, and at least this is needed for HiKey960.
> Also, I think Rob will be ok with not adding 1 more quirk to the dwc3
> devicetree. :)
> 
> BR,
> Thinh
> 

Hi All,

Sorry for jumping in, but I checked the SNPS v1.90a databook, and that
seemed to remove the requirement for the GCTL.softreset before writing
to PRTCAPDIR.  Should we consider adding a controller version/IP check?

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2084B30506C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhA0EIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:08:09 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:47238 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhA0Dfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:35:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611718530; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TlLlxYx/6jyB4V4uLiJQpaxX4prK2yg62U7jBcs9aNI=; b=V8c1dRwtmFoTe0/vxxnRe1sscapOpHY0WtxVwLDyTnigzjOYtbHmzAEbpH/lNgNgMwCBPAf4
 o0WlAee2iwulHWDRBv60HMSbZYZKccCfwwpxCE1xhGxkRYiEEBq5hu/XEtn7NG+Tn5dVciYA
 upDj+5WmRiJN+kEcu36LXiP7PWI=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6010df642c36b2106d4e4dce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 03:35:00
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6D10C43464; Wed, 27 Jan 2021 03:34:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.110.78.65] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A00D7C433CA;
        Wed, 27 Jan 2021 03:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A00D7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
To:     eg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CGME20210122065248epcas2p19a972d3a385b91d6e05a16f2ef7b0dd6@epcas2p1.samsung.com>
 <20210122064125.GA121941@ubuntu> <20210122071540.GB121941@ubuntu>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <c658e20c-299f-c748-ca48-e3351dcfffd2@codeaurora.org>
Date:   Tue, 26 Jan 2021 19:34:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122071540.GB121941@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2021 11:15 PM, Jung Daehwan wrote:
> On Fri, Jan 22, 2021 03:32, Wesley cheng wrote:
>> Hi Daehwan,
>>
>> If this is an unexpected event where userspace initiates the UDC bind
>> sequence, then after the above sequence occurs, the DWC3 device should
>> still be able to re-enter runtime suspend after the autosuspend timer
>> expires.  Since the cable is disconnected, the dwc->connected flag would
>> still be false.  Is this not happening in your situation?
>>
>> I'm just trying to understand what issue you're seeing other than the
>> momentary transition from runtime suspend (due to cable disconnect)
>> -->runtime resume (due to unexpected UDC bind) --> runtime  suspend (due
>> to nothing connected).
>>
>> Thanks
>> Wesley cheng
> 
> Hi Wesley,
> 
> I don't know why but DWC3 device is not re-entering runtime-suspend in
> my situation. I'm still debugging it.
> Even if DWC3 re-enter runtime-suspend but it doesn't mean stopping gadget.
> Are you stopping gadget manually in this case?

Hi Daehwan,

Sorry for the late response.  So during the DWC3 runtime suspend path,
we will execute dwc3_gadget_suspend() which should disable the gadget
events and disable ep0 then clear RS bit.  Then on runtime resume, the
DWC3 will be re-enabled, and the RS bit set again.

Thanks
Wesley Cheng

> 
> Best Regards,
> Jung Daehwan
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

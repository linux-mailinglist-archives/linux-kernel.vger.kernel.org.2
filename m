Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E149940F258
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhIQG3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:29:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64206 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhIQG3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:29:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631860110; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=71x/5CV+GloaODoruzokP4i9Sjebw7Bm1eLwxI/272A=; b=SC63itUGCiN+OY02Lqk9XG0vh9gYb8RIGDn1Y0LzaFro3J5MGE6vt39eD8S4+bh2yOkCY4HT
 3llOV6RZaTGPpt/gph2aYV+QKFft2OVCGGKGvlhlLHSuUs7qi9OktA9ZK3cNV5QcCMzk2prR
 UhChOc5lJzhJGrAENw4vd2XhGGQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6144357ce0f78151d6a4e6b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Sep 2021 06:28:12
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92C21C43460; Fri, 17 Sep 2021 06:28:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.26] (075-140-094-099.biz.spectrum.com [75.140.94.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7A75C4338F;
        Fri, 17 Sep 2021 06:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B7A75C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC
 unbind
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917021852.2037-1-wcheng@codeaurora.org>
 <87y27vai3p.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <474148e5-37e2-ea0c-7d78-9e71155314d9@codeaurora.org>
Date:   Thu, 16 Sep 2021 23:28:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87y27vai3p.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/2021 10:17 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
>> There is a race present where the DWC3 runtime resume runs in parallel
>> to the UDC unbind sequence.  This will eventually lead to a possible
>> scenario where we are enabling the run/stop bit, without a valid
>> composition defined.
>>
>> Thread#1 (handling UDC unbind):
>> usb_gadget_remove_driver()
>> -->usb_gadget_disconnect()
>>   -->dwc3_gadget_pullup(0)
>> --> continue UDC unbind sequence
>> -->Thread#2 is running in parallel here
>>
>> Thread#2 (handing next cable connect)
>> __dwc3_set_mode()
>>   -->pm_runtime_get_sync()
>>     -->dwc3_gadget_resume()
>>       -->dwc->gadget_driver is NOT NULL yet
>>       -->dwc3_gadget_run_stop(1)
>>       --> _dwc3gadget_start()
>> ...
>>
>> Fix this by tracking the pullup disable routine, and avoiding resuming
>> of the DWC3 gadget.  Once the UDC is re-binded, that will trigger the
>> pullup enable routine, which would handle enabling the DWC3 gadget.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Thanks, Felipe!

> 
> This looks okay to me, but needs to be tested by a few folks ;-)
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>
> 
Yes, would be good to get some functions using
usb_gadget_activate/deactivate().  It should be OK for those situations
as well, but just to make sure :)

Thanks
Wesley Cheng
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D93376991
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhEGRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:40:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46749 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhEGRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:40:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620409153; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=clkC5swQRcI9z/5st3tJgs7VjrvjMlMixVkfgmUs6Q0=; b=vJGNaSMe9OL2utaxyclA11XxLuBDNFQUwog1gT6s/7pABjYV5uQnAmqzLDjb/wyovAvNKh2v
 07xlN5b4bYBvHdYTMpjyqgxhfJCz/5g5lM959EISzX2zclGXidjeylUdMxplqJkHBJ/DcTQK
 UkRsBTCF+NKMIPrF46li2apZeAY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60957b35febcffa80f4e3af3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 07 May 2021 17:39:01
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 171A0C43143; Fri,  7 May 2021 17:39:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.11.176] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1131C4338A;
        Fri,  7 May 2021 17:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1131C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Return success always for kick
 transfer in ep queue
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, jackp@codeaurora.org
References: <1620369287-27492-1-git-send-email-wcheng@codeaurora.org>
 <87bl9mhgee.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <bb9d37e3-dce4-7b71-4dcd-97e2916be7de@codeaurora.org>
Date:   Fri, 7 May 2021 10:38:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87bl9mhgee.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2021 5:34 AM, Felipe Balbi wrote:
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
>> If an error is received when issuing a start or update transfer
>> command, the error handler will stop all active requests (including
>> the current USB request), and call dwc3_gadget_giveback() to notify
>> function drivers of the requests which have been stopped.  Avoid
>> returning an error for kick transfer during EP queue, to remove
>> duplicate cleanup operations on the request being queued.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Hi Felipe,
> 
> do you want to add a Fixes here? :-)
> 
Sure, will do!

> We should probably Cc stable too.
> 
Got it.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

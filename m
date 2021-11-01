Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA5441742
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhKAJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:34:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16206 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhKAJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:31:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635758919; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+cvx76a5ZISfyv1meP9/ctorZvn8Hza4TCWz08IrKTA=; b=NXodEZcVApEQzqhfDbq93lovvy7s8pGq4tZNylIZRTNfpCG81azbvMTZsJXJ2usk3qTf6Gpb
 p+kLdMijzY7DXl6UaJ1gIoJ8V1YQ6kP0dOSXQlyxKt9udsvL0+YqCSBX+4Ccb4KyDfUDjz+F
 m58jbmk4dILvUavuSBq4dydGVA8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 617fb342545d7d365f0c8280 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 09:28:34
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FED2C43635; Mon,  1 Nov 2021 09:28:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.231.195.33] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9988BC4361A;
        Mon,  1 Nov 2021 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9988BC4361A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v1] serdev: Add interface serdev_device_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <1635753048-5289-1-git-send-email-zijuhu@codeaurora.org>
 <YX+eRgCrUs2Y5iaX@kroah.com>
 <fe5a8bec-b186-c719-5f02-a0a67eb8862f@codeaurora.org>
 <YX+mDGr8tDzVT4Hr@kroah.com>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <573d3640-2e8b-9266-4205-755ac0951abd@codeaurora.org>
Date:   Mon, 1 Nov 2021 17:28:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YX+mDGr8tDzVT4Hr@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2021 4:32 PM, Greg KH wrote:
> On Mon, Nov 01, 2021 at 04:29:10PM +0800, Zijun Hu wrote:
>>
>>
>> On 11/1/2021 3:59 PM, Greg KH wrote:
>>> On Mon, Nov 01, 2021 at 03:50:48PM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> For serdev_device which is mounted at virtual tty port, tty ioctl()
>>>> maybe be used to make serdev_device ready to talk with tty port, so
>>>> add interface serdev_device_ioctl().
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/tty/serdev/core.c           | 11 +++++++++++
>>>>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
>>>>  include/linux/serdev.h              |  9 +++++++++
>>>>  3 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>>>> index f1324fe99378..c0f6cd64716b 100644
>>>> --- a/drivers/tty/serdev/core.c
>>>> +++ b/drivers/tty/serdev/core.c
>>>> @@ -405,6 +405,17 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>>>>  
>>>> +int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
>>>> +{
>>>> +	struct serdev_controller *ctrl = serdev->ctrl;
>>>> +
>>>> +	if (!ctrl || !ctrl->ops->ioctl)
>>>> +		return -EOPNOTSUPP;
>>>
>>> Wrong error for returning that an ioctl is not handled :(
>> checkpatch.pl always reports below WARNING when i use ENOTSUPP as present interfaces
>> do. so i change error code to EOPNOTSUPP.
>>
>> #28: FILE: drivers/tty/serdev/core.c:412:
>> +               return -ENOTSUPP;
>>
>> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> Both of them are not the correct error to return when an ioctl is not
> supported.
> 
is ENODEV okay?
>>> Anyway, what in-tree driver needs this functionality?  Why does serdev
>>> need any ioctl commands?
>>>
>> i am developing driver for a special bluetooth controller which is integrated within SOC,
>> and it does not connect with the BT HOST with UART as normal controller do, but it has very
>> similar features as the BT controller with UART I/F. it is mounted on a virtual serial port
>> driven by a tty driver developed. but it need to call tty ioctl to make the 
>> special BT controller ready to talk with tty port. so i add this interface.
> 
> Please submit this change when you submit your driver that uses it at
> the same time so we can review them all at once.  We do not add apis
> that are not used in the kernel tree.
> 
okay
>> as you known, the main purpose of ioctl is to achieve MISC and irregular control. so it is useful
>> for these irregular devices.
> 
> For tty devices, "custom" ioctls are not ok, use the standard tty
> commands and you should be fine for everything you need to do.
> 
> If not, then perhaps your design is incorrect?
> 
i just want to refer bt_ioctl within https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/tree/drivers/soc/qcom/bt_tty.c?h=NHSS.QSDK.11.5.0.5.r2
by serdev. so add this interface.
are there any other good solution to advise?
thanks 
> thanks,
> 
> greg k-h
> 

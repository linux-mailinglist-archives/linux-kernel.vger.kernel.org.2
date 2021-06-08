Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF97E39F60F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFHMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:11:25 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36568 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhFHMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:11:23 -0400
Received: by mail-wm1-f43.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so1292239wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DbVC8wJA9F4nF7dQEdTB61GzcQ3IOcOmMh55KiS4SzM=;
        b=PA1QPgaHAJ0VQyDLb/FrPX2KdvLXPGSl5uM0PEB8h2jNjjwhDZM9599GvrKipFWL6N
         Ou/rc6S+j/5sIyJ2TJjkmEIXqTlJvRjhUpFDLgGc2puSrIM7T8b0S4ufACfwzU0w9SD7
         8O3KIuS+G07A0Gmjd4mAe6KBidcdQcneCLKvGS9cY3nYHD6Y/SAkxvAZ+POVg4EveYkr
         q37OnNOVhjn2pLtAM6kzCoA2hQATjs6CiGceDm83dMiyS67ATyuonAaJj6bMDfzbIwz8
         7MqI1EqkW0jbvIKwci8k0ftFkiVt2dkVasgCZGr3ZGaNAPFbcAewkt1aCSAfkSgmQDAl
         qiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DbVC8wJA9F4nF7dQEdTB61GzcQ3IOcOmMh55KiS4SzM=;
        b=AzMyPZ5Mt6fZPS9cTIWnvGqxOzIa1npQzoULE+p34n0097EUKJALp/Vgisly0ViNLQ
         0/kl+lLp49I+a4qYY+pbgwVduN2n/xhhaMu4GzV0yFv2tGd0h/DPmr7M39/+1E62lwUl
         h6wDFdjHfsyfy0iJfrtfz1X9p8WGjLAfnpzm8f9nkCztKBu2zqx6TjNQXg0ubg89PJt/
         T0SyZ6wx9mDv7t25d0IVsUUqva/9on6KfJHS3LuX6FDkKi979Tt7TZ66IeL6qo7ikXP5
         EFLML8INYrkQuiRHFDRki/lOUawKYv7YmsGqTK8KD/NGJN/smAIGwidEFB0A7FEBrIwC
         Q5fQ==
X-Gm-Message-State: AOAM5325hzzTOMJe3vSv71vDlnmeRiDoNpECkHMjg5NVoanvB1RdCjec
        uMXcZO6akwykK4s34CxSVQOUChCEbbxZcvfe
X-Google-Smtp-Source: ABdhPJyDTOg+FvhgA+m0IpvBbmyX606kD79oGBeXw/FJohgM0gODYpRMNjJ+OYJWuRApaeAl+UJxvQ==
X-Received: by 2002:a7b:cc87:: with SMTP id p7mr3975819wma.85.1623154109398;
        Tue, 08 Jun 2021 05:08:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f4ed:83e3:926a:9eb7? ([2a01:e34:ed2f:f020:f4ed:83e3:926a:9eb7])
        by smtp.googlemail.com with ESMTPSA id p5sm20518776wrd.25.2021.06.08.05.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 05:08:28 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBjbG9ja3NvdXJjZS9kcml2ZXJzL3Nw?=
 =?UTF-8?Q?rd=3a_Remove_the_dependency_between_sprd_timer_and_SPRD_arch?=
To:     =?UTF-8?B?5p+P5bm056aPIChOaWFuZnUgQmFpKQ==?= 
        <nianfu.bai@unisoc.com>, Nianfu Bai <bnf20061983@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg55Ge5bOwIChSdWlmZW5nIFpoYW5nLzEwMDQwKQ==?= 
        <Ruifeng.Zhang1@unisoc.com>
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
 <aac6c6a3-6666-075a-6901-7e3c3b2ae01d@linaro.org>
 <1623120924545.61863@unisoc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cde99078-c13d-4454-cdcb-990239571ecc@linaro.org>
Date:   Tue, 8 Jun 2021 14:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623120924545.61863@unisoc.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nianfu,

On 08/06/2021 04:55, 柏年福 (Nianfu Bai) wrote:
> On 11/05/2021 09:08, Nianfu Bai wrote:
>> From: Nianfu Bai <nianfu.bai@unisoc.com>
>>
>> Tick broadcast installed by insmod cannot switch to oneshot mode correctly
>> caused by linux timer framework, need to build in kernel image.
> 
> What timer is compiled as a module?
>> We want to compile sprd timer  as a module.
> 
> Why the timer framework does not allow to switch to it ?
>> Pls refer to the patch description deblow:
> https://lore.kernel.org/lkml/161860007587.29796.7100262021118685563.tip-bot2@tip-bot2/

Thanks for the pointer I understand the bug.

However the description does not refer to this fix. It tells the timer
is a module and then tells it depends on the sprd arch.

What are the connection between all these points?

On the other side, the email format is not text, replies are not
correctly put inline, it is hard to follow the discussion.

Please, take the time to read the documentation about submitting patches
[1] and then provide a clear Changelog, no need to refer the timer is
loaded after because it is a module, the Kconfig says the opposite.

Thanks

  -- Daniel

[1] Documentation/process/*

>> SPRD_TIMER
>> has been selected by SPRD arch, we have to enable SPRD arch when we build
>> sprd timer in kernel image, this action conflicts with general kernel image,
> 
> Why this is conflicting with general kernel image?
> 
>> so we need to remove the dependency between sprd timer and SPRD arch.
> 
> Can you rephrase the changelog, I'm not getting the point.
> 
>> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
>> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>> ---
>>  drivers/clocksource/Kconfig | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 39aa21d..04b333c 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -447,10 +447,8 @@ config MTK_TIMER
>>         Support for Mediatek timer driver.
>>
>>  config SPRD_TIMER
>> -     bool "Spreadtrum timer driver" if EXPERT
>> +     bool "Spreadtrum timer driver" if COMPILE_TEST
>>       depends on HAS_IOMEM
>> -     depends on (ARCH_SPRD || COMPILE_TEST)
>> -     default ARCH_SPRD
>>       select TIMER_OF
>>       help
>>         Enables support for the Spreadtrum timer driver.
>>
> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> ________________________________
>  This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
> 本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

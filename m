Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F284571E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhKSPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKSPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:46:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:43:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b12so18849102wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=v28mrZiOo2cDSGsmKOr5GmpF/KtBBSnfGE+N97wF9R4=;
        b=LOhN168FCrDI8Fo5TQTRTcTWxJGMabVkI/pVsc6/uYki1DTyEF7Ks8YK+yoEuQxN74
         b+Ty49mEjIDKg6dPFtKRPUYH3m4g0giC/RSQnsLQ6ijTQo5nlLwQ4Xqcx6FwSR6FSM9h
         UuI3mSkKk3soU4E0WPBP8Z9/ez0gzaIAyOsxFhohaZEdH2sFIffm0roduS5RmAzrtefn
         afoFZvcoAEbtZU7Luy0A72AhvuE+sXjBRXTMZ1mKqtEdQg++K6yZJsM8iyvb1eh+8mHg
         XJU8H+/LldZxE1JJbtpogePz+2t9d0BZw0ThhUuZ4OXf8UqfisYu0xes2NTvzlPd4lvn
         aUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=v28mrZiOo2cDSGsmKOr5GmpF/KtBBSnfGE+N97wF9R4=;
        b=l7Mw6roansO+IZymp5/hvRpJjm1nGcJyA2Y+z1KHjVzvCVXfBrcBGcI+HEyTegax1Z
         C3YoK/dpIWN345uOpi791d0Hrs6FkcKFsEhyAxHZCBFTSyBgpt58aJgo8bGCNohjjdGV
         FWO9zP/g2oR/XccTJBnf+tq3ew9TSgrYCo0MnG/VS4NZUDuwMQ7Ot8bH/sYzDCNW9wPB
         i9lF2PaBmOSPGn1W5j2SYpn6tTB8NzQmxUJoA54mFs6Guj8bZ6n5KhXUlCGPIAc9BPbN
         KDbgVuJR6uRP6UwhU0NmsFznLJT/1H2a3bzUUMOCmPlrMICCXta0ZpLHuFADfEaBQnx4
         Dr+g==
X-Gm-Message-State: AOAM531eGupL+a8U9K1Hneh1SWfYGZelJhwu4OpJOTSMptPaUHw2GKiB
        zASi925iUlYQZEDqSOP+HK1GliWRth59cQ==
X-Google-Smtp-Source: ABdhPJwzZMH8k4e8zn/vTqDS4GK3uH+6jQQmxU5TgAsdTDRz5FnN92ZzEB9I2U/uHCz+EP09Aj9/iA==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr8406361wrg.433.1637336585573;
        Fri, 19 Nov 2021 07:43:05 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id y6sm117941wrh.18.2021.11.19.07.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:43:05 -0800 (PST)
Message-ID: <4a39bc52-53ff-ca79-8d34-4310b2894f43@gmail.com>
Date:   Fri, 19 Nov 2021 16:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Content-Language: en-US
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <YZfEHZa3f5MXeqoH@smile.fi.intel.com>
 <f1a90f53-060e-2960-3926-e30b44a1be28@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <f1a90f53-060e-2960-3926-e30b44a1be28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed CC]

On 11/19/21 16:38, Alejandro Colomar (man-pages) wrote:
> On 11/19/21 16:34, Andy Shevchenko wrote:
>> On Fri, Nov 19, 2021 at 04:06:27PM +0100, Alejandro Colomar (man-pages) wrote:
>>> Yes, I would like to untangle the dependencies.
>>>
>>> The main reason I started doing this splitting
>>> is because I wouldn't be able to include
>>> <linux/stddef.h> in some headers,
>>> because it pulled too much stuff that broke unrelated things.
>>>
>>> So that's why I started from there.
>>>
>>> I for example would like to get NULL in memberof()
>>> without puling anything else,
>>> so <linux/NULL.h> makes sense for that.
>>
>> I don't believe that the code that uses NULL won't include types.h.
> 
> I'm not sure about the error I got (I didn't write it down),
> but I got a compilation error.
> That's why I split NULL.

Now that I think about it twice,
since I'm rewriting these changes from scratch,
I think the error might have been
not due to pulling too much stuff,
but due to circular dependencies.

Having more granularity
helps precisely define the dependencies.

I think the problem was in
<linux/memberof.h> requiring NULL from <linux/stddef.h>
<linux/stddef.h> requiring memberof() from <linux/memberof.h>
or something like that.


Regards,
Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

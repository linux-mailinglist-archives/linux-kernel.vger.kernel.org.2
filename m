Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5E37A26E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhEKIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:47:13 -0400
Received: from smtpcmd04132.aruba.it ([62.149.158.132]:60676 "EHLO
        smtpcmd04132.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:47:11 -0400
Received: from [192.168.1.128] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id gO1ilD32p8ee9gO1ilkC9D; Tue, 11 May 2021 10:46:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1620722763; bh=VrcFfeCqXiyL7uHhi7RWskqk8AeHeKM0dqu0fazsd3I=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=W7+msTdKCHphaGm/wEO+b0QbBe9xj/LjfLPIXoDAULT1ov7p4I42jNEAsK1TS7ANH
         0PqWKulJOHqGCkdZ37FFcnZYipO7rRmwRN7zCg3S5NU5jWSWiDUL/uaJYDN44sPvUz
         m//dN7YSTD/2x3piP7bwtlFnW+2hzikPCODE6fhc3mJUl1ugL/ymrmbSQK0e/e2S2Z
         t3mpUABOZr6XoAI/Qpv1iHYaXMvwM//mlVy5WRIUhQVA4RbRcGZI9bik1sEGH55IkV
         c1BrLM6bKen/IuO1b2ZpmJedtanhNPhWINiQ2JmNF9ctbwxutMz2eh7dbz91Pky+bx
         Btfy/tdKKRCBQ==
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
 <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
 <YJovqMqJj3mBeRE8@smile.fi.intel.com>
 <55aeec09-63c7-7d1a-13c9-cd8f4b7dc1f9@enneenne.com>
 <YJo3LoDSqr18YiNh@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <04e6d0e4-4ef1-b27b-0b10-7e57280d5c9f@enneenne.com>
Date:   Tue, 11 May 2021 10:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJo3LoDSqr18YiNh@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKUVCFIGy1WBpDb339Mjdgk+I7Lu/gLyP5gDugHEdjzs4X/2u8t65frrAKXnvVVACIlibyOtVqwzLgtQWytjToy6EPxWHf7gT/SMxE8sFTpU6OFoK/nd
 EAuGmf1vQAnrf/7OgNIgeIRbJK6nfFkllQ3vHbi/9ihkFLFdObdhLeVAF20hqB9JNjE3qXuM+7yRlFbzThKcmaVHeYmMFssrDMonMAcgWQIgjMLo5mE2OfeF
 uDpilNFTDL5b3ms0Qa1r/BZRzKs5+U3keOdpENmJCvUyzqu0Mwz5KRto8TgHdu5qdJerwp9VMCzTX1MqPZVq2w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/21 09:50, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 09:26:36AM +0200, Rodolfo Giometti wrote:
>> On 11/05/21 09:18, Andy Shevchenko wrote:
>>> On Tue, May 11, 2021 at 09:05:00AM +0200, Rodolfo Giometti wrote:
>>>> On 10/05/21 16:13, Andy Shevchenko wrote:
>>>>> Switch to use module_parport_driver() to reduce boilerplate code.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> ---
>>>>>  drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
>>>>>  1 file changed, 8 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
>>>>> index 7a41fb7b0dec..42f93d4c6ee3 100644
>>>>> --- a/drivers/pps/clients/pps_parport.c
>>>>> +++ b/drivers/pps/clients/pps_parport.c
>>>>> @@ -22,8 +22,6 @@
>>>>>  #include <linux/parport.h>
>>>>>  #include <linux/pps_kernel.h>
>>>>>  
>>>>> -#define DRVDESC "parallel port PPS client"
>>>>> -
>>>>>  /* module parameters */
>>>>>  
>>>>>  #define CLEAR_WAIT_MAX		100
>>>>> @@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
>>>>>  		.dev		= NULL
>>>>>  	};
>>>>>  
>>>>> +	if (clear_wait > CLEAR_WAIT_MAX) {
>>>>> +		pr_err("clear_wait value should be not greater then %d\n",
>>>>> +		       CLEAR_WAIT_MAX);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>
>>>> Why do you need to do so? Maybe a comment would be welcomed.
>>>
>>> It's in original code, I just moved it to ->probe().
>>>
>>> What comment do you want to have here, because original code has no comment (I
>>> think in any case it's out of scope of this change, but may be prepended or
>>> appended to the series)?
>>
>> Mmm... these functions can be called at different times, so I don't know if we
>> can just move the code safely.
> 
> I do not see any issue here. TL;DR: it won't be worse, but might even give an
> improvement.
> 
> Before it prevented to module to be initialized,
> now one may amend this at run time. the downside is that now it will require
> module removal and inserting versus just two attempts of inserting in a row.
> 
> For the built-in case it shouldn't change much (but if
> /sys/module/.../parameters/... is writable for this, then it will allow to do
> the similar trick as above, so extending functionality with the flexibility,
> means direct improvement).
> 
> Okay, permissions are 0 there, I don't remember what it means, maybe the
> parameter won't be available under /sysfs at all, but again, it won't change
> the functional behaviour, the downside is the memory consumed by the 'built-in'
> code at run time.

OK, I see. If so it's OK for me:

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

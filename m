Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9529F398D46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFBOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFBOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:40:48 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:38:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a6so2835986ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wa/wty1AqVchNLec2lyVeo7rH67/UrtzC+3fwYGm3+k=;
        b=W9DsqSl18rPIG3MTwutPjA67ZKIVWYxaHbnbhi3zlWGx8ORcZBDBjH4RXq/ASqmkcp
         bU5Nl+Wv3p/vRjhh7yXKi5sn9cgIPHH3YAXyauguMZrI1ny7mSE/4dFyKPPOvKuoqiul
         zO3M1kEgUIHkN/GwotsQskj/ofeyQa8ndp0Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wa/wty1AqVchNLec2lyVeo7rH67/UrtzC+3fwYGm3+k=;
        b=AzE4vAY4uuTf1CfjUzT5IQ5GMbvv/GyQ82f6YCFMkuQ0Mi9uyDfKtH8GszuVlPhZDj
         9UzCAMPDfhO9w+2xQKR4lksgyQwsMpn5nubltRbzlQ7GAd+wXwrbX3iMUfJAayiDiIQ4
         1jAOSXwhuZtOAxFqwAlh/gyGAco4ls7shuDySnHsT1JjEJXHuSZGuEgVZCQqQkq7Nquh
         YYRGVhpn76FhbAdZDit1HGfci3ZVfGLcU+SMUj+lqMEQuEgQIokHljWuTf4IqVNLHopw
         MZAk0vwdflBb1LRyirnMTK4mcnjVtfVy6PR71o8ZObLpEOC5ByOy49M8z+CJqW1rREfa
         QJvA==
X-Gm-Message-State: AOAM532wMTNBBr3ir3KjGfJT76Alfc4W5RvDuwC5UgLn0mYE2f0oNM8V
        g4FSkWkECIMhY5g9r6RGF3OLBWyTqc5ecw==
X-Google-Smtp-Source: ABdhPJzSNXy7b5DGkDCPiHfC7JqwcrGXcCTmeLd4RHyEUn6x1JdXI7FWvRd0pmhb61A+xjo6zk1Ifw==
X-Received: by 2002:a05:6638:2643:: with SMTP id n3mr30375514jat.104.1622644727758;
        Wed, 02 Jun 2021 07:38:47 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k9sm89434ioa.13.2021.06.02.07.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 07:38:47 -0700 (PDT)
Subject: Re: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
To:     Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
 <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <dabb158b-8c7f-152e-f9a8-3c6e482af751@ieee.org>
Date:   Wed, 2 Jun 2021 09:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 9:27 AM, Manikishan Ghantasala wrote:
> Sending this mail again as I missed to reply to all.
>   Hi Alex,
> 
> I agree those are called bit-field member names rather than labels.
> But the reason I mentioned is because the ./scripts/checkpatch.pl
> gave out a warning saying "labels should not be indented".
> 
> Sorry for the confusion in the name I referred to. So, I think this
> change is needed as I feel this is not following the coding-style by
> having indent before the width for bit field member. I went through
> other places in source code to make sure this is correct, and sent the
> patch after confirmation.

I agree that many instances in the kernel source place the width
of a C bit-field immediately after the colon.  But it is not a
universal convention, and I personally prefer the aligned widths
used by the Greybus code here.

So I don't find this patch acceptable.

					-Alex

> Regards,
> Manikishan Ghantasala
> 
> On Wed, 2 Jun 2021 at 19:13, Alex Elder <elder@ieee.org> wrote:
>>
>> On 6/2/21 8:36 AM, sh4nnu wrote:
>>> From: Manikishan Ghantasala <manikishanghantasala@gmail.com>
>>>
>>> staging: greybus: gpio.c: Clear coding-style problem
>>> "labels should not be indented" by removing indentation.
>>
>> These are not labels.
>>
>> I don't really understand what you're doing here.
>>
>> Can you please explain why you think this needs changing?
>>
>>                                          -Alex
>>
>>> Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
>>> ---
>>>    drivers/staging/greybus/gpio.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
>>> index 7e6347fe93f9..4661f4a251bd 100644
>>> --- a/drivers/staging/greybus/gpio.c
>>> +++ b/drivers/staging/greybus/gpio.c
>>> @@ -20,9 +20,9 @@
>>>    struct gb_gpio_line {
>>>        /* The following has to be an array of line_max entries */
>>>        /* --> make them just a flags field */
>>> -     u8                      active:    1,
>>> -                             direction: 1,   /* 0 = output, 1 = input */
>>> -                             value:     1;   /* 0 = low, 1 = high */
>>> +     u8                      active:1,
>>> +                             direction:1,    /* 0 = output, 1 = input */
>>> +                             value:1;        /* 0 = low, 1 = high */
>>>        u16                     debounce_usec;
>>>
>>>        u8                      irq_type;
>>>
>>


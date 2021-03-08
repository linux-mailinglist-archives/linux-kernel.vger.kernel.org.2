Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94B43310A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCHOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCHOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:19:40 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39565C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:19:40 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i18so8914410ilq.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E7V6nX6QNu39reXsVUNZH8XsbZ4HLycXsme3SEqI7dk=;
        b=peDf1NqdsE39tKcLp8Yts/ZQ8N2hxaC67jh0lF+3dkCPk8a6KAJmgSLZ2e/QpZ06eV
         rsX43ZO0M104E3m1jSlbr90n8sCQlFV32b/K1fA3QNlvDh+9jdYnGgt7wCLsyQLEBebw
         4SYvJauQcfebgFTuCuudUjq8Di/8A9QWPdyjsE/Q8OgmKBkiey04FgvyN3zXiOQ2uU61
         A3zV/+zmByHTq7qdIQqlf7GkEZT7r1n4dWjErWLKgoq/13ivsRHjmcb90xgwZzBk/+vB
         V/PzfeTLsdaEGWBWtIV5h/PAgX1wl6TxyJclluDyEoHhgi5XX1ocLQS+S7qDuNg3Iuzw
         f1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7V6nX6QNu39reXsVUNZH8XsbZ4HLycXsme3SEqI7dk=;
        b=HXJBW0K8icS2UtVqDNJytfU4qi/6/AkmWRevHyTjY6L3YokEJObWZV9qKtOGzkz4Ga
         UFNvqEY+jaPLWNaJyKVG81IzKBVBW9ph3SKQVWqgP6x3rf5JINfmXOFcCx/9bRpgWSmR
         bsTokzrP5LV19WjhVaFN4VnPNX48JhNX/HTus+AnfLeAXCYpXS3DBrqEmhfxCg0QhBHT
         yo2AJT2IhfkCqlLHr6lPLKUYRTWa6wv67Pd1UkiFhqiDzrj6N9AztHGJBwOzyvfqZQB/
         h3hPbWX3fwmx8d6e6wuNHiUpzGsiXOi5zc5jR5VqngBLdUzOeKcpkwB11OXMsXNDOJ2m
         dDqA==
X-Gm-Message-State: AOAM533/OSjj6y7eGKucuI+KnY6M59dVOpK83+X/xg0e3rXjJtJ+WDMW
        CWBmVaXVVhWycwofgtL8fnmKOFlaNXjL+w==
X-Google-Smtp-Source: ABdhPJyQ7HqAU9lVZQfG5pO94V2Gf3PA4j10RPYLFLREhaOv0bk+cghf3mtSWrpSpHqCwmANIU3TqQ==
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr20398044ilb.161.1615213179285;
        Mon, 08 Mar 2021 06:19:39 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y6sm6357917ily.50.2021.03.08.06.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:19:38 -0800 (PST)
Subject: Re: [PATCH net-next v2 5/6] net: qualcomm: rmnet: don't use C
 bit-fields in rmnet checksum trailer
To:     David Laight <David.Laight@ACULAB.COM>,
        "subashab@codeaurora.org" <subashab@codeaurora.org>,
        "stranche@codeaurora.org" <stranche@codeaurora.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
Cc:     "sharathv@codeaurora.org" <sharathv@codeaurora.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cpratapa@codeaurora.org" <cpratapa@codeaurora.org>,
        "elder@kernel.org" <elder@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210306031550.26530-1-elder@linaro.org>
 <20210306031550.26530-6-elder@linaro.org>
 <ebe1bf51902e49458cfdd685790c4350@AcuMS.aculab.com>
 <956ca2dd-d15e-ce40-e3b4-56b0f5bf2154@linaro.org>
 <a2954816677f4ae1b27e4cb8e38da0a1@AcuMS.aculab.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <bef760ad-7f24-f83a-ce3d-957b72b635de@linaro.org>
Date:   Mon, 8 Mar 2021 08:19:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a2954816677f4ae1b27e4cb8e38da0a1@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 7:53 AM, David Laight wrote:
> ...
>>>> -	if (!csum_trailer->valid) {
>>>> +	if (!u8_get_bits(csum_trailer->flags, MAP_CSUM_DL_VALID_FMASK)) {
>>>
>>> Is that just an overcomplicated way of saying:
>>> 	if (!(csum_trailer->flags & MAP_CSUM_DL_VALID_FMASK)) {
>>
>> Yes it is.  I defined and used all the field masks in a
>> consistent way, but I do think it will read better the
>> way you suggest.  Bjorn also asked me privately whether
>> GENMASK(15, 15) was just the same as BIT(15) (it is).
>>
>> I will post version 3 of the series, identifying which
>> fields are single bit/Boolean.  For those I will define
>> the value using BIT() and will set/extract using simple
>> AND/OR operators.  I won't use the _FMASK suffix on such
>> fields.
> 
> Even for the checksum offset a simple 'offset << CONSTANT'
> is enough.

I do not want the code to assume the field resides in the
bottom of the register.

> If it is the bottom bits then even that isn't really needed.
> You might want to mask off high bits - but that is an error
> path that needs to have been checked earlier.

Using u32_get_bits() (etc.) is a general-purpose way of
setting and extracting bit fields from registers.  In a
way, it might be overkill here.  On the other hand, we
can expect additional structures to be defined in
<linux/if_rmnet.h>.  If we handle fields in this common
way now, they can be handled the same way for new
structures.

I think your implication is right, that this could be
done possibly more simply without the helper functions.

Let me do the BIT() fix on version 3.  If others echo
your thoughts about not using the u32_get_bits() family
of helper functions, I can address that in version 4.

					-Alex


> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


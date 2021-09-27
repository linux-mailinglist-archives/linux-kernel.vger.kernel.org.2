Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51294194F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhI0NXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhI0NXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:23:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD03C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:21:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so554175wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsIJ9dO06OxsoSNc6NSWOldwLtFGf888curFbOwDr2g=;
        b=qkZBYQDGlLBIkVndlR5FmB33D+tX8EXqpGjpzFQc+OGwYjKjkCe3JBsuFbXx3dZ8YT
         eKPgIc602BMmomFHZPbcdfB0axKWyd5up94MLnX8zxX40vcgWVt3gDl1I5CcQ+BEjdnX
         ENaYDNybHm6yqdbOEoWsjIwOknTTa5vwDiGeXNogbHVQYcr9NbLS3ON0UQa6V2aoP3M2
         98DM5az9vndYLCppY2OoGxsPEgpRa+Zje99rE3Ftf19Wc8X99z8Kk4QNFaWIc1A9wKZr
         8HoFZ7Tnu4QR9XwMAV6IYK64IHZ6KvwelzHxZ620R+9E9rMSOOjdz9YXkE1/HXmHO0H8
         WG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsIJ9dO06OxsoSNc6NSWOldwLtFGf888curFbOwDr2g=;
        b=TXyLn1+FrzXRg/4fiNQI5Kk5xMxlocfEbkUamIrn4VfRr21gMpbJR7PKWZ335rujat
         9hySn/xnQTwTF6Gw7k4+qjkl6kQmlL9mWkHTCgMO/u4LbLxcNAzMVRgCo4cINqNDlqdU
         IThcIMcCMt3FvGrPrZ5ipyha+aHNX9qFBbhP86TtOcHdxK9qqW5SIhoOALxkDzze7eo7
         a2q/0iHVVpu2ZIU7D2j8ldg5lX7RpkvA7hyoYGSlPxwgiegyt++eaQvKTATQLOEqDBkF
         SvooUztsPFoKy7DIjosIEWp/W9yJaFD7obi74MDcVXGkO47OaVXeGSAAF3MKjCskneNL
         vyVw==
X-Gm-Message-State: AOAM530loCHXpeMYFiu5NpF5csXTrQqH0aksgzE6Kjju8VcO4ToFxHNe
        srSbdH+oGXMwLyZv54odNK1ORtvKVgvfxlc3
X-Google-Smtp-Source: ABdhPJywlkhImNz1nTnbee8WNknBnpkLfELMLiAbgnhF9YVHc0xNXi8hRaN7LsURQxwFATMJyJT4/w==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr16354358wmo.138.1632748902185;
        Mon, 27 Sep 2021 06:21:42 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:11ee:1594:bd11:4057? ([2a00:1098:3142:14:11ee:1594:bd11:4057])
        by smtp.gmail.com with ESMTPSA id a3sm4064800wrn.16.2021.09.27.06.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 06:21:41 -0700 (PDT)
Subject: Re: [PATCH] staging: vc04_services: shut up out-of-range warning
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210927113702.3866843-1-arnd@kernel.org>
 <20210927122658.GF2048@kadam>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <011c53e6-d628-02b7-fc18-ca3165a45f98@raspberrypi.com>
Date:   Mon, 27 Sep 2021 14:21:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927122658.GF2048@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 27/09/2021 13:26, Dan Carpenter wrote:
> On Mon, Sep 27, 2021 at 01:36:56PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The comparison against SIZE_MAX produces a harmless warning on 64-bit
>> architectures:
>>
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:185:16: error: result of comparison of constant 419244183493398898 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>>          if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
>>              ~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Shut up that warning by adding a cast to a longer type.
>>
>> Fixes: ca641bae6da9 ("staging: vc04_services: prevent integer overflow in create_pagelist()")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index b25369a13452..967f10b9582a 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -182,7 +182,7 @@ create_pagelist(char *buf, char __user *ubuf,
>>   		offset = (uintptr_t)ubuf & (PAGE_SIZE - 1);
>>   	num_pages = DIV_ROUND_UP(count + offset, PAGE_SIZE);
>>   
>> -	if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
>> +	if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
>>   			 sizeof(struct vchiq_pagelist_info)) /
>>   			(sizeof(u32) + sizeof(pages[0]) +
>>   			 sizeof(struct scatterlist)))
> 
> The temptation would be to declare "num_pages" as size_t instead of
> adding this cost.  But then something will complain about the
> "pagelistinfo->num_pages = num_pages;" assignment because
> "pagelistinfo->num_pages" is a u32.
> 
> The next temptation is to change the SIZE_MAX to UINT_MAX.  I didn't
> do that originally because I can't test this and I was trying not to
> break things...  We probably still don't want to break things, but maybe
> there is someone who is more familiar with this who knows if UINT_MAX is
> okay?

The VPU can't address more than 1GB directly, so UINT_MAX is more than sufficient.

Phil

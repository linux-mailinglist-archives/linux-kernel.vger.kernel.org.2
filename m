Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2313E3568
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhHGNFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHGNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:05:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339FC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 06:04:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h14so14772294wrx.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iohwz+jjdUGOVKYHNCdeEdRI2f7781Lw+Ns9z4YxHhc=;
        b=CA682m8lxUdkpoCzQFMdzVSG9TG3g8hBjJPvUAyx9k+3J87OqJiEW54jskT5epfFss
         VuzUoEZvjDeNLXmC2hXb5SkO5VG62AqApCO4aaXES+G0gvAT/fe1Cwl2yILn0DBm5zG7
         nlm9wOENpjNe1FGrX9xnaPb28GLQmBIYPL7vXtMIl1HsIbNoyae05aNKQSwZH9PrEgdK
         ws/yXZj5+oAgCjaN+qX0BX13mJFQQPVZhLIWB2k6ZDsb3Nup9fbtmCbXw5+plzhJsmBz
         YLDfHKiRUjn2yo/hdRcLxnf7BdhdvfvvmfPjPxeT3qJo0Y6v5BUQfh414tvLt8EQ5nGF
         I2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iohwz+jjdUGOVKYHNCdeEdRI2f7781Lw+Ns9z4YxHhc=;
        b=KCyzA5BrCbSGwiDkQeqt0OLxqjlHbe8E9nUFpFVJeSZXH+4RxmYopv+iTz5w2dMwDO
         wa9H507Svly76KsyZu7SgBqiEzkQqmW9gVyNnK45LBlC3yqMyo47t/YjW5hvVDgqPGYQ
         E4Eai0BSQqCwMMq4ukSnFo85sghZbfeA73iYaqNHlauoAN1WOZlzGsEQIOakaxdU7O+v
         HrnLGlk56zgD5mmp3wAfk0gzbc538cXAMajt/VL668AIO7BTDE1mTNQbK/ruJRAyXbrs
         tn9ci+X943Mfcv23+REBY3bXpKGRLrcLu+/LLhPNfCxpGOZtigntBvLFarCBtT8pV94h
         qUaA==
X-Gm-Message-State: AOAM532+Am53+AFSqMEGRWj0lShUD6pmW4G3AC/D0TcClSYRwzssCE1C
        Mbnk0UcGb0cDVZcpQKDOZGvPiKYNegZ+wg==
X-Google-Smtp-Source: ABdhPJxuY8E9A+5xmxCO4mFRcvndg4NGugpNaZKspqYr3JEymEB4Q214Qx+gibH5TOiUhAbZWa2y/g==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr15705322wrk.355.1628341480878;
        Sat, 07 Aug 2021 06:04:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 18sm11145826wmo.2.2021.08.07.06.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 06:04:40 -0700 (PDT)
Subject: Re: [PATCH 0/4] slimbus: patches (set 1) for 5.15
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
 <YQ03FPyxF8DFlwI7@kroah.com>
 <71200533-db05-157f-480a-d64812e1d9c2@linaro.org>
 <YQ6EMKD0gOIJn+FL@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e737f324-400e-824b-3865-017d2d2a5543@linaro.org>
Date:   Sat, 7 Aug 2021 14:04:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQ6EMKD0gOIJn+FL@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2021 14:01, Greg KH wrote:
> On Sat, Aug 07, 2021 at 11:48:48AM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 06/08/2021 14:20, Greg KH wrote:
>>> On Fri, Aug 06, 2021 at 10:16:35AM +0100, Srinivas Kandagatla wrote:
>>>> Hi Greg,
>>>>
>>>> Recently runtime pm testing on slimbus reveled that its
>>>> totally broken on SlimBus ngd drivers.
>>>>
>>>> Below are the fixes to get it back working.
>>>>
>>>> - One of the reason begin incorrect device pointer used for
>>>> runtime pm and in some places
>>>>
>>>> - Second one was to do with unable to validate transaction id
>>>>    which resulted in negative runtime pm count.
>>>>
>>>> - Other fix was to do with resetting dma addresses once ngd
>>>> controller is power-cycled.
>>>>
>>>> With all these fixed runtime pm is now fully functional on NGD
>>>> controllers.
>>>>
>>>> Currently I marked them all with Cc: <stable@vger.kernel.org>
>>>> as these all patches are required to fix runtime pm on SlimBus
>>>> NGD controller.
>>>>
>>>> Can you please queue them up for 5.15.
>>>
>>> Why do you want these for 5.15-rc1 when you need them to fix problems in
>>> 5.14?  Shouldn't they go into 5.14-final?
>>
>> Yes, these should go to other stable trees aswell.
>> I assumed that Fixes tag will automatically backport those patches.
> 
> Yes, but that can not happen until they hit Linus's tree, which would
> not be until 5.15-rc1.  Do you want to delay until that long from now?
> 
> How about splitting this into 2 patch series, one that you want to see
> get into 5.14-final, and one for 5.15-rc1.

All the patches in these series are fixes so the can go to 5.14-final.

--srini
> 
> thanks,
> 
> greg k-h
> 

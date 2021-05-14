Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31866380488
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhENHnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhENHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:43:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79362C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:42:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so43338879ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ybj0Wo1OiQ8Ih6tzwUC6wscj3urV7h1h6AdU5SM1LE0=;
        b=F0zJ7RdevA957kyra8pX0GVIfrIRss54HmSxrtAuCRoBRK4AY6wppw8UQeJ5O1xuXu
         8keIq4smmOvM8Dfue8T9zdGd+K1B7kBqZ1KCNR3PSGqECVXKokzx0ezXkOs1PSmo+HJN
         X3q/3gXnZTey7rcub1FsgNjw9/A8DKvOTRxEc+8M7mancPSuwIAwfcmIB354sXxJRTe1
         kyJOaCwYVyPQ5I7iz65YbV8XBZU5hojsof014j/NMLNdRJ/YxlV7Ze7DWk3TkZBMpNEW
         /nEETmMPhRc9dlmuSp0zhxWWuj1BdmzsfeP2gMnf/9Zuif7FR5oyVzYpYOiwqVeXrSyc
         ML2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ybj0Wo1OiQ8Ih6tzwUC6wscj3urV7h1h6AdU5SM1LE0=;
        b=fGdupyMUdoB+Gk5ywtBtlJQsllMMCojElSrxU8kOh6MjpB7PFWU0Vx1YsXjsdyfcZz
         L0a7FNmgfO1yVqgITGxXxhPzbaRa1vMZthrx9qcbtPNKoEa3rubVn88t3QGASJMRj4qv
         DzTdzS2sVhGwEc+YLpy8JQ3SVcm7v6UGEpqtoQR29GNOq4TjG2I8qGCBko3dT7omhKq6
         3rfcy0ARTf0BxU39jZhwGktQIZ42sOjkZqANZ5jvA68bVaeqx1gbJcwMjiv49vZU6S42
         0lfnWfJFFIM8Dn0DQqeraTWKm6kwzvY3lolVsP0UO7hMHD4n7xzgaqgNeU+BEX+RoNSX
         yhDw==
X-Gm-Message-State: AOAM5337GdvXAvOeKQjVtOORi66cAxsNVZIudiUlNf5sUkbTs2rtp9P0
        cxfvoa0NbJ+1tY3eA8liaMigf9VNpIpKPg==
X-Google-Smtp-Source: ABdhPJxahJ6vtjso9lqzXnK0wyNWsRQpHMI2oL6nA+MWQ2uhmCvgwnSbErgZY0I+d+y/V0Be+JkJ4w==
X-Received: by 2002:a17:906:7302:: with SMTP id di2mr28471115ejc.409.1620978139208;
        Fri, 14 May 2021 00:42:19 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id h8sm3086528ejb.104.2021.05.14.00.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 00:42:18 -0700 (PDT)
Subject: Re: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Luo Longjun <luolongjun@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sangyan@huawei.com,
        ningyu9@huawei.com, luchunhua@huawei.com
References: <20210507182410.10515-1-luolongjun@huawei.com>
 <20210511172020.GB21033@arm.com>
 <6ef5c7a0-3596-a67c-c99d-c8e0def8a96a@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <aa3d0bf1-8330-42e0-d11b-c554194c3b81@gmail.com>
Date:   Fri, 14 May 2021 09:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6ef5c7a0-3596-a67c-c99d-c8e0def8a96a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 11/05/2021 22:04, Enric Balletbo i Serra wrote:
> Hi Catalin,
> 
> Thanks for cc'ing me.
> 
> On 11/5/21 19:20, Catalin Marinas wrote:
>> On Sat, May 08, 2021 at 02:24:10AM +0800, Luo Longjun wrote:
>>> When I compile kernel in ARM64, it produces the following output:
>>>
>>> *** Default configuration is based on 'defconfig'
>>> arch/arm64/configs/defconfig:1018:warning: override: reassigning to
>>> symbol MTK_PMIC_WRAP
>>>
>>> After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.
>>>
>>> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
>>> ---
>>>  arch/arm64/configs/defconfig | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 08c6f769df9a..9907a431db0d 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
>>>  CONFIG_SPI_SH_MSIOF=m
>>>  CONFIG_SPI_SUN6I=y
>>>  CONFIG_SPI_SPIDEV=m
>>> -CONFIG_MTK_PMIC_WRAP=m
>>>  CONFIG_SPMI=y
>>>  CONFIG_PINCTRL_SINGLE=y
>>>  CONFIG_PINCTRL_MAX77620=y
>>
>> Adding Matthias and Enric. This change looks fine to me but I think it
>> should go in via the arm-soc tree. Commit 9fd5449e061e introduced the =m
>> option while commit fbbe38309d56 introduced the =y variant.
>>
>> You could add:
>>
>> Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
>>
> 
> I sent the same patch some time ago [1].
> 
> I agree, either land this patch or mine. In any case,
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Matthias is this something that should go through your tree?
> 

Yes, this should go through my tree. I'll take care of it.

Regards,
Matthias

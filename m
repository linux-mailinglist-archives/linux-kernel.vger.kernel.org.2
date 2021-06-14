Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE53A5EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhFNJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:00:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBA9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:58:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b205so6957230wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cR/6zRsaGY9YfIlwevZHCWwT2etKuhsmQ987OMG5H9c=;
        b=WQfk6x3x+g5q7nXr5DIsXFQI0uy7zxg11+IIyHQC+UuhY+9wnT76mv8Q7WQaHBlTk+
         5xGigLo4FutudtluCrEyzPPE1Za2bqGDdc6EIyUofpdrUBF47JSaD8Ay3NLAkMEUL9rz
         MFv3ARbz2iyPUln8kZBs6mAr8A37sCq15tLXEUNodCiQIyrivCoyBT9wBODaRJW8L8tZ
         j16tQzsBdt61sitpiCglhSdQL6nOXiAkxEXG+1IiqlRLkOErS4bmxZm/dbeFjvFQMdjd
         j1ji/02/y+ebNo23kQUqm8G8W0NeHTpoa4ef7PKIr792b74RyTKC63ZtliU1CZMrak4A
         SKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cR/6zRsaGY9YfIlwevZHCWwT2etKuhsmQ987OMG5H9c=;
        b=Ke4b0PeKKvho/1CZ9+yJtbjelFZg2G8aKZvoYIlt0kIfjeCK4uYQ90pSUFqtfLjym0
         YXxmFpJPHyneGBMAzt9vsH5gaas4uruzo6jyhrPE5vUb631fk3SrjDNZng7bF98oap4f
         5GNpEwz2ZgjH5JS9jxO+iYxuxIypEgbNYLcFuWYVjoNPe9+aUpR4juD3nZWizLU81AA0
         SnIUi98IXMqgvLh6p94jP9/mwSqcrtsPhRE9fUONG7XeqBGuv+/ps9dNu2RXv6XkUFXG
         4Iz9/Qi5U0B1PAtfKGTLazdh1vMd6oKRldgpE/QWfsDRxrSCAn5fQrt8dq0TJ5UReO3r
         xzVg==
X-Gm-Message-State: AOAM531PbDBwbXOIwP6oCglXOT6UEH95IBjMfK/HE/SPjH7/ibc9cqwi
        nwZGdU3/MLa2ErSI0RGdEEQ=
X-Google-Smtp-Source: ABdhPJx8/DxT3tbbludZNcJjh+Ltk70zZ4GyN5Lk/Nnu9qM3urKCytgC2pjdZYt8p1rtxp1m55E0fQ==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr15757009wme.154.1623661100653;
        Mon, 14 Jun 2021 01:58:20 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 62sm16611410wrm.1.2021.06.14.01.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 01:58:20 -0700 (PDT)
Subject: Re: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Luo Longjun <luolongjun@huawei.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, ningyu9@huawei.com, luchunhua@huawei.com
References: <20210507182410.10515-1-luolongjun@huawei.com>
 <20210511172020.GB21033@arm.com>
 <6ef5c7a0-3596-a67c-c99d-c8e0def8a96a@collabora.com>
 <aa3d0bf1-8330-42e0-d11b-c554194c3b81@gmail.com> <YMPYC5OAEh5vJQwv@pevik>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d16dc4ce-8e24-1064-0e46-6a3dcd253cfd@gmail.com>
Date:   Mon, 14 Jun 2021 10:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YMPYC5OAEh5vJQwv@pevik>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 11/06/2021 23:39, Petr Vorel wrote:
> Hi,
> 
>> Hi all,
> 
>> On 11/05/2021 22:04, Enric Balletbo i Serra wrote:
>>> Hi Catalin,
> 
>>> Thanks for cc'ing me.
> 
>>> On 11/5/21 19:20, Catalin Marinas wrote:
>>>> On Sat, May 08, 2021 at 02:24:10AM +0800, Luo Longjun wrote:
>>>>> When I compile kernel in ARM64, it produces the following output:
> 
>>>>> *** Default configuration is based on 'defconfig'
>>>>> arch/arm64/configs/defconfig:1018:warning: override: reassigning to
>>>>> symbol MTK_PMIC_WRAP
> 
>>>>> After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.
> 
>>>>> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
>>>>> ---
>>>>>  arch/arm64/configs/defconfig | 1 -
>>>>>  1 file changed, 1 deletion(-)
> 
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index 08c6f769df9a..9907a431db0d 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
>>>>>  CONFIG_SPI_SH_MSIOF=m
>>>>>  CONFIG_SPI_SUN6I=y
>>>>>  CONFIG_SPI_SPIDEV=m
>>>>> -CONFIG_MTK_PMIC_WRAP=m
>>>>>  CONFIG_SPMI=y
>>>>>  CONFIG_PINCTRL_SINGLE=y
>>>>>  CONFIG_PINCTRL_MAX77620=y
> 
>>>> Adding Matthias and Enric. This change looks fine to me but I think it
>>>> should go in via the arm-soc tree. Commit 9fd5449e061e introduced the =m
>>>> option while commit fbbe38309d56 introduced the =y variant.
> 
>>>> You could add:
> 
>>>> Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> 
> I was going to send fix myself, I'd prefer also y, but weren't 100% sure sure.
> 

This has landed in the arm-soc tree this weekend.
Anyway, thanks for looking into this as well.

Regards,
Matthias

> For a record:
> 
> * CONFIG_MTK_PMIC_WRAP=m committed by author in 2021-01-04, merged 2021-01-31 15:31:01
> 9fd5449e061e ("arm64: configs: Support pwrap on Mediatek MT6779 platform")
> sent: 4 Jan 2021
> https://lore.kernel.org/r/1609747703-27207-3-git-send-email-argus.lin@mediatek.com
> Applied to v5.11-next/defconfig 31 Jan 2021 15:32:26 by Matthias Brugger <matthias.bgg@gmail.com>
> https://lore.kernel.org/linux-devicetree/5d5a67a5-ac2d-9ef9-b20c-66cbd55ebb8f@gmail.com/
> 
> * CONFIG_MTK_PMIC_WRAP=y was committed by author in 2021-03-31 11:06:57, merged 2021-03-31 12:12:59
> fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
> sent: 31 Mar 2021 11:06:57
> https://lore.kernel.org/r/20210331090659.4169966-1-enric.balletbo@collabora.com
> But originally sent: 9 Feb 2021 10:11:11
> https://lore.kernel.org/lkml/20210209091112.2075478-1-enric.balletbo@collabora.com/
> 
> Kind regards,
> Petr
> 
>>> I sent the same patch some time ago [1].
> 
>>> I agree, either land this patch or mine. In any case,
> 
>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
>>> Matthias is this something that should go through your tree?
> 
> 
>> Yes, this should go through my tree. I'll take care of it.
> 
>> Regards,
>> Matthias

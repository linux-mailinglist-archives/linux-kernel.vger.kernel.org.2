Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1D37AFED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEKUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:05:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhEKUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:05:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1B3901F41760
Subject: Re: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Luo Longjun <luolongjun@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sangyan@huawei.com,
        ningyu9@huawei.com, luchunhua@huawei.com,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20210507182410.10515-1-luolongjun@huawei.com>
 <20210511172020.GB21033@arm.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6ef5c7a0-3596-a67c-c99d-c8e0def8a96a@collabora.com>
Date:   Tue, 11 May 2021 22:04:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511172020.GB21033@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thanks for cc'ing me.

On 11/5/21 19:20, Catalin Marinas wrote:
> On Sat, May 08, 2021 at 02:24:10AM +0800, Luo Longjun wrote:
>> When I compile kernel in ARM64, it produces the following output:
>>
>> *** Default configuration is based on 'defconfig'
>> arch/arm64/configs/defconfig:1018:warning: override: reassigning to
>> symbol MTK_PMIC_WRAP
>>
>> After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.
>>
>> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 08c6f769df9a..9907a431db0d 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
>>  CONFIG_SPI_SH_MSIOF=m
>>  CONFIG_SPI_SUN6I=y
>>  CONFIG_SPI_SPIDEV=m
>> -CONFIG_MTK_PMIC_WRAP=m
>>  CONFIG_SPMI=y
>>  CONFIG_PINCTRL_SINGLE=y
>>  CONFIG_PINCTRL_MAX77620=y
> 
> Adding Matthias and Enric. This change looks fine to me but I think it
> should go in via the arm-soc tree. Commit 9fd5449e061e introduced the =m
> option while commit fbbe38309d56 introduced the =y variant.
> 
> You could add:
> 
> Fixes: fbbe38309d56 ("arm64: defconfig: Allow mt8173-based boards to boot from usb")
> 

I sent the same patch some time ago [1].

I agree, either land this patch or mine. In any case,

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Matthias is this something that should go through your tree?

Thanks,
  Enric


[1]
https://lore.kernel.org/linux-arm-kernel/20210423075201.2616023-1-enric.balletbo@collabora.com/T/

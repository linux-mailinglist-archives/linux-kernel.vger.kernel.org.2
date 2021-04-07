Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5743565C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245522AbhDGHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:50:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15938 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhDGHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:50:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFc2R3p9rzyNSk;
        Wed,  7 Apr 2021 15:48:15 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 15:50:19 +0800
Subject: Re: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select
 GPIOLIB
To:     Robert Foss <robert.foss@linaro.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>, <heying24@huawei.com>
References: <20210406090733.169989-1-zhangjianhua18@huawei.com>
 <CAG3jFyvC6ozPxQ=TPdPgLAugKky5AhOZGJSiw0Dc3Kn5Pba0cA@mail.gmail.com>
From:   "zhangjianhua (E)" <zhangjianhua18@huawei.com>
Message-ID: <d9bd5abf-0293-6155-dee0-20199fed1fc0@huawei.com>
Date:   Wed, 7 Apr 2021 15:50:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAG3jFyvC6ozPxQ=TPdPgLAugKky5AhOZGJSiw0Dc3Kn5Pba0cA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

Yes, you are right, there are many files reference 
gpiod_set_value_cansleep() and

devm_gpiod_get_optional(). How about add config dependencies for all 
releated

configs or only add config dependencies for the top level config?


Best regards

Zhang Jianhua

在 2021/4/6 18:21, Robert Foss 写道:
> Hey Zhang
>
> On Tue, 6 Apr 2021 at 11:07, Zhang Jianhua <zhangjianhua18@huawei.com> wrote:
>> If CONFIG_DRM_LONTIUM_LT8912B=y, the following errors will be seen while
>> compiling lontium-lt8912b.c
>>
>> drivers/gpu/drm/bridge/lontium-lt8912b.c: In function
>> ‘lt8912_hard_power_on’:
>> drivers/gpu/drm/bridge/lontium-lt8912b.c:252:2: error: implicit
>> declaration of function ‘gpiod_set_value_cansleep’; did you mean
>> ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
>>    gpiod_set_value_cansleep(lt->gp_reset, 0);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~
>>    gpio_set_value_cansleep
>> drivers/gpu/drm/bridge/lontium-lt8912b.c: In function ‘lt8912_parse_dt’:
>> drivers/gpu/drm/bridge/lontium-lt8912b.c:628:13: error: implicit
>> declaration of function ‘devm_gpiod_get_optional’; did you mean
>> ‘devm_gpio_request_one’? [-Werror=implicit-function-declaration]
>>    gp_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>               ^~~~~~~~~~~~~~~~~~~~~~~
>>               devm_gpio_request_one
>> drivers/gpu/drm/bridge/lontium-lt8912b.c:628:51: error: ‘GPIOD_OUT_HIGH’
>> undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
>>    gp_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>                                                     ^~~~~~~~~~~~~~
>>                                                     GPIOF_INIT_HIGH
>>
>> Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
>> ---
>>   drivers/gpu/drm/bridge/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index dba62f92d051..caa9658ec933 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -67,6 +67,7 @@ config DRM_LONTIUM_LT8912B
>>          select DRM_PANEL_BRIDGE
>>          select DRM_KMS_HELPER
>>          select REGMAP_I2C
>> +       select GPIOLIB
> This appears like the right fix for this problem. However, a number of
> drm/bridge drivers seem to call both gpio_set_value_cansleep() and
> devm_gpiod_get_optional() without having the GPIOLIB kconfig option
> selected so this can't be a new issue. Maybe some more investigation
> is in order.
> .

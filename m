Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225C8357D07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhDHHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:11:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15176 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:11:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGC5l6YQ7zpVJ1;
        Thu,  8 Apr 2021 15:08:11 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 15:10:49 +0800
Subject: Re: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select
 GPIOLIB
From:   "zhangjianhua (E)" <zhangjianhua18@huawei.com>
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
 <d9bd5abf-0293-6155-dee0-20199fed1fc0@huawei.com>
 <CAG3jFyu6YY5pr5bdvqAbzZu0GG0z=PWP+JHL59G26cg0P=563w@mail.gmail.com>
 <a40abdd7-af43-28a3-1b79-0de6ca0c0093@huawei.com>
Message-ID: <53492034-4cec-12ed-ae27-d693686084ee@huawei.com>
Date:   Thu, 8 Apr 2021 15:10:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a40abdd7-af43-28a3-1b79-0de6ca0c0093@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robert

I am sorry that I make a mistake about the compiling error of lt8912b,

the reason is that lt8912b miss the header file <linux/gpio/consumer.h>.

Although there are many files reference gpiod_set_value_cansleep() and

devm_gpiod_get_optional(), they all include <linux/gpio/consumer.h>

and not occur the compiling error like lt8912b. I have send the second

version patch, please read.


Best regards,

Zhang Jianhua

在 2021/4/7 17:50, zhangjianhua (E) 写道:
> Thanks, I will do that.
>
> 在 2021/4/7 16:03, Robert Foss 写道:
>>> Yes, you are right, there are many files reference
>>> gpiod_set_value_cansleep() and
>>>
>>> devm_gpiod_get_optional(). How about add config dependencies for all
>>> releated
>> I think this is the way to go and roughly half of the drm bridge
>> drivers seem to need this change.
>>
>> Do you mind submitting a series of patches adding this fix for all of
>> the relevant bridge drivers?
>>
>>> configs or only add config dependencies for the top level config?
>>>
>> .

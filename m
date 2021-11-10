Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8766644C182
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhKJMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhKJMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:49:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78918C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:46:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B1A601F45536
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636548389; bh=WtI3fS9QXyc7xtq/U8v+DObsz4S+7OVyg0Rl357ssW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ehRxczPGT7XnOrvgW0DmvRPx5TWqrn0KEyRrebNslCeBbKao/xXD266GOq72UF4Mp
         qE0KzcgfZGrrUNTdjHx0QJ2uPFONccGcZMHBoDv89UtcTxvgbVyPZJYThRJI9i2OSm
         CgdsUDdpV4mUO2+q0l6/5gh3hFEIFUN8nItwLwTkKYqLSnyVhwGanHsgunDuILN8Me
         zDNsllEKtDVPm5o/6+tQjAGK8QjjrJcmejnUWwj+GiiDhyQ/qC2NRLcZERoPCII1G/
         tYwr54PyNJ6/PGVt+bXH+R4C2E0rIBHCQ6N69apEwmT7vCvu5Dmt1taO5ru1pCXOHH
         PavuMnMffn1+A==
Subject: Re: [PATCH v2 2/3] drm/bridge: parade-ps8640: Move real poweroff
 action to new function
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20211102093618.114928-1-angelogioacchino.delregno@collabora.com>
 <20211102093618.114928-2-angelogioacchino.delregno@collabora.com>
 <d2fe91c8-ab29-7706-80f4-fe6619f07327@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <286beb55-00db-ba76-0a51-900d59e2ab34@collabora.com>
Date:   Wed, 10 Nov 2021 13:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d2fe91c8-ab29-7706-80f4-fe6619f07327@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/11/21 13:44, Dafna Hirschfeld ha scritto:
> 
> 
> On 02.11.21 11:36, AngeloGioacchino Del Regno wrote:
>> In preparation for varying the poweron error handling in function
>> ps8640_bridge_poweron(), move function ps8640_bridge_poweroff() up
>> and also move the actual logic to power off the chip to a new
>> __ps8640_bridge_poweroff() function.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/bridge/parade-ps8640.c | 37 ++++++++++++++------------
>>   1 file changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c 
>> b/drivers/gpu/drm/bridge/parade-ps8640.c
>> index 8c5402947b3c..41f5d511d516 100644
>> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
>> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
>> @@ -293,6 +293,26 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
>>       return 0;
>>   }
>> +static void __ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
>> +{
>> +    gpiod_set_value(ps_bridge->gpio_reset, 1);
>> +    gpiod_set_value(ps_bridge->gpio_powerdown, 1);
>> +    if (regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
>> +                   ps_bridge->supplies)) {
>> +        DRM_ERROR("cannot disable regulators\n");
>> +    }
> 
> That '{' is redundant
> 
> Thanks,
> Danfa
> 

Hi Dafna,
the braces were added as a way to increase human readability.

Cheers,
- Angelo

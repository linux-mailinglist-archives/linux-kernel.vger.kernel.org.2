Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5901D41506A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhIVTVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbhIVTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:21:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F604C061574;
        Wed, 22 Sep 2021 12:20:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so10024475wrc.7;
        Wed, 22 Sep 2021 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K+zmkw3T+xfgg89H6sRPETPAMl2svBQd3Km0SQBXfMg=;
        b=fnP5JqC0TbL40/JKO/2OcQ4PRqgmzh60NA/IdHSEkpMqLsnLe6915SOxmvixeUfRh6
         iSWArdeb/d7QxIuRe6jAEyhPtjrj+yEsDjhgepWrjKWeM22gPlZ6thUAoXsKYOFXEAqg
         PGPBbjTgzpy3KWDfSF0k9dSqAKQsq+Jq78+GPGvKp0i8SNXuyw4/Urb4rHvGlYgPAAUY
         OOVFllwK1bHuFu7u+hRD7iYZ1YzNhMh16RR9Kw+LS78i8hVQOk1A3JEz7ON8KU5Q75TC
         t2xTkG+z7GZnevZb1PzZszRZ9SAP8vYSoJAG+K2ynMXIW2Q5+1ub2XPJqUt8k+lO9+Nu
         MepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K+zmkw3T+xfgg89H6sRPETPAMl2svBQd3Km0SQBXfMg=;
        b=Nn2+xQBROCrc5vFLhICV8s8BJzhz2I6iwsntOnHLYZYNkH42KdXPnBI0YCvLpb8twm
         rSk/mX69hfA3ase9u6kZAmx6+6qFw0EC3etu+NNM1yY8CAUH7KF21m7ujz4J1sqhkzyp
         2+vCi3E3Y9WTkNnrUcElFWINwiW60BT7NG+Muyy7y6CJtQS6oSu3/zeJVY71IySB/Uqd
         W8PnYURZuYVmfIZgNDKssC7HfIGFIEoO+estu3FrlTsQKnRPAAxKP7OKF1QhNk92nigL
         p7DiaXLFF3YvLUjxM8OiXgsHFaO2HsIbAm3Hi4xWNEsntIisTIwm4kXg8IorwaVHQpX6
         kAiQ==
X-Gm-Message-State: AOAM531Fzlm/SF5RH0Gujyv7Mx6hwsPQhrSFrC+/A53G9rF353/drj6+
        HOs1+d4+nvOrY3lP1G11uqVHk8tzkw==
X-Google-Smtp-Source: ABdhPJz2XsEEcdlQKn+ptUbgAF5BMrqk/aYGbT822ZavTUFjd2LlmLGyEV3W9AfvEZtWFDyqf5cFeQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr12268598wma.150.1632338412027;
        Wed, 22 Sep 2021 12:20:12 -0700 (PDT)
Received: from [192.168.200.20] (ip5b434083.dynamic.kabel-deutschland.de. [91.67.64.131])
        by smtp.gmail.com with ESMTPSA id x14sm2925957wmc.10.2021.09.22.12.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 12:20:11 -0700 (PDT)
Subject: Re: [PATCH][next] drm/rockchip: Remove redundant assignment of
 pointer connector
From:   Alex Bee <knaerzche@gmail.com>
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Colin King <colin.king@canonical.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210922112416.182134-1-colin.king@canonical.com>
 <27c79f7a-8e4c-fad8-c6cf-a89793f2e3c6@gmail.com> <22365175.EbdSka62eY@diego>
 <6d18a1a6-37e3-41f9-ddd1-1dae33864d23@gmail.com>
Message-ID: <4a166499-1e83-99c8-8859-9d01a301412d@gmail.com>
Date:   Wed, 22 Sep 2021 21:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6d18a1a6-37e3-41f9-ddd1-1dae33864d23@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Am 22.09.21 um 19:31 schrieb Alex Bee:
> Hi Heiko,
>
> Am 22.09.21 um 18:45 schrieb Heiko Stübner:
>> Hi Alex,
>>
>> Am Mittwoch, 22. September 2021, 18:35:38 CEST schrieb Alex Bee:
>>> Hi Colin,
>>> Am 22.09.21 um 13:24 schrieb Colin King:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The pointer connector is being assigned a value that is never
>>>> read, it is being updated immediately afterwards. The assignment
>>>> is redundant and can be removed.
>>> The pointer to the connector is used in rockchip_rgb_fini for
>>> drm_connector_cleanup.
>>> It's pretty much the same for the encoder, btw.
>> I think the issue is more the two lines
>>
>>     connector = &rgb->connector;
>>       connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
>>
>> hence the connector = &rgb->connector being overwritten immediately 
>> after
>>
>> Now that I look at it again, the whole approach looks strange.
>> drm_bridge_connector_init() creates the connector structure and
>> returns a pointer to it.
>
> Totally agreed.
>
> The main reason I was doing it that way, was the way it was done 
> already in rockchip_lvds.c, where the connector was already existent 
> in the struct rockchip_lvds (and was already used in the panel-case - 
> all places where it is used accept pointers also, btw) and is *no* 
> pointer - and is done already this very strange way.
>
> I wanted to re-use it for the bridge-case and didn't want to differ in 
> coding in rockchip-rgb to much.
>
> The only reason I can think of, why it was done that way is, that we 
> might need a pointer to a fully initialized struct drm_connector for 
> some reason (drm_connector_cleanup ?), what we wouldn't have if have 
> just a pointer and something goes wrong before drm_connector_init 
> respectivly drm_bridge_connector_init.
>
> Alex
>
>
>> So the first line below sets the connector pointer to point to the
>> &rgb->connector element and the second line then set a completely
>> different address into it.
>>
>> So the connector element in rockchip_lvds and rockchip_rgb should 
>> actually
>> become a pointer itself to hold the connector element returned from
>> drm_bridge_connector_init() .
It turns out, nothing bad happens (i.e. rockchip_rgb_fini, the only 
place where the connector is also used, isn't called if 
rockchip_rgb_init fails) - so it will be OK if we make the connector a 
pointer in struct rockchip_rgb. But we'll need to keep it a "full" 
struct drm_connector in struct rockchip_lvds, since in case it's a 
panel  it gets properties assigend before drm_connector_init is called 
and should for that reason initialized before.

I'll send a patch soon.

Alex

>>
>>
>> Heiko
>>
>>> Regards,
>>>
>>> Alex
>>>> Addresses-Coverity: ("Unused value")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>    drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c 
>>>> b/drivers/gpu/drm/rockchip/rockchip_rgb.c
>>>> index 09be9678f2bd..18fb84068a64 100644
>>>> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
>>>> @@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct 
>>>> device *dev,
>>>>        if (ret)
>>>>            goto err_free_encoder;
>>>>    -    connector = &rgb->connector;
>>>>        connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
>>>>        if (IS_ERR(connector)) {
>>>>            DRM_DEV_ERROR(drm_dev->dev,
>>>>
>>>
>>
>>
>>


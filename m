Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF147433F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhJSTPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhJSTPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:15:00 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:12:47 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id j8so1995519uak.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UL2YWvVo40k3t4YquvgzfNyGVxoWuhyDYA5TDAnYaqE=;
        b=XhFSPrpOjgsv8KEQw7fqBFsEbBSYxR3HokS9HBLiBqjgviw64athINP2fH7Y/2bB2a
         G4W1EELpCpPpkZhK1IW99mWADLO8p6uQXPwtgHDWZevBZrgsbqoziSzNEl+REjUszxQk
         KGsUming6DmMk/tQi9zkfsU7meppqZ59upelZVK4s3y9mS2cbsd0P19E5iEl9XjQfxX7
         EsCqDfXoYae7Xiypa7gpRnkze8Q9EQ97fMPLcOlTs8tVctWKrAWKtE/BwHNVN6jkqxlj
         oEUKLYo6/jw7taJB0ZxaNnkm4MLbYFdnAs8q+4jm1avG81vm0L/ENgROSDb3k3STburd
         BvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UL2YWvVo40k3t4YquvgzfNyGVxoWuhyDYA5TDAnYaqE=;
        b=OMbRiIby7eJhxnbkPlpbeMqeT0lGNBPUNSQ0TF0oLe6km5QO0CA5qwMu3/kmVut0fL
         67E5VUiImS9+rFM/ZXR10fPOOhXBgHojTNnPeeBe3D88ueopoXwiCya1gyrkQIKcoBv3
         URnRp2ICHMgfV1Zi7VmWXVAMzwWYgE/V3d3nECqY8rVXRZ4EQQr8OF8pqRK7vOHXja5a
         ZSfFuWiO59AmwLPf28VV8UNjX97TuR47Xk+z9s+k/OFvWbcsOybA86Y/W/X9TRq665UI
         cThld7MN+m5fkoFqqwixkLQT7L+2rxUryQwETZw299qML2DnN4wjWpuLx6C4P9MWiLDv
         Mzww==
X-Gm-Message-State: AOAM532h+2W1VVjgaFIu7PogPQIb11ChLMR317d3I/wdJH0OneS6sbbs
        eC6k/vz0/zZVD9IoQHdMuh6rh3CwCj0=
X-Google-Smtp-Source: ABdhPJy+bqHMFR+qhpS79F3P6nzKEvZAUNkMkSHHF9xEtGfVOoCuHJhhn6PP3nJEztxC5RiEmToGSw==
X-Received: by 2002:a05:6102:956:: with SMTP id a22mr14433080vsi.20.1634670766080;
        Tue, 19 Oct 2021 12:12:46 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f4:b20b:270b:2d4a:f08:5534? ([2804:431:c7f4:b20b:270b:2d4a:f08:5534])
        by smtp.gmail.com with ESMTPSA id w27sm11708299vsi.25.2021.10.19.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:12:45 -0700 (PDT)
Subject: Re: [PATCH 5/6] drm: vkms: Prepare `vkms_wb_encoder_atomic_check` to
 accept multiple formats
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211005201637.58563-1-igormtorrente@gmail.com>
 <20211005201637.58563-6-igormtorrente@gmail.com>
 <5507450a-eb69-b24c-9f43-a1780dafbfa9@suse.de>
 <e9cbdad7-416a-65fe-eb50-1cbb42a01e7b@gmail.com>
 <9dbd2c55-2c29-eb12-94d0-dbd5110c302e@suse.de>
 <4d573cd9-ac1b-59d6-fb97-e5c24152892b@gmail.com>
 <f20d3359-1ec8-35ca-e885-bd35caa55c50@suse.de>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Message-ID: <fbe3ad70-375e-0f14-dba3-8f2e3f081457@gmail.com>
Date:   Tue, 19 Oct 2021 16:12:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f20d3359-1ec8-35ca-e885-bd35caa55c50@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/19/21 4:17 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.10.21 um 21:32 schrieb Igor Matheus Andrade Torrente:
>> Hi Thomas,
>>
>> On 10/18/21 3:06 PM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 18.10.21 um 19:41 schrieb Igor Matheus Andrade Torrente:
>>>> Hello,
>>>>
>>>> On 10/18/21 7:14 AM, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 05.10.21 um 22:16 schrieb Igor Matheus Andrade Torrente:
>>>>>> Currently, the vkms atomic check only goes through the first
>>>>>> position of
>>>>>> the `vkms_wb_formats` vector.
>>>>>>
>>>>>> This change prepares the atomic_check to check the entire vector.
>>>>>>
>>>>>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/vkms/vkms_writeback.c | 11 ++++++++++-
>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c
>>>>>> b/drivers/gpu/drm/vkms/vkms_writeback.c
>>>>>> index 5a3e12f105dc..56978f499203 100644
>>>>>> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
>>>>>> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
>>>>>> @@ -30,6 +30,8 @@ static int vkms_wb_encoder_atomic_check(struct
>>>>>> drm_encoder *encoder,
>>>>>>    {
>>>>>>        struct drm_framebuffer *fb;
>>>>>>        const struct drm_display_mode *mode = &crtc_state->mode;
>>>>>> +    bool format_supported = false;
>>>>>> +    int i;
>>>>>>        if (!conn_state->writeback_job ||
>>>>>> !conn_state->writeback_job->fb)
>>>>>>            return 0;
>>>>>> @@ -41,7 +43,14 @@ static int vkms_wb_encoder_atomic_check(struct
>>>>>> drm_encoder *encoder,
>>>>>>            return -EINVAL;
>>>>>>        }
>>>>>> -    if (fb->format->format != vkms_wb_formats[0]) {
>>>>>> +    for (i = 0; i < ARRAY_SIZE(vkms_wb_formats); i++) {
>>>>>> +        if (fb->format->format == vkms_wb_formats[i]) {
>>>>>> +            format_supported = true;
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    }
>>>>>
>>>>> At a minimum, this loop should be in a helper function. But more
>>>>> generally, I'm surprised that this isn't already covered by the
>>>>> DRM's atomic helpers.
>>>>
>>>> Ok, I can wrap it in a new function.
>>>>
>>>> AFAIK the DRM doesn't cover it. But I may be wrong...
>>>
>>> I couldn't find anything either.
>>>
>>> Other drivers do similar format and frambuffer checks. So I guess a
>>> helper could be implemented. All plane's are supposed to call
>>> drm_atomic_helper_check_plane_state() in their atomic_check() code.
>>> You could add a similar helper, say
>>> drm_atomic_helper_check_writeback_encoder_state(), that tests for the
>>> format and maybe other things as well.
>>
>> Do you think this should be done before or after this patch series?
> 
> Just add it as part of this series and use it for vkms. Other drivers
> can adopt it later on. The rcar-du code [1] looks similar to the one in
> vkms. Maybe put the common tests in to the new helper. You can extract
> the list of supported formats from the property blob, I think.
> 

OK, Thanks!

> Best regards
> Thomas
> 
> [1]
> https://elixir.bootlin.com/linux/v5.14.13/source/drivers/gpu/drm/rcar-du/rcar_du_writeback.c#L140
> 
>>
>>>
>>> Best regards
>>> Thomas
>>>
>>>>
>>>>>
>>>>> Best regards
>>>>> Thomas
>>>>>
>>>>>> +
>>>>>> +    if (!format_supported) {
>>>>>>            DRM_DEBUG_KMS("Invalid pixel format %p4cc\n",
>>>>>>                      &fb->format->format);
>>>>>>            return -EINVAL;
>>>>>>
>>>>>
>>>
>>
>> Thanks,
>> Igor Torrente
> 

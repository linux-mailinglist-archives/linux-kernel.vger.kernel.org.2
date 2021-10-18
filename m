Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551F4327C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhJRTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhJRTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:34:57 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A014C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:32:45 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id u5so9239431uao.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c16Ybt2AqXiaOhX2V1lJPOyD208pF8xRjT38M77BT20=;
        b=fd7Ivm4GRSsoYpEAYMntY7uQaqmQSojjanP9E/F+RiH3NJ0eQdNlx0weN66YmymMab
         +/5lWIyf8P6m1fhgmAsNpf1u2v7rh4/KbtsIPz+N/GkFjiN4TLHXuiBMBuz+GiFMW5nN
         CQ2zFw3Mzm/i5h0chbgScxmn/kAVPYLUhiIcLTfr+u8lxrho74ZhKBc0/Qz1vHDz+AbH
         Dqpg/+QtSCXrQs5oj4gU5xJ3TLkIFtlWOGb1B5tIrljANfYlXBiismRM0iE/a2SnS5Vb
         zLkXCp/1SZyfBLKzdR5tFqvcta82NQG0kBDsI311zn1hRd4vWbp2WaZenLlsX4Ot8QR+
         9c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c16Ybt2AqXiaOhX2V1lJPOyD208pF8xRjT38M77BT20=;
        b=AzDk4I3zK7wJe9IW8LcOAalFJ3KM2KWH0W9wxn7KiDdJJkPjcxqqT9+nGV/7btmcKn
         p4ijKeU2uZV0j+ss04JAVgNXqsZD9jvNNGZ8rN59keYD64FEV/MhhsA49MkstCcbLytR
         D55QXPTFtiCfgWf5nYgCbGbEt1hJ6M554bUqd8IP8XQLwtPl9qvbDr4oa/67u+TxRqSd
         NQGgg0M5CnrXxfvnD9yknwyLDLXnEKHy4RrBatXCI/D/XhSkrn/TaEJLoJd5kU1RKxDy
         z5KuRCpk5zS9mtyLuC4etGcyiqnH0XZmqNbuCuJYiSdyUpzPJF5DOaGPRCePpMRcUuYS
         Ii0w==
X-Gm-Message-State: AOAM530Aarx9ZVot6JMImdOzMvw7bv2kV9P3kfG/G8i6Q4Lxs7G68Ot3
        Lm6o6F0KunuC1ZQHB55j/MRFeqexSmw=
X-Google-Smtp-Source: ABdhPJyzyba6f1GxxfDfPyedB9l6vRqhnxGF48HcjXZ/DE2DFKa7lZ51htlO6aA+EukvgF+ebFnMbA==
X-Received: by 2002:ab0:5741:: with SMTP id t1mr28021168uac.72.1634585564512;
        Mon, 18 Oct 2021 12:32:44 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f4:b20b:2ce0:3c04:a56a:40cc? ([2804:431:c7f4:b20b:2ce0:3c04:a56a:40cc])
        by smtp.gmail.com with ESMTPSA id j64sm9736221vkc.6.2021.10.18.12.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 12:32:44 -0700 (PDT)
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
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Message-ID: <4d573cd9-ac1b-59d6-fb97-e5c24152892b@gmail.com>
Date:   Mon, 18 Oct 2021 16:32:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9dbd2c55-2c29-eb12-94d0-dbd5110c302e@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/18/21 3:06 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.10.21 um 19:41 schrieb Igor Matheus Andrade Torrente:
>> Hello,
>>
>> On 10/18/21 7:14 AM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 05.10.21 um 22:16 schrieb Igor Matheus Andrade Torrente:
>>>> Currently, the vkms atomic check only goes through the first 
>>>> position of
>>>> the `vkms_wb_formats` vector.
>>>>
>>>> This change prepares the atomic_check to check the entire vector.
>>>>
>>>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/vkms/vkms_writeback.c | 11 ++++++++++-
>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c 
>>>> b/drivers/gpu/drm/vkms/vkms_writeback.c
>>>> index 5a3e12f105dc..56978f499203 100644
>>>> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
>>>> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
>>>> @@ -30,6 +30,8 @@ static int vkms_wb_encoder_atomic_check(struct 
>>>> drm_encoder *encoder,
>>>>   {
>>>>       struct drm_framebuffer *fb;
>>>>       const struct drm_display_mode *mode = &crtc_state->mode;
>>>> +    bool format_supported = false;
>>>> +    int i;
>>>>       if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>>>>           return 0;
>>>> @@ -41,7 +43,14 @@ static int vkms_wb_encoder_atomic_check(struct 
>>>> drm_encoder *encoder,
>>>>           return -EINVAL;
>>>>       }
>>>> -    if (fb->format->format != vkms_wb_formats[0]) {
>>>> +    for (i = 0; i < ARRAY_SIZE(vkms_wb_formats); i++) {
>>>> +        if (fb->format->format == vkms_wb_formats[i]) {
>>>> +            format_supported = true;
>>>> +            break;
>>>> +        }
>>>> +    }
>>>
>>> At a minimum, this loop should be in a helper function. But more 
>>> generally, I'm surprised that this isn't already covered by the DRM's 
>>> atomic helpers.
>>
>> Ok, I can wrap it in a new function.
>>
>> AFAIK the DRM doesn't cover it. But I may be wrong...
> 
> I couldn't find anything either.
> 
> Other drivers do similar format and frambuffer checks. So I guess a 
> helper could be implemented. All plane's are supposed to call 
> drm_atomic_helper_check_plane_state() in their atomic_check() code. You 
> could add a similar helper, say 
> drm_atomic_helper_check_writeback_encoder_state(), that tests for the 
> format and maybe other things as well.

Do you think this should be done before or after this patch series?

> 
> Best regards
> Thomas
> 
>>
>>>
>>> Best regards
>>> Thomas
>>>
>>>> +
>>>> +    if (!format_supported) {
>>>>           DRM_DEBUG_KMS("Invalid pixel format %p4cc\n",
>>>>                     &fb->format->format);
>>>>           return -EINVAL;
>>>>
>>>
> 

Thanks,
Igor Torrente

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D861F432548
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJRRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhJRRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:43:51 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98941C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:41:39 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id q13so5365884uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ym5/eMT1XXXvSklsHO74skF3/hJuEqIN4dprBSaCf9E=;
        b=S4LHb3XCWbgzPV1akDqvFcodPhbfy611oLMG82tVycdZo0BmqWwRxucM9O6PCwk2Xg
         CgaUvFH6nqqWPbEE8C4YvmRp1gQx9baSyVj5SYtwL6L2R6tdxI0Z5MEVhaef5pU3XgSS
         Au2O0MMMc6EbTHVozrr9dlMkbSSPhP4aAYSZUqahaBjBhoJGVXFiLo+r8VdIYXSmpTy3
         Sbk05KX4tcskHXTeVZk8bqpd5/JsFEIqzEcsIlgGO0rxPdgFbCCoaqSEAyiy+so1aeai
         +Q5Ezc37uIg3hU0wb5skrAVTk4joDWHcLnMLUt2yti1kqeFqK9U+a5Mqri/DvzWSIU6Y
         w2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ym5/eMT1XXXvSklsHO74skF3/hJuEqIN4dprBSaCf9E=;
        b=MlLFAyWx7XYiC5A7GZ959kwSH9rehUs3c2qA+ju2Eke6GgC+rKy5R3uFBOxmv+R8RM
         cbHVADrMM9dADMN0kw9n07WmyZPnAdVhvv2F2FvsHqTsbLsO/IipuM1gjgWqXtRxK9Fu
         y5/Eumbt44d0IF3vFleSljNuWLbpR2/Vqn2DJ6nZ2Um0lLD52RHB/GqZg53NLJMocyNJ
         XKNcJ3N4FDFVZszCseT+XRiJFjMpNyuz/frAQf8WeRAFhjOkMEZGGD5qzVGfRkg7MuQn
         rKqrqRIwuTlPCrKOLS/nOmuH7UHescUgnFUESP/GqrzPhg01VOMZ2kIhqsTY+ncnDRzQ
         C+zA==
X-Gm-Message-State: AOAM533zqVCkZ0TUgHu0AhTK+cKtqGxVR2rYsHo3E5gmSiUFcTfO2Sxq
        3CJfFu+5IaSTZWKUDztQBIs=
X-Google-Smtp-Source: ABdhPJwVkrreUNrGZzlSHYfbkvZbdSX0JaYjnA2yIhwcsIUKdKY5FMZ3Kghll63h1r/k2LwK5KlAWQ==
X-Received: by 2002:a9f:36f0:: with SMTP id p103mr27833626uap.42.1634578898653;
        Mon, 18 Oct 2021 10:41:38 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f4:b20b:2ce0:3c04:a56a:40cc? ([2804:431:c7f4:b20b:2ce0:3c04:a56a:40cc])
        by smtp.gmail.com with ESMTPSA id 45sm9295409uaq.8.2021.10.18.10.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:41:38 -0700 (PDT)
Subject: Re: [PATCH 5/6] drm: vkms: Prepare `vkms_wb_encoder_atomic_check` to
 accept multiple formats
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com
Cc:     hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
References: <20211005201637.58563-1-igormtorrente@gmail.com>
 <20211005201637.58563-6-igormtorrente@gmail.com>
 <5507450a-eb69-b24c-9f43-a1780dafbfa9@suse.de>
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Message-ID: <e9cbdad7-416a-65fe-eb50-1cbb42a01e7b@gmail.com>
Date:   Mon, 18 Oct 2021 14:41:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5507450a-eb69-b24c-9f43-a1780dafbfa9@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/18/21 7:14 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.10.21 um 22:16 schrieb Igor Matheus Andrade Torrente:
>> Currently, the vkms atomic check only goes through the first position of
>> the `vkms_wb_formats` vector.
>>
>> This change prepares the atomic_check to check the entire vector.
>>
>> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>> ---
>>   drivers/gpu/drm/vkms/vkms_writeback.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c 
>> b/drivers/gpu/drm/vkms/vkms_writeback.c
>> index 5a3e12f105dc..56978f499203 100644
>> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
>> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
>> @@ -30,6 +30,8 @@ static int vkms_wb_encoder_atomic_check(struct 
>> drm_encoder *encoder,
>>   {
>>       struct drm_framebuffer *fb;
>>       const struct drm_display_mode *mode = &crtc_state->mode;
>> +    bool format_supported = false;
>> +    int i;
>>       if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>>           return 0;
>> @@ -41,7 +43,14 @@ static int vkms_wb_encoder_atomic_check(struct 
>> drm_encoder *encoder,
>>           return -EINVAL;
>>       }
>> -    if (fb->format->format != vkms_wb_formats[0]) {
>> +    for (i = 0; i < ARRAY_SIZE(vkms_wb_formats); i++) {
>> +        if (fb->format->format == vkms_wb_formats[i]) {
>> +            format_supported = true;
>> +            break;
>> +        }
>> +    }
> 
> At a minimum, this loop should be in a helper function. But more 
> generally, I'm surprised that this isn't already covered by the DRM's 
> atomic helpers.

Ok, I can wrap it in a new function.

AFAIK the DRM doesn't cover it. But I may be wrong...

> 
> Best regards
> Thomas
> 
>> +
>> +    if (!format_supported) {
>>           DRM_DEBUG_KMS("Invalid pixel format %p4cc\n",
>>                     &fb->format->format);
>>           return -EINVAL;
>>
> 

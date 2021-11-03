Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A26444388
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKCObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbhKCObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635949720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjCrBXWwYzBj3m1TWb42Da2qoJJrqcfHeMnXi0fhczc=;
        b=jJRai2dU4RM0+tEparQIsy8VlNos8VTqdrSBYtIrFZw/5y0eTbyygdrQQIbYDmxdrV733S
        4/Z740NgcmNgE30MAjkpOU3Tov/Fad95YsnCplfC4vEknjVxobG50/9yA6CVIeYQFbET0D
        bAofaeTCbtBiPAqi2yUZKEVNFAyXjXQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-AMqk9vJkPhqK1gjFatCYXA-1; Wed, 03 Nov 2021 10:28:39 -0400
X-MC-Unique: AMqk9vJkPhqK1gjFatCYXA-1
Received: by mail-wm1-f71.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so1151150wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wjCrBXWwYzBj3m1TWb42Da2qoJJrqcfHeMnXi0fhczc=;
        b=f1K9uDzkDTsGf2+ng/LuQTT18lvN1ngk4ECnffplJX3SbhjbXuLc64Qoz81UasHEPm
         wAOWPCdKL3o+pP65crMBUTINP9+NV+UL+DSf7MqhVc58BkXEB6UQMGfrcFKVg/Mv1CI5
         HmGO0kTCDEjOxZWMWE3FrboPjIL+EG0Qi3Wt/I+awGh3SgogRtUux582rohax8j+KNPE
         OUkMSPGkE9TgWlJ9skxBwhhHyajbVP3rEGBVA5rd+TN4LUOap6sJflU13J+ifklMW8l6
         +r+l4X0s3Ggr/H5H2eF+tafXEoVW5n+sNcd6PcNyzjFUazcl43+E0/QT2S4tyRn2PPp1
         HttA==
X-Gm-Message-State: AOAM532ZVOhc2OrIUIlDycpl4qGECtV/9b0Gt1z7J/xyX1fn6yRTjrM9
        2L4izIS3adXcXpLv2iHsh/8VMCSCiCI1lR4j7eoeUjmzACuRhV3bIdONUoTs/RdkO1FveHhBfFC
        1mmDuSsUfqqv57rBnJIWsR/6A
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr21502516wrs.270.1635949718008;
        Wed, 03 Nov 2021 07:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygbrJwATC2G/bV3PqN0MYXRcgYe3aBtB674/ombGZ2HxFPH0E2H3yEXKRBe/gbkyWGcW/pQQ==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr21502482wrs.270.1635949717828;
        Wed, 03 Nov 2021 07:28:37 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z8sm2163734wrh.54.2021.11.03.07.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:28:37 -0700 (PDT)
Message-ID: <5b4e4534-4786-d231-e331-78fdb5d8496a@redhat.com>
Date:   Wed, 3 Nov 2021 15:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 3/5] drm: Rename vgacon_text_force() function to
 drm_modeset_disabled()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        amd-gfx@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        spice-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20211103122809.1040754-1-javierm@redhat.com>
 <20211103122809.1040754-4-javierm@redhat.com>
 <eddc2967-8355-b64a-79d8-6c1cda1bc732@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <eddc2967-8355-b64a-79d8-6c1cda1bc732@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 13:57, Thomas Zimmermann wrote:

[snip]

>>   
>> -	if (vgacon_text_force()) {
>> +	if (drm_modeset_disabled()) {
>>   		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
> 
> Please remove all such error messages from drivers. 
> drm_modeset_disabled() should print a unified message instead.
>

Agreed.

>> -static bool vgacon_text_mode_force;
>> +static bool drm_nomodeset;
>>   
>> -bool vgacon_text_force(void)
>> +bool drm_modeset_disabled(void)
> 
> I suggest to rename this function to drm_check_modeset() and have it 
> return a negative errno code on failure. This gives maximum flexibility 
> and reduces errors in drivers. Right now the drivers return something 
> like -EINVAL, which seems wrong. Returning -ENODEV seems more appropriate.
>

Good idea. I'll do it in v2 as well.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


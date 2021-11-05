Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208494461C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhKEJ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232978AbhKEJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636106144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ67s9sbnfsD5fqdtGG0nGBmSdAaIG5RWNWBFufx9E8=;
        b=TkztJmfb0Z4d5Q7UrtQL+DyWHuqpVNqfrdsLFZ+WiVfpGFPuMhNLrJ6F0nv5PsMlaarAZb
        Vygb0wLA0cRBG+/tiSf4jFiiLaL74ejFHMHrXXXujjjbzKMNx7ZJmLQBW7khPh6LFcMIPc
        JR7ikaxBoCVEu4dcI2OiMs+xAg75I6U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-KY2IodOMOyqpx61B_ZcBWA-1; Fri, 05 Nov 2021 05:55:43 -0400
X-MC-Unique: KY2IodOMOyqpx61B_ZcBWA-1
Received: by mail-wm1-f70.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so5481195wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 02:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oZ67s9sbnfsD5fqdtGG0nGBmSdAaIG5RWNWBFufx9E8=;
        b=Kl5ULJwzCBpF7ItfAQDGi7nYfQZuuFvIZaUzQ6pOWtjYND3Z36UoWXZpd/yyiCsANx
         oe72ACV5CNsghN9b5WXbLF2OvRcnUsNI9wn6ncWC3m3G2Bh6ZtSfFqfcg7xizJV1R5OE
         1DeeaVPVGSFAPHDKB1alhf2tJqYd/z0GX+gKSDGJHq79z7o++32SREER82Ku2gdqEsV2
         5DC5ISi7Et+2qZWLwEtq9dzF0l4WYsuIjKljj9HASI/6it2ECmRyV8+CpQScG+/se3+c
         8wy+3DZeA4iO37rlkkYIXbOC6YgcSmlxGmrTpToiWmEGlW4Aai4gkKSomFNzv8ZbRlL4
         KNow==
X-Gm-Message-State: AOAM532m3d1aZnsdbEXKU5588IdiPybii6grqCIEM18aBwKPCAg1M56d
        R7N8UMBMgkJQTFeztaH0Phneur/OqGWXzV+y0S9JI0K3hpKDDqkQZErz+FfSB2OTlJilrYYANtl
        vmpGOacHgC/eOndCzeN1+pRGg
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr27635759wml.146.1636106142130;
        Fri, 05 Nov 2021 02:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT8viACi1U7JY5S3rkG/MaHma60ZlmQ0NQODpS8eTcPcWv9ZvZPYhizNzNYarjDaHcIaJjnA==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr27635740wml.146.1636106141897;
        Fri, 05 Nov 2021 02:55:41 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s26sm5390804wmc.0.2021.11.05.02.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:55:41 -0700 (PDT)
Message-ID: <847c2315-b4a2-3bd1-e048-4263b5f496ed@redhat.com>
Date:   Fri, 5 Nov 2021 10:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] drm: Move nomodeset kernel parameter to the DRM
 subsystem
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-3-javierm@redhat.com>
 <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 10:00, Thomas Zimmermann wrote:

[snip]

>> +
>> +static int __init disable_modeset(char *str)
>> +{
>> +	drm_nomodeset = true;
>> +
>> +	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
>> +	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
>> +	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> 
> I'd update this text to be less sensational.
>

This is indeed quite sensational. But think we can do it as a follow-up patch.

Since we will have to stick with nomodeset for backward compatibility, I was
planning to add documentation to explain what this parameter is about and what
is the actual effect of setting it.

So I think we can change this as a part of that patch-set.
 
>> +
>> +	return 1;
>> +}
>> +
>> +/* Disable kernel modesetting */
>> +__setup("nomodeset", disable_modeset);
>> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
>> index 45cb3e540eff..c890c1ca20c4 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -4,8 +4,6 @@
>>    * Copyright © 2021 Intel Corporation
>>    */
>>   
>> -#include <linux/console.h>
>> -
>
> These changes should be in patch 1?
>

Yes, I forgot to move these when changed the order of the patches.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat


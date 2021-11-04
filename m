Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A334452BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKDMOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhKDMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636027900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4AdwkaPbMWXGax5KA2rt+Gqe0a1WXxhr6YwLEgt8I0=;
        b=GgSG1M7REVOd9hgk/YlLKOf8NBXt9IAEVdhE12Wr7BrVfaMo5pZVehE3cJhR+TOT425K6s
        cpvMLk7LWEbxmxSJnid1T9Df24oXWMbOY5od4hsrIqSYJrkUSbIRJJy0h2y4lmgUcp8Hv8
        J4tu7eVSAAG1y9lZIOXkRyEJ4fBAr2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-xt3eyZuLONGoM47TacVbag-1; Thu, 04 Nov 2021 08:11:39 -0400
X-MC-Unique: xt3eyZuLONGoM47TacVbag-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so958294wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 05:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4AdwkaPbMWXGax5KA2rt+Gqe0a1WXxhr6YwLEgt8I0=;
        b=RLol2nMmDizIvIJMqwr32Epj+a4+7UVc3faRPNiABAbdwbNVdTE7Y0psPn7wlaoA3t
         Eh09m6tcb/1lDBkIVr9hTkiGmCa+12FZP0bsHWU9Y91A7n2X5zAJ76J30LuxeYZ1+kio
         uYcOtZDPMQYzBxF8Sq4OxhLUvngqtLT2uyB8HEBWZgt03SUHc6RhfcplnJNBjYq3vIOj
         b6prE8nykp6qHRloyub3UcFOgZsc2E5RPVXXvsBm/9ixMbO1QaN+VgE4gFsEk3zz7lgc
         SqsdKcqdsC08GeyBTOq8OkAFdSe8gbit9EQfZvMm+dLbwIDestuwjqsVMyw5Z/PIcpBH
         Pc8g==
X-Gm-Message-State: AOAM531iuXldq2so7ZoxbpSPBLP29DJvcwAmRQL3nrjRYSxARDPL0E50
        vBrimG8SGs7CqgrSdIhmiZuYsTAdcOwvMLPEoC9EOrvEoeMlJvoyFKnrZh+QxkIUR23KUb9F8Pa
        t89xEUbTHEXq2znVV0fr2V0uN
X-Received: by 2002:adf:df0b:: with SMTP id y11mr39858302wrl.181.1636027897551;
        Thu, 04 Nov 2021 05:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqjM2sqm4+v2bQK0eMMRayg/y3fRlX2oxxNi5kHRob7ai2dH72Yu+LW42MTv2MDIAJ+D0ErQ==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr39858269wrl.181.1636027897338;
        Thu, 04 Nov 2021 05:11:37 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h13sm5041912wrx.82.2021.11.04.05.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 05:11:36 -0700 (PDT)
Message-ID: <394db9f5-79f1-495c-f0a8-fac3af5f8e25@redhat.com>
Date:   Thu, 4 Nov 2021 13:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 4/5] drm: Add a drm_drv_enabled() helper function
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>
References: <20211103123206.1041442-1-javierm@redhat.com>
 <87o871bbmb.fsf@intel.com> <54aedf5a-34b1-15f6-47f1-39815b3832ae@suse.de>
 <87bl30b2h3.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87bl30b2h3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani,

On 11/4/21 12:10, Jani Nikula wrote:
> On Wed, 03 Nov 2021, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 03.11.21 um 14:41 schrieb Jani Nikula:
>>> On Wed, 03 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
>>>> DRM drivers can use this to determine whether they can be enabled or not.
>>>>
>>>> For now it's just a wrapper around drm_modeset_disabled() but having the
>>>> indirection level will allow to add other conditions besides "nomodeset".
>>>>
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>>
>>> Can't see i915 trivially using this due to the drm_driver
>>> parameter. Please let's not merge helpers like this without actual
>>> users.
>>
>> Can you explain?
>>
>> This would be called on the top of the PCI probe function. The parameter 
>> would allow to decide on a per-driver base (e.g., to ignore generic 
>> drivers).
> 
> Where and how exactly? This is why we need to see the patch using the
> function. A patch is worth a thousand words. ;)
>

Thomas suggested to squash patches #4 and #5 so I'll do that when posting v2.
 
> See current vgacon_text_force() usage in i915/i915_module.c. It happens
> way before anything related to pci or drm driver. Why bother with the
> complicated setup and teardown of stuff if you can bail out earlier?
>

Yes, most drivers use vgacon_text_force() in their module init callback.

The ones that do in their probe function are drivers that don't have a
module init/exit but just use the module_platform_driver() macro.

I won't modify that and will keep the bail in the same place that the
drivers already do. I hope to have time and post a new revision today.

> 
> BR,
> Jani.
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


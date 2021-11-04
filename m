Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0A445AF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhKDUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhKDUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636056559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRdrRlX7d6jR9XJ1WlJwuA/7L4WdNGNHCwwgPSMtrew=;
        b=dDewa/LtGBJX7ac4fwngfqrK3V0fYBgwe+JLjd8GGTEQ1eZqtvHimZmHkNb2MWId6OpMe4
        HTZd/hQxjMhhf1/oCMVhZIyNr1OO3vGG7gUcU+MqTAZyqMZM+UmA92DYXS5vxkJy3HaJHG
        WZC+ZVdbavgqa5ilcXPTOemEuhnqZWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-CyVjZpq5NbmvRtCbemev9w-1; Thu, 04 Nov 2021 16:09:18 -0400
X-MC-Unique: CyVjZpq5NbmvRtCbemev9w-1
Received: by mail-wr1-f69.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso1399277wrj.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WRdrRlX7d6jR9XJ1WlJwuA/7L4WdNGNHCwwgPSMtrew=;
        b=cQIb5tEQ3Q8xNncN8Fjk6N7x3Qk3MnMiA7OON8Agy45urCSTByWYNPP9Q2bG5z4IPW
         T54GQmaQ6280ErlaZUrVJgieYC4sapPeWmqDuNMpdv19Yhev5GrYEmeRTpr624EFd4XK
         CxSl1n9ELh3aW0UOAvWN3z4fRjQaCTUCQdRQIlJ2qxGuXAtTcdAErHj2ttuSViA2T/yy
         9jJyJQVYIe3ZPkyW0IHksNWM7XhmgeBxHBPP7m5ZUdhN8DTFTl7d0/9hIQsZ6BgrqiA+
         Eepz1MBgNk/8bHFRXa/wWdW665l/NJEgZriVtmkef/7oEcwGcoVEhWt7q7e3Rq8X1BqQ
         AsKA==
X-Gm-Message-State: AOAM532y0AgFEkslA5Eka11Qf+aeWq20Wol8ROQ7GkSELFi9jUVLyBBS
        30jW4zQ80tE7RIdGuCxliwpjYpsyhxKdb/RCASnXijnRLcHDCg7PyxPnFhEnO5bB6l1FCvlPx4C
        4Ud9mi0HCqkAyAI5vUSmCB+dt
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr26040179wmh.86.1636056557044;
        Thu, 04 Nov 2021 13:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy76MY/85Rr56RxIxfOCWbJkdVKLFu3k+Td/GsoIreVUO3gSrCM0LaAND1RBuRZ0S+UgTUN+Q==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr26040146wmh.86.1636056556830;
        Thu, 04 Nov 2021 13:09:16 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z15sm6028960wrr.65.2021.11.04.13.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 13:09:16 -0700 (PDT)
Message-ID: <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
Date:   Thu, 4 Nov 2021 21:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87ilx7ae3v.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani,

On 11/4/21 20:57, Jani Nikula wrote:
> On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
>> +/**
>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>> + * @driver: DRM driver to check
>> + *
>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>> + * if the "nomodeset" kernel command line parameter is used.
>> + *
>> + * Return: 0 on success or a negative error code on failure.
>> + */
>> +int drm_drv_enabled(const struct drm_driver *driver)
>> +{
>> +	if (vgacon_text_force()) {
>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_drv_enabled);
> 
> The name implies a bool return, but it's not.
> 
> 	if (drm_drv_enabled(...)) {
> 		/* surprise, it's disabled! */
> 	}
> 

It used to return a bool in v2 but Thomas suggested an int instead to
have consistency on the errno code that was returned by the callers.

I should probably name that function differently to avoid confusion.

But I think you are correct and this change is caused too much churn
for not that much benefit, specially since is unclear that there might
be another condition to prevent a DRM driver to load besides nomodeset.

I'll just drop this patch and post only #2 but making drivers to test
using the drm_check_modeset() function (which doesn't have a name that
implies a bool return).

> 
> BR,
> Jani.
> 
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


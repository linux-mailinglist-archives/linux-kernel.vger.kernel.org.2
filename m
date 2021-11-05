Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86A244618D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhKEJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232616AbhKEJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636105723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDCxTaiuFN2oEnFyA/uNKzyzy5BqHnuVtliUgcTwAYg=;
        b=iqXTa6FOGtUvh6h+YYv36T8RGq9SRYaq+dSxItGpN2pTj5bv9i3iRw+N5B7yWea0Rw/O3i
        tx54caYUf54cTuXxSYRj5x2Qfs2liPADIi/warL/yJaaShKyIkpQGl7f5gcf6Wc6t+Fctn
        qeh1dWuclLaeOkeAbnTiqWVOo6W9PaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-omYIjQNFOxiGzWvdmDHTzQ-1; Fri, 05 Nov 2021 05:48:41 -0400
X-MC-Unique: omYIjQNFOxiGzWvdmDHTzQ-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so3114352wmj.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 02:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TDCxTaiuFN2oEnFyA/uNKzyzy5BqHnuVtliUgcTwAYg=;
        b=M7XE8BV2mhxwS/A1k6u2Tu/TYa7j13UozKqog8U3SxJeZ7cs8zGAepp3SdxEHvqFhs
         +DZYJIcrhjvnISei9ELPZO6jiif9dNO+XN9vz0Jo46JnxmiTx6T5mWreihIFsO4ZZr1n
         CaVB05wmKnhvyxN9In+BPHH1AMVRjGweA8ntPadtp9AVE0FkSxJHq02+c6FHob/MTeTc
         SXqa6Y9/Fs0jxP9zpHuzH6PN/ZiDsU8Q93+4ulsZg4pAgNSC7qy8jvJQ51O6rZRO4PBZ
         U2UWVdqCSQNi6ToDpf+3fk6IS/o2gnXeClgTQZSZbc+eSjN6Bsd3Iq0yRVzS7QAxy0Cd
         uaHg==
X-Gm-Message-State: AOAM531sMZlew89upZ2ZiF5jOjzDAi5dLvbgMhqLCcz1t1uLfj5krjXn
        VWPwlAd9moYfeaIYrTeQwD9MqKN1BgzYstzylgvkKxzk6NB0riSC5nKLAJZ2fIujvkUGnOjDMPX
        oKzs3k6/E3LWbLCXX20lmToYE
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr47457544wrx.64.1636105720564;
        Fri, 05 Nov 2021 02:48:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAy5NPgcgZDunmEq87tVcIv6+r2xtRAUkaFqPrEIO+dNAeu5S620buzaYA0spdyOnq5mk7Jw==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr47457520wrx.64.1636105720304;
        Fri, 05 Nov 2021 02:48:40 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id u20sm6503643wmq.6.2021.11.05.02.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:48:39 -0700 (PDT)
Message-ID: <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
Date:   Fri, 5 Nov 2021 10:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        amd-gfx@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        virtualization@lists.linux-foundation.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        spice-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
 <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
 <d4a64906-69e5-3250-2362-79f2afac0a23@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d4a64906-69e5-3250-2362-79f2afac0a23@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 11/5/21 09:43, Thomas Zimmermann wrote:
> Hi
> 
> Am 04.11.21 um 21:09 schrieb Javier Martinez Canillas:
>> Hello Jani,
>>
>> On 11/4/21 20:57, Jani Nikula wrote:
>>> On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
>>>> +/**
>>>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>>>> + * @driver: DRM driver to check
>>>> + *
>>>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>>>> + * if the "nomodeset" kernel command line parameter is used.
>>>> + *
>>>> + * Return: 0 on success or a negative error code on failure.
>>>> + */
>>>> +int drm_drv_enabled(const struct drm_driver *driver)
> 
> Jani mentioned that i915 absolutely wants this to run from the 
> module_init function. Best is to drop the parameter.
>

Ok. I now wonder though how much value would add this function since
it will just be a wrapper around the nomodeset check.

We talked about adding a new DRIVER_GENERIC feature flag and check for
this, but as danvet mentioned that is not really needed. We just need
to avoid testing for nomodeset in the simpledrm driver.

Do you envision other condition that could be added later to disable a
DRM driver ? Or do you think that just from a code readability point of
view makes worth it ?

>>>> +{
>>>> +	if (vgacon_text_force()) {
>>>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>>>> +		return -ENODEV;
>>>> +	}
> 
> If we run this from within a module_init function, we'd get plenty of 
> these warnings if drivers are compiled into the kernel. Maybe simply 
> remove the message. There's already a warning printed by the nomodeset 
> handler.
>

Indeed. I'll just drop it.

>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_drv_enabled);
>>>
>>> The name implies a bool return, but it's not.
>>>
>>> 	if (drm_drv_enabled(...)) {
>>> 		/* surprise, it's disabled! */
>>> 	}
>>>
>>
>> It used to return a bool in v2 but Thomas suggested an int instead to
>> have consistency on the errno code that was returned by the callers.
>>
>> I should probably name that function differently to avoid confusion.
> 
> Yes, please.
>

drm_driver_check() maybe ?
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


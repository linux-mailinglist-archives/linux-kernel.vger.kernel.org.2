Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C743CA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbhJ0NUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242081AbhJ0NUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635340690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0knKn4vlSSXJNLziODRiT1VCKABnqaDy5uuDBcVhuU=;
        b=R23NAdCrOUN6asoivg6xqFbbZoqmAjEg3mpo97PyQuhxOqMATgi+BQQUi9qnxUmYW9sIzr
        xlGau06jAsUTiLhyoJ6115l3+R3mePsA6bqiF2nLj10vrJmVv43wtiWFT9aUw2w3s5u8fG
        oJvz/Am5MDhxmUX5vI0syLe7A8QDRiM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-77DGL579OHCuOSGS4fIKFA-1; Wed, 27 Oct 2021 09:18:06 -0400
X-MC-Unique: 77DGL579OHCuOSGS4fIKFA-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so1258339wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T0knKn4vlSSXJNLziODRiT1VCKABnqaDy5uuDBcVhuU=;
        b=2oRhtk4xswdmgbph7YVUinR9MisEBgjXxccz3AZ8Wg0sY5zIkEvuHTPjzpuKEUiII/
         xmrq426t1BZQtP7/MAgKxPkwaLg8mtQ1Oej8X/OdLjg3Y/rLzrtCi/LVBTDp8dYdJKg8
         GtDZQI32uOu4oxcPZo45Rs/OD933NZrw8pmfKc6klSTjC88SW2oEl9gGs4lPZOqiBd89
         Xpx+MznPQJgnyBaEDQ354dydMyfliDi4ln635chXAE7uhzgsIA0ISXAL2jbKlNH2E4bs
         kNN1EsmG/wIEdcRLA+J5UHGP2wcNT8OI7P4vQttHl9cT13QP7MiUWkLJDmI1Raqao1A+
         24qQ==
X-Gm-Message-State: AOAM533RUuA3HoDL+VkTE0AwhYpZ97u1A+xaOX7pmkDkAaEZZucTkLMg
        DTyVzMgdeFAKs3F53pFk+64c/z48VVyc0bQfu5Frcvp+DnPWvOx7vkYh/Cm2dkqTbARr/dFqWKF
        /qBLzgbkHYTJVnkJMJSdCXvTa
X-Received: by 2002:adf:f904:: with SMTP id b4mr40692308wrr.403.1635340685718;
        Wed, 27 Oct 2021 06:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkN+ouoRwZcIXIo4nO3GPnaT6BwP+6Gy2W0VoJk+RIw7SPLg61t2NykMicE+Lxtab8AZLmqQ==
X-Received: by 2002:adf:f904:: with SMTP id b4mr40692273wrr.403.1635340685540;
        Wed, 27 Oct 2021 06:18:05 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o1sm1872624wrp.95.2021.10.27.06.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 06:18:04 -0700 (PDT)
Message-ID: <76763f5e-8c37-c36a-8f64-af3efe0da254@redhat.com>
Date:   Wed, 27 Oct 2021 15:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210927142816.2069269-1-arnd@kernel.org>
 <202109270923.97AFDE89DB@keescook> <YVXJLE8UqgcUNIKl@phenom.ffwll.local>
 <878ryeit9i.fsf@intel.com>
 <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com>
 <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com> <87zgquhbjx.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87zgquhbjx.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 14:55, Jani Nikula wrote:

[snip]

>> Why the dependency has to be in a user-visible symbol? What could be the
>> problem with having something like:
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index cea777ae7fb9..f80b404946ca 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -82,6 +82,7 @@ config DRM_DEBUG_SELFTEST
>>  config DRM_KMS_HELPER
>>         tristate
>>         depends on DRM
>> +       depends on (DRM_FBDEV_EMULATION && FB) || !DRM_FBDEV_EMULATION
> 
> To me, this seems like the right solution. Depend on FB if
> DRM_FBDEV_EMULATION is enabled. That's exactly what the relationship is.
>

The problem as Arnd explained is that then this relationship will have to
be expressed in all the Kconfig symbols that select DRM_KMS_HELPER.

Otherwise the symbol will happily select the wrong state and even when a
warning is printed by Kconfig, it will just set an invalid configuration.

For example with CONFIG_FB=m (that led to the linker errors if the symbol
is also not CONFIG_DRM_KMS_HELPER=m) and CONFIG_SIMPLEDRM=y (that selects
CONFIG_DRM_KMS_HELPER), this would cause the following unmet dependencies:

$ make prepare modules_prepare
WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
  Depends on [m]: HAS_IOMEM [=y] && DRM [=y] && (DRM_FBDEV_EMULATION [=y] && FB [=m] || !DRM_FBDEV_EMULATION [=y])
  Selected by [y]:
  - DRM_SIMPLEDRM [=y] && HAS_IOMEM [=y] && DRM [=y]
  Selected by [m]:
  - DRM_I915 [=m] && HAS_IOMEM [=y] && DRM [=y] && X86 [=y] && PCI [=y]
  - DRM_VIRTIO_GPU [=m] && HAS_IOMEM [=y] && DRM [=y] && VIRTIO_MENU [=y] && MMU [=y]

so CONFIG_DRM_KMS_HELPER will wrongly set to =y which will cause the issue.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E3B43C9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhJ0Mla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241934AbhJ0Ml3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635338343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drsID2TRJVUaimjxFLYNgX49ECeQkuI1bTTLrAYGzWs=;
        b=iIYrjlHDQ/CfMflDyQhjEWmcXCyN7lJBsHxHBZ9ZkqHHrziEqpTR5p8n94LE/jFsWWcuXy
        1v0Ddk8fzzSIIIi5ceNPUVnN1PndZLqDGAtwwORbKlKoiAvu1jar1OyzYEjKQ500Qbg6JM
        3hjKOxFyp0SZWg+HaquvSUcMGpkxcs0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-j1QcE4LFMq-d69YCql3Scw-1; Wed, 27 Oct 2021 08:39:02 -0400
X-MC-Unique: j1QcE4LFMq-d69YCql3Scw-1
Received: by mail-wr1-f69.google.com with SMTP id b8-20020adff248000000b00171bceb5139so576724wrp.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=drsID2TRJVUaimjxFLYNgX49ECeQkuI1bTTLrAYGzWs=;
        b=0sq1rCl1W4iO/P9axPZqITwE04cfqUf2GnjShe8Jazk/d1rrowFVLHOcGWsKpXw34B
         7emJAfKQPnotjx80ZpzkXlNn1xHQiJMg4rY+3RhbtcrYugKcaAnu9qJj6ZPyCTkyET7Y
         Xjr7SQXMYv+HQgdrmAw40LjdmOCW8UGWoyuhJmDNV6J4Gh3ElCa5ay8KTQeWw9bXb/pz
         fztEtMMQKIpLVp5aawqfEACyR871qiS4lcpznqlxJxbWzqkmshFl9Wwq223zO5izrzvI
         0wQgdXnt4tKy5Gc3r/cXLeS8V07v/Ep3C1Io9LnKwqts9gYLBmh0uJbkEz34M/5k+W2+
         tHMw==
X-Gm-Message-State: AOAM533SRyWLBEUUAPSB/pK4TYUkBOmghNm6qIPD9Kd2nrhyXJSklgQ0
        LvNy4Fd8DMEcn+h+j00cHmUt+tcLSAvAFQsG2RoPpazDP5HM8mVUpU8gjzYGGWHdkv1E58NVDjl
        iP0+9Rl9yWxisc2zyIWVGjD9H
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr5435389wmq.21.1635338340729;
        Wed, 27 Oct 2021 05:39:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyUJYUQHFPGEeeUWW5qt0iGapKxZCX79kADIwOLF8bb3nuqrjxlX05B8T42yC9cOdOmlpfFA==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr5435373wmq.21.1635338340545;
        Wed, 27 Oct 2021 05:39:00 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id r10sm14579669wrl.92.2021.10.27.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 05:39:00 -0700 (PDT)
Message-ID: <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
Date:   Wed, 27 Oct 2021 14:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 14:18, Arnd Bergmann wrote:
> On Wed, Oct 27, 2021 at 1:47 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:

[snip]

>> drm_fb_helper.o is not part of drm.ko, it's part of
>> drm_kms_helper.ko. This adds some sort of indirect dependency via DRM
>> which might work, maybe by coincidence, maybe not - but it's certainly
>> not obvious.

Indeed, you are correct that's not semantically correct.

> 
> Right, how about this change on top?
> 
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK
> 
>  config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
> -       depends on DRM
> -       depends on FB=y || FB=DRM
> -       select DRM_KMS_HELPER
> +       depends on DRM_KMS_HELPER
> +       depends on FB=y || FB=DRM_KMS_HELPER
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
> 
> That would probably make it work for DRM=y, FB=m, DRM_KMS_HELPER=m,
> but it needs more randconfig testing, which I can help with.
>
>> The likely culprit is, again, the overuse of select, and in this case
>> select DRM_KMS_HELPER. And DRM_KMS_HELPER should depend on FB if
>> DRM_FBDEV_EMULATION=y. That's the problem.
> 
> This is something we can't easily express in Kconfig, as we can't add the
> dependency to a symbol that only gets selected by other drivers, which
> is why the dependency has to be in the user-visible symbol,
> in this case DRM_FBDEV_EMULATION.
> 

Why the dependency has to be in a user-visible symbol? What could be the
problem with having something like:

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index cea777ae7fb9..f80b404946ca 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -82,6 +82,7 @@ config DRM_DEBUG_SELFTEST
 config DRM_KMS_HELPER
        tristate
        depends on DRM
+       depends on (DRM_FBDEV_EMULATION && FB) || !DRM_FBDEV_EMULATION
        help
          CRTC helpers for KMS drivers.
 
@@ -104,7 +105,6 @@ config DRM_FBDEV_EMULATION
        bool "Enable legacy fbdev support for your modesetting driver"
        depends on DRM
        depends on FB
-       select DRM_KMS_HELPER
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


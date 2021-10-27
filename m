Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9843CAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbhJ0Nip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236811AbhJ0Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635341778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGAgU8sFMkBfN+ogQRdoDOKIrf4t8BDQtiu9bep9LTI=;
        b=hQoeRy+jN7oVuC/v41gMde8H9K8u5d8NGCY5ZvsOxsC7wfufnDJg9Fr8LfF5ZETXbEK2MX
        sT1GXAF+KEmOU5j+Z1TDuv+PRFmH2KNuWA2KgNZG/OY3OYXzZlcnIiuzKQSUGcRuscVUEH
        PYx0WACj2OtiAjPnFU5FTTauxtHx6xQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-uPCqBlzrOzO6KjgpBTBdcg-1; Wed, 27 Oct 2021 09:36:17 -0400
X-MC-Unique: uPCqBlzrOzO6KjgpBTBdcg-1
Received: by mail-wr1-f69.google.com with SMTP id i8-20020a5d6308000000b001742659b50eso254280wru.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HGAgU8sFMkBfN+ogQRdoDOKIrf4t8BDQtiu9bep9LTI=;
        b=pqiFTvG14iKXTbB+zul4pr58Wdvb79YyyQ71V6vpta9XngiI3Qa7aFoi7RsyWAdbgt
         EsTD5W+nAlzPcEEVlDPMxldrp7UeGoqh0SbAjpmU5agTO9Vn7klUZo3i+MEgCSh2izYy
         JsUqY4CvIb65moidOQgo2OEXRWzCM9CpkFmO4RDZzviozFybqU8uCR7wSBIVjf6SJKCj
         1q94SdR2hn4mhT3rk22r7tXkb9UAj7m0BpJF+o0K8rx3wQL/sieRbrLO15j0HRdIzZO7
         Vyurit3SbvNm/HmAlajv+prX+baDMV3tKg2RgTjwYC80G82Pn9tUoLU0sHf8PHkKsK9E
         C3/g==
X-Gm-Message-State: AOAM531G27C+SXQpc2I+/7Fc8XyUJFbSklX1LP1aIZ3pKtP7wIHfMVvy
        cHEWSJGPJccc6ntl9UmNXUjvS8s8hTp3dv/nBcIkfWamMkbfdvMlCL6dpNnJgASakr0mnjr/3IS
        t1n5GVgMKoN/jEF/hJmxr2GP3
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr5705931wmq.173.1635341776269;
        Wed, 27 Oct 2021 06:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbmPrH9Z0DjjdY9RmSwXuXV5NSvYIJTaNRAESht+qDYjmHT9FSA7ryojF0uBa4uPXN3oLe2w==
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr5705891wmq.173.1635341775997;
        Wed, 27 Oct 2021 06:36:15 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id k63sm3534742wme.22.2021.10.27.06.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 06:36:15 -0700 (PDT)
Message-ID: <d243edae-9d3d-1a00-3dcd-c4c2d1fb02cd@redhat.com>
Date:   Wed, 27 Oct 2021 15:36:14 +0200
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
 <3604fb90-f6c3-0fa2-c864-7f1795caee1e@redhat.com>
 <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
 <87tuh2hb17.fsf@intel.com>
 <CAK8P3a0KHwaSNqg_dz8-w6e_EJBrsQw_ti+5aErsSr+8AfV9cA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAK8P3a0KHwaSNqg_dz8-w6e_EJBrsQw_ti+5aErsSr+8AfV9cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 15:25, Arnd Bergmann wrote:

[snip]

> That's not going to help in this case, the way the helper functions work is that
> you select them as needed, and you avoid the other dependencies. This part
> works fine.
> 
> We could probably get rid of this symbol by just making it an unconditional
> part of drm.ko, as almost every driver ends up using it anyway.
> 
> Arguably, this would make the end result worse, as you'd again get drm.ko
> itself to link against the old framebuffer code.
> 
> What I'm not sure about is whether drivers/video/fbdev/core/fb.ko could
> be split up into smaller parts so DRM_FBDEV_EMULATION could
> only depend on a set of common code without the bits that are needed
> for the classic fbdev drivers.
>

I attempted to do something like that but the changes were nacked:

https://patchwork.kernel.org/project/linux-fbdev/list/?series=538227
 
>       Arnd
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


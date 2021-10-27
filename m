Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8F343CA74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhJ0NWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231793AbhJ0NWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635340779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmBW9ZsJpllmwuQ41q44efrPHGVrMnFkjaAV59vBkn8=;
        b=cVlKWgagN2DgVmhCKGzKcxOueBTLdNwFe/6nBOpuar/2BbNyYv7JcWInmbVGtfBPoV944V
        6W00k39aHBo1I2epvnBgoIvFwhq2zrxi8x7LPPxKBiZ6iUSm3KBLZzEUbMBuIcxjInbju5
        uIf/G/Y8OAL1dItlEvu7w4SRfiAejC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-uJKiHmwVPzW8gFYxXTYs8Q-1; Wed, 27 Oct 2021 09:19:37 -0400
X-MC-Unique: uJKiHmwVPzW8gFYxXTYs8Q-1
Received: by mail-wr1-f71.google.com with SMTP id a15-20020a056000188f00b00161068d8461so660463wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NmBW9ZsJpllmwuQ41q44efrPHGVrMnFkjaAV59vBkn8=;
        b=xAY4+GomNPzAFp7u3IYhktKUrquFW0jyx9S96uE6YoINPEOqpoRtNVFUYJMwQvzGP7
         U8QB/XVq+B3HR94F49BygyXtWZWC217W0ZdmigrNXQGuNCUiZYQtPuhOlCaDS+q0IHm1
         1TJ8L4hb413XOz33yBE1gW9xkcJoMOIdapHGr9N7cXsay1CZoamwB9lwQuPb8w2XIbXE
         3Q2H8BEYxPbbfkIG1Utr2OgwGPlBQHceEw/UDHD+wJWXB3HJI34nNW8rP25M8Se56QgL
         z4P3R0o20gmSKRgQ8l/TM+4OkiY30NwJxLCW52A9Fx/6FL0CAoovzxfm/9KjfwX63xHA
         Z83A==
X-Gm-Message-State: AOAM5331t64D5EOu4FnUTqEMkV3V7JNQBmMXeTUHFe421HPfvo5DtWDR
        hQFr11k/iqLCNwp4jGPkUgOmNYiMu5OPaVeexAYH+lguk15nM1zGYsJWW1fjEUNBZRhsfznSyE/
        vyHtQuxXd4oQEl0UXSm4QzvUL
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr5937765wmj.98.1635340776734;
        Wed, 27 Oct 2021 06:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGZ+C2x7YeFPeS66m8A33fG4z3y9tcXC+XOvNQf+SJwdpIXNQgevr3zC4K6F099z9lmcXR2A==
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr5937727wmj.98.1635340776362;
        Wed, 27 Oct 2021 06:19:36 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id x21sm3415372wmc.14.2021.10.27.06.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 06:19:35 -0700 (PDT)
Message-ID: <ca11cd15-3877-468b-c6b7-9022b6b11824@redhat.com>
Date:   Wed, 27 Oct 2021 15:19:34 +0200
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

[snip]

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

Looks good to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


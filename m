Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E743CA32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhJ0M67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235988AbhJ0M66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635339393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dV1Z80ykRADd512OHhKXIV+1XGUp97f6U0RAWP3BwzU=;
        b=cOELT0zGVbEYEJOPWA/AYrrSygxSf/BwaqQlL12f50gQTuNZ/xzOjDz+Djxjcz6Cj65FV9
        iEHt0Y3ugj0nu2AXXsZVGj316hR8Jp5FO64Yu7+9XOPOoH1AKptyfG/Ypr6/lmTVQo/96n
        S48iNnLxZXAqlThI2Od9g8iKhbIIpqY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-SZeQhNroO8igP6qaWeVcTA-1; Wed, 27 Oct 2021 08:56:32 -0400
X-MC-Unique: SZeQhNroO8igP6qaWeVcTA-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so1232909wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dV1Z80ykRADd512OHhKXIV+1XGUp97f6U0RAWP3BwzU=;
        b=lPaS/isdAjvf2qGj1syyqF0OFGi86AqOkZaB32QKhvp5AopQ/UHfCQBfOyu0vLKIEM
         iLxCMecjHaWdOpqcbwOwx6MOuXjihHyy+SUgjJN/rceSYV7P+GdKKmqMt+lw0m38T1xX
         yPpf2Ic5dLPSB5wxL8I83KxPkgXZTjduq9okkw+AhWsgnprZLQIF1alRVav3aZHUtcsF
         lpLq5SRW5HWlKDuuUp8WdOzSjJISOq4fSVsYWLDx+Ph/hMENGfJP6Oa0WQxRJKIN7i79
         exRG6nyluoPmzqmk1jJB5ww6iMTd8BEZsBEH6fE1+8YSC1gKLG2Ks8XEQLpi6FYZST4c
         +CyQ==
X-Gm-Message-State: AOAM5311vxaBkwOmCAE2NhjPa4lQ0Uk0BotFejl8qRa4bpxqZG1FiW9z
        +qgW+b+v1qRamwcXA9u+31/pESfXBjss7KqpueU1suPkYpQy44BuZ2GDbGV4U9hqrB1vWW+5GvJ
        FidkDwEKN33CCdJezVPz7PjbW
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr1219570wrr.11.1635339390576;
        Wed, 27 Oct 2021 05:56:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKaVjORReycoaANOAduGQwiJYFkPr9IAe/CbTP2Q74FGscfijWFU6rg2CScZQ7+TQK5c04xw==
X-Received: by 2002:a5d:43c5:: with SMTP id v5mr1219550wrr.11.1635339390425;
        Wed, 27 Oct 2021 05:56:30 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id x2sm3349278wmj.3.2021.10.27.05.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 05:56:30 -0700 (PDT)
Message-ID: <5a01bedd-9150-b23c-7e2a-08d2e7da0fe6@redhat.com>
Date:   Wed, 27 Oct 2021 14:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAK8P3a0_9U0MDLcNG8GL_ZDCGQAsB=G7DBC0k1BYB1HNQTbu4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 14:52, Arnd Bergmann wrote:

[snip]

>>
>> @@ -104,7 +105,6 @@ config DRM_FBDEV_EMULATION
>>         bool "Enable legacy fbdev support for your modesetting driver"
>>         depends on DRM
>>         depends on FB
>> -       select DRM_KMS_HELPER
>>         select FB_CFB_FILLRECT
>>         select FB_CFB_COPYAREA
>>         select FB_CFB_IMAGEBLIT
> 
> This fails because of all the other drivers that try to 'select DRM_KMS_HELPER'.
> Kconfig will now complain about a symbol that gets selected while its
> dependencies
> are not met.
> 
> To work around that, every single driver that has 'selects DRM_KMS_HELPER' would
> now have to also list 'depends on (DRM_FBDEV_EMULATION && FB) ||
> !DRM_FBDEV_EMULATION'.
>

Ah, I see now. Thanks a lot for the explanation.
 
>        Arnd
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


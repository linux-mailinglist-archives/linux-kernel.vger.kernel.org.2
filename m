Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB684379B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhJVPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231635AbhJVPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634915781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGKg98798sR7hDdh2nqAXz7sKPnZ3GW7bRVI1o0f6mc=;
        b=EJ7sT7KoVrV5cGIXkuTul4dyhKvbdWmdu/g4b5hc8bJ2YKMtRj2NY50fJlOUrGXyasZBl6
        YT1aluwCLBUT/2aHCcQxUI+7gKYgitDhBJ2tQnNCrygaMd1IBqMmTCcjr5kHVWF7XAoMcu
        Rxdm1lqEuRNs18DvFry9DxsBRRyemug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-IygQvx73NwWeRVm8nxui_Q-1; Fri, 22 Oct 2021 11:16:19 -0400
X-MC-Unique: IygQvx73NwWeRVm8nxui_Q-1
Received: by mail-wm1-f71.google.com with SMTP id v18-20020a7bcb52000000b00322fea1d5b7so1161869wmj.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pGKg98798sR7hDdh2nqAXz7sKPnZ3GW7bRVI1o0f6mc=;
        b=JOL48JOCdM/y/OlW8FB0g3HhMV3mj9EoDTqemXt9G1GqQmvcuVnBtiZzWAlVNPHkc8
         nncDpl6u1m8cSnI5tPQovKo1zA5Gbm3Gn7ifUDiCH5qOSe58R/PH1q0LyH1CutUjphYc
         rKJoapWOyJjH4pyMMtBldka+LaG14Sy4RDFLGkKRRr5mpttRBiLdSx5mVHtM0cQSMUlj
         XICNWBiNG+9FShSMYsOsX1Pq+SQSEvkWhLZQ3ZvzEPxt0i37OjxsJp38u1sSMpYDdTRb
         EOMZ5kB6Rmdk9ULTA8NI1ufeGMf0uOdca3e42CF8TUC1XTWRN4+rdgabJZjJrzqgM38I
         s8XQ==
X-Gm-Message-State: AOAM5305O+s4x5v6pHPrFB0T+fZhTQX6R/PTtMEiSKB7WhkUrpCE7yvO
        zyP81EDKUJX7UkkT2qzESoUB5qmaVeoG1/XEHqBcJ3h76DIjbV7qYAGz6ZTTc897FSIdIuqSySI
        1+PT1DPkMpr2T2nexYcMWo+v3
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr627052wrr.74.1634915778351;
        Fri, 22 Oct 2021 08:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEKQAQpr7NQ++0cIjm/8luZl970ACFAB+piCj+X1eATgioaVsZPPinY4goUeNvEb0f2ZXSww==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr627019wrr.74.1634915778129;
        Fri, 22 Oct 2021 08:16:18 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id l20sm12942958wmq.42.2021.10.22.08.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:16:17 -0700 (PDT)
Message-ID: <352163b2-2946-aec8-16b4-fd6f01373ff2@redhat.com>
Date:   Fri, 22 Oct 2021 17:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
Content-Language: en-US
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20211022144040.3418284-1-javierm@redhat.com>
 <CAEg-Je_v0zvOs1dOZ3P0qsPDO7LC8xk0zxQBLH6gr65V82dnPA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAEg-Je_v0zvOs1dOZ3P0qsPDO7LC8xk0zxQBLH6gr65V82dnPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neal,

Thanks for your feedback.

On 10/22/21 16:56, Neal Gompa wrote:
> On Fri, Oct 22, 2021 at 10:40 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> The simpledrm driver allows to use the frame buffer that was set-up by the
>> firmware. This gives early video output before the platform DRM driver is
>> probed and takes over.
>>
>> But it would be useful to have a way to disable this take over by the real
>> DRM drivers. For example, there may be bugs in the DRM drivers that could
>> cause the display output to not work correctly.
>>
>> For those cases, it would be good to keep the simpledrm driver instead and
>> at least get a working display as set-up by the firmware.
>>
>> Let's add a drm.remove_fb boolean kernel command line parameter, that when
>> set to false will prevent the conflicting framebuffers to being removed.
>>
>> Since the drivers call drm_aperture_remove_conflicting_framebuffers() very
>> early in their probe callback, this will cause the drivers' probe to fail.
>>
>> Thanks to Neal Gompa for the suggestion and Thomas Zimmermann for the idea
>> on how this could be implemented.
>>
>> Suggested-by: Neal Gompa <ngompa13@gmail.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> Hello,
>>
>> I'm sending this as an RFC because I wasn't sure about the correct name for
>> this module parameter, and also if 'remove_fb=0' is intitutive or instead a
>> parameter that's enabled is preferred (i.e: 'disable_fb_removal=1').
>>
> 
> In general, I think the patch is fine, but it might make sense to name
> the parameter after the *effect* rather than the *action*. That is,
> the effect of this option is that we don't probe and hand over to a
> more appropriate hardware DRM driver.
> 
> Since the effect (in DRM terms) is that we don't use platform DRM
> modules, perhaps we could name the option one of these:
> 
> * drm.noplatformdrv
> * drm.simpledrv
> * drm.force_simple
>

or maybe drm.disable_handover ? Naming is hard...
 
> I'm inclined to say we should use the drm.* namespace for the cmdline
> option because that makes it clear what subsystem it affects. The
> legacy "nomodeset" option kind of sucked because it didn't really tell
> you what that meant, and I'd rather not repeat that mistake.
>

Yes, agreed. In fact, that is the case for this patch since the param is
in the drm module. I just forgot to mention the namespace in the last
paragraph of the comment.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat


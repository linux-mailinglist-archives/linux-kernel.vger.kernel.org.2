Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9941F446314
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhKEMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232786AbhKEMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636113672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6mnjEfsvPWlmw0Dlsyl+1vpuoyclHqeKNkGqPRjBhA=;
        b=aAeUt1RHQHUsaXJhgMEUog4k0I9N9TaJ07ZLg6x6s4dLIuF/O4sTDAQDdm3o9vyS0PGOen
        yobtCGrQO5Wg/ViNngAJo9JoiypFBhHw9QpuIzduh/JbL51qUWLuOFKz8s3aT7XdHXfD+g
        c1NDVjloAz2SbQT+BYDpYx0u4JmQ/fY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-Ka0DV7zDMWib-kfQTQrErw-1; Fri, 05 Nov 2021 08:00:52 -0400
X-MC-Unique: Ka0DV7zDMWib-kfQTQrErw-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso3191243wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 05:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6mnjEfsvPWlmw0Dlsyl+1vpuoyclHqeKNkGqPRjBhA=;
        b=Ab1Rk2201DMVf2j7NlD1R3wlcWcgvZCrnva2PP8qY4773tkmpK7SpAz3SstNJmNCXY
         R7Bd86oKoX5m6zEll1fSruVyydakCzoolCAUv00JebnH0KZFhkFRNNbhFKk9Ik9UQJaR
         LZMdr740hohE+YUsQyYJio9WCZJlPmFeyim0sHj2ZRHAJNJ5+IvOYxZ6ObId3FffYHeM
         Y2BtB7c+bhxoxVysFQZ8gYwShv/qY9Zn6j7tUvKH7BXi9/c7I4omTnMCr08S3fKZsgLt
         S9E6LKSkuBoZ4OXBOYfYeo2HIJrnxHWRWLn/qSvGgAkmeEG8rp99xrN0SmoWviAfs8di
         /6JQ==
X-Gm-Message-State: AOAM533EInPKjdOAWngQM3t+fveeIgqs2bWR69VJlrR0qwcjIWSMRNA2
        SbyfD/1OckCyg2juylDMb2P/agqYbXIx8Wv6hIOPXrkuhutOywdqyrYduWkplFEMWvnbHm8vUEH
        2ockf3I4pcpzim1ckI1gV6e1O
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr36559137wri.285.1636113651757;
        Fri, 05 Nov 2021 05:00:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxlHaNU9FU6Qy+ImAOwcqW/sLneLxZOG0rukxfbYjqJBdrwuSz7fg+xp3pWIymRwt/FJOPRA==
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr36559073wri.285.1636113651479;
        Fri, 05 Nov 2021 05:00:51 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m21sm7590336wrb.2.2021.11.05.05.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 05:00:51 -0700 (PDT)
Message-ID: <335a9e0f-cce9-480b-10e0-bd312b81e587@redhat.com>
Date:   Fri, 5 Nov 2021 13:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
 <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com> <877ddmapfj.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <877ddmapfj.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 11:04, Jani Nikula wrote:
> On Fri, 05 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:

[snip]

>>
>> Do you envision other condition that could be added later to disable a
>> DRM driver ? Or do you think that just from a code readability point of
>> view makes worth it ?
> 
> Taking a step back for perspective.
> 
> I think there's broad consensus in moving the parameter to drm, naming
> the check function to drm_something_something(), and breaking the ties
> to CONFIG_VGA_CONSOLE. I appreciate the work you're doing to that
> effect.
>

Thanks, I appreciate your feedback and comments.
 
> I think everything beyond that is still a bit vague and/or
> contentious. So how about making the first 2-3 patches just that?
> Something we can all agree on, makes good progress, improves the kernel,
> and gives us something to build on?
>

That works for me. Thomas, do you agree with that approach ?
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


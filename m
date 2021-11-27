Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152046013B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhK0Tpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:45:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234799AbhK0Tnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638042026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8RNZ9mAJByky9V93E1UlbnnyGphpUak9sPhZ/HMjss=;
        b=Z/QxKa27a/kTcb/k4/tM91xoSdZNuPZuxCp0mjBoAfJ9M95qiGZhPinR//x9p2Z4dmPrQH
        7X9Rk3O2AfNLUu6/xlfWRg1sJB3q4UmLAV3rzvMW1RN8m4wRDSRrKO/r/Iag4pBqfHY6Os
        WzzmztiObr1JxoUtMzeLztxdTituyWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-lDmNgbuwMjKa4jdXIfs5vA-1; Sat, 27 Nov 2021 14:40:25 -0500
X-MC-Unique: lDmNgbuwMjKa4jdXIfs5vA-1
Received: by mail-wm1-f70.google.com with SMTP id n41-20020a05600c502900b003335ab97f41so7466002wmr.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t8RNZ9mAJByky9V93E1UlbnnyGphpUak9sPhZ/HMjss=;
        b=oSbwMl4UV1KpgAbn8fW9AxtMg2oESTKnh2wR3qZc/eleotB3IpvdKqnjKbUAMZwQy6
         e1akx7CuYsYUh6SA0VzXgTQMhjgz0OOfg8WaH4J+rcdHRi/HJKshMuoKdfRtuSNKEn5z
         EshmztOlb20AfFjjxBtwF189198fH6jYJIHgvKNmh3/dPb6sAkqe/R5W+q8h2Q5gy71j
         oNxvArYE9BXRbOeEQ4FEzYu1MIRo3tipo9mJFndRkN7yPFqSBskWifi3GdDGqkTUJzs7
         R219q3zQN9ThRaBLLWu3jC2HwnvcX2glE3ofxzHriWToaU7u0ZxVxdoEk9BhQUielCkA
         WcXg==
X-Gm-Message-State: AOAM5322GbXNSOZQ7QVWOXe4sxXexBLNv3S8EcSRf+a1k0EA6aifHydD
        +eIBpt9pAakyJJpPhMAJ2Ijy/epcidHo/FwxML7psLP5jZ1B48BNegUmkW032+V6IY0dv2aVRvQ
        h0KnoQieYdmqbUf5lyVtMbQ/mEei4UFTL0unEkfjdaqHsC+41oYHdnfnF9/SdiRhrV0UX0Rjqfd
        4=
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr23642519wri.251.1638042024346;
        Sat, 27 Nov 2021 11:40:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBQ+Tio+oHqcKl0gpxrZuLMQiJF7IdVOaJBN+FhlZqCJLCfE8bPqtMGj4HUuVoO7l1kXNH/g==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr23642502wri.251.1638042024133;
        Sat, 27 Nov 2021 11:40:24 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t8sm9470235wrv.30.2021.11.27.11.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 11:40:23 -0800 (PST)
Message-ID: <e3aeb07f-34e6-6ae5-61b1-bb357b0a7aef@redhat.com>
Date:   Sat, 27 Nov 2021 20:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm: Fix build error caused by missing drm_nomodeset.o
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20211127191910.709356-1-javierm@redhat.com>
 <YaKGeKU7HJOgEu9r@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YaKGeKU7HJOgEu9r@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/21 20:26, Daniel Vetter wrote:
> On Sat, Nov 27, 2021 at 08:19:10PM +0100, Javier Martinez Canillas wrote:
>> The patch for commit ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter
>> to the DRM subsystem") was generated with config 'diff.noprefix true'.
>>
>> But later was applied using 'cat nomodeset.mbox | dim apply-branch' on a
>> machine with 'diff.noprefix false'. And command 'git am --scissors -3' as
> 
> Huh that's a dangerous setting, I guess a dim patch to check for this and
> very loudly complain would be good? Care to type that up?  It's no big
> deal because strange git settings for dim is pretty much a game of
> whack-a-mole, but we should tackle them when they pop up.
>

Sure.

>> used by the dim tool doesn't handle that case well, since the 3-way merge
>> wrongly resolves the path for new file drivers/gpu/drm/drm_nomodeset.c as
>> gpu/drm/drm_nomodeset.c instead.
>>
>> It led to the following build error as reported by the kernel test robot:
>>
>>   make[4]: *** No rule to make target 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
>>
>> Fixes: ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter to the DRM subsystem")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Build testing before pushing should be done, not the other way round :-)
> 

Yes, sorry about that. I wrongly assumed that the tools would do the correct
thing but I will make sure to build test before pushing in the future.

> Also this is pretty much why we want gitlab CI and real branches.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> ---

Thanks!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


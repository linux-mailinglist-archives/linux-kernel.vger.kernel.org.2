Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27A445769
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhKDQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230345AbhKDQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636044253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBeSNSo+VR936LBuXFto2HVzfx/uW1FgtYIk1y3q3ig=;
        b=CBVY3wAoy78upQNbKAT1HVlHDBpW4oEl0NbOHqlw8hz+XAM45IIsqMx9wT6FBTHERDHg6I
        h207V7GgFIdF5o0vj424y1hfbUtdxmpIm3EE1+0uJwpm1eT+0mXEEd/T7hq/7E1t++v9zk
        HkSLJ2SgiK0VMUli6JbyzWmnaRWXtWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-Rb_6Xot1PQm4Yf9NA2Bl7g-1; Thu, 04 Nov 2021 12:44:11 -0400
X-MC-Unique: Rb_6Xot1PQm4Yf9NA2Bl7g-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso1216810wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GBeSNSo+VR936LBuXFto2HVzfx/uW1FgtYIk1y3q3ig=;
        b=tyX2VGI+yMmoT6TVzSnDslK42vm/4SFyjmbwWxR7lc5r5U+7Gad7CJfw5GgUXBh39g
         kfgZ3P/dy1z83MZ0TfCXluosNtykUq8lwUhuILc3FsxPzV0NTT9MUiKm5nyTTw+jaEqz
         jGJxe34uioUo4l901HAAR/ziy5WEJJEH4r25bhu27aLFq1yZm3XmcrovhVh2ykjERkGr
         OY+eInSSFKjR34YrLWZv3NXPG5MiRCMnub5abbPfB+h8eWk5PnKF3r1aoZoML+Sf5ebb
         gVItvBR1Tg6Kn2Jnsm0XEIndpNu/y9Hr3bcz+9xU8SlAatUdYarfZFXcgcoAJXchGnFD
         xwAg==
X-Gm-Message-State: AOAM530aSN68q9L1KE6g2pmCt+XiZXhjnEopK7w9UvWjxSkL2uYBPTvE
        HrPtdS1V4Rx+nrbRPN3ipC5EFJztVm3XTZppmvbaNs55fxno6FA71qk0zGQsOBibjrPTYmapuAx
        yd287+3/TPKU8F1juKX3ORehr
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr39525097wrt.224.1636044250772;
        Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnATpWRYfiqKo492+/czqTIzFCv7HIX437cz1EV9eI7R7UChO4l+utit2RLduHTmaqMKEFNQ==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr39525075wrt.224.1636044250590;
        Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o4sm6636216wry.80.2021.11.04.09.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
Message-ID: <3ff9fe95-9bc7-a043-78c6-d52d0ff02e23@redhat.com>
Date:   Thu, 4 Nov 2021 17:44:08 +0100
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
 <20211104160707.1407052-2-javierm@redhat.com> <87zgqjanz2.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87zgqjanz2.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 17:24, Jani Nikula wrote:

[snip]

>> index ab2295dd4500..45cb3e540eff 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -18,9 +18,12 @@
>>  #include "i915_selftest.h"
>>  #include "i915_vma.h"
>>  
>> +static const struct drm_driver driver;
>> +
> 
> No, this makes absolutely no sense, and will also oops on nomodeset.
>

Ups, sorry about that. For some reason I thought that it was defined in
the same compilation unit, but I noticed now that it is in i915_drv.c.
 
> BR,
> Jani.
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


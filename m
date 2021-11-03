Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76A44407B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKCLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKCLXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635938469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMsm4l7tSaUZIWaNbRsjHnQoDrghReNTpOtLwY9pusY=;
        b=SZTvhrtxrk4tBcobwwGdCqfgnSSnOLLZ2ZkAnswjgNTs+MaOzMTxIxcQGstQUIf4iCG7+M
        /PZFH7Q7bI8FBTc0k1MJ4mcSGFZ6zMb9v4DfdCTTGaSoi5seJhdZw0idZSJUfX6d7kYaQ1
        KLBZK3Qmxonabc7R0r3eyrhnJAVdLBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-ai2SafeAPgWYz_AcliVRxQ-1; Wed, 03 Nov 2021 07:21:08 -0400
X-MC-Unique: ai2SafeAPgWYz_AcliVRxQ-1
Received: by mail-wm1-f69.google.com with SMTP id a18-20020a1cf012000000b0032ca3eb2ac3so961070wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 04:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qMsm4l7tSaUZIWaNbRsjHnQoDrghReNTpOtLwY9pusY=;
        b=jXMy7c8HQMNl1XaUY9a/0N5My6GnW1B6mqA44KT1u82zhoTT5BcxQ1QirYYu33L2Mz
         fj0Z1hj2yprcUfQI/nH3UxBFIRSDvbs8ARRzPcrwMIkAGpfowOiIam6GC6KaL4x/cSAH
         GLDBpFGqEXYt0AfOKou+DROq69nEMbOt98OGyhEAdlhwQozpF1grwZIq2kRhiqHXl2tu
         UKKnxQGX4aZoTEib70SWVZ7rJGKjk5IYPbhUpImIKJ6n/qIjpBcCa/Zr/EhV4KUIz4e1
         DJX8M9usXrzUywsokqSd1N3GXwx412sEQOClTugCO0HvpAfeMS3vBE1Mgl4YJsV5uvLv
         C2tw==
X-Gm-Message-State: AOAM5316oOL3QOvsrUOwoHZIwpUsJsbmgtEL3axp0nCyR+jEoYF0k7kS
        0hmFayVFzDWlY2BxnScKmmsp6x3hANF0rTmsINHNB2FLKo3ri0embP2iGhwi9YRT2AEHsqYUILP
        A2yKNF5Qy8FbRaY2mWkSO2LY0
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr14712236wmq.110.1635938466741;
        Wed, 03 Nov 2021 04:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO+jI/YCKK8ByXrXNFn/5jY/jVaSLifadMvClU1bKSzOii0MQ1babTIiX1yjvpa29ZT7GA+Q==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr14712203wmq.110.1635938466556;
        Wed, 03 Nov 2021 04:21:06 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z1sm1707031wre.21.2021.11.03.04.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 04:21:06 -0700 (PDT)
Message-ID: <6bd3ff4c-c2df-5cc8-bdc5-22bc37c0cb9e@redhat.com>
Date:   Wed, 3 Nov 2021 12:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
Content-Language: en-US
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20211103104812.1022936-1-javierm@redhat.com>
 <20211103104812.1022936-3-javierm@redhat.com>
 <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neal,

On 11/3/21 12:05, Neal Gompa wrote:
> On Wed, Nov 3, 2021 at 6:48 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> The "nomodeset" kernel cmdline parameter is handled by the vgacon driver
>> but the exported vgacon_text_force() symbol is only used by DRM drivers.
>>
>> It makes much more sense for the parameter logic to be in the subsystem
>> of the drivers that are making use of it. Let's move that to DRM.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
> 
> Please no, I'd much rather have a better, more meaningful option
> instead of "nomodeset". If anything, I would like this option to
> eventually do nothing and replace it with a better named option that's
> namespaced by drm on the command-line. That was part of the feedback I
> gave in the original patch set, and I still stand by that.
> 

I do agree with you that a more meaningful parameter would be desirable.

But I think that's orthogonal to this series and something that could be
done as a follow-up. That is, nomodeset isn't going away anytime soon as
that's what users are get to.

This doesn't mean that a drm.disable_native_drivers, drm.safe_mode or
whatever could be added. Internally it would also toggle the same value
but it will be much more clear to users what's the expected behaviour.

By having a module parameter under the drm namespace, it would also allow
to change this from user-space through a sysfs entry. Something that's not
currently possible for the "nomodeset" paramter.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


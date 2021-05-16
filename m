Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0B381F77
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhEPP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 11:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhEPP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 11:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621178752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh3Sd0JcU9szqK55NWh6S2hsCVgwsM8f4R5lJKfXVFU=;
        b=Lx2pslD+9vfT5nVV9pIcahJYSu71pRknQhR5GBuTL42nGosM/mMtbJhaqdM79rHYEhnGKG
        8IwGAkXydXAEIPZ1MVv8r8mXsePuxbWvJLmWvsX4nfisVDJc2bcAJx7YF7qiWp9Xdjsxc0
        aizf5JZ8L8QwVKrPQsFqawLI2Di5Aow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-fXCImnqDNuGFho3LbKU9HA-1; Sun, 16 May 2021 11:25:51 -0400
X-MC-Unique: fXCImnqDNuGFho3LbKU9HA-1
Received: by mail-wr1-f71.google.com with SMTP id s7-20020adfc5470000b0290106eef17cbdso2503655wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 08:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rh3Sd0JcU9szqK55NWh6S2hsCVgwsM8f4R5lJKfXVFU=;
        b=r6yVW51jR6WfOPD7d/vgaxJVdfvLjQbdRpb0hjLQuTDgfuh7IHrxwrBYTWLWT0usGj
         qDuI4FSfoDAEhhHDaXwOo77qT0McJ4rMrzi675apbHurtx7GpXU98BIuB3fNJhZ+LwNa
         ud4qOo+WJ8amqUMW0je9rqBQuT1rwnuxXdfNak6e6/V5deDoRLlYnCsY6Ol5/WSnhOoq
         AbV0hCM9Etb5HQgomfREvSKvbKqj6ImDm6JI4WHJoFTO4G2zLOnG/KgigdAWO+BCbcZv
         7oM2cPpKrYAenaXOndNDVa0e4gP3mRoKN2cwvR7O478M6/lLodY3MbVIKcriKIXR2/z+
         7Lcw==
X-Gm-Message-State: AOAM532Qmn6cMkvjfvV7Ms/AmvrmHdI4zE2rU7+6XSzAofJ9Jcs3KA9C
        /4b6HB+6iq0/gtZ3TeIqlF/PT1cq1CiiYdaUGbCiA7yXDpb177R89Krcz6QeY5SMkdbs0RP9oXw
        +DeFpCqwHQqRvdFm/EKKhdugn
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr70258912wrs.9.1621178749819;
        Sun, 16 May 2021 08:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrIeisoP1v0heRBwNPcG4ITRaoMkHe2GGAaPVT/JCNOExMusD/ggg/zsQI0GgHRlRdmJxhyA==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr70258905wrs.9.1621178749653;
        Sun, 16 May 2021 08:25:49 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f8sm10609976wmg.43.2021.05.16.08.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 08:25:49 -0700 (PDT)
Subject: Re: [PATCH v2] drm/rockchip: remove existing generic drivers to take
 over the device
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20210516074833.451643-1-javierm@redhat.com>
 <ef974dd8-5619-35b7-74de-4e270033a3c3@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <1b492488-3f25-fca9-e9d9-78138bed1d2c@redhat.com>
Date:   Sun, 16 May 2021 17:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ef974dd8-5619-35b7-74de-4e270033a3c3@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/16/21 12:30 PM, Thomas Zimmermann wrote:
> 
> 
> Am 16.05.21 um 09:48 schrieb Javier Martinez Canillas:
>> There are drivers that register framebuffer devices very early in the boot
>> process and make use of the existing framebuffer as setup by the firmware.
>>
>> If one of those drivers has registered a fbdev, then the fallback fbdev 
> of
>> the DRM driver won't be bound to the framebuffer console. To avoid that,
>> remove any existing generic driver and take over the graphics device.
>>
>> By doing that, the fb mapped to the console is switched correctly from the
>> early fbdev to the one registered by the rockchip DRM driver:
>>
>>      [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Ping me if no one else merges the patch.
>

Sure, I will. And thanks a lot for your review!
 
> Best regards
> Thomas
>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering


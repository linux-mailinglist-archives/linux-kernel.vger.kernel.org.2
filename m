Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F283928B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhE0Hkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232985AbhE0Hkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622101140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tr9Om/qHWPld9nvtg7I4AilQwhNjlhgHg8Y3pfskr8o=;
        b=YNPdnAQIyJCOx+iUwkhM4Q/F9kJHIrxRyUbISNOB2OhoT7rgXm6RgPbcuZN4hITCgAfZwL
        sD0973VZNzlvDxL++CS3MEJuAhL+7RwN8+QSNaG3aF+B2lG/RMXFs1rFqJYFjFCZwmgX8z
        jYfGI0c0PkGP7WOWT0Jm3e7+gOV4HUM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-bM52Tfv-OYutp7rL9cj11A-1; Thu, 27 May 2021 03:38:58 -0400
X-MC-Unique: bM52Tfv-OYutp7rL9cj11A-1
Received: by mail-wm1-f71.google.com with SMTP id n2-20020a05600c4f82b0290181c444b9f1so1613580wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tr9Om/qHWPld9nvtg7I4AilQwhNjlhgHg8Y3pfskr8o=;
        b=NVOdiLfkSACmUriJLsvi2zeZDhhXup+rRVizeSF1ARWEjV1gp2jYPoBsNPmQpV0FXP
         gkyobf8kYTT6sQeXp5NCiAKn6tSTjfbX17cvBAtAZEMpoZnlJ2hOgopY1WpXaDpGqG6B
         ec//nP4DYGGbMghwyidHd+vnLrruIF52qeQyO7a1CG1MiduRctwMhJGvfBSFiN85e33Q
         xsoVQ58pq+c0/pojOfVcspWPnh/Iyo727oTNP+FilxVXgFXr6L43PnkAluVyLkiXUhx5
         ZxgNOQDuT+y1ktL4j9EzjJVgIlr6eT9iM2hMkRgA7vGhseRlim9Hnk89Hrhb1Yla0fGb
         t5bA==
X-Gm-Message-State: AOAM530Sn4XPIrVh/MaG0T0E/7uukl777MwFWQekCMlBIH86mYTcN1YK
        nmGVUTDxzvE7Qu8gSDhXX84xy/AK4P5/phtwv1/P2GLqcu6Ut9YVLyWPoJiHmFrNAIS3uGuMJS6
        A+jqoGi6i2HIjbqP8Rp83LYi6
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2052140wmc.36.1622101137741;
        Thu, 27 May 2021 00:38:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZVop6H2VW1mRjVUOgw8KEymXsvePOqGNAVjrj5q1DCCxN2zMbkp3L1Ndnzh3bt5xh50E+CQ==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2052118wmc.36.1622101137559;
        Thu, 27 May 2021 00:38:57 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h9sm1753276wmb.35.2021.05.27.00.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 00:38:57 -0700 (PDT)
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
Message-ID: <1f781f88-24ff-98b8-9c86-ae4db311843f@redhat.com>
Date:   Thu, 27 May 2021 09:38:55 +0200
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

Thanks for the ack.
 
> Ping me if no one else merges the patch.
>

I would really appreciate if you merge this patch.
 
> Best regards
> Thomas

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering


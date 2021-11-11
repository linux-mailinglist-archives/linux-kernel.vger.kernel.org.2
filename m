Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433F444D5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhKKLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhKKLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636629493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cm+DUi8ko4XSbRJD2kBqXRStf4XmBaQnXCvcSQsugM4=;
        b=O7OOvBcQuZjmXK/lX+1egIUxRrTeKwPtodZyIMhTfFHcsn9cA92ffIcZkPD7RKqBIDFEew
        HO3WfzDe7EgOF+bpnp+6GwuGjWxdrg2xugHZ+z98o4gZkk0rH/HpB+yOjImFtfsg5aVBPh
        wsfEWTfLlwJ0xB1/NTQJMEHdssLkEC4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-dlkdIVKEMeKhwf0MvRVb4w-1; Thu, 11 Nov 2021 06:18:12 -0500
X-MC-Unique: dlkdIVKEMeKhwf0MvRVb4w-1
Received: by mail-wm1-f70.google.com with SMTP id g80-20020a1c2053000000b003331a764709so4640272wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cm+DUi8ko4XSbRJD2kBqXRStf4XmBaQnXCvcSQsugM4=;
        b=e6SgDpCbsVWRci9fIibEOboZnzdB7DiMsGcFzAx6m0ETrhNzf/k+Zw8ZPotIoZi18H
         VPQhrlm8pI2w8PKvWv+pO8URMy8H7oNAZlaoCqlJIjK2Qdhhba4io8hMsh6lnOEkR5Ly
         NUOZr8/1jjzoq+vXRX7aPsPfyyuf0o5miqQOEBXIGIoSVZjoWpoKUa6T/pE8pLeW+/2K
         cjbq9kLmxWwSOfgxe3P+6PydWRaEH78jcCwOLiR5Y5PtdQYGG+Su68w/IGr0LEJGimq2
         mgwHguHTJyxXWyiNe1UFjOtmOHag+SoGFM0L1kZRY2dmh/wHj2fPvA6wfby6J4gfJG7W
         XAhQ==
X-Gm-Message-State: AOAM532rBtvHToMR8jXLnbBxLjXifCbJRKzRxKqCxzLwSBiq4tmj927q
        5CKiMJ6S32appbDGjeOyQ0mG74SOFie8TCLCpKFqM9dEyCsw+DyO1crDGg4aDX+20f4CdfrEdA3
        jE0Ocato2vE1Cz+A2PkuwzNgFBk2CxXwvMb7YiLtcd7vd/MhaqhtljMGLinDQf8LWw/pHSk1XQ3
        0=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr24715999wmk.40.1636629491017;
        Thu, 11 Nov 2021 03:18:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4QxzjI3CdpXCnsWkA7eOREXt8H1mIwhs9QLzOlluAuSBhSe0vmw+5iQBIRwQe7D8C02d50Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr24715959wmk.40.1636629490719;
        Thu, 11 Nov 2021 03:18:10 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o2sm2797562wrg.1.2021.11.11.03.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 03:18:10 -0800 (PST)
Message-ID: <62258612-be91-d195-58e4-057819e7b29e@redhat.com>
Date:   Thu, 11 Nov 2021 12:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fbdev: Prevent probing generic drivers if a FB is already
 registered
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>
References: <20211111092053.1328304-1-javierm@redhat.com>
 <YYzoWTMBkC64a4Cn@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YYzoWTMBkC64a4Cn@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 11/11/21 10:54, Daniel Vetter wrote:
> On Thu, Nov 11, 2021 at 10:20:53AM +0100, Javier Martinez Canillas wrote:
>> The efifb and simplefb drivers just render to a pre-allocated frame buffer
>> and rely on the display hardware being initialized before the kernel boots.
>>
>> But if another driver already probed correctly and registered a fbdev, the
>> generic drivers shouldn't be probed since an actual driver for the display
>> hardware is already present.
>>
>> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Thanks for your review.
 
> Also Cc: stable@vger.kernel.org?
> 
> btw time to organize drm-misc commit rights so you can push stuff like
> this?

Yes, I'll start the process today to request that.

> -Daniel
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


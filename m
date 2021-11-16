Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1E452E99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhKPKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbhKPKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637056903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=533DJPrDDxlMGTv0pnxjgO+BwgxyEzDlbPhO6HwlUb4=;
        b=IMJbRc71ULBSUHRPlKAJ1ahgAjNowOWQB2GmfGP+vIwUepZsFkxjbpNP7vsa+u23uSzUzw
        IhsYXBYXk8eMPmSWezzdYvK0kjNCJZ3/DPkgs4g6wLAuBj8OvOEm1W9TwdLqBTFhtcVeUT
        VzDSNKR+SMFOf7JUZ6ZlejVOT3dh0uo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-1-e0LjunOhWJ838b-FIL6A-1; Tue, 16 Nov 2021 05:01:41 -0500
X-MC-Unique: 1-e0LjunOhWJ838b-FIL6A-1
Received: by mail-wr1-f70.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so4344890wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=533DJPrDDxlMGTv0pnxjgO+BwgxyEzDlbPhO6HwlUb4=;
        b=Dsr8QIKK0pB+Wg+nL1JRd/yOnv09kDxrFpRQdTA1j/ZWplOYgI/bYI2VHUN1E2cUu0
         Ru3OZVURVUGD//lzH5HUvyKxdGmZGHSGNpWIpbbe8pcXOyrZc+X4dlq38+GbtbxBcZNl
         X0vQPuQzmCV9FpAFXkmNE4Zu2cHA3+kH8UtQP+9rShfVsedT8uRXC2edmW9oh/DaGLp+
         9Z7J0++o3AdEpBq7EerVLZnKcjuTQ3bjWbdygQ81XARjxp0BGSlQNUkmKxWrNVAtMejV
         497CW6EZ+Mt3yMNHNPtl2tFULB14Rihu9FMg1tJFAzVqqbNfST+q2KLW0rfF7jrAnXFE
         /koA==
X-Gm-Message-State: AOAM532O75x0arYeczHwQzPfIE6aroSFYNcNSpukDPmc7Vps8KeFqWKw
        f+PaiQs0sHO38xhxn9y19GX1pMr+hlkHYwBLyegv237qQgGAxQzX3G+sLh/1IWiaYDrug10ise1
        lbyHWmsOVRf9NtLLCopbk6aLa
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr6163762wmj.156.1637056900561;
        Tue, 16 Nov 2021 02:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlGjWi8alUIqPMmPz5/NWCmPlLiqtCNyw7It2G0hrbpLCRkisY1dNBJt1D//kFA9f//Tcinw==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr6163736wmj.156.1637056900360;
        Tue, 16 Nov 2021 02:01:40 -0800 (PST)
Received: from [192.168.1.102] (91.pool90-171-47.dynamic.orange.es. [90.171.47.91])
        by smtp.gmail.com with ESMTPSA id t11sm16568630wrz.97.2021.11.16.02.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:01:39 -0800 (PST)
Message-ID: <7cbadb2a-b6e9-f264-9d95-b76c7071af27@redhat.com>
Date:   Tue, 16 Nov 2021 11:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211111111120.1344613-1-javierm@redhat.com>
 <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
 <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
 <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 11/16/21 10:43, Geert Uytterhoeven wrote:

[snip]

>>
>> So this is already a fragile solution and $SUBJECT doesn't make things worse
>> IMO. Since not having something like this can lead to issues as reported by:
>>
>> https://lore.kernel.org/all/20211110200253.rfudkt3edbd3nsyj@lahvuun/
>>
>> We could probably do some smarter here by providing a function that checks
>> if the registered fbdev drivers matches the aperture base. But I'm unsure
>> if that's worth it. After all, fbdev drivers are likely to be disabled by
>> most distros soon now that we have the simpledrm driver.
> 
> Checking the aperture base is what was done in all other cases of
> preventing generic (fbdev) drivers from stepping on specific drivers'
> toes...
> 

Ok, I can re-spin the patch checking if the aperture ranges overlap. There's
an apertures_overlap() function in drivers/video/fbdev/core/fbmem.c that can
be exported for fbdev drivers to use.

Another option is to just say that DRM drivers should be built as a module if
the {efi,simple}fb driver are built-in.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


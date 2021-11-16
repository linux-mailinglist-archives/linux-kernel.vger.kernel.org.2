Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE56F452E05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhKPJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbhKPJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637055033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSJuWcsoneSy8n7p/CMH5CiBgKa6pj13KM6UjkRVYgQ=;
        b=ZNuw90pTNo8VJXxz7jytgIOtMXeoDb4DbUHAGdahSP8vRwHAmGwfZGKZBZwHU/MeHpkhZ/
        xNSSa13UmHXu20euuyTvHp1oK2pcwzIz4pX49X2ZgQUrlJBPk1I53JXypZDih8s43l3jBX
        je44eTgQy+Yl+yCqbLiqHFpaMNaHcPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-HpwkiycQPOSzgtzoNbLrGw-1; Tue, 16 Nov 2021 04:30:32 -0500
X-MC-Unique: HpwkiycQPOSzgtzoNbLrGw-1
Received: by mail-wm1-f70.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso1210434wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mSJuWcsoneSy8n7p/CMH5CiBgKa6pj13KM6UjkRVYgQ=;
        b=O+rFkdw9TzdfxumnUzRiujs+66JtSP/jkFqrlrBYYyA+Q6+h836CJeogRglC/Qi8K3
         OB4yfalYsxKNuMVGnZOCgSCnzkCypjvqlEGHU8f1Hs6NqY4rfHGgd4eD8uTJh5Oct53M
         ku2oKsMt3CFzdlyhU9hZ7NfnlIWg0/kYgAdzoyEWjzSj3OLiG6KqQ3O31H21BD0BFsCS
         0jih3N9PEN+CepWagGqcozpBycPqtrUpCle0W9FCRtqElPqA7KT426mR1SysQ7B3LrkQ
         a+eSieWJIWI8mfuoHZGque1CyklsoF1HtZvfENwyMUTC2gXCUiTHit3YAn2o42+oexVL
         6ytg==
X-Gm-Message-State: AOAM53336qz6B+PGpLo/wvYwm63QALFkiGMgiSz58hxl0PMqHXk6leg6
        Dlpbu829HFC3hu2Zt+Wa4iOsvqwrj1yoDA2YcBza7azFIwF02i45f3Y86DtKsb0GPagZUqaASDJ
        YVCAPOG0ExXXHHdWA7h55TfrH
X-Received: by 2002:adf:a389:: with SMTP id l9mr7555784wrb.121.1637055031192;
        Tue, 16 Nov 2021 01:30:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgwiZj0DgXvYqrW2sWMV/yCu3WNu9rReMDFw4j3A00MnBKJ5k23ydvxJPOILvWBidIQ2S8/A==
X-Received: by 2002:adf:a389:: with SMTP id l9mr7555735wrb.121.1637055030865;
        Tue, 16 Nov 2021 01:30:30 -0800 (PST)
Received: from [192.168.1.102] (91.pool90-171-47.dynamic.orange.es. [90.171.47.91])
        by smtp.gmail.com with ESMTPSA id p2sm1944790wmq.23.2021.11.16.01.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:30:30 -0800 (PST)
Message-ID: <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
Date:   Tue, 16 Nov 2021 10:30:23 +0100
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 11/15/21 17:20, Geert Uytterhoeven wrote:

[snip]

>> @@ -351,6 +351,17 @@ static int efifb_probe(struct platform_device *dev)
>>         char *option = NULL;
>>         efi_memory_desc_t md;
>>
>> +       /*
>> +        * Generic drivers must not be registered if a framebuffer exists.
>> +        * If a native driver was probed, the display hardware was already
>> +        * taken and attempting to use the system framebuffer is dangerous.
>> +        */
>> +       if (num_registered_fb > 0) {
> 
> Who says this registered fbdev is driving the same hardware as efifb?
> This might be e.g. a small external display connected to i2c or spi.
> 
>> +               dev_err(&dev->dev,
>> +                       "efifb: a framebuffer is already registered\n");
>> +               return -EINVAL;
>> +       }
>> +

That's true, although I wonder if the {efi,simple}fb drivers should even be
probed in that case. As I see it, these are always a best effort that are
only useful for earlycon or if there isn't another display driver supported.

Since there may be other conditions needed in order for these to work. For
example, when using the u-boot EFI stub in most cases the unused clocks and
power domains can't be gated or otherwise the firmware frame buffer could go
away (e.g: will need to boot with "clk_ignore_unused" and "pd_ignore_unused").

Same for the simplefb driver, if the DT node is missing resources that are
needed by the display controller to continue working (clocks, regulators,
power domains), the firmware setup framebuffer will go away at some point.

So this is already a fragile solution and $SUBJECT doesn't make things worse
IMO. Since not having something like this can lead to issues as reported by:

https://lore.kernel.org/all/20211110200253.rfudkt3edbd3nsyj@lahvuun/

We could probably do some smarter here by providing a function that checks
if the registered fbdev drivers matches the aperture base. But I'm unsure
if that's worth it. After all, fbdev drivers are likely to be disabled by
most distros soon now that we have the simpledrm driver.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


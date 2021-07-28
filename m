Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34F63D8C17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhG1Kol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232609AbhG1Kod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627469071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVPX76oa+ikEVer1UL4g4IfAB5UX3EuLtEsoXtArruM=;
        b=CC6aYbCijMdrn5YCpKiVOY9ICYi2uvt/lUeXk0QJy6oxr/t5kZiWVJf/fMP0gKfi2weQgT
        zvM6lWK0wEMYPytmw3myuB95jH9NRl49tvgrI0LT26LHjoAFXWsxLdW5j0AYRCp+6QlS13
        /m4UcP8mXot5hU2D5mgoMPaPt+U20w0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-iRU8VLxPNjGFW0XI-jW7hw-1; Wed, 28 Jul 2021 06:44:30 -0400
X-MC-Unique: iRU8VLxPNjGFW0XI-jW7hw-1
Received: by mail-ej1-f70.google.com with SMTP id yl23-20020a17090693f7b029051a448bab28so668281ejb.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wVPX76oa+ikEVer1UL4g4IfAB5UX3EuLtEsoXtArruM=;
        b=CaF3HaQyT7+n957ssGfLfht1UOc5YwT6M3xhbU4MVbLe3NAS8OOAL4hBtLi5pvszXe
         fvvDy9883zI/QFUzZDbZbmg0ZqqwhUuuRGhTBmCviX295G7zeda5J9fa0JJ6UlSRY+dU
         6ddKzwKUF35DvEvu6If7CvNqd6c/0CMfKuZ439tDnlyPiAtKDSVG0q+CnHmT38ijZzQJ
         YeOvtBbdwfV1s6yNrFuCVekyEJuxFYEAIaBpN+FwfsJVrJXwkPgla+wUVVT47csrdGkP
         mT0Bocvt4XvJiQTtavD8XzvXld/1uDgsVdZRFqhglqkJeyeLRLbGKBk17sviBobmJM4d
         m3gg==
X-Gm-Message-State: AOAM532tvOkFvcxn/Xy1dUvFEv7J0F6cz9HlBSekXGufZm9X/RyI0Q4W
        ppsmhQNSxpDjsAAgeKDINCiLpRWKVOWUC0MsrSpWTkk3MWE4bbMmsw6YXHgGtyzQYTVFqc1oYWS
        w/aO6DBP6OdvyemVS8mxqnIjq
X-Received: by 2002:a17:906:2817:: with SMTP id r23mr26205724ejc.285.1627469069102;
        Wed, 28 Jul 2021 03:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWcLtMBxOnIs64TlNoB0jmKwP4hUfZ5cywxkR9K10TtWPUd3iAhD3JxMJ1jDhe556eWIuu2A==
X-Received: by 2002:a17:906:2817:: with SMTP id r23mr26205710ejc.285.1627469068919;
        Wed, 28 Jul 2021 03:44:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o14sm2472320eds.55.2021.07.28.03.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:44:28 -0700 (PDT)
Subject: Re: LED subsystem lagging maintenance
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHp75VeWKgyz32scczN0c+iJwGZXVP42g0NG0oXrdJ34GyHB8w@mail.gmail.com>
 <20210728103551.GA31304@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <179c4bce-ce9b-c9a8-4f24-cb4b3397e0f0@redhat.com>
Date:   Wed, 28 Jul 2021 12:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728103551.GA31304@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/21 12:35 PM, Pavel Machek wrote:
> Hi!
> 
>> I have noticed that in the last couple of cycles the LED subsystem is
>> a bit laggish in terms of maintenance (*). I think it's time that
>> someone can help Pavel to sort things out.
>>
>> In any case, I wonder if we have any kind of procedure for what to do
>> in such cases. Do we need to assume that the subsystem is in a
>> (pre-)orphaned state? If so, who is the best to take care of patch
>> flow?
> 
> To be honest, patches were not applied because they were not that
> important to begin with, because of lacking explanation, and because
> you pushed a bit too hard.
> 
> Yes, I'm quite busy in -rc1 to -rc3 timeframe with stable reviews. No,
> LED subsystem is not orphaned.

It is good to hear that you are still actively maintaining the LED
subsystem, thank you.

This thread does remind me that I was planning on re-sending this
LED patch which seems to have fallen through the cracks:

https://lore.kernel.org/alsa-devel/20210221115208.105203-1-hdegoede@redhat.com/

Can you pick this one up please? Or shall I resend it?

Regards,

Hans


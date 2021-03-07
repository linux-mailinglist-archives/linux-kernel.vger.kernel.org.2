Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E50330063
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 12:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhCGLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 06:36:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCGLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 06:36:18 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIrgX-0001pK-8B
        for linux-kernel@vger.kernel.org; Sun, 07 Mar 2021 11:34:57 +0000
Received: by mail-ed1-f72.google.com with SMTP id r19so3166520edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 03:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op5mu56rLKVeXZ5BYHLLFs3XBf2gdeKehd8++u/6LDA=;
        b=Ae1lyzG7wcREDsqaVx/+1xFnP933KjMpUUR1Vc6JCs7FSI1wzK2cKDxJ3e837RfuLw
         8av/qQIjI/eFatGeEDURnwNNJvjWa20eOLnduQlM4+mFvXGx1OTSfW0Ie8Fqt487DE6z
         A3sYP7aWRWjVYlT2knPTScfWvGb0h/j4Oq8pro5OoQropPdqwC0/zqsZ6PI3aFhDvDe5
         OgRahP5dc6zAQIlE6eWJ8gjwlMoWZGKdsEGMP9KlYIGMMlA6bTejitqW3jthSpv1dbJ0
         edpiJCIxhF/xs98+ie3sMVvC0d605plqvQoRUJUobDa0Kz2CHT0G5De1SPB9atT55XXv
         yGuw==
X-Gm-Message-State: AOAM532oKo/p+yKzqM8sEw7nw6RPqU39TlEFD45Z4DsvNTT+UppT46kw
        PTt1sW9ghtl5uxrzAV/ECn3yFnI+Ibd/L8XFyZhTFt6x+qLDWAG/ReYp2GENeABcNfdJ9scYCYE
        H5IsaHsdThOqsT0Y83AO5/GrEbkxw+lXXiCUEoi5QwQ==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812458edq.293.1615116896809;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN50SNAvRJvyv1TTGSoHps9ZM3d2RwZosjPBjKJrezHq2PpQu4f0MDG5tTUROmsW8Jne4o4A==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr17812435edq.293.1615116896694;
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id g25sm5016167edp.95.2021.03.07.03.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:34:56 -0800 (PST)
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-22-marcan@marcan.st>
 <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com>
 <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st>
 <CAHp75Vd_kwdjbus3iq_39+p_xRk3rum2ek3nLLFbBDzMwggnKA@mail.gmail.com>
 <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d33fffec-28bd-99b2-a8b1-cc83b628e4b3@canonical.com>
Date:   Sun, 7 Mar 2021 12:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2021 17:29, Hector Martin wrote:
> On 06/03/2021 01.20, Andy Shevchenko wrote:
>>> I am just splitting an
>>> existing function into two, where one takes the lock and the other does
>>> the work. Do you mean using a different locking function? I'm not
>>> entirely sure what you're suggesting.
>>
>> Yes, as a prerequisite
>>
>> spin_lock_irqsave -> spin_lock().
> 
> Krzysztof, is this something you want in this series? I was trying to 
> avoid logic changes to the non-Apple paths.

I don't quite get the need for such change (the code will be still
called in interrupt handler, right?), but assuming the "why?" is
properly documented, it can be a separate patch here.

Best regards,
Krzysztof

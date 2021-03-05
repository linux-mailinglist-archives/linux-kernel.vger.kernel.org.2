Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6C32E6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:55:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCEKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:55:01 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI86l-0000tl-TM
        for linux-kernel@vger.kernel.org; Fri, 05 Mar 2021 10:55:00 +0000
Received: by mail-wr1-f69.google.com with SMTP id f3so888660wrt.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSEM++y1rebUisHLCtkG+UNXZIjCmpiRoJ42u2ytX3M=;
        b=F8GQp88ASRuM5aUFp+ZA9kLgTwd8f8Oy9SjQzaGZOr2ew9Yb/90K2tFTt/BKOKF+nZ
         X5d9GWNfYkDxdY2ucMOV8zDdrJljw4XR2KhEXLv5AkCaJK0vk0Gbia0NtNsVD1t9gfeE
         0bnw8zxeYAmLcMCJPwjXFnNameivMWhauZv5crFGv46k9rYFJa8hB0oVIhoaTzHkqDhq
         ETQf1+HQ0Jk9y7KzmpJLfkNXgCVlycVpFzgHf4A+nI1wZfB5mCu++hdrWWYnBoCclNkd
         HM4JOcImPHopMmIGch0eqH/9H0mERy/m4PLTW5j0aW6e9KLF52JhP+G9VF2pGkfx2F1s
         8dQA==
X-Gm-Message-State: AOAM532hI+6+jDcI1uU3WqCIkPiYaJag3S9YwY384nsxWXwXjIyEKEwV
        TIH+PmcE8bvDuY4igdTj30YAubgFCva0v+XGX7BHTjy9AE354GRwnQRUQW6q+WY20gJQNsUd+Fx
        ktDLIC3zQ3LmNTNQ0PKBpTfSxuikHtmAgp6D3UM1sTg==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr8453981wmj.122.1614941699043;
        Fri, 05 Mar 2021 02:54:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVP9HaZ/X6h/g7Ggd5kC4cMtRdG0Xd39MHNruIlJ/V8+Cs+3v2YX2SK0aMTtOO80rSXOLn5A==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr8453958wmj.122.1614941698935;
        Fri, 05 Mar 2021 02:54:58 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id s23sm3761833wmc.29.2021.03.05.02.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:54:58 -0800 (PST)
Subject: Re: [RFT PATCH v3 22/27] tty: serial: samsung_tty: Use
 devm_ioremap_resource
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-23-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fe2cbf68-8b88-5128-035d-f941a9d17d74@canonical.com>
Date:   Fri, 5 Mar 2021 11:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-23-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> This picks up the non-posted I/O mode needed for Apple platforms to
> work properly.
> 
> This removes the request/release functions, which are no longer
> necessary, since devm_ioremap_resource takes care of that already. Most
> other drivers already do it this way, anyway.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

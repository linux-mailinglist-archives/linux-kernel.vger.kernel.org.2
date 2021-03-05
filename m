Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F294432E675
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCEKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:31:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50042 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCEKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:30:32 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI7j5-0007C4-4o
        for linux-kernel@vger.kernel.org; Fri, 05 Mar 2021 10:30:31 +0000
Received: by mail-wr1-f69.google.com with SMTP id g5so851274wrd.22
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJu6iNTkK4wSmf0pqRfj82yyDdC0OqRkZT1hSBnQXr8=;
        b=fgzwmgOAEGjDDO+v9okvFxQnvVGHYjZeLXWYsuIGU75PUISci0ykGgkVZyhcHWo4+K
         VoYCANtXwlNn6iM/MBZkiFedsqJiSAfK7Jl76X797+KFvSm041Tr5O27e9mg8xVRQUkt
         kzHa5eoKBke7vQkSbTgIGBhO7/OUVd0LSKU0ktV6PHtvMS9Qx6SZlcBQwGQLwNrcOxNW
         8M5ngfCAN9SpQitdIaDxUVRhz7/qlH0AiBZNihZiuc2DXhxJcLdQ/DrEMlhw909gv4Ac
         wBK5sruKB3z7OlrEd645oE5YzMvGUKAQKt5WPwtlsNeTkXZzKye6K3hew7MLPo5YjGrk
         q2Zw==
X-Gm-Message-State: AOAM530qxXijanSDqD2WEePOa5WecagjdZRzDre8opoeU9XNGdTeFADJ
        RakwT2V3sclBwIZt1UUT34kB0QkT1172/oTeLKXoyL/R5OPx9YbflMhKHsgrjGpJqM/rAFBTotb
        E6rSRM9SHcbrDSVv/RYArSVPGj1gOewRtMklCFipJag==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981750wmi.107.1614940230676;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy800OFDrvV/rynegL9gdp5sOoCnfFTAFviFAiUlwZkphbdPaIzFS7W/py4nWV80SKpjFhzmQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981727wmi.107.1614940230567;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id 1sm3878530wmj.2.2021.03.05.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Subject: Re: [RFT PATCH v3 18/27] tty: serial: samsung_tty: Separate S3C64XX
 ops structure
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
 <20210304213902.83903-19-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cf61a889-b84d-f788-52f2-9b68bcc83d52@canonical.com>
Date:   Fri, 5 Mar 2021 11:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-19-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> Instead of patching a single global ops structure depending on the port
> type, use a separate s3c64xx_serial_ops for the S3C64XX type. This
> allows us to mark the structures as const.
> 
> Also split out s3c64xx_serial_shutdown into a separate function now that
> we have a separate ops structure; this avoids excessive branching
> control flow and mirrors s3c64xx_serial_startup. tx_claimed and
> rx_claimed are only used in the S3C24XX functions.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 71 ++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 17 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

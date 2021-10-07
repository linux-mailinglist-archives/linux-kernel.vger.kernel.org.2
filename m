Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1784D4253BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhJGNMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:12:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35766
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233155AbhJGNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:12:37 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F14223FFE9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633612242;
        bh=JhSvZ4bZ9XDCLRxn5WXaBJyzQncLRhcDh11CxYaApWU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ssev8JtnHQHs3Uo1y0JyESJ1LF0vVKOGk7MddSRvqDn1nKPgVjgtKjsZrSTUSHV1p
         rr5ea6VPIqhHsrL0SWS9DZib+ous1r7eLD6KdzjHUq3J1iDFCQloN3kmPF/x+Otfqg
         pTObyuAR+rIQIq6FZWZoNfS+vSBvaB2PFC+U6EGFaA2k1+5Zz1IP4PCNR9WHpf+SZX
         d17+NZDC2KRpWsQuI2zv3tb1EYNf7c8ThrfdNsqPxxxIWyUYU8Tv4/LkKEcQcoZhND
         TIxfGlQjVf8cR53n4vfCYWsqRPC5t9b2uaEtuBTOm4zgZDClUo1bKe653iyZKCiAlG
         zyMVHjmXTsQaA==
Received: by mail-wr1-f69.google.com with SMTP id a10-20020a5d508a000000b00160723ce588so4648472wrt.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhSvZ4bZ9XDCLRxn5WXaBJyzQncLRhcDh11CxYaApWU=;
        b=ZnZlOfAciEK9q5BE1PooHTGYXJlyJJIoZVXwMzTktFVwlj21Bg5fSVQHSAZyTceZIM
         goe1xtQZn3pC7G2on3yTlT9uCggASUfE/RZjmccr7GHF9VkQ2NsszJjGs3hp+CZ3/aqE
         L8BNVMKVoJ9mI2oH2eTaKv0AxGIVt21QpbSLYIk7FCTQJvUgHwWTOf4rukkLkClJBz8J
         1OAPrHxdGd7Vp9L0L/GDZkz1eY+N9s6YG/QEFCtvEbSKXMFCkuYagLqJxGY5PAbg3tM4
         yH2prGLrpG0bZCgSydVNUKzwwGYh7Ieep8ypyKSBbP5N5E4afkE/YHnuClVHjsn9Sn/N
         Nyyw==
X-Gm-Message-State: AOAM530zzXrfZWu+nu8uQIW8rK12+gVL+VH2EUv8+sPIP/u2JrkS605n
        s+JjixAY4tWg/GHclUWMmTU32MHYAf+0rzH3cMIuCm53K4pH3+onKYhdYestnJccy7IEhjfsS4n
        /btQtOcp31MvB8D7TH+KRBhMMYPyJ2rGcelwvQKvt4A==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr4569222wme.3.1633612241869;
        Thu, 07 Oct 2021 06:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLwRYPKIpB+6rBu8rzxazPdAbZRZWVT14g4gFsnMg69geQZ9M20oFRASa/T2iiTTB4yzVtpw==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr4568961wme.3.1633612239499;
        Thu, 07 Oct 2021 06:10:39 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id v16sm2571457wrq.39.2021.10.07.06.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:10:39 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-2-marcan@marcan.st>
 <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
 <57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a5d52d94-4d42-6842-a40f-db25d2581929@canonical.com>
Date:   Thu, 7 Oct 2021 15:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2021 17:26, Hector Martin wrote:
> On 06/10/2021 15.56, Krzysztof Kozlowski wrote:
>>> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>> new file mode 100644
>>> index 000000000000..0304164e4140
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>> @@ -0,0 +1,74 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
>>
>> Please don't store all Apple-related bindings in bindings/arm/apple, but
>> instead group per device type like in most of other bindings. In this
>> case - this looks like something close to power domain controller, so it
>> should be in bindings/power/
> 
> This is a controller that, right now, is only used to instantiate device 
> power management controls, but the controller itself is just a generic 
> syscon device. Depending on the register range, it could conceivably 
> encompass other register types (e.g. clock selects) within it, though 
> I'm not sure I want to do that right now. Apple calls several of these 
> different register sets as a whole a "PMGR". So I'm not sure if it 
> really qualifies as "just" a power domain controller. If we want to 
> restrict this to the power state portion of PMGR, then it might make 
> sense to call it something more specific...
> 
> See arm/rockchip/pmu.yaml for the setup this is modeled after.
> 

Makes sense now and actually few other designs including Samsung Exynos
have it as well.


Best regards,
Krzysztof

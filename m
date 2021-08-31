Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082AD3FC7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhHaNEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:04:55 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40640
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233132AbhHaNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:04:53 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B36284017E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630415037;
        bh=qDh+jaB0np2Ma4qQPLUONgv0hkCk0/2/t0zPMqiZXPk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=UzTEnwFsdJONS1Cp9/apf1twDjul36NWZFWPANsFja/7BB3ieYJ4H2MRWMwAI6Kbd
         kWdKk/eYLFKKBNlVdlTgFfx4VwkOwl3xDNHG1kdg2v57Ca9d6TIfglj1Y7vFTeRe/a
         E9TqVckQVBkfSBnlpH4xBSD69GTxcSdJq65BkmTp7tZXJuT6/+fh9KmijL4a7oMdxD
         hJupMgWd2rKK+VFr00jafqmgVNCZrXzcDF0ra1ACUuv6QXp1k7kYa1/rtuQ7Bk4UHu
         aeq967iV8q+k200kpmKUYUbxAM34d6Xyh1lqhwdf1htutDUCdwgrn7ld5BCmC6ffQG
         n4o8PMxzD5xkw==
Received: by mail-wr1-f71.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so3980462wrx.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDh+jaB0np2Ma4qQPLUONgv0hkCk0/2/t0zPMqiZXPk=;
        b=rOS71kRHVvRsJd5bLoBw6oFDGV/JWmBS2OOCk6KoFPCN6mJCa6tbNJ4OvobCQG40+O
         9G9P+kVz8SC1bPJep6QQFx2tkI2yiJb0/w1ZxR2i1TFjqK+zMTFC54AVThX5PqqTrqYH
         dSNnJ0vp9Fo+OhxTAOnjfJKEpKaoerB6LyTEOmN3aJS571/3MDlksxkyhl1Mngiui1dq
         dX9Bd0r2IRuhfixJIWNZVKAR+lT/gY9MsopQyaH7+rBTRMD93dtYmFW1ChAdxWMRVv+N
         j0MQig11jJfM2G36M/NDZoTQUapbu4tdTHwS/WzPj/OyvWbLVAm1YhvBPf0dqvItAbeU
         6liQ==
X-Gm-Message-State: AOAM532JDj+i7NK0pRBWJ7RjXu5+tSv4TnPhtSHYdenuDGKuBmqWBJHh
        AM4bZms3Vvv4GXxUA+AGTZr49E57UrRpSj+5sAaWSxj9yXTgcOdMbT1E54ewQ5/+G/PRRU00tMh
        tiXFHDGnFoSh2Jt9qFqebEBzSDzP4mPw4mNxiTl/zFQ==
X-Received: by 2002:a1c:98d2:: with SMTP id a201mr4148671wme.89.1630415037217;
        Tue, 31 Aug 2021 06:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeqlQimbRGjw6jejCDWBCWbWbg+R0a4qSrqXfxkK2pAyisDvv0rWZSb1NBFkB7+rE1teZl2A==
X-Received: by 2002:a1c:98d2:: with SMTP id a201mr4148639wme.89.1630415037010;
        Tue, 31 Aug 2021 06:03:57 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.63])
        by smtp.gmail.com with ESMTPSA id l15sm18300749wrv.84.2021.08.31.06.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 06:03:56 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] dt-bindings: clock: samsung: convert Exynos4 to
 dtschema
To:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
References: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com>
 <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
 <CAL_JsqJvEgqvnTokdNjOR=XdY89TdZxUXR4--P1FXVj75z3tgA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d5e75754-4724-9cbf-d07e-47c40cfa130f@canonical.com>
Date:   Tue, 31 Aug 2021 15:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJvEgqvnTokdNjOR=XdY89TdZxUXR4--P1FXVj75z3tgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2021 14:36, Rob Herring wrote:
> On Wed, Aug 25, 2021 at 8:41 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Merge Exynos4210 and Exynos4412 clock controller bindings to existing DT
>> schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/clock/exynos4-clock.txt          | 86 -------------------
>>  .../bindings/clock/samsung,exynos-clock.yaml  |  3 +
>>  .../clock/samsung,exynos4412-isp-clock.yaml   | 64 ++++++++++++++
>>  3 files changed, 67 insertions(+), 86 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
> 
> [...]
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/exynos4412.h>
> 
> Where is this header? linux-next is now failing:
> 

Argh, it should be exynos4.h. Stephen mentioned it but I missed the
difference in number. I wonder how it passed dt_binding_check on my
machine...

Sorry for the mess, I'll send the fix.



Best regards,
Krzysztof

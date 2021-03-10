Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1133422A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhCJPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:54:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhCJPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:54:22 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lK1AD-0004nJ-AY
        for linux-kernel@vger.kernel.org; Wed, 10 Mar 2021 15:54:21 +0000
Received: by mail-wr1-f72.google.com with SMTP id v13so8171918wrs.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14FPz1l6aS2SCug92QhFgOtMYZ2KTboq6wLTNYV4gRU=;
        b=ETBKxntAUZBd8CtaAB3t8zsaS2C298HNGC4ZOSJRjSScYRtJrT1BesBiBUFTBymQOK
         hsqkrpZKcketVWi0rGY5lOxVUyoknURW9Iw5oIrmJvixZ17a5NhugDPbNz1QQDcMBqqV
         b18BF1llx9l+61w1odx4peZpASshDy6rUv9moKzOKNGBHM+tg2cqIsQsVvN8abb1i0wH
         6Ttrm+pHBAEp9ciaVO8+L8c7+sT23wZkMLG78QE5X80hlDHryW8hMmJ35kjjU3/BYFnL
         bbAKhnNDeUEdWo5kV9hC4cUNUVCSWCzkeBkcKq55OncA691YzjZC3F7dTb0EjHFrtGRs
         rV3g==
X-Gm-Message-State: AOAM533FDQU0WMP21LjmHL+VGNjhFO4HAWmDBogltDI02eacmjrB5j0B
        bQKdBfqJvPfrTWqdHDRwzuBTLYSx1jxW0aKCNfiZOzmGcv644Ctowyf10GHUa9KeNTjvD2bAEcd
        v7PfOYxyRnZER+xiutlUMe79i+0ZfNt7CxcOAPKTq6g==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr4060599wmc.9.1615391660978;
        Wed, 10 Mar 2021 07:54:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYVlIoIwJAU38MnjUazA5nQqK16xaytYspMDuXR9nuYZruHOq/jCZGaK71U4tP9AymiD6NlQ==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr4060585wmc.9.1615391660799;
        Wed, 10 Mar 2021 07:54:20 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id n4sm9584462wmq.40.2021.03.10.07.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:54:20 -0800 (PST)
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tom Rix <trix@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310094527.GA701493@dell>
 <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
 <1c06cb74-f0b0-66e5-a594-ed1ee9bc876e@canonical.com>
 <CAK8P3a1CCQwbeH4KiUgif+-HdubVjjZBkMXimEjYkgeh4eJ7cg@mail.gmail.com>
 <52d0489f-0f77-76a2-3269-e3004c6b6c07@canonical.com>
Message-ID: <ba2536a6-7c74-0cca-023f-cc6179950d37@canonical.com>
Date:   Wed, 10 Mar 2021 16:54:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <52d0489f-0f77-76a2-3269-e3004c6b6c07@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2021 16:47, Krzysztof Kozlowski wrote:
> On 10/03/2021 16:39, Arnd Bergmann wrote:
>> On Wed, Mar 10, 2021 at 4:06 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com> wrote:
>>> On 10/03/2021 15:45, Tom Rix wrote:
>>>> On 3/10/21 1:45 AM, Lee Jones wrote:
>>>
>>> Many other architectures do not have vendor prefix (TEGRA, EXYNOS,
>>> ZYNQMP etc). I would call it the same as in ARMv7 - ARCH_SOCFPGA - but
>>> the Altera EDAC driver depends on these symbols to be different.
>>> Anyway, I don't mind using something else for the name.
>>
>> I agree the name SOCFPGA is confusing, since it is really a class of
>> device that is made by multiple manufacturers rather than a brand name,
>> but renaming that now would be equally confusing. If the Intel folks
>> could suggest a better name that describes all products in the platform
>> and is less ambiguous, we could rename it to that. I think ARCH_ALTERA
>> would make sense, but I don't know if that is a name that is getting
>> phased out. (We once renamed the Marvell Orion platform to ARCH_MVEBU,
>> but shortly afterwards, Marvell renamed their embedded business unit (EBU)
>> and the name has no longer made sense since).
> 
> I wait then for some ideas from Dinh (or anyone else).
> 
>>
>> Regardless of what name we end up with, I do think we should have the
>> same name for 32-bit and 64-bit and instead fix the edac driver to do
>> runtime detection based on the compatible string.
> 
> I can rename ARCH_SOCFPGA on 32-bit ARM as well, however converting edac
> driver from #ifdef ARCH_SOCFPGA64 to proper compatible string will be
> too much for me: I am not able to test it.
> 
> This edac Altera driver is very weird... it uses the same compatible
> differently depending whether this is 32-bit or 64-bit (e.g. Stratix
> 10)! On ARMv7 the compatible means for example one IRQ... On ARMv8, we
> have two. It's quite a new code (2019 from Intel), not some ancient
> legacy, so it should never have been accepted...

Oh, it's not that horrible as it sounds. They actually have different
compatibles for edac driver with these differences (e.g. in interrupts).
They just do not use them and instead check for the basic (common?)
compatible and architecture... Anyway without testing I am not the
person to fix the edac driver.

Best regards,
Krzysztof

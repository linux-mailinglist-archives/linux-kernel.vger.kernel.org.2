Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D8413A00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhIUSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:22:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34222
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233373AbhIUSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:22:20 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D2FD4027C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632248450;
        bh=s1x0s0nZoSfkDljorxbVXRoxNOeXqYSIOV8lCyGgV/M=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=OuMq8TuW98drYQVUd6qIyfwLIV+l0aD1dljAtR9Qgrut7WqnGE7qjLMfn9gS0Uz2q
         7k8akZJm8/yItZ1RAYIpdAjDeGzxA3NUOv9XTMgGSOb+NmwR/AhRSRZIrGpdDFQD+H
         YkowoHGlYv7UHc0JcZHQHATJbnDj47YTSjydUa3HPxPwPvEYs+piTLxdwFtFEEXqWm
         gmPDfcr7rfrgfYBwwZS8WmIqY37yFNB201YUgMOnSVkwRZjzUmojCzGU+lJauHbb3I
         PlyVsoC5n5Ad7+6plKI5trJrzbgieb3p48CdU9GggF+iaiRkt0g8jme6xawxj4EIfr
         RkbeDiWD1LJLw==
Received: by mail-wr1-f70.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so9558639wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s1x0s0nZoSfkDljorxbVXRoxNOeXqYSIOV8lCyGgV/M=;
        b=Feg+n/LN++B5RyH9YHtQfijdxvawAD4f6hf31AmiB5q6a9bDdiodj7A9vtEGznljwX
         HPcyJ3NReNzPx3odUeWRfW8DDIQ6cxtszAP4gAo3GNOcmzpPFpDFkLBzUwj4x6G5slpx
         ntrV8m2JPkUwxFPGQ+ZUlpNVlEQQ1YIZGloXQJlUMWjmgwA8ghzL6EGhCT63arTOSutD
         CwfIcR+sQpYuJLPemZQrWGSbZ2PGtopmuSYSAP4EMVnA9euQ1i1BLl53licU3v7nTsjV
         yE6TYXFJTRYgAcTUiYBIohGnhsMdomm5NAnUClLZTiyDoM5m+Q3nsQLDqq4Zu+/Mu+C+
         G/yA==
X-Gm-Message-State: AOAM532+4Je7gyCsrBCBN1yl9Ov+yvJ/W92OwbKinRIAUoo7LUiTKH/J
        Bfi8z7T3Y3qU8bvlelCoYkfSSQTrsvajXqd0dfSV0UUPF8lpArm8bUK+HdTYSDc4PRXSamqTuWf
        7V7ER7ELGvVZUhPbHeNwV9vxNPG5qHJse/UEcMkCtcQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr6116127wmi.163.1632248450029;
        Tue, 21 Sep 2021 11:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzFXWldxf5QmNutieh/xiyRvCC3i4k/pd4YG3SgGB01SyUaFQH3M57JkcGsRr4RuTJRGTbMw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr6116109wmi.163.1632248449844;
        Tue, 21 Sep 2021 11:20:49 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l124sm3715171wml.8.2021.09.21.11.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:20:49 -0700 (PDT)
To:     Will McVicker <willmcvicker@google.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-3-willmcvicker@google.com>
 <2b48a41a-9130-b4cc-40d3-0bc7930ac76a@canonical.com>
 <YUmVj80m/rEC2mT7@google.com>
 <CABYd82a4OwxHNUUmUtBmTpSvWLu-f4sepHMF49kPQtWLU3MkDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v1 2/4] soc: samsung: change SOC_SAMSUNG default config
 logic
Message-ID: <ad2de848-8fce-f275-25de-83a886243645@canonical.com>
Date:   Tue, 21 Sep 2021 20:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABYd82a4OwxHNUUmUtBmTpSvWLu-f4sepHMF49kPQtWLU3MkDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 19:45, Will McVicker wrote:
> On Tue, Sep 21, 2021 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> On Tue, 21 Sep 2021, Krzysztof Kozlowski wrote:
>>
>>> On 20/09/2021 21:03, Will McVicker wrote:
>>>> Switch the default logic to enable SOC_SAMSUNG and it's sub-configs to
>>>> be enabled by default via "default y if ARCH_EXYNOS" versus being
>>>> selected by the ARCH_EXYNOS config directly. This allows vendors to
>>>> disable these configs if they wish and provides additional flexibility
>>>> to modularize them in the presence of a generic kernel.
>>>
>>> This is not true. Vendors cannot disable these options as they are not
>>> visible.
>>
>> Good point, well made.
>>
>>> Although I understand that Arnd prefers this way and I do not
>>> object it, but your explanation is incorrect.
> 
> Thanks Krzysztof for the reviews! I'm sorry I missed the whole "hidden
> configs" part. I'll upload the series to include the fix that refactos
> the Samsung SoC drivers menuconfig which will address that and allow
> one to enable/disable those configs. I'm going to hold off though
> until we hash out the rest of the discussion in the cover letter
> email.

No, please first read our discussions, including Lee's and Geert's
comments. The drivers should not be converted to modules or made visible
if such configuration does not work. If it works, please describe your
testing setup.

All these drivers are *necessary* for a multiplatform kernel supporting
Exynos platforms, therefore disabling them does not make any sense (if
you support Exynos platform). If your kernel does not support Exynos
platform, just do not select ARCH_EXYNOS and problem disappears because
none of these drivers will be visible and selected.

Unless you describe here some out-of-tree kernel which wants
ARCH_EXYNOS, because vendor did not upstream it's code, but you do not
want existing Exynos upstream drivers. We do not support such
configuration. Please push your lovely vendor to work with upstream.
That's the only solution.

It's the third time this abuse re-usage of ARCH_EXYNOS appears and the
same as before - the vendor does not like to upstream stuff. There are
few guys trying to upstream recent Samsung SoC support by themself (ping
me for contacts if you would like to participate) but the one party
which should be doing it - the lovely vendor - does not actually
participate and instead sends ridiculous patches like this one here...
or like this [1] [2].

Nope, please work with upstreaming SoC support, instead of abusing
ARCH_EXYNOS for out of tree code from the vendor.

[1]
https://lore.kernel.org/linux-samsung-soc/001001d5a03d$05de1f70$119a5e50$@samsung.com/

[2]
https://lore.kernel.org/linux-usb/20210303022628.6540-1-taehyun.cho@samsung.com/

Best regards,
Krzysztof

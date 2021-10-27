Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B643C3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhJ0HeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:34:23 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36074
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240468AbhJ0HeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:34:22 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 840493F17B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635319916;
        bh=2s/FQ79PC6XkEYiIzPy8bx8P14QzrSmxySRxZyJ5I+g=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U4fnaFa/z2KU9TFg768RKyGh87x5gDHO2CzNUQ2KjIW1VmIdGwRXRjbO46eYInSJp
         l0DSKW1YzntjOYetWoVIPJvE8FPJeLZ4aqhuAGw6mZoXr9i7/GBnbckjYAmRnBZw2E
         XhV7erGaIt/5R6UCvum+R4JnKjiWiMFnvrdcyLAPceT+wAExzNuWazpYaQc7yMUQwA
         y/NHi5iM0jZon80LKVIHuJ5Ps4jChJuNRIkSmsPUPPb3VYedozCNS6W7FW+xj6Bvw8
         1GQGJL+p5T7BxMHVAezauUhf6KH/OB80k3PR9Wx+knFTBr/jlJ1Nxg0kLRyg7GQacm
         1wz+4gB1jOPyQ==
Received: by mail-wm1-f72.google.com with SMTP id y12-20020a1c7d0c000000b0032ccaad73d0so872816wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2s/FQ79PC6XkEYiIzPy8bx8P14QzrSmxySRxZyJ5I+g=;
        b=CKvo6qlaRtNLXxFSBpUJjTY9Av/Fe38zQhmjToeAzW8i/pxGuDZTHqMgpaUXC2dzMJ
         BYOYO77Ig0g9wn7nQHRWv9kTT5AxqVX3l3IphbYPqqCle3Qa9PUoG9q78Ud5dbEbmM+J
         frci/U4AyM492i6Pd2rawXxB7ewDMWawQvTVpZ6+XaZ2yrDR1TQJR5odELocR1vnk50D
         eA0CHg9VkwqWsLViSXVV5MGLsFLkmcWSg/MCvbhkwaM+L7MclRe5RU+jd3zoJpttGaoz
         vMCAeOXoraoDfgogB23l4YQAfLuuf/EzVuaR+hcdcfQtRAAcYNurOWR12cC+tuksV+GZ
         vOzw==
X-Gm-Message-State: AOAM5311uC+OfQylF0tG2t9qDXxUb37lprxG0TtjYh3LIBwVGvhs+FQm
        6V7UjQrNH2WpH4OJYiHr5pnAJ/S5E+MVwkwWW4hX8R4cIiAwLnq7yTeSikbOiyETmydcajjx0AE
        jxOdbH7nfOt8HmwWt1lTx77mRqNfJR9LbQYNIMkOpzA==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr3910066wmc.165.1635319916223;
        Wed, 27 Oct 2021 00:31:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAa8hTgfeIlBDfFWTQRAvviX6QL7re5ZcjzQ8pDZ7Uc0nekEP6wY4UvbzxYdJvKiPo7Oy8Xg==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr3910043wmc.165.1635319915921;
        Wed, 27 Oct 2021 00:31:55 -0700 (PDT)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id h22sm2872326wmq.42.2021.10.27.00.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:31:55 -0700 (PDT)
Message-ID: <a4f8fad0-4ae4-5a7e-1691-ae46abd061fa@canonical.com>
Date:   Wed, 27 Oct 2021 09:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
Content-Language: en-US
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagar.kadam@sifive.com" <sagar.kadam@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <mhng-5dc2aa26-9f1c-4764-9877-6d99569210b4@palmerdabbelt-glaptop>
 <DM6PR04MB7081C64D27D133CEDE728393E7859@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <DM6PR04MB7081C64D27D133CEDE728393E7859@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 04:31, Damien Le Moal wrote:
> On 2021/10/27 8:58, Palmer Dabbelt wrote:
>> On Tue, 12 Oct 2021 09:46:58 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
>>> Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling
>>> the one and not the other does not make sense.
>>>
>>> As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will be
>>> needed DRM drivers should be compiled as modules.
>>
>> Do you have an nVidia card that works on real hardware?  Last I checked
>> was a while ago, but they weren't working at the time (IIRC it was
>> something to do with PCIe addressing, but it was a hardware limitation
>> so I don't remember exactly how it all fits together).
>>
>> If they work then I'm happy to flip them on.

My SiFive Unmatched is running KDE on a GT710.

It would be unfair to treat the two major GPU vendors AMD and Nvidia 
differently.

> 
> Why enable this at all ? If they do not work, then disabling theses cards make
> sense. But if they do work, isn't leaving the config to be the default defined
> by the driver the preferred approach ? Otherwise, we will eventually end-up with
> a defconfig that has everything enabled...

If you want to get your system up, having keyboard input and GPU output 
is the bare minimum that you need to proceed unless you are a developer 
working over UART and have a second system available.

To keep the kernel small DRM drivers should be modules.

Best regards

Heinrich

> 
>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   arch/riscv/configs/defconfig | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>>> index 4ebc80315f01..c252fd5706d2 100644
>>> --- a/arch/riscv/configs/defconfig
>>> +++ b/arch/riscv/configs/defconfig
>>> @@ -72,9 +72,10 @@ CONFIG_GPIOLIB=y
>>>   CONFIG_GPIO_SIFIVE=y
>>>   # CONFIG_PTP_1588_CLOCK is not set
>>>   CONFIG_POWER_RESET=y
>>> -CONFIG_DRM=y
>>> -CONFIG_DRM_RADEON=y
>>> -CONFIG_DRM_VIRTIO_GPU=y
>>> +CONFIG_DRM=m
>>> +CONFIG_DRM_RADEON=m
>>> +CONFIG_DRM_NOUVEAU=m
>>> +CONFIG_DRM_VIRTIO_GPU=m
>>>   CONFIG_FRAMEBUFFER_CONSOLE=y
>>>   CONFIG_USB=y
>>>   CONFIG_USB_XHCI_HCD=y
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9D40A6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhINGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:31:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58222
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239936AbhINGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:31:29 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 984CF40268
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631601006;
        bh=mGyLy4lM5okQDmHALZVjk94Ha/DQjAy4TbWZ9Q6x1pw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=dab3kxgn8aTjAzUDiwBy6Fs7tWZJthSo2WvtKu4+4OpTlDUk8jS4e7+iG8rMd+K2C
         ad8mX/ilGascPhQV7T+gsQH5r/ZnFzJf40ZSczqUMXuUZMK4owJEOlGJNvUtJ1mYy8
         KN6HLoAeCkfROWg/kEUxYgE0wznYmMCGN+Kg2MaU6G9SF4Ow8sDOS/OK9gihEevqtp
         ppkPRBc8NZgHiEQDKpsy76HbVvzFwuEJ0uVQT2TUY0J5fp2vmcpKtGwIy2pbxTVaNF
         yF7S2dDIf8oL9U9ZvHixu8OoWUxW3i/6n3EkEWO1uOkk0Umot0HpWyq+nDFlUhQqvg
         sdfP/zdi9D8Kw==
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so5994413wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 23:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mGyLy4lM5okQDmHALZVjk94Ha/DQjAy4TbWZ9Q6x1pw=;
        b=6i9XgEE7gIApn+yTpil3BVQTE5MJkyfkGW4imgIbV9Aqca7dg3ZV6v3TUvlKPnXKlZ
         fFA2IL0tAPORHKXOBVRb08aDONbzqkxHzSqLGwc4vVZpAScb2vhwrBfr2NkHc6XQ95pZ
         fVW5M4bcLO+UQiO0I+Pal5QQ0k1MX8d00Dc1cGzNWO/GzaWDZb6TSwdN1Wwu7IJDRjX4
         B3FUUlr0AC7CcWZyWzpoL7jf2DhrVR2zfDNCuetYLs+FwpGzmYfAolm/Jz/qX12aULqA
         FTzuAWMR1bTTp4xk3YjMXQv8wPKN9pwDnp3al44FbngqXgpShABhNz2dobBV24k8lOoS
         7lrA==
X-Gm-Message-State: AOAM532BFUNSKbLx+vdFr0VGOYMK2KbwGI+dgKSPZehaAFb6uYMB4Lq/
        UIlWKZfDii+TSLVVDoW4AoMjaxlH88+PAdTe5hvYKvbMdRBVO9hs3Hsv5JSZZDbsDiombD4BV8d
        wCviJHJ1Rd63hWafrLjCH892WwH31qfsAQUzUWdFXcw==
X-Received: by 2002:a1c:46:: with SMTP id 67mr281427wma.29.1631601006117;
        Mon, 13 Sep 2021 23:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyoWwYhUPQD2O/E5bqOQvwgFgn3xJyU4lqo4GZBhWWfuNE3Yxbbaofe70nMKnO2KpYYR1x0w==
X-Received: by 2002:a1c:46:: with SMTP id 67mr281401wma.29.1631601005871;
        Mon, 13 Sep 2021 23:30:05 -0700 (PDT)
Received: from [192.168.178.189] ([46.253.247.67])
        by smtp.gmail.com with ESMTPSA id q201sm182015wme.2.2021.09.13.23.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 23:30:05 -0700 (PDT)
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Samuel Holland <samuel@sholland.org>, guoren@kernel.org,
        Liu Shaohua <liush@allwinnertech.com>, wefu@redhat.com
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
 <e46bb02d-961d-672d-76c7-9844d76ee69b@canonical.com>
 <9cd8db15-7431-dfec-6e48-dcf6b30d4f6c@sholland.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <b6ea6e53-cb38-3b4c-c8a1-241e48e123ea@canonical.com>
Date:   Tue, 14 Sep 2021 08:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9cd8db15-7431-dfec-6e48-dcf6b30d4f6c@sholland.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/21 7:16 AM, Samuel Holland wrote:
> On 9/13/21 10:49 PM, Heinrich Schuchardt wrote:
>> Calling a Kconfig menu item "Allwinner SoCs" which includes all
>> future Allwinner SoCs irritates me. How about CONFIG_SOC_SUNXI_D1
>> instead?
> 
> Would you want to have a separate option for each new SoC? That seems
> like the only way to split things up, if you want to be more specific
> than than "sunxi" (or equivalently "sun20i", which is the codename for
> the RISC-V series).
> 
> Except at the very beginning (sun4i-sun7i), there have not been clear
> generational boundaries between the various sunxi SoCs, so most of the
> 32-bit ones already get lumped into a single symbol (MACH_SUN8I). And
> there is a single Kconfig symbol, ARCH_SUNXI, for all 64-bit Allwinner SoCs.

On arm64 we have avoided SoC specific Kconfig symbols and left it to the 
defconfig to select all SoC specific drivers. Generally the tendency of 
the defconfigs is to provide a multiarch kernel. So this should be ok on 
RISC-V too.

I was just concerned about the 8250 driver assigned to something called 
"Allwinner SoCs" which didn't seem future proof.

> 
> There is enough overlap in peripherals that you need a common symbol for
> the peripheral drivers anyway. How about... ARCH_SUNXI? There are 90+
> uses of this symbol throughout drivers/ and sound/, and I have found
> that more than half of them apply to the D1 (see e.g. this commit[1] and
> some of its ancestors).

Looking at the current use of ARCH_SUNXI in drivers reusing the same 
name on RISC-V makes sense.

Best regards

Heinrich

> 
> RISC-V has so far adopted a CONFIG_SOC_xxx naming scheme, which is
> different from arm/arm64's CONFIG_ARCH_xxx pattern. But now we have a
> case where a SoC family is split between the two architectures. I'm all
> for consistency with the names of other RISC-V platform symbols, but it
> seems that reusing the existing ARCH_SUNXI symbol would be better than
> cluttering up the driver Kconfig files with a duplicate.
> 
> Regards,
> Samuel
> 
> [1]: https://github.com/smaeul/linux/commit/7841e5c32366
> 

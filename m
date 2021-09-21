Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41790413039
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhIUIhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:37:23 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35006
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhIUIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:37:21 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3CE043F226
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632213353;
        bh=lQRT6EGGve1EBnMNNxr8uMFKa9VogaceuvltbqBrtr8=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=V5Ar01ZNphCZj8Na1gOBq7Qvw566jlPqmlah2+FMP6sGwGjQQBIBAddnPWWDOui/V
         jYoUBr+jqXfxAVibGMdUt3HHRK7nFKnTEEMtuywYzYIBmzUVqXa83I+QIr82LgGQEH
         XlSHAhSjfnXahYcxD90phiJzgzXCwvKZR/6YGtyG2fuYNN3HKiWGsAr2WThTCh19Z3
         TGQc3agt+Nstl9FcYiNoqlbRXDWZ0iFX2MzQiblboKfIb/NrjrQernd2eej3URKiLU
         S/6u0gakPtlyYpj5ZbPNKCEYEnB0ncYo3Fayst6tM676U8lyRv+zsimf8czavu1WHL
         6CjnrpVPIFmtA==
Received: by mail-wr1-f69.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so8198098wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQRT6EGGve1EBnMNNxr8uMFKa9VogaceuvltbqBrtr8=;
        b=ilh42GnQ9Y6M5YYpJZR77PWjKxJqpYitxkMLu6CtYuv+fnKuBBSU+TT300cWMGOquS
         cahx9zd5CgbR16ryftkmXoIxtq0Pedbpo0Zk2gOguVsPm6isQk2u6LLXRhxoHj19g7kf
         uSOSK0+WYnoB00r0o+hiLR8Orxh4aHDyPNMC07Q4mnqm96TwTTMKVlixIsF6AYO3pRt1
         ODxvHHPS/c/JN2tmdEU/enAFkIiiU5JTKPbcvjfReXjKurJKyi9L4LZ1gQ4s9UEcUhDh
         6kZYqyuk0nkSjhkhngK0Kzu7yWoHS9M1EjjIVArubQ6GoiSmu3FQyIdOa4cBXU3UadeP
         VA5Q==
X-Gm-Message-State: AOAM532fA+GPBv/Z9/ZYs/Gz+uif4bMSOw2je8ldCO5bi5ovtkalsJ2S
        Tky9xtr7dSnl6U3fJ2Nw8nIcgoeVpppwgtJGR1kQ/KdRmNAmRfO6UVg17NfsdFSjzxo7QtHvVXJ
        fDjgprnD7n6zDEagg6pH4XdpfJdjDkDtqCvtXyrd3Aw==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr3357162wmi.10.1632213352914;
        Tue, 21 Sep 2021 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDvUrXflYulapeJv6L1lTo5OVRdOzoWqHitDx/QOp0/pTxHCrxTBBq7VpLs3ZVu4Jpt3sotw==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr3357151wmi.10.1632213352769;
        Tue, 21 Sep 2021 01:35:52 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c185sm2235289wma.8.2021.09.21.01.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 01:35:52 -0700 (PDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-2-willmcvicker@google.com>
 <a8d40b96-bcb2-5eb6-b0e5-c20c14471c8a@kernel.org>
 <CAMuHMdWdHF49qj+qV-DnbDDv14J3y98TPHd_6y_i7o7_azhErg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v1 1/4] clk: samsung: change COMMON_CLK_SAMSUNG default
 config logic
Message-ID: <2c8a79f7-711a-b075-745f-ea77b82a1117@canonical.com>
Date:   Tue, 21 Sep 2021 10:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWdHF49qj+qV-DnbDDv14J3y98TPHd_6y_i7o7_azhErg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 09:50, Geert Uytterhoeven wrote:
> On Tue, Sep 21, 2021 at 9:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 20/09/2021 21:03, Will McVicker wrote:
>>> COMMON_CLK_SAMSUNG is selected by ARCH_EXYNOS which forces this config
>>> to be built-in when ARCH_EXYNOS is enabled. Switch the logic to use a
>>> "default y if ARCH_EXYNOS" to provide flexibilty for vendors to disable
>>> or modularize this driver.
>>
>> The clock drivers are essential, you cannot disable them for a generic
>> kernel supporting ARCH_EXYNOS. Such kernel won't work properly on platforms.
> 
> Obviously it's not gonna work if the clock driver is not enabled
> at all.  But does it work if you make the clock driver modular, and
> put it with all other essential driver modules in initramfs?  Debugging
> would be hard, as the serial console driver also relies on clocks
> and PM Domains etc.

The kernel could boot without clock drivers (default settings from
bootloader), probe clocks from initramfs and proceed with rootfs from
eMMC/SD/net.

In theory.

However I have no reports that it ever worked. If there is such working
upstream configuration, I don't mind here. Just please explain this in
the commit msg.

> 
> If not, this patch should be NAKed, until it works with a modular
> clock driver.
> 
> If yes, perhaps another line should be added (_before_ the other line)?
> 
>   + default m if ARCH_EXYNOS && MODULES
>     default y if ARCH_EXYNOS
> 
> However, many developers may want MODULES=y, but not want to bother
> with an initramfs.  So perhaps we need a new symbol
> MINIMUM_GENERIC_KERNEL or so, protected by EXPERT, and make the
> driver default to m if that is enabled?

Yeah, that's indeed a problem to solve. For most users (and distros)
building kernel for Exynos this should be built-in by default.

Anyway, the option is non-selectable so it cannot be converted to "m" or
disabled. And this is claimed in the commit msg:
"provide flexibilty for vendors to disable or modularize this driver."

The commit does not achieve it.

Best regards,
Krzysztof

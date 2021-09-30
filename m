Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BA41D9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350792AbhI3MX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:23:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42994
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349889AbhI3MXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:23:24 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A8B940283
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633004501;
        bh=psXH7e13JGze4Ceqpc/FfNuVUHKJpQgMmOPZqTVq+O8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=csp1wfHwz2rJ46xbEiiMUwP0GhhqoyMPjG1AfIGwyiSJBfiIi4h0qd6pTPJTp6bpW
         nTt765qRJOVtzNntC5lI/1A8InBpR+Kidke4NrpRbc0FROOR644jyk2MBHeR6HfjkG
         B2emIx9C6/YQXOio4qNLVOeDzUKlUBJLGIxy+I8FD5y5Yx1gWOQEXo3NYzjsEEQzqE
         YG+mj/f3KQOj1EOuCV0MlwcVElXca6OlfCCwlWLl05SevM0X+KBVPnxz+ileT7Jm71
         lDEyxAmA9Svl9EGVCk9OlObUuHaTEjDDmNCGC/K2lXLQl5dqbPfsaBIhWiSX4cQVaT
         DLzN+Xp/2MrOA==
Received: by mail-lf1-f69.google.com with SMTP id h27-20020a0565123c9b00b003fca9e11144so5400181lfv.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psXH7e13JGze4Ceqpc/FfNuVUHKJpQgMmOPZqTVq+O8=;
        b=3ruEce63zxBKLi05NXaA1xVV9AoALT0jZID1xI0I6DO/+XRMliJMKEp0JSrnk0sB2a
         /dHtx1o3SPhQlc3sg/ZfptGfNO3vzEpzRPa2FEWEcds/wIAfiJbDhykejEcgSDtLrmdo
         IvZA0bRvh0JtaFtftsXvIX4AMWwinkpY00UqRHbEJafBrkvNtf5a8OYqM7BOlISjNW9H
         dEHwHuNsMlIaeTdVXOhje3Pqq+PXLXZszICT0XNKxZobAUQyE6v4gNkpVkh54ytIkVBZ
         4uKeUWSZAo9vOD1HQKgNKguf7NwT95dqK2h1WvwdfzcteERQYgk3FzjKa0yI07r+O2yC
         dDgg==
X-Gm-Message-State: AOAM533s9S+/QncObTaoCDTU9Xo0gTpWOlPjCA/zjE+JvgQHLZ/o1+jZ
        KehqqatXlOnw5gVvSf+7ZsjinckOA3GuIJ8IYwouHH1hiw4QtrnBp5YG5drsxam5TTglQgkcWT5
        Ab6VXbG3KUbG8JAQ5AL5TQHFiCaqXpYMrWPjlVSC+yA==
X-Received: by 2002:ac2:4305:: with SMTP id l5mr5441263lfh.231.1633004499559;
        Thu, 30 Sep 2021 05:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpPzoro/RcXsP62t0RoXfe8Sb1d3Eh5d1ulxEp+yM4aqAVEsPnMfSfprUv/3yeGRa/w+mMuw==
X-Received: by 2002:ac2:4305:: with SMTP id l5mr5441240lfh.231.1633004499341;
        Thu, 30 Sep 2021 05:21:39 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id o27sm352431lfi.263.2021.09.30.05.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 05:21:38 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select
 configs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Saravana Kannan <saravanak@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <20210928235635.1348330-1-willmcvicker@google.com>
 <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com>
 <CABYd82YodFDwBxexCv+0hpYrdYEX1Z1CvnRkmnBPkEJNJ4bssQ@mail.gmail.com>
 <c65bf0db-6fd1-eb05-f407-37c41f9125f4@canonical.com>
 <YVWCK5QO331rfhJJ@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <72d27a82-9d4d-1f91-bd1f-ebead3b75ffa@canonical.com>
Date:   Thu, 30 Sep 2021 14:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVWCK5QO331rfhJJ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 11:23, Lee Jones wrote:
> [0] Full disclosure: part of my role at Linaro is to keep the Android
> kernel running as close to Mainline as possible and encourage/push the
> upstream-first mantra, hence my involvement with this and other sets.
> I assure you all intentions are good and honourable.  If you haven't
> already seen it, please see Todd's most recent update on the goals and
> status of GKI:
> 
>   Article: https://tinyurl.com/saaen3sp
>   Video:   https://youtu.be/O_lCFGinFPM
> 

Side topic, why this patchset is in your scope or Will's/Google's scope?
Just drop it from Android main kernel, it will not be your problem. I
mean, really, you don't need this patchset in your tree at all. The only
platform which needs it, the only platform which will loose something
will be one specific vendor. Therefore this will be an incentive for
them to join both discussions and upstream development. :)

Best regards,
Krzysztof

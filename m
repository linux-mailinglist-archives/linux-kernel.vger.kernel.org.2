Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAB41D97C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbhI3MQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:16:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42746
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350731AbhI3MQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:16:50 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DCE740606
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633004106;
        bh=sHtMVee23aJJuvqmywuH7ESFy0k6t0bV8U/1nrqOJLI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FWai4uKiuGxJC4cb1J6/ajTQqZcPLqVwwVCRavKljZtgJ11ostDezYX94sOvYjjVe
         4dFU+vWo6dpzzOmAmcIL4fBg548243WELrXKfuxpGRcW0i+2Hz9oeoM9g/pbv95VUg
         c6fV2jyWsibzj77z6e833xZAeeGc5Yx4f6YCsKW/HfTpYqDwBJZJLunMkqNiCYMUSn
         3n8ei0FkUj2W/+SoFc5dRp2/q3kjM+ZoGwwxd+LlGgz0LwTkWIE0ust28kcSKfQJqA
         KaBZ5PSuorb6JHZxRjXWn1D+tT+grK2zoe2i/8g1Ca45v7T8ALEaLt2EwIKP7SJk/p
         u2VdqGJzFRsLw==
Received: by mail-lf1-f69.google.com with SMTP id bp11-20020a056512158b00b003fc7d722819so5441980lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHtMVee23aJJuvqmywuH7ESFy0k6t0bV8U/1nrqOJLI=;
        b=kNwzLDKk4UvGC7GLPnAlLS2c5mOPV19FEe/gFBGLMnTvQ1vMZpDdpQpFpv5kHylZ4o
         HZKzX9RdD+7U66GIxjHKyc0K+/e2ivVH5qYf+PdAxCwiU6sJkPD9LzbX6rHyqpl3grYH
         QnZgydTM+8ZZbitrvz7akxZSH1a0z5+OT4pNvxmfNa2OKYbMTDy0BP2n/KYvspVrtZXr
         5ZRU/B2IPAWKNd6RuARf6qD6zdOWcvorm80GX2bq/0yMLXFMl76ea/Sv7d+5U7aCdigr
         K0hRphJAkLVTJgrGEyCaE1c6+Pa/puM0HFto8lshlTEbU/4DNnBTTzshUrJJJdoUlK5X
         XWfw==
X-Gm-Message-State: AOAM532rO2twg1ZVbh9LzX6+YRFZfBtc9T20ZGodUfwsODfPZQ9TF81C
        LFOPMpG1SiIFg21fNhRbzxAyLVPHtZU5yAMrp4sTNMpi+al4ORcMA/evMY+gAk99ISjquZdoVwG
        YDLV3wCM6A3g5MFezLtNOMqQmsC1BlxVeyqFiHe7BHA==
X-Received: by 2002:a2e:5450:: with SMTP id y16mr5761507ljd.21.1633004105784;
        Thu, 30 Sep 2021 05:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+cux4wyOirwFRf+O2xj4igckX9azoZlF3oZnFaYbiBaTtiQzVamjgULYK4cmnunDnkNNRxg==
X-Received: by 2002:a2e:5450:: with SMTP id y16mr5761488ljd.21.1633004105601;
        Thu, 30 Sep 2021 05:15:05 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id t11sm350942lfr.281.2021.09.30.05.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 05:15:04 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select
 configs
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20210928235635.1348330-1-willmcvicker@google.com>
 <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com>
 <CABYd82YodFDwBxexCv+0hpYrdYEX1Z1CvnRkmnBPkEJNJ4bssQ@mail.gmail.com>
 <c65bf0db-6fd1-eb05-f407-37c41f9125f4@canonical.com>
 <YVWCK5QO331rfhJJ@google.com>
 <CA+Ln22EbXKsRFZ=3L4A_jqciRxG2hnAh9iKTfQ_Ypr2NJgDzQQ@mail.gmail.com>
 <YVWkxnc8wTdBgRsv@google.com>
 <CA+Ln22FBy2ks9gX3df=rQw-6W3iftMVoqsoqBPchGCqDDoMaLg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8729f109-93c1-24dc-f7d9-9c83d7ac24dc@canonical.com>
Date:   Thu, 30 Sep 2021 14:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+Ln22FBy2ks9gX3df=rQw-6W3iftMVoqsoqBPchGCqDDoMaLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 14:10, Tomasz Figa wrote:
> 2021年9月30日(木) 20:51 Lee Jones <lee.jones@linaro.org>:
>>
>> On Thu, 30 Sep 2021, Tomasz Figa wrote:
>>
>>
>> Is that the same as exporting symbols to framework APIs?
>>
>> Since this is already a method GKI uses to allow external modules to
>> interact with the core kernel/frameworks.  However, it's not possible
>> to upstream these without an upstream user for each one.
> 
> Not necessary the core frameworks, could also be changing the ways the
> existing drivers register to allow additional drivers to extend the
> functionality rather than completely overwrite them. 

Yes, the first user could be within the kernel after modifying some of
the drivers.

> It's really hard
> to tell what the right way would be without knowing the exact things
> they find missing in the upstream drivers. As for upstream users, this
> is exactly the point - upstream is a bidirectional effort, one takes
> from it and should contribute things back.
> 
> Generally, the subsystems being mentioned here are so basic (clock,
> pinctrl, rtc), that I really can't imagine what kind of rocket science
> one might want to hide for competitive reasons... If it's for an
> entire SoC, I wonder why Intel and AMD don't have similar concerns and
> contribute support for their newest hardware far before the release.

Lee used the argument of not-disclosing-edge-hw but I also don't see
much of it in the case of few drivers needed to be overridden. Just
bunch of registers for the same stuff we have sine 8 years. Rather the
vendor does not want to commit effort towards upstreaming these...


Best regards,
Krzysztof

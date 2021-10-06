Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530E8423BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhJFKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 06:51:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59266
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238185AbhJFKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 06:51:23 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B40843FFDD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633517366;
        bh=fHV2H4TjtGE0HYth4tntm/Ia3ePfNo/5UUHL9sD7VwM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=CWh9zNPWzBzDeMm1GJ9ecLCxyZ4b/Irb8Wgl90rXCkCEAt+Ju5ICMKnGErbCNs+aJ
         tKzMdCPyUVGKgeTws7/ldogUGImJaY0oyc3VaTS0ejMXJpDJZo3+mefDQDJrElz6LF
         9YnWCDZPt+O61QauF6Od1ZogdXn4eybsYaFmeODsvAnT6RJUoiy0NKtvbRD169l4zA
         tmDt8MtjwUkD6RHO6uPN0zj13fiiiOAraexuSW3FSH58E8gEhhnmfqpFl6xH6EK0+X
         fo2tWh5cbGVh+p2oTFyoTVJ+Jl4584jiZiaPVhreAteCC7cBKiorKYhqZWrukOhx67
         QcEgGczhw2PeQ==
Received: by mail-lf1-f70.google.com with SMTP id k7-20020ac257c7000000b003fd3ab38ddeso1710582lfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 03:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHV2H4TjtGE0HYth4tntm/Ia3ePfNo/5UUHL9sD7VwM=;
        b=j1najpi1UeILVTUFZriylgmbBC5v4hBCV9y4I/jZpwPG1/aE1KQ6vKDEfGgSY6AYEW
         9ZkWemeI2NwKqnVJ2nvhUrF4L9VCQxqhWngzJUGGK6JMo5FeHE2cJ2ttbVU4Gt/JPUK8
         IwOtpNkoJzekgee9DmsKFCKEnzf27LdBgnn+JXvGSSflzDaau8hIVLbIR4eTAEA6Rfny
         C/mUIF+VZUcZuyqjAXViZD/Ttup02PkhN6RI4X3dnRoN2aEXVNxfodtqRzMs0wx1kpYd
         oOegQ+W6FMt31VVPKwjjRAzzDunw4zRKv3TrQ2mFSjun6Tqakr9matAlqp0mK6SwuSUx
         g/0A==
X-Gm-Message-State: AOAM5320edOO+3I7L3jM1tK+DL/67Nlyacgm7NFBfAVbEKksQb5+LaZS
        ng0hfw/i05wd0crNyHUE3jfU/H7Ou78YaEVaUXg1tepBrMcnv6Xd1WOXLRM7oe8OKkany5vl20b
        GHoZfJC08VWSRdpYMsr3XKD/oXdgrnOxrlVJRuf8kSw==
X-Received: by 2002:a05:651c:231:: with SMTP id z17mr28170686ljn.233.1633517366029;
        Wed, 06 Oct 2021 03:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxdzWARQNf2KRq6lRaEAGi+Oi/ccdXkqGkkKFTqJRc/mzEMQ6wTE7V49HtuYGG3JA4Z+uyuw==
X-Received: by 2002:a05:651c:231:: with SMTP id z17mr28170655ljn.233.1633517365861;
        Wed, 06 Oct 2021 03:49:25 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w21sm125488lfe.237.2021.10.06.03.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:49:25 -0700 (PDT)
Subject: Re: [PATCH 4/6] dt-bindings: clock: Add bindings definitions for
 Exynos850 CMU
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanwoo Choi <cwchoi00@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
 <20210914155607.14122-5-semen.protsenko@linaro.org>
 <96e5587e-aca7-248e-6448-8edfc70784b7@gmail.com>
 <CAPLW+4mEeh8Fo8kGHx+rB7nX7bDfaQRPGDotgPLTp4pm4rC0Cg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <77d976c3-a0b4-294f-d49a-8fd46b112a28@canonical.com>
Date:   Wed, 6 Oct 2021 12:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4mEeh8Fo8kGHx+rB7nX7bDfaQRPGDotgPLTp4pm4rC0Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 12:28, Sam Protsenko wrote:
> On Wed, 15 Sept 2021 at 19:37, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>
>> Hi,
>>
>> You don't add clock ids for the all defined clocks in clk-exynos850.c.
>> I recommend that add all clock ids for the defined clocks if possible.
>>
>> If you want to change the parent clock of mux or change the clock rate
>> of div rate for some clocks, you have to touch the files as following:
>> - include/dt-bindings/clock/exynos850.h
>> - drivers/clk/samsung/clk-exynos850.c
>> - exynos850 dt files
>>
>> If you define the clock ids for all clocks added to this patchset,
>> you can change the parent or rate by just editing the dt files.
>>
> 
> Hi Chanwoo,
> 
> I see your point. But I have intentionally omitted some clock ids,
> which can't be / shouldn't be used by consumers in device tree.
> Actually I took that idea from clk-exynos7.c.
> 
> Krzysztof, Sylwester: can you please advice if all clock ids should be
> defined, or only those that are going to be used in dts clk consumers?
> I don't mind reworking the patch, just want to be sure which design
> approach we want to follow.
> 

I would advise to define all clock IDs, unless the clock really, really
should not be used. Why do you think several clocks should not be used?
Have in mind it is not only about consumers but also clock reparenting
and assigning rates.


Best regards,
Krzysztof

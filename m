Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB33E8A56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhHKGpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:45:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59624
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234879AbhHKGpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:45:45 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 5FC0E40C77
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628664321;
        bh=gmY/J/A33Nx43ZzHIFzZWs91cvzZlKl1g6yirbYjAYw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=rGTxJX2i6cMZYpbTGYYGKuK2R497CMsziU0rTK1qivTi/C/wi4Vxdi/oYdoG6TXZL
         iVQMZhv7rZDDuREzRXBS4HwilV0v+ro9Dqpg9MrhpKJQBL6Brfi56fyUFphAE/eMkq
         BGzrevVZuOqiLWk8BYk2nzVyWwck9Vp5eWT9ubEu1icXlipCC3Ha8LAoxo76nRjeR3
         s6Z7KesOdzf5M2vk1c7JMHO1Q/5SXYUrfFfhSL/atQtmCn0U5yxZ04VdTapiO7HGZp
         CH1G9mMDONVjYuA3zuwfg3T5yJDySPgukhv6hOiTZOZ33UtG4ktQsiEvvXSHziGp9i
         Nk+UcdPRgWWGQ==
Received: by mail-ed1-f70.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso738038edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gmY/J/A33Nx43ZzHIFzZWs91cvzZlKl1g6yirbYjAYw=;
        b=A35E6yAwAwCzXu35an3mSWzXyhC0xjePYQeGXNeIMw+Z20piFnX67VJn9OULwk35US
         xZhEPU6u3QWwo7Cjei9Si2t5o+wClIL7rmLQtc0RKSxt526c5xT3GazPErccT/ZalXdx
         VUPn0ZdMCNNuyCyrWOTWAW+RONSL4aVeaKDH5MTXC9Jyyyg/3P/TQkGzmJ8NI61oLGwt
         MxMCM3FXJdDhrLGzko7VTI84/EvnpFChHjHOCWSQmeUyfBijGZZOYvtB2RPU5HRnFB00
         OHaQlV26aWnBUsH9KY8BzYhTQ9aEg9nO3cOtxT6VMs5QpPdFZKHs90sce2oE5OERiIqo
         F0QQ==
X-Gm-Message-State: AOAM531AQUKkA97MSAf1Um08BKu9dFj5bAXKqOuZaq8ikl0P025G+y9m
        H9BizfcUoahmLq56hCWy6OHcax5e0J6QeUGcqdNoaOrrM+7ipsn38kKsucbgdmBWwCjlLHDN1Y1
        x831WbKmVDS8uK8tQ0ZRXiyXyIijp1m1hFmkpflOJWw==
X-Received: by 2002:a17:906:b886:: with SMTP id hb6mr2214605ejb.13.1628664320878;
        Tue, 10 Aug 2021 23:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeQI3Jl5IBCJ1wbuMCYAH2RdwJTbWq0SzgphVQ3VMfqTXOBz/h15Zxr3R9LY/NpsIUu7B+YQ==
X-Received: by 2002:a17:906:b886:: with SMTP id hb6mr2214598ejb.13.1628664320762;
        Tue, 10 Aug 2021 23:45:20 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h19sm10827579edt.87.2021.08.10.23.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 23:45:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: samsung: add bindings for
 Exynos external clock
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
 <20210810093145.26153-3-krzysztof.kozlowski@canonical.com>
 <CAPLW+4mKv0Azi4w2S=Ono1gpghmBtfy4QpaRBjtHkgrUGZVW_Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fb4cf910-8465-7efc-184f-eef691cf614d@canonical.com>
Date:   Wed, 11 Aug 2021 08:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4mKv0Azi4w2S=Ono1gpghmBtfy4QpaRBjtHkgrUGZVW_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 19:49, Sam Protsenko wrote:
> On Tue, 10 Aug 2021 at 12:32, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Document the bindings for Samsung Exynos external to SoC
>> (oscclk/XXTI/XusbXTI) clock provided on boards.  The bindings are
>> already implemented in most of the Exynos clock drivers and DTS files.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
> 
> Just want to mention that remaining users of such fixed clocks can be
> converted to regular fixed-rate-clock, and then this binding can be
> removed along with samsung_clk_of_register_fixed_ext() API? Just a
> thought.

Removal of samsung_clk_of_register_fixed_ext() would cause ABI break,
probably acceptable for these devices. Yet still, someone would have to
do it and test it.



Best regards,
Krzysztof

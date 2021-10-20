Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C2434FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJTQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:10:41 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47010
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhJTQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:10:39 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABFFA3F320
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634746103;
        bh=RWTk/Tv2KUeM7X1g2MvuLj9i0LZ6zolSFoXZHZ0BGqs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=vhHFmZRayX+8Jpg19V5WxbCsuQl2vEbwSQyYKrJQfHUIsR6yZWNGzpbRsyf6quZrU
         STOha3P8zM6AswebCNCD3m5ZCqRF8m2UDa6Ucw1KVQyVMK/1bJ6yBzsy5BufQHepvt
         cFyrWrR3eg8xKClFdr+AAGbIDkklCFE65Ksglh99k0bdYKiXZdsu8kvZ1ewX4hAySj
         UZyXdgPRPcx4Dc1/cIdHIvMlOlfqP/ZfZlxriw4HpBXN/s1vGKvfytjJZ9IDwvm9bL
         krOGSM3C6frpa2pe7+Zb3XVs1d4dn7dSSy+ivO2XFjFerSPxY5OSE831bnOZPOVvXZ
         3bM9CPyz/3HTg==
Received: by mail-lj1-f200.google.com with SMTP id o4-20020a2ebd84000000b00210ae894d18so2081682ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RWTk/Tv2KUeM7X1g2MvuLj9i0LZ6zolSFoXZHZ0BGqs=;
        b=JApVMoe3EP62WEGyAP6t1ZkTsv7TstQwcU5GC+qOrk7M0PgieRnf1XA07O89DkLBMW
         ZSiaLBtPlR/8Q0i2Cbbrr17du5hx4xJROuGLKOu9S+9cip1eG12mhb7MEp9Suv6QHuL+
         VM7LY7aKhwaWp1SCnrN0SUW2Lfwt2LEUBBDfS9kXNHKsB+jGr53oBr9x1CR9Guqphbb6
         2MSmXsyIV8eDuuYi6Em1ujY1b+vCUFLal/gf4HKmnwCZv6f1ZwuSuBu4Bm+olmD+c0XH
         nzcvLZwAGVr2BFFhg+BmPqxJCLtIk/jDk19eirrBUHO7amz32Qy5sN33IFu2SGITpYoh
         zgVg==
X-Gm-Message-State: AOAM532H/rxYACH7VZlMjA8S0UuhWXQYJOEVBNgSo9Wo57XxdGzpLAt2
        KUhc1xNznRIRGAlt3ojIv8BavxCPz2jvokar12YCoN5MxyH7LLlIospybZwRLODLYFxTyZy9sAm
        Sb4ct9sfedBiHg+144ibsRStFi4uWU4y5utrWITXb9Q==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr339436ljh.388.1634746103040;
        Wed, 20 Oct 2021 09:08:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQBhryxOg2qMNZCZTzCoht5bSmgiOrv8jBxqdEbpYVM7m9PuTRf7dCdi6+luozNbZUjbDqdA==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr339400ljh.388.1634746102794;
        Wed, 20 Oct 2021 09:08:22 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x3sm242086lff.20.2021.10.20.09.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:08:22 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] regulator/mfd/clock: dt-bindings: Samsung S2M
 and S5M to dtschema
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211006132324.76008-1-krzysztof.kozlowski@canonical.com>
 <YXA+GoTf6u/Y4qLX@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <16c79986-03b2-b74b-0de8-4118e2c4419f@canonical.com>
Date:   Wed, 20 Oct 2021 18:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXA+GoTf6u/Y4qLX@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 18:04, Lee Jones wrote:
> On Wed, 06 Oct 2021, Krzysztof Kozlowski wrote:
> 
>> Hi All,
>>
>> Changes since v2
>> ================
>> 1. Add Rob's tags.
>> 2. Remove "regulator-name" from properties (all regulator dtschema).
>> 3. Move "unevaluatedProperties" higher to make code easier to read (all regulator dtschema).
>> 4. Add ref-type to op-mode property (patch 6: s5m8767 regulators).
>>
>> Changes since v1
>> ================
>> 1. Drop DTS patches - applied.
>> 2. Fully remove bindings/regulator/samsung,s5m8767.txt .
>> 3. Minor subject reformatting and few typos in text.
>>
>>
>> Intro
>> =====
>> This patchset converts all devicetree bindings of Samsung S2M and S5M
>> PMIC devices from txt to dtschema.
>>
>> It includes also two fixes because later conversion depends on it
>> (contextually).
>>
>>
>> Merging/dependencies
>> ====================
>> 1. Regulator related binding changes depend on first two commits (the
>>    fixes), because of context.
>> 2. The mfd bindings depend on clock and regulator bindings.
>>
>> The fixes and bindings changes (patches 1-10) should go via the same
>> tree.  For example regulator or mfd tree.
>>
>> Another alternative is that regulator patches (1-2, 4-6) go via Mark who
>> later gives MFD a stable branch/tag to pull. Then the clock and MFD
>> bindings would go on top via MFD tree. Or any other setup you would like
>> to have. :)
>>
>>
>> Overview of devices
>> ===================
>> Essentially all Samsung S2M and S5M PMICs are very similar devices. They
>> provide the same functionality: regulators, RTC, 2 or 3 clocks and main
>> power management (e.g. power cut to SoC).
>>
>> The differences are mostly in registers layout and number of regulators.
>>
>> The drivers are built around one common part, mfd/sec-core.c, and share
>> some drivers between devices:
>> 1. MFD sec-core for all devices,
>> 1. one clock driver for most of devices,
>> 2. one RTC driver for all devices,
>> 3. three regulator drivers.
>>
>> The regulator drivers were implementing slightly different features,
>> therefore one regulator binding for all devices does not make much
>> sense.  However the clock device binding can be shared.
>>
>> The final dtschema bindings try to implement this - share only the clock
>> bindings.
>>
>> Best regards,
>> Krzysztof
>>
>> Krzysztof Kozlowski (10):
>>   regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS
>>     is disabled
>>   regulator: dt-bindings: samsung,s5m8767: correct
>>     s5m8767,pmic-buck-default-dvs-idx property
>>   dt-bindings: clock: samsung,s2mps11: convert to dtschema
>>   regulator: dt-bindings: samsung,s2m: convert to dtschema
>>   regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
>>   regulator: dt-bindings: samsung,s5m8767: convert to dtschema
>>   dt-bindings: mfd: samsung,s2mps11: convert to dtschema
>>   dt-bindings: mfd: samsung,s2mpa01: convert to dtschema
>>   dt-bindings: mfd: samsung,s5m8767: convert to dtschema
>>   dt-bindings: mfd: samsung,s5m8767: document buck and LDO supplies
> 
> Looks like these are ready to be pushed.
> 
> However, I am not in receipt of patches 1-2.
> 
> Am I okay to merge 3-10 right now?

No. This is v3, but we need v4. Please:
1. Merge tag from Mark:
https://lore.kernel.org/lkml/YWCT+YL%2F9qHbF9f0@sirena.org.uk/

2. Then apply patches 7-10 (MFD bindings).

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A703EEA93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhHQKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:07:55 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38146
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239272AbhHQKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:05:57 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id DAB1E40CCF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629194723;
        bh=GOIsTUQ+gJL63rEPiNcOFHz6lWCZ7WtQFp4xSBwe2Ag=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KR3OuOLtFVIu4XExacpwX/8dSub2ngtOKv6LCQNweF4Bho7czM20sa/BgRekZufGS
         xqs6bjy/F+imrKpHycy+QK9ESHEh2hH8nokCgByTQu4fgaRH+rB/QL2Ig76PjRmzIe
         X1Wq/26umxem1Rq8kxaDGs+Udip/eTqfeOo6KvJMvpBMZxwUDNsJlny47pKlEXBGEO
         SuBaHxX2G1VdkFQOMtEGLbPYZsB6BmuRTSXKOZSXYXipPJ07E6eSYVfTP6PWGzyoOD
         9xbZTBNsbgUC1OIim5HLS051jMCZ8kQUZe6cgJqDfdfjhBxJIJADvx1j1I/EMnhchc
         KEG3aBIKA7wxQ==
Received: by mail-ed1-f72.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso9165154edy.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOIsTUQ+gJL63rEPiNcOFHz6lWCZ7WtQFp4xSBwe2Ag=;
        b=j3169Tp1htgpSELXYP++oUZOygSTGRKnc2d6ErSr8S9oJSbkzf4eMzrtjeQ0LMjq/w
         tokjTZL4MDgC3UpRM19iPSzpiBpnzuf6VPmXc6LHr4QgX0gi+u7WpPljdLUXMft9m9vm
         tUWu0SkaF3Ldiip1GgGWNTuicdzT8+fnTLKGhhik4Q0C/BW4t9HySf7u3rUERXD5qa0W
         pg6KC0vGcyu244XCek13ULUZqXn2bS5NumOJucqoLJE4SjnzRS3lipxMB+jwcWayHVyv
         KgOBUszXkWHfMSvoFtABT8Vc4lDO8iHypdZ7bHT6TJOH2vrYsi4rtKCCmxpakJLahbjN
         Lkwg==
X-Gm-Message-State: AOAM5311C0+nG8MSIwnX4m6fP4+1O3DMWKIOIz1fS+zkSoVBm4Qf15G8
        NxXFE2G3W3/vyzoNCg10s8kYj/wc+IwwCkurXOD8r7Ep4NKog5/VXw1331bP5X3RmVEtyjOuD2H
        MGptgIdA/h0jpKpKCYudQBuOVWmqTVN5rUcN4VUjmtQ==
X-Received: by 2002:a05:6402:214d:: with SMTP id bq13mr3229752edb.263.1629194722062;
        Tue, 17 Aug 2021 03:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC3ptiEqOWsybRDl1sa+LgQ0zWpCdCEsdKyWGPcbPrtTBHxez2xHpr+Za6aNluTlhnkIYe4g==
X-Received: by 2002:a05:6402:214d:: with SMTP id bq13mr3229732edb.263.1629194721860;
        Tue, 17 Aug 2021 03:05:21 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id p23sm559903ejc.19.2021.08.17.03.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:05:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-bindings: rng: convert Samsung Exynos TRNG to
 dtschema
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20210811084306.28740-2-krzysztof.kozlowski@canonical.com>
 <CGME20210817095553eucas1p174e68fc6d7cfad9c2fd34f729272b01a@eucas1p1.samsung.com>
 <dleftjeeasfl9b.fsf%l.stelmach@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c3a1d7d2-7b32-b7eb-4647-f86e22f5e5ff@canonical.com>
Date:   Tue, 17 Aug 2021 12:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dleftjeeasfl9b.fsf%l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2021 11:55, Lukasz Stelmach wrote:
> It was <2021-08-11 śro 10:43>, when Krzysztof Kozlowski wrote:
>> Convert Samsung Exynos SoC True Random Number Generator bindings to DT
>> schema format using json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/rng/samsung,exynos5250-trng.txt  | 17 -------
>>  .../bindings/rng/samsung,exynos5250-trng.yaml | 44 +++++++++++++++++++
>>  MAINTAINERS                                   |  2 +-
>>  3 files changed, 45 insertions(+), 18 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>>  create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>> b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>> deleted file mode 100644
>> index 5a613a4ec780..000000000000
>> --- a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -Exynos True Random Number Generator
>> -
>> -Required properties:
>> -
>> -- compatible  : Should be "samsung,exynos5250-trng".
>> -- reg         : Specifies base physical address and size of the registers map.
>> -- clocks      : Phandle to clock-controller plus clock-specifier pair.
>> -- clock-names : "secss" as a clock name.
>> -
>> -Example:
>> -
>> -	rng@10830600 {
>> -		compatible = "samsung,exynos5250-trng";
>> -		reg = <0x10830600 0x100>;
>> -		clocks = <&clock CLK_SSS>;
>> -		clock-names = "secss";
>> -	};
>> diff --git
>> a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
>> b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
>> new file mode 100644
>> index 000000000000..a50c34d5d199
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> https://protect2.fireeye.com/v1/url?k=f38ca35b-ac179a0d-f38d2814-0cc47a31ce52-1faa1ecb65482b8a&q=1&e=8b3490f9-a5fc-4da0-b2ee-7b0aec781403&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Frng%2Fsamsung%2Cexynos5250-trng.yaml%23
>> +$schema:
>> https://protect2.fireeye.com/v1/url?k=9409519d-cb9268cb-9408dad2-0cc47a31ce52-12394c4409905980&q=1&e=8b3490f9-a5fc-4da0-b2ee-7b0aec781403&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: Samsung Exynos SoC True Random Number Generator
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +  - Łukasz Stelmach <l.stelmach@samsung.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: samsung,exynos5250-trng
>> +
>> +  clocks:
>> +    maxItems: 1
> 
> How about copying description from above into the description: property?

But what to copy? There is no description except generic clock bindings.

> 
>> +
>> +  clock-names:
>> +    items:
>> +      - const: secss
>> +
>> +  reg:
>> +    maxItems: 1
> 
> ditto.

The same, I have no clue what to copy. It's obvious that reg contains
"physical address and size of the registers map".


Best regards,
Krzysztof

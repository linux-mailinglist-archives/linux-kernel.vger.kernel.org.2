Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3A3EFD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhHRGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:50:03 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50258
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238080AbhHRGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:50:00 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 8490240CC6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629269365;
        bh=koyaZ5FIZxDdS33SITxLj7wHGHh/MSdOiD6GS5fpHeg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=LxH8xivxknKbu4PGoNssjfpIhFmTTJS13p40vXmGzRWBM8fZhw6sjJJ3oQsC3RUOq
         xQ5m3MjNoHlNhJAdVnea8HHideSZIFVb4Mgwjjc1uOoHuQeIAKLor5aqiZ5u7surzl
         MSG0eQR9xo6hBnlKXLo3x07cAGB4DZqTLinqtwjLLqa0Xv+HGtmDnRG0SIa8Ln7UA+
         6ITkLPfu+K6zc9F2O8ajLai2sVydqLk4SNqnYeK++s8/ARpuioYq/zVPC1M7SdYVcf
         bfI91/PpBabdySBu6YuShmiUOyM0BpLCcLZEUHdwY8S99Iss0SEkLp8br90B2/XTlH
         Zq7vAM6m8K7ag==
Received: by mail-ed1-f69.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso514078edb.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=koyaZ5FIZxDdS33SITxLj7wHGHh/MSdOiD6GS5fpHeg=;
        b=Bq1l+TBYMu31NJWjzDoP1h2aLBh6jpwaiBTUJ/Q5qLSvPUrB/pN5ZvV6hPOLJr6nDr
         9o2N++cQqqZ1gMOairzYYdc3OWDQ3zRmT25/7yeOauc09Yvj7QR4Lm92LO4fE+gV8rti
         vpnJkqGXpxkO6OdTT2kNXY3lDEs4Kwukyhykb4+zvvPnMuNuaV4FWZGX1BvgOAhqMRJR
         N5/2GoTHop3+oJLQQjZ59EW1Zit9kPzuNU0z87pt09D26Wc4ssUy1j68514pXhFTFcJ2
         DHUPpBF+6jdfuLshy+1CjoEIYmnqo0cPJg5BAmba3ESBW6MHz5iiqCdJNGWKDgIvBg9k
         QoEA==
X-Gm-Message-State: AOAM531kIkY3BXUzmONnYsYHBCAgm3/KgvBebQNSJ90WNxKz+5bZtU21
        Dbj7T4fhuVPhiUqwwcCFKroq9urEJ+GF70J1TQIW+u9Y79dRJMt3pnG2jUYm/75eZ5q72sOAR8s
        sXjOfUgtJHgcczgplAnIzr9Ikvg5JuS4JUGTBhwdukw==
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr8154723ejr.313.1629269365306;
        Tue, 17 Aug 2021 23:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWhQFCV598TtTdTr1EoTmYGq5dI5oFgzC45QcBRmM+oIeH6pPwo+Is9DtzMEBVJyV2Y08tYw==
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr8154708ejr.313.1629269365121;
        Tue, 17 Aug 2021 23:49:25 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f20sm1580873ejz.30.2021.08.17.23.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 23:49:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: samsung: convert Exynos5250 to
 dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
 <20210810093145.26153-2-krzysztof.kozlowski@canonical.com>
 <YRwZG1uerWt+NAQH@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c7311cd1-7e62-91d9-bbbd-cfc3c027da35@canonical.com>
Date:   Wed, 18 Aug 2021 08:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRwZG1uerWt+NAQH@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2021 22:16, Rob Herring wrote:
> On Tue, Aug 10, 2021 at 11:31:38AM +0200, Krzysztof Kozlowski wrote:
>> Convert Samsung Exynos5250 clock controller bindings to DT schema format
>> using json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/clock/exynos5250-clock.txt       | 41 ----------------
>>  .../bindings/clock/samsung,exynos-clock.yaml  | 48 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  3 files changed, 49 insertions(+), 41 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> deleted file mode 100644
>> index aff266a12eeb..000000000000
>> --- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> +++ /dev/null
>> @@ -1,41 +0,0 @@
>> -* Samsung Exynos5250 Clock Controller
>> -
>> -The Exynos5250 clock controller generates and supplies clock to various
>> -controllers within the Exynos5250 SoC.
>> -
>> -Required Properties:
>> -
>> -- compatible: should be one of the following.
>> -  - "samsung,exynos5250-clock" - controller compatible with Exynos5250 SoC.
>> -
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region.
>> -
>> -- #clock-cells: should be 1.
>> -
>> -Each clock is assigned an identifier and client nodes can use this identifier
>> -to specify the clock which they consume.
>> -
>> -All available clocks are defined as preprocessor macros in
>> -dt-bindings/clock/exynos5250.h header and can be used in device
>> -tree sources.
>> -
>> -Example 1: An example of a clock controller node is listed below.
>> -
>> -	clock: clock-controller@10010000 {
>> -		compatible = "samsung,exynos5250-clock";
>> -		reg = <0x10010000 0x30000>;
>> -		#clock-cells = <1>;
>> -	};
>> -
>> -Example 2: UART controller node that consumes the clock generated by the clock
>> -	   controller. Refer to the standard clock bindings for information
>> -	   about 'clocks' and 'clock-names' property.
>> -
>> -	serial@13820000 {
>> -		compatible = "samsung,exynos4210-uart";
>> -		reg = <0x13820000 0x100>;
>> -		interrupts = <0 54 0>;
>> -		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
>> -		clock-names = "uart", "clk_uart_baud0";
>> -	};
>> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
>> new file mode 100644
>> index 000000000000..cd6567bd8cc7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/samsung,exynos-clock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung Exynos SoC clock controller
>> +
>> +maintainers:
>> +  - Chanwoo Choi <cw00.choi@samsung.com>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
>> +  - Tomasz Figa <tomasz.figa@gmail.com>
>> +
>> +description: |
>> +  All available clocks are defined as preprocessor macros in
>> +  dt-bindings/clock/ headers.
>> +
>> +properties:
>> +  compatible:
>> +    const: samsung,exynos5250-clock
>> +
>> +  assigned-clocks: true
>> +  assigned-clock-parents: true
>> +  assigned-clock-rates: true
> 
> These can be dropped. They are always allowed if 'clocks' is present.
> 
>> +  clocks: true
> 
> This needs to define how many.
> 

Right, thanks.


Best regards,
Krzysztof

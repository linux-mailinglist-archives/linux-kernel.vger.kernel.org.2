Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82F3E4973
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHIQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:08:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:41668
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhHIQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:08:38 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 3944B3F240
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628525297;
        bh=dYynETD7e7Go9Y3JtAn5FrP3ZxbiVg1MuIylXG2rAf8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pyGhmHpfOH+p4Aqapn+twQco7LEoCG1gYBl9POr4f3LhdJt70NCdLVLm2jG6Yfz10
         9pPa29XIwscOAYrlr3ik1qI2zXlFlBJwA2/43BIWwgivjg4wzQ+UHp8wfOjq1Hg5Af
         JG/B+Q8mHKGZ2kNX/5IcRieQB1Ks0ZLGl+Lzjh1pQc+lObEtpThMzTWeD2kg5FiSV7
         IbwV1UAOHdTGeJjhcNgHiSvI9lhhRDDGndh2a8A5Lwvhb1W4gD4n8ZUMn+ixhMfwra
         n529bvMH3EaywjyK2xwQUxn1iuAHpIx6It3kuY2Rd+yZHTYeJh+McDhiFcbMZQ7ksw
         N9dJhNtVCzc1w==
Received: by mail-ed1-f70.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso9091049edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYynETD7e7Go9Y3JtAn5FrP3ZxbiVg1MuIylXG2rAf8=;
        b=Ivh/DLYS1oXeLmUj4ixHYziLtCy4ySoaBL9eKaPn3xCQIUWzRarijP2yAuv/3oTW6x
         fnihUn9Ytq916yKu8taMLzrofl5AWxMCnp6T9qfVDeFrqTxyozrdnrdFpQEXQTvA8qe7
         1w5cYNltooSKRKzo++GW4bqn+zlvIWz+ftJxtwV9Co4Vh6sMgOSKtzA/ManCfJWQfdBE
         Kx70fJVUYr8QWngkHe80waGx/Z/hejymwxgkShGp42cju3L8AV9kZgkkOn1ySD1bZZYT
         FIhVFV1T+yO7zXioAvOiFYioJ5mmwL/+Uee3y/6HNV3W6mOQEqe+z3r2fiRW4NhPfv8J
         PoQQ==
X-Gm-Message-State: AOAM530LBprBs9XD0/yohpwfBGrViMy6hOR6EB2vNeySBxGRD4Am7JOV
        9IcDOBNnfozAyOHh+6BZEFnr9QQPv1CNtnX/A1clSS45/ivA3qnM5lbnsz6t3KyYbFnrjLmstPo
        O8u8+m2elhtDJ1CL5NZ/J5nuCa4BgFqxsIMbk8CNGfQ==
X-Received: by 2002:a05:6402:4246:: with SMTP id g6mr30558357edb.95.1628525296918;
        Mon, 09 Aug 2021 09:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqPYbBDvdZ6Zu8eRL5FMWxXMVz1K8C56iPevCS7X6zyD5UDOu9mh2jlErjtcaIA6EgN/i2TA==
X-Received: by 2002:a05:6402:4246:: with SMTP id g6mr30558336edb.95.1628525296752;
        Mon, 09 Aug 2021 09:08:16 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id m3sm8239214edb.7.2021.08.09.09.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 09:08:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] dt-bindings: clock: samsung: convert S5Pv210 AudSS to
 dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20210809135942.100744-1-krzysztof.kozlowski@canonical.com>
 <20210809135942.100744-3-krzysztof.kozlowski@canonical.com>
 <1628523608.157762.3895394.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <3ba3aeee-7ee2-2b38-397a-71ea1543163e@canonical.com>
Date:   Mon, 9 Aug 2021 18:08:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628523608.157762.3895394.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2021 17:40, Rob Herring wrote:
> On Mon, 09 Aug 2021 15:59:41 +0200, Krzysztof Kozlowski wrote:
>> Convert Samsung S5Pv210 Audio SubSystem clock controller bindings to DT
>> schema format using json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/clock/clk-s5pv210-audss.txt      | 53 -------------
>>  .../clock/samsung,s5pv210-audss-clock.yaml    | 75 +++++++++++++++++++
>>  2 files changed, 75 insertions(+), 53 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.example.dts:24.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1419: dt_binding_check] Error 2

Thanks, I'll fix it in v2.


Best regards,
Krzysztof

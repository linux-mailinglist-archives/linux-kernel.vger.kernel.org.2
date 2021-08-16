Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169F03ED055
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhHPIc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:32:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37582
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234778AbhHPIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:32:53 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id F36C33F07D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629102741;
        bh=UCYlNRmzeCEuDZZ2cqWcomGqHyEFVVrQDIMY2+9YLGA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=MYrqrVmrHcoTPYEI2L6Xw/GkpSth+gyuWRaalz/jJNXNm3pFgstyw4o01/4reBUZh
         j9IdInuGMeGNyiM/SXdGji5+JcKBeInuICFlQwXI+BOdjoj3MUigDhwVugCv8tPVMl
         v9NNLo/g4vc5RmXH2rSbmB/D4nbuX8DKMNfLmyq8rsFSJcCs38kwV3+PShWRjGwYvk
         4ou4pvDwfXiOTUlhBJ/2KLjb/BddxB72kFl7Llf1Ujgp3VMT5Bc5kaZlaRQfy+KRDM
         Fb4ppBNwOtAdkqLiOkwUq7ZkuhQ9zO4llBPtwexlHJxxVLwrqCVZJkuBbBU8DtWbm6
         clmPHfbAs5vqg==
Received: by mail-ej1-f71.google.com with SMTP id nb40-20020a1709071ca8b02905992266c319so4382655ejc.21
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCYlNRmzeCEuDZZ2cqWcomGqHyEFVVrQDIMY2+9YLGA=;
        b=a6mSL25IY39IzhSL03KlG8RVAolLz7wUN+sOUFrPJ0p8NIMwpEN0IztZ2WlOu9bws/
         DMig2MLmkhSscGhHeWxYVxMCPYBkYBlik0Ms6GpgWHn83DJmTyrSc479A7Wm/N4FnjLK
         HZ+SP6z5Cs1LRaVvSVWSo6vgrADtqqCLgX7z56ymMCbd9Ao6ruRTgVObbGPfqFYnjJZY
         WmaBDzzCg3krHfjH0hUZbJviGmujV0NafAPDUHlRXpO1jbyyFVboULRxIwExKVhB94LJ
         hmF4SQBA4b/Jl12/x3yG+4PxpZMoC6vAUaqC/tGRZaix6vylvlda9FoLK3BkCJPHsYFS
         NwWQ==
X-Gm-Message-State: AOAM530E1GLgYEXF6PLPYkvvjW+NQzn6egyLdNMCIpfJezKtEhjM04DJ
        oVLBVSlhXrX6FHeg5TThK1SUO+e+X1gdyXa6A3+BVAvyYr9x3tHNu2Ez/u3jIOWT2wDgaGegQl5
        aqu4Sir8jyDpxbH1hAdzpdgYibZM+ZzeYD6xWw8OQ2w==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr18627046edr.5.1629102741794;
        Mon, 16 Aug 2021 01:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWp7YYIs1HvFB9r8ma/frRskh/jd0dudB3BzbInzpUKcEh8rihjaxeMk6VTvCkVyqBdNIC2w==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr18627027edr.5.1629102741690;
        Mon, 16 Aug 2021 01:32:21 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d16sm4505366edu.8.2021.08.16.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:32:21 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to
 dtschema
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
 <73eebe7b-46da-137b-1938-09a5b453320a@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
Date:   Mon, 16 Aug 2021 10:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <73eebe7b-46da-137b-1938-09a5b453320a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2021 09:53, Lukasz Luba wrote:
> Hi Krzysztof,
> 
> On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
>> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
>> Dynamic Memory Controller to DT schema format using json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>>   MAINTAINERS                                   |   2 +-
> 
> I'm not an expert in this DT scripts and why it complains. Maybe it
> complains because the "samsung,exynos-ppmu" is defined in the .txt
> file... (?)
> Although, in general looks OK.
> 
> Acked-by: Lukasz Luba <lukasz.luba@arm.com>

I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
because it complains about compatible in example which is not present in
the bindings. Usually it means someone wrote example not matching the
bindings (e.g. a typo in compatible) but here it is on purpose.


Best regards,
Krzysztof

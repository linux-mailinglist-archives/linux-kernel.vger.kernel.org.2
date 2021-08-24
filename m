Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02453F6974
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhHXTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:03:40 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58226
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233201AbhHXTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:03:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 362444076A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629831772;
        bh=tXo6FALvM7TQ/HZAw0MdLp6mungZZc7pCeMeJQgnDkk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=g3i5l2M92xF6rlKhhhjhEw20C2jPprR6TPI92Mavqcu1r6qpmsBWswxwDJVsCybM/
         67IuDWKL4ZOMHEQFB4fctTnWVwbvpHDoz9oudzfyEobjvhseHx9rVMWhLp5elMb29N
         naO+cqV92Mol7JLt58FHyEr4fuMXvWjf30GkEP3LFQz1Xo7zTvrM7KGjyK/wSR+8rO
         Mo7eATR6WHWJA51E7CbH+EivZlJmLdKSVmW7Xo+e+cn+K1xR61Ihz8D66xiREerVMY
         LPGDgGHPwUvXvqYhl4E3v7fYXSLWeedWjY6bpSgQivjBjNwjFIchXjUNngi/CEkbmd
         MaWg5SlmB8vAA==
Received: by mail-wr1-f72.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso1961058wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXo6FALvM7TQ/HZAw0MdLp6mungZZc7pCeMeJQgnDkk=;
        b=XunRld9Rwp4S8CkgxKgh3heIsi/B9r6Fh++8J6DbhxXdknzYDKrO6dH43nE/1DbeLi
         HRA/qjVhVo1ds/m7RsFICs7mg1IJR+iVU/5ZNzJidLuPp1QUQJa8QRDNWuiqF2ZzvM1m
         JwbybTRdoL7NzgoGTXuMCxMmyq7TDCH4zPeHJ9F6toWcgEkGqSTDM0NSfAY3tq0NcBmY
         yNhHiu4wcIM5IT2T5hgv9eHDpoN4Dob9shAjFS+yyN9dr6gEMz7bvlH65uNWL7NBTaU2
         qFmi8HgC6ywjoxNvYhTcr8V66eE0vwoiu9+trakv64/Zb9ziWy9MVQLozIIxLlzGqfc1
         5qaQ==
X-Gm-Message-State: AOAM533NZs0oyBAMSscjjAV7JZhJHj1TB852tlGXGkqc1M50HI8F7e6T
        rLlQBLwhwzdn879BvhjgrBu9xzAsMusYhl3xPbLWaOTWXWLozdqOZPxuXn/iLaWkD7R/ZKqk/lV
        wAjn+e0nMGJd85Y+WzC2cefntWR8dWeQN1OwIc767Hw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr19755879wrw.415.1629831771809;
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Nq9ck+jffd623Tc7f2vLQxJV7O8vjvKSyxvbiu6imcb5omWNkifvBcdaBd6SM5xESLiGyg==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr19755866wrw.415.1629831771683;
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.31])
        by smtp.gmail.com with ESMTPSA id t14sm7449255wrw.59.2021.08.24.12.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
Subject: Re: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI
 controller
To:     Rob Herring <robh@kernel.org>, Atish Patra <atish.patra@wdc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
 <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9423ddab-4635-ea15-7a9d-dbcf1bc215dc@canonical.com>
Date:   Tue, 24 Aug 2021 21:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2021 16:33, Rob Herring wrote:
> On Thu, Aug 19, 2021 at 05:44:32PM +0200, Krzysztof Kozlowski wrote:
>> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
>> without any additional vendor compatible:
> 
> I think the lack of vendor compatible is the error here. Experience has 
> shown that vendor specific compatibles are needed for licensed IP.
> 

In such case this could be:
1. a specific "microchip,mpfs250t-sd4hc", which
seems to be on MPFS Icicle Kit:
https://www.digikey.co.uk/en/product-highlight/m/microchip-technology/mpfs-icicle-kit-es--polarfire-soc-fpga-icicle-kit

2. or a generic "microchip,mpfs-sd4hc"

Any hints here?

Best regards,
Krzysztof

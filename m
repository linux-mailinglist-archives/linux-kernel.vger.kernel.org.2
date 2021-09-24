Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9A4170B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhIXLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:14:10 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60902
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244448AbhIXLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:14:06 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F171E40192
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632481952;
        bh=T9o6pyPTAwyXjaj9IKJIIkkYu0EcijNstrWhBloVkIM=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=oaJjFS+zdUwHBKwA3tqnJjKCbbfDu08R8esWQP9/8vwnHN6HSPTT+DkedMk1diQMt
         2YKfYjo27HfrLCUJHLj1LmR2djhElpOt/m0VzRblLtgFCUBXIXEDnBNsOfZE+oPOjg
         AmXwj7Ar55t15ZqHV3uJdDE6LeMzET7rfvI7YNy42PIM3uVFUknqvZY1t2g8gCgwEW
         y73moDDA2Q9R9ITlD9Puj7+AiDjl3vPP6u7C3MaW+4XJFddcf1aAT2ycSN2xl0Pbgx
         6yXnBkyLk+aXDduDgB+Ao8q94OIYeo5jVrPIwAeHzW6a9ARZuliY/5aN+GNv2gFNEU
         ekecalXHzINvw==
Received: by mail-wr1-f69.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so7763305wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T9o6pyPTAwyXjaj9IKJIIkkYu0EcijNstrWhBloVkIM=;
        b=tZKX0CV7o1BH36T9H39prr6qRaG/ouGq5q9PDZcjZmVVmEgtJ1uQJ2S9yWhsBLU6pl
         SrRAVc/OuG7GIQxeINSw+uBc4+8lQGVsolQlxjUvV67KIYffuV0c6T+8Xnpz0velWI4F
         FGVqYGGGRfNmtjBzQXPfnnNeump2LV8hh9or3FjLGybtrjfNjT6QmiVkxSY77w7YLGoJ
         OmMhZOLU8ZW8Lhnhx9ylwp1iqdLfYOTef+L0tPzY+DX9K9S/aF+z4BU2DWxLITipSuW7
         xTZc6iEW4dENLdlARmXZ4w5g4xShoVWYppJggH4nO811ExbwOpVOUF1oRvHwVskvNKHR
         jIwA==
X-Gm-Message-State: AOAM532KNxAplpsg1fIo+CYm740cMrLhix/DE+TmG1DjhS5JhAZnfA3C
        UoIjFlyALxVMuWsKCxeYfzVmdw6MNnapdYu8P1AkoAVteRXn9IYBWMf4N9OG1m3c+8eAtkLYIo8
        rp1Ly5Tme0EaaT/VVLBiuvV4DDgQMwfN9jYfOwH2Llg==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr1432591wme.107.1632481952595;
        Fri, 24 Sep 2021 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF9z6IBsr8Sd/ad2WwWktRj5c9dwwwnXwUG6I9Lqvm4jEvrorUlgQ3efPSEZjSlnhUXcId+g==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr1432575wme.107.1632481952412;
        Fri, 24 Sep 2021 04:12:32 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id k4sm7939100wrv.24.2021.09.24.04.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 04:12:32 -0700 (PDT)
Subject: Re: [PATCH] memory: renesas-rpc-if: Avoid unaligned bus access for
 HyperFlash
To:     Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210922184830.29147-1-andrew_gabbasov@mentor.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c6de6ec0-fd06-14bc-c483-52a2d0a4590a@canonical.com>
Date:   Fri, 24 Sep 2021 13:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922184830.29147-1-andrew_gabbasov@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 20:48, Andrew Gabbasov wrote:
> HyperFlash devices in Renesas SoCs use 2-bytes addressing, according
> to HW manual paragraph 62.3.3 (which officially describes Serial Flash
> access, but seems to be applicable to HyperFlash too). And 1-byte bus
> read operations to 2-bytes unaligned addresses in external address space
> read mode work incorrectly (returns the other byte from the same word).
> 
> Function memcpy_fromio(), used by the driver to read data from the bus,
> in ARM64 architecture (to which Renesas cores belong) uses 8-bytes
> bus accesses for appropriate aligned addresses, and 1-bytes accesses
> for other addresses. This results in incorrect data read from HyperFlash
> in unaligned cases.
> 
> This issue can be reproduced using something like the following commands
> (where mtd1 is a parition on Hyperflash storage, defined properly
> in a device tree):
> 
> [Correct fragment, read from Hyperflash]
> 
>     root@rcar-gen3:~# dd if=/dev/mtd1 of=/tmp/zz bs=32 count=1
>     1+0 records in
>     1+0 records out
>     root@rcar-gen3:~# hexdump -C /tmp/zz
>     00000000  f4 03 00 aa f5 03 01 aa  f6 03 02 aa f7 03 03 aa  |................|
>     00000010  00 00 80 d2 40 20 18 d5  00 06 81 d2 a0 18 a6 f2  |....@ ..........|
>     00000020
> 
> [Incorrect read of the same fragment: see the difference at offsets 8-11]
> 
>     root@rcar-gen3:~# dd if=/dev/mtd1 of=/tmp/zz bs=12 count=1
>     1+0 records in
>     1+0 records out
>     root@rcar-gen3:~# hexdump -C /tmp/zz
>     00000000  f4 03 00 aa f5 03 01 aa  03 03 aa aa              |............|
>     0000000c
> 
> Fix this issue by creating a local replacement of the copying function,
> that performs only properly aligned bus accesses, and is used for reading
> from HyperFlash.
> 
> Fixes: ca7d8b980b67f ("memory: add Renesas RPC-IF driver")
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> ---
>  drivers/memory/renesas-rpc-if.c | 47 ++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 

Thanks for the patch.

Please rebase and test on a recent Linux kernel. This looks like work on
something slightly older or stable kernel, since you Cc not the address
from maintainers.

The patch came slightly after Wolfram's and I wonder whether you hit
similar issue:
https://lore.kernel.org/lkml/20210922091007.5516-1-wsa+renesas@sang-engineering.com/


Best regards,
Krzysztof

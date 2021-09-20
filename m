Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B451D4117A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhITOzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:55:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39160
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232090AbhITOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:55:33 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0980F40264
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632149646;
        bh=V0X+3uidaeyp1K6mH5laK1N1lZeTwvHcyGOGgKbVfnY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=iQ5jiAUZT3HUCVEfdHYiBjz5bV56hvPG0zI8zfqmetNVR57Cr+Y3N00m2IsbKKvtX
         At9kUYO/rQDdEngpaLiuavnLbDbglkSwXYxDk0p3IgnQ1SUvb7PM/JwthLKWxkbhkv
         2cMD5n0fyJt8AMytpHFxe7s+rbw+0s9k8QqH9TTtul4zGLIlK6xEQ5F+KHBeCSLE0/
         1oOa0SVKTauQ23ZB0G5tkuewocRPW7hNtEjIxGu9CtDAcNQqG+A0Ea3iNtqk6Y6KoV
         NYJWhHa9IXqCBYhyraxlMFXTkI9zrb924Wf9IxOa2pvf3yb9LOYo+2GCNygzG3S2wi
         Q1+zdY9tjq47w==
Received: by mail-wr1-f69.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so6313966wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0X+3uidaeyp1K6mH5laK1N1lZeTwvHcyGOGgKbVfnY=;
        b=Xpk9v1mYAps9bJ2tfqmODWMRKCvrxfkqmfhMv7olbxMWANOsG1dJBGG2lkAkMw7M8l
         IlIAncg64+IjJ5d5w9OrIBs1cf0OTHJvROi2qZe/GdpdOvLadeVQ8W7HnY1+EyUQ1QJE
         tZeU9rVJy8jE/0QDJqOcbKE9djytqMK0JbGJCCxgwMypkZp8PMhwI8D8Hk9yitJIadgJ
         5kRiDI6xmaoyPJPrY/wA6xFdbY1108R/t6k9vfvnyQX08Xz6BXhYRlgwugVYwOjHDf2U
         88ECeQdprs4SWobhh8aEnZevCqSo4rMPlClnj80fJ0dIZKEpTkupLrWc99VZFu4WSmJ/
         rIDA==
X-Gm-Message-State: AOAM530bqIvVPQk4TwUpqhBpEnkxL0w97iknGu5r8IKKmDsdseWSx3t5
        Y6X0pxLk1K/ScJJwkw+JcR2klep3zNIzXvvqfZCiiuZ2Cvst/mKYQJvYeJMlwrM4+fU3YBmGSXw
        HJuh8RsuyZmSmzW3gRzKNH9J8H4jgUxwnMR6MhshapA==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr30489012wmi.10.1632149645732;
        Mon, 20 Sep 2021 07:54:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKtZyLQklhvFP4E8CIP8/HFnNPR2fRGO1PTaijQfdrYO28OItWxsrb7LXGbo8xKOP7lAiUbg==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr30488997wmi.10.1632149645581;
        Mon, 20 Sep 2021 07:54:05 -0700 (PDT)
Received: from [192.168.2.20] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m18sm16064557wrn.85.2021.09.20.07.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 07:54:05 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] riscv: dts: microchip: drop unused pinctrl-names
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
 <20210920132830.152802-4-krzysztof.kozlowski@canonical.com>
 <CAMuHMdX5vhihbKrXh4x_VyA2Cc=nR+53g_fZPHsuHVF56rBvMQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ef5771df-86fa-524a-8a5c-c519e913330b@canonical.com>
Date:   Mon, 20 Sep 2021 16:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX5vhihbKrXh4x_VyA2Cc=nR+53g_fZPHsuHVF56rBvMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 16:32, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Mon, Sep 20, 2021 at 3:28 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> pinctrl-names without pinctrl-0 does not have any sense:
>>
>>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Add review.
> 
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> @@ -33,6 +33,7 @@ properties:
>>        - items:
>>            - enum:
>>                - issi,is25lp016d
>> +              - issi,is25wp256
>>                - micron,mt25qu02g
>>                - mxicy,mx25r1635f
>>                - mxicy,mx25u6435f
> 
> This one looks like an accidental addition?

Thanks, I screwed up something during rebase... I'll send a v3.

Best regards,
Krzysztof

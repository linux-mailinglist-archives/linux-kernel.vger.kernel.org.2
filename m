Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0634542EFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhJOL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:56:34 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49828
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235134AbhJOL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:56:33 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E79BF40003
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634298865;
        bh=c9jh8Oug06AKc57muwkesbMnQqm4YikcwhqDP8QKSX8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mkKg5OQbSywb0OSiOY/run2jL9iViaDEVss/9GUisJm3zdVrvUjfXnWZmNaeiXyX9
         u05SG/XaGOrCj5CArSpdnmZwy9WPeWFCDqBGsHQroGXm6PJDN97HpyRmvMsPz5kvL1
         dIbOC7yw5zsFQ+i5jQjckIuRw8Zy8EztOtfHX4fscz9L2LzT5m8jaFinC0+2wZyGyU
         KXn1QtJmbY250od8VIzrnItUCDTSl0advX/smiQCUa1qutFqhJYcW3097t4xhXiICc
         jsnP+3z4gxZJ0WTtSNs5fDElQSwaKsbFzE5ipa9exFuAY4CCbcUXgTi7hdSg4W8gq8
         gWHia6a8+c5sw==
Received: by mail-wm1-f71.google.com with SMTP id o196-20020a1ca5cd000000b0030dc197412aso790259wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c9jh8Oug06AKc57muwkesbMnQqm4YikcwhqDP8QKSX8=;
        b=ZxA5jPgobMJo8kSjeKW5vWHgt8Jyl1chhskVBN16MqI4JOyYg7M4GQ81eli8xKolfg
         qMVJLQiwDVkIyVZpREiih+YGlFEgmKjahGansnZLzyyv+8mBfyVIaBp5oW7Yl2/QWlr6
         l1/nFyHikKiCxDo98v/fVI5+eGGC8uOvGlDmO0ncbTP3A2tkLcBWOt4Q3GL4yMTf8wAv
         D8AJfZMkwSPOeVXgeXtpIuFkLlWwisNCH7ipHciIfievp9GRbIw0STC7gTnnsrM+57Tj
         eluhwXmOYUwzAAQzlN3dIoZwFrFQbPhgFTGHXvtA7DoLhPi+ZSz6yjSLU7vspps3GqxD
         ZwUQ==
X-Gm-Message-State: AOAM530pCgef6IB6aeHCZ1LLypxg5JpSSLtKrrz9J7M+nAyFtZ4XtNCY
        wKKUgQF6AOJbLG/KjlA4xnala11HrQIUVe7Hpo1UxgYc3R8Y5LnIVDSnoZO1N+opHVtgqW3aGPQ
        fk4/otflMwTiAz3nC+bTp3QQHlXg3ONgPOF8mQv2Nkw==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr12195412wmg.35.1634298865219;
        Fri, 15 Oct 2021 04:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrsgC8rHPMRvubvnpUIbMn2Nt0B3IBm9IRtB1R9WUWCgSJvYa0cPdXCvYF+Pd0OXvt+Lspfg==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr12195376wmg.35.1634298864992;
        Fri, 15 Oct 2021 04:54:24 -0700 (PDT)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id d8sm4931663wrv.80.2021.10.15.04.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 04:54:24 -0700 (PDT)
Message-ID: <49af3dc8-0d1e-e82f-6df2-2bf8338acd3a@canonical.com>
Date:   Fri, 15 Oct 2021 13:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
Content-Language: en-US
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmUSmi9mbiHpatBjGgRjrtyJPms9BRmyBPs5BWeVb7n1Nw@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmUSmi9mbiHpatBjGgRjrtyJPms9BRmyBPs5BWeVb7n1Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 12:14, Bin Meng wrote:
> On Fri, Oct 15, 2021 at 6:09 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The CLINT in the T-HEAD 9xx processors do not support 64bit mmio access to
>> the MTIMER device. The current schema does not allow to specify this.
>>
>> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
>> restriction. Samuael Holland suggested in
>> lib: utils/timer: Use standard property to specify 32-bit I/O
>> https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378bc59ff30008e
>> to use "reg-io-width = <4>;" as the reg-io-width property is generally used
>> in the devicetree schema for such a condition.
>>
>> A release candidate of the ACLINT specification is available at
>> https://github.com/riscv/riscv-aclint/releases
>>
>> Add reg-io-width as optional property to the SiFive Core Local Interruptor.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> index a35952f48742..266012d887b5 100644
>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> @@ -41,6 +41,13 @@ properties:
>>     reg:
>>       maxItems: 1
>>
>> +  reg-io-width:
>> +    description: |
>> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only support
>> +      32bit access for MTIMER.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    const: 4
> 
> But this is not a "sifive,clint" anyway. Should there be a new
> dt-bindings for T-Head clint variant?

I assume by new dt-bindings variant you mean: Add a new compatible 
string in Documentation/devicetree/bindings/timer/sifive,clint.yaml.

The vendor Debian image uses:
compatible = "{allwinner,sun20i-d1-clint", "sifive,clint0"};

We could add this diff in a future version of the patch:

--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -26,6 +26,7 @@ properties:
        - enum:
            - sifive,fu540-c000-clint
            - canaan,k210-clint
+          - allwinner,sun20i-d1-clint
        - const: sifive,clint0

      description:
@@ -33,10 +34,10 @@ properties:
        Supported compatible strings are -
        "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
        onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
-      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
+      CLINT v0 as integrated onto the Canaan Kendryte K210 chip,
        "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
-      integration tweaks.
-      Please refer to sifive-blocks-ip-versioning.txt for details
+      integration tweaks, and "allwinner,sun20i-d1-clint" for the Allwinner
+      D1. Please refer to sifive-blocks-ip-versioning.txt for details

    reg:
      maxItems: 1

Best regards

Heinrich

> 
>> +
>>     interrupts-extended:
>>       minItems: 1
> 
> Regards,
> Bin
> 


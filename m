Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B073D6F84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhG0Gce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0Gcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:32:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0434C061757;
        Mon, 26 Jul 2021 23:32:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id k7so11336381qki.11;
        Mon, 26 Jul 2021 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZodOxH2mi3oVQCgZbHeQ1Z7SEaNLCAQji8pdEN9SFds=;
        b=VWqZ1K7VEeCqADO0lcyNxpZAtCvuDbxYnXe/umnQYXFTEU2Q3/5SRXKGUPG5yZGA/F
         fUzFX5UI02FBKI/E+1OslEFh+gkpbahMpM1bEP1zYkewuW8f5hEu3cIrLR06rHDd/KH5
         Qsx2ttP624HUmtVTlT0+h4apaFiSw+/M2539iJW96pNnHSNivMPe7BPReZZ5IJ77T1Sj
         ilhMv+PxwRu/cbEmReNpO0VqXpsd2w6zKKCdlXoURxsb8mEdY8WKDwn6aCKzcXtI5zas
         o52DOIew7NRlI1k4bgdZ6KEw92WXEKPvuJmKxmjTCyleRY9wb8SY/kYfMF4vIyynKMkU
         r33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZodOxH2mi3oVQCgZbHeQ1Z7SEaNLCAQji8pdEN9SFds=;
        b=cHbgZa2uk6JAjU4i8WsIjgCo3NJv2FvD2H8PTepaJluq6nBwR/11zbpAm01Yuk0T4I
         FEINHJ8SOMSggCIxWY2DdaxF+p+awOpYIrUEQLHXjTI+vciNYUlEioUiwnL3e6U7Xcln
         ie0BYNxHTt6Zb3DhLnszPPTYtF2K0KIXNL53lEiGIaY+uH3irAwhs9G+WSuaeo58tPTb
         Qb1waKxVmLpn6FsBTDXjutOmD9Z7zG923mH5yB1/mlkzxn50UZ1IJi1zFnGUNorySXmR
         iGDCv9vs49i8ow+Ddb7mMB2/gc3qaFsN5LXrCZYdhlOluoJWROXmaCuSPIzyGSrgxiy/
         Bxvg==
X-Gm-Message-State: AOAM531GR6lEH+Ec+tV35Qf37NABbJBIxZocRw62unBYnyaU+vj74tKn
        tzFrvRjDZ9MqVUTCD26Ghow=
X-Google-Smtp-Source: ABdhPJwzRlk7guZzCPjW8tkviOhayM0/Oinn+yB/k8dcg0RGIfF01sY4KWBtXJCQ9kyRWfQA9KqzTw==
X-Received: by 2002:a37:8504:: with SMTP id h4mr20860646qkd.85.1627367552216;
        Mon, 26 Jul 2021 23:32:32 -0700 (PDT)
Received: from [192.168.1.201] (pool-74-96-87-9.washdc.fios.verizon.net. [74.96.87.9])
        by smtp.googlemail.com with ESMTPSA id r13sm1033279qtt.38.2021.07.26.23.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 23:32:31 -0700 (PDT)
Subject: Re: [RFC PATCH v2 06/11] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
To:     Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Bin Meng <bmeng.cn@gmail.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
 <20210618123851.1344518-7-anup.patel@wdc.com>
 <20210712192207.GA2322460@robh.at.kernel.org>
 <CAAhSdy0=aL+N7fLD4+b0u3j3zj8+xYOFH_WAu3N8wFkJNxFqrg@mail.gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <5c00f06b-e29e-2c2f-e5e5-dff9d92fa3ff@gmail.com>
Date:   Tue, 27 Jul 2021 02:32:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0=aL+N7fLD4+b0u3j3zj8+xYOFH_WAu3N8wFkJNxFqrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 11:27 AM, Anup Patel wrote:
> On Tue, Jul 13, 2021 at 12:52 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Jun 18, 2021 at 06:08:46PM +0530, Anup Patel wrote:
>>> We add DT bindings documentation for the ACLINT MSWI and SSWI
>>> devices found on RISC-V SOCs.
>>>
>>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>> ---
>>>   .../riscv,aclint-swi.yaml                     | 82 +++++++++++++++++++
>>>   1 file changed, 82 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
>>> new file mode 100644
>>> index 000000000000..b74025542866
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
>>> @@ -0,0 +1,82 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: RISC-V ACLINT Software Interrupt Devices
>>> +
>>> +maintainers:
>>> +  - Anup Patel <anup.patel@wdc.com>
>>> +
>>> +description:
>>> +  RISC-V SOCs include an implementation of the M-level software interrupt
>>> +  (MSWI) device and the S-level software interrupt (SSWI) device defined
>>> +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
>>> +
>>> +  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
>>> +  specification located at
>>> +  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
>>> +
>>> +  The ACLINT MSWI and SSWI devices directly connect to the M-level and
>>> +  S-level software interrupt lines of various HARTs (or CPUs) respectively
>>> +  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
>>> +  parent interrupt controller for the ACLINT MSWI and SSWI devices.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/interrupt-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - riscv,aclint-mswi
>>> +          - riscv,aclint-sswi
>>> +
>>> +    description:
>>> +      Should be "<vendor>,<chip>-aclint-mswi" and "riscv,aclint-mswi" OR
>>> +      "<vendor>,<chip>-aclint-sswi" and "riscv,aclint-sswi".
>>
>> The schema doesn't match the description.
>>
>> There's no actual vendor implementation yet? You could do:
>>
>> items:
>>    - {}
>>    - const: riscv,aclint-mswi
>>
>> But then your example will fail.
> 
> Is it okay to have optional vendor compatible string ?

I think you can express this with something like

properties:
   compatible:
     contains:
       enum:
         - ...

> 
> Vendors can add their specific compatible string if there is some
> special handling required. If there is not special handling required
> then the two compatible strings are enough.
> 
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 0
>>> +
>>> +  interrupts-extended:
>>> +    minItems: 1
>>
>> You need maxItems too. I guess this based on number of cores, so just
>> pick a 'should be enough' value.
> 
> There is a limit on the maximum number of connections between the
> device and HARTs or CPUs so this will be the maxItems over here.
> 
> I will update this in the next patch revision.
> 
>>
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts-extended
>>> +  - interrupt-controller
>>> +  - "#interrupt-cells"
>>> +
>>> +examples:
>>> +  - |
>>> +    // Example 1 (RISC-V MSWI device used by Linux RISC-V NoMMU kernel):
>>> +
>>> +    interrupt-controller@2000000 {
>>> +      compatible = "riscv,aclint-mswi";
>>> +      interrupts-extended = <&cpu1intc 3 &cpu2intc 3 &cpu3intc 3 &cpu4intc 3>;
>>
>> interrupts-extended = <&cpu1intc 3>, <&cpu2intc 3>, <&cpu3intc 3>, <&cpu4intc 3>;
> 
> Okay, will update.
> 
>>
>>> +      reg = <0x2000000 0x4000>;
>>> +      interrupt-controller;
>>> +      #interrupt-cells = <0>;
>>> +    };
>>> +
>>> +  - |
>>> +    // Example 2 (RISC-V SSWI device used by Linux RISC-V MMU kernel):
>>> +
>>> +    interrupt-controller@2100000 {
>>> +      compatible = "riscv,aclint-sswi";
>>> +      interrupts-extended = <&cpu1intc 1 &cpu2intc 1 &cpu3intc 1 &cpu4intc 1>;
>>
>> Same here.
> 
> Okay, will update here as well.
> 
>>
>>> +      reg = <0x2100000 0x4000>;
>>> +      interrupt-controller;
>>> +      #interrupt-cells = <0>;
>>> +    };
>>> +...
>>> --
>>> 2.25.1
>>>
>>>
> 
> Regards,
> Anup
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D164380DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 02:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhJWAFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 20:05:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56662
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhJWAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 20:05:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DE353FFF9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634947394;
        bh=XUfcmdIiHP0nbLBuvoKlNVwHtrOEgTh5qPjTylX+Xt8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iL7jHtxartRcssf3q/vpY9COqvftBSFZMYTXUdfFCtTHGSFMWTq31kKzGqDUxG34C
         XgsZ2zbo1S7u8vjoGGzGPG4VAze5Fl2DMPYa0irZECxWlSYoByXdq5LX7M9Gg1EnMt
         qoDtBeF1agk6WgwNnevWdv/RP0fuc4EINa5abgecZsmcbPdFkUxa93iSs72hsAURUZ
         cVZL4pencx5NGO68PDWC++e7eIvyYuUifBnuUcMvtkNPmmk2PpdNxcJjp1L9y0iPsS
         Rx3T8HHR5BuAp08fywj36XjYBfVKMQ39Iad2c+zq3j0ObPN5RpIIGO4xA6t4i8ibab
         DcY+1bbrleL4g==
Received: by mail-wm1-f72.google.com with SMTP id g188-20020a1c20c5000000b0032328337393so1912946wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 17:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XUfcmdIiHP0nbLBuvoKlNVwHtrOEgTh5qPjTylX+Xt8=;
        b=I/D2Vcz6KMU7GwIUlKBIU9K+ZUPcex4YFCfdzUvbtH2COJ0RGt++Dfy5x2FFCl7UPD
         OaOAST/+hffM4Picgy7LqR0bfZG7PV7TED6plKJQtDUegM+7L875qUl9tMmnuk+ioYdj
         /fhV+s4JwvFmOaJze6OmD5PEPF16m8EALENatdqVmIgz+XsmyAX3GR7bpj3GSIJfUauR
         qLPR2wgWetg4/ACaEu+v62MFnHbU7Hbp9saxx9ybMxMSx51zjfN9DtOOCpiDvd1eTC9s
         fcGrDmmnfLJpYX7Nrz5L9jzYQr3ofCd3f70glMvLGUnSR5oGm7J8X8yBVELOhAHJorH+
         YdKA==
X-Gm-Message-State: AOAM5325mw/Rx9hwTFqblNCOj8oaLPUjIiuJCOpHDM4OVcbA/XbbjJMp
        B3e/ZI1wChqFbtt7U+r793bXySim0ZWz6eD41hYir3EKowJ+sc3+xzkNxERJzclA/5OHoDDtl1S
        BK3hAXIXSOY1g1D7puEU0ZGtYrpPlDNceOKYnt8+lsw==
X-Received: by 2002:adf:fccc:: with SMTP id f12mr3804392wrs.208.1634947394133;
        Fri, 22 Oct 2021 17:03:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7/oKz0tgyj4UYNQC2NoolgI+FF+Jp6VqF/7vU92xkd9q+CO9Gla8aTbLNFqjeQM7R06FKpA==
X-Received: by 2002:adf:fccc:: with SMTP id f12mr3804372wrs.208.1634947393940;
        Fri, 22 Oct 2021 17:03:13 -0700 (PDT)
Received: from [192.168.123.35] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id a16sm9182038wrp.14.2021.10.22.17.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 17:03:13 -0700 (PDT)
Message-ID: <6d642c10-27b1-72bd-a38e-f966ae8831f0@canonical.com>
Date:   Sat, 23 Oct 2021 02:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/1] dt-bindings: T-HEAD CLINT
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bin Meng <bmeng.cn@gmail.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        opensbi@lists.infradead.org
References: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
 <YXMriYWcOcgJSpKj@robh.at.kernel.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <YXMriYWcOcgJSpKj@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/21 23:22, Rob Herring wrote:
> On Wed, Oct 20, 2021 at 11:36:03AM +0200, Heinrich Schuchardt wrote:
>> The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
>> not support 64bit mmio access to the MTIMER device.
>>
>> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
>> restriction and the "sifive,cling0" compatible string. An OpenSBI
>> patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
>> is generally used in the devicetree schema for such a condition.
>>
>> As the design is not SiFive based it is preferable to apply a compatible
>> string identifying T-HEAD instead.
>>
>> Add a new yaml file describing the T-HEAD CLINT.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> @Palmer, @Anup
>> I copied you as maintainers from sifive,clint.yaml. Please, indicate if
>> this should be changed.
>>
>> For the prior discussion see:
>> https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
>> https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/
>>
>> A release candidate of the ACLINT specification is available at
>> https://github.com/riscv/riscv-aclint/releases
>> ---
>>   .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/timer/thead,clint.yaml b/Documentation/devicetree/bindings/timer/thead,clint.yaml
>> new file mode 100644
>> index 000000000000..02463fb2043a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/thead,clint.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/thead,clint.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SiFive Core Local Interruptor
>> +
>> +maintainers:
>> +  - Palmer Dabbelt <palmer@dabbelt.com>
>> +  - Anup Patel <anup.patel@wdc.com>
>> +
>> +description:
>> +  T-HEAD (and other RISC-V) SOCs include an implementation of the T-HEAD
>> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
>> +  interrupts. It directly connects to the timer and inter-processor interrupt
>> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
>> +  interrupt controller is the parent interrupt controller for CLINT device.
>> +  The clock frequency of the CLINT is specified via "timebase-frequency" DT
>> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
>> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const:
>> +          - allwinner,sun20i-d1-clint
>> +      - const:
>> +          - thead,clint0
>> +
>> +    description:
>> +      Should be "<vendor>,<chip>-clint" and "thead,clint<version>" for
>> +      the T-HEAD derived CLINTs.
>> +      Supported compatible strings are -
>> +      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC
>> +      and "thead,clint0" for the T-HEAD IP block with no chip
>> +      integration tweaks.
> 
> T-HEAD uses the same versioning as SiFive? If you use version numbers in
> compatible strings, the numbering needs to be documented and correlate
> back to the h/w design. See [1]. IP release numbers for FPGA IP for
> example. What it should not be is the binding author making up 0, 1, 2,
> etc. versions.

The only publicly available information on the IP block is:

https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf

Page 3 has a version number for the whole document. Chapter 9 does not 
have any version number for the CLINT. So should we simply call the 
block "thead,clint" without any version number?

@Guo: do you have more information accessible?

Best regards

Heinrich

> 
> Rob
> 
> [1] Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> 

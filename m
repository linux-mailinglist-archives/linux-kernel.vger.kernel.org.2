Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D672036F70B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhD3IVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:21:50 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:33010 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhD3IVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:21:50 -0400
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id A277A601F34D;
        Fri, 30 Apr 2021 11:20:55 +0300 (EEST)
Received: from localhost.localdomain ([172.24.252.69]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Fri, 30 Apr 2021 11:21:00 +0300
Subject: Re: [PATCH v2 1/4] dt-bindings: nvmem: Add bootcount-nvmem
To:     Rob Herring <robh@kernel.org>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1619617498.git.nandor.han@vaisala.com>
 <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
 <20210429205310.GA1729011@robh.at.kernel.org>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <48fc2a6c-9c4d-d858-5ab5-c10c590d8345@vaisala.com>
Date:   Fri, 30 Apr 2021 11:21:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429205310.GA1729011@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2021 08:21:00.0548 (UTC) FILETIME=[C0D95C40:01D73D99]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your feedback.

<snip>

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - linux,bootcount-nvmem
> 
> What makes this Linux specific? IIRC, u-boot has boot counting function
> too.
> 

U-Boot has indeed the counterpart functionality of bootcount feature, 
however, in this particularly case is not called `u-boot,bootcount-nvmem`.
If you have any suggestions I'm happy to change it.
Should I remove the `linux` prefix?

<snip>

>> +
>> +  linux,bootcount-magic:
>> +    description: Override default mask value.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> I don't understand what this is. Is it magic or a mask?

It's the magic value. Seems to be a mistake in the description.
I'll correct this.

> 
>> +
>> +dependencies:
>> +  nvmem-cell-names: [ nvmem-cells ]
> 
> Core schema takes care of this.
> 

Ok. I will remove it in that case.

<snip>

>> +examples:
>> +  # example with 16 bit nvram cell:
>> +  - |
>> +    bootcount {
>> +        compatible = "linux,bootcount-nvmem";
>> +        nvmem-cells = <&bootcount_regs>;
>> +        nvmem-cell-names = "bootcount-regs";
>> +    };
>> +
>> +    rtc: rtc@68 {
>> +        bootcount_regs: bootcount_nvmem_regs@e {
>> +            reg = <0x0e 0x2>;
> 
> It would be simpler to just add a compatible here and get rid of the
> 'bootcount' node here.
> 

This is the configuration for NVMEM cell provider and is done according 
to bindings/nvmem.yaml document.
Is here something that I'm missing?

At least this method of declaring NVMEM cells providers are decoupling 
the code from hardware declaration resulting in a more robust code.

Regards,
    Nandor


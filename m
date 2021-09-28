Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC77441AFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbhI1NST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhI1NSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:18:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC677C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k7so6117964wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTy8p1FX9+52bZQjKRfzWopRlURae3gGJlw1jmoFHv8=;
        b=XW5F8YTXIshTrJRRmHPKLAH1WY0udi50bVo8C+w9H//C81wqcNN4N7h3wA0XA+wv4n
         svvOOjboDWloSRedXg/h5ngPkkK3rtVv/BJAXTIMU1YGKt9MAsvw1E9lZy3cZCK7yb9s
         F90Kr0X36aWSieu6mUPT8estmLI5B4uukt2itKtCqutBXErDapQw8aIe4zfuzs7M+I19
         gIV10j9MVsJMEmrM17qXlBEjhTjEK2XgA359bZCmKCG1cbDOBv6MeAzphzQvP/l850xX
         7ZvXYL2pfrObqddGk2Bn5O2vxdOcADlhSIjNJLUmaN4v7jF8BAotyUYWBoXLa/gOogqr
         UEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTy8p1FX9+52bZQjKRfzWopRlURae3gGJlw1jmoFHv8=;
        b=7i/pLbSj0PnXyuW3tJHcLY8cDTWVYPWoWRSOvvYRbXTK8Gjly3sOYU/GnCeBz+4GsM
         ZH+R/7bU8hbTBcqHwhPRIF3fjvahTb+1dxeqX48aWsrxWAN8rTr4RWwCehcsQliHGjPP
         gZNmcKt8YuzbeZh0ChiMWnVMK4YQF21KnYAJeSspgg4WhLCdsbdXGylI6FzrmvjDyzMa
         sw79rI5mxluP6pQKZg5kEauZALlyZgRyGxC4q3nWP0a4IfSf7xvXjWgEVjS003jJenHY
         45J/nm9zQmXNCPoRzjYRP1JnL+PgeVreFFeU85t2uQBlDC3+ygYrtIsJOnzMX4savHcA
         4xlg==
X-Gm-Message-State: AOAM531uc62E8k7t8gfsP7CUw5J6CYvyjlGme4UThyIHJYjpYMA4w3EE
        ssg3gAna1lXAI+0BdTMIb/9iKaTvadmKUQ==
X-Google-Smtp-Source: ABdhPJyXR9JiZ5AHF8bdJC7ezb76OdWc45UKcupfrQGAIiBT/OiPOP6QDIynGQXNx1a3yrE69MQmIQ==
X-Received: by 2002:a05:6000:1865:: with SMTP id d5mr6698460wri.248.1632834993434;
        Tue, 28 Sep 2021 06:16:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g12sm3171123wmh.36.2021.09.28.06.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:16:32 -0700 (PDT)
Subject: Re: [PATCH V2 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Rob Herring <robh@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     shawnguo@kernel.org, a.fatoum@pengutronix.de,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
 <20210923110109.29785-2-qiangqing.zhang@nxp.com>
 <YVIsq7JJ2A1NhB/w@robh.at.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <110991f8-13e8-665e-0cc7-c102b55cda0e@linaro.org>
Date:   Tue, 28 Sep 2021 14:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVIsq7JJ2A1NhB/w@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2021 21:42, Rob Herring wrote:
> On Thu, Sep 23, 2021 at 07:01:04PM +0800, Joakim Zhang wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Some of the nvmem providers encode data for certain type of nvmem cell,
>> example mac-address is stored in ascii or with delimiter or in reverse order.
>>
>> This is much specific to vendor, so having a cell-type would allow nvmem
>> provider drivers to post-process this before using it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>>   include/dt-bindings/nvmem/nvmem.h                  |  8 ++++++++
>>   2 files changed, 19 insertions(+)
>>   create mode 100644 include/dt-bindings/nvmem/nvmem.h
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> index b8dc3d2b6e92..8cf6c7e72b0a 100644
>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> @@ -60,6 +60,11 @@ patternProperties:
>>               - minimum: 1
>>                 description:
>>                   Size in bit within the address range specified by reg.
>> +      cell-type:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        maxItems: 1
>> +        description:
>> +          Type of nvmem, Use defines in dt-bindings/nvmem/nvmem.h.
> 
> I don't think magic numbers are the right approach here. Actually, I
> don't think we need any DT additions.
> 
> Why not just have the consumer side just tell the nvmem provider what
> the data is and to translate it. The consumer side already has a name
> (e.g. mac-address) which defines what the data is and I think is pretty
> standard. If that name is standard, then you could pass it to the nvmem
> core. If not, define some kernel internal types to use.

Thanks Rob for the inputs,

There are potentially two sources for this information.

1> nvmem cell node name itself.

2> "nvmem-cell-names"

I think nvmem-cell-names is much more consistent w.r.t naming, which 
should help us determine pretty much similar information.

This might need bit of rework in core driver to be able to pass to 
provider drivers.

--srini
> 
> Rob
> 

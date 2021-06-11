Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C63A3FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFKJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:58:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEFC061574;
        Fri, 11 Jun 2021 02:56:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8293399wmh.4;
        Fri, 11 Jun 2021 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2aS2aKAnK8HRnoLMpd4OzBFgPhNdvccv1jLgYOp9O1Q=;
        b=Vyj4vp+WQf3MX0A/ykECp07yDpSb+a2MxyYqRr080tcVKfgDf8tI640rL1QeMrCyK/
         KSxsuph4wUrjqR0LqLMf107xy6m80NsuUZ8qw6qGK49pLXNKXBzwlBA4xfcYuohcPlEd
         DJtrZ9Myk0J4eOPUqnBaXEUy2QwJsPSoyG1OhkYwAOaDqsL0I3/Eix5GjJdvYu8EyKRO
         YYmkuL/aB3Hyq9eGmrBD0f6jkV82JH2iQUnLbF7c77tbekcZIxtmu/FAiwa2nkgomV6w
         uMbwDw5ag+Ficnl5rBF6lagRTWz89/ntlx8XIrYzFsOiybdWQWTxRv6g45A13YaAw609
         OiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2aS2aKAnK8HRnoLMpd4OzBFgPhNdvccv1jLgYOp9O1Q=;
        b=R/H6mTcuG7voykUhEWZIIDKdtJeb1MH8vublQLb9J6l2+VRjGKtsGhI7u+nFDtdbUp
         d30jxErKY4loGZgjG86TVBFDVTxGbcJrr79nEcVeYi7vYFt8E6eRrUw3wHAah1k6l1ST
         h+5RHwfc5PxuGPa83KlLlUr/VhPxiuYMrzv40wulHf5fDIKPgcZ0nnukgFl+QXkrKndY
         b2iBFVnWOoIOjIiN2GzhH1ZuTqpyrmd0jLPbWh2mzhZ6HUPqm4Ae+4VTpPORVwYqSYEo
         KKXMm5L+nzh86GRutHYexlNzT7Uxnvtan3Ah9pzEQ1DP3zhnjHsCb+9+HYXgTjZ1HT5B
         aNCQ==
X-Gm-Message-State: AOAM533HHfDREXatrZEfQX5WdA/IPw8vbBcE8Rtpd2fFGQ22eUTt0C/1
        gTaqsHZ3fJwXk4qaKBSSayr0XQFjidr6bg==
X-Google-Smtp-Source: ABdhPJzRO51Kgr6iMGfZOZyQH08p7CKPYr70cepTRwtpjrGRVpTlK4qEzZS/X+xskoGy1H8iq7qkGw==
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr3096187wmf.11.1623405409129;
        Fri, 11 Jun 2021 02:56:49 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 73sm6955489wrk.17.2021.06.11.02.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:56:48 -0700 (PDT)
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
To:     Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-2-chun-jie.chen@mediatek.com>
 <20210602171201.GA3566462@robh.at.kernel.org>
 <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
 <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
 <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <de082c64-ace3-30b5-7404-1f4b607a83e1@gmail.com>
Date:   Fri, 11 Jun 2021 11:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2021 19:41, Stephen Boyd wrote:
> Quoting Matthias Brugger (2021-06-08 07:45:49)
>>
>>
>> On 07/06/2021 07:20, Chun-Jie Chen wrote:
>>> On Wed, 2021-06-02 at 12:12 -0500, Rob Herring wrote:
>>>>> +
>>>>> +description:
>>>>> +  The Mediatek imp i2c wrapper controller provides functional
>>>>> configurations and clocks to the system.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - mediatek,mt8192-imp_iic_wrap_c
>>>>> +          - mediatek,mt8192-imp_iic_wrap_e
>>>>> +          - mediatek,mt8192-imp_iic_wrap_s
>>>>> +          - mediatek,mt8192-imp_iic_wrap_ws
>>>>> +          - mediatek,mt8192-imp_iic_wrap_w
>>>>> +          - mediatek,mt8192-imp_iic_wrap_n
>>>>
>>>> Looks to me like these are all the same h/w, but just have differing 
>>>> sets of clocks. That's not really a reason to have different 
>>>> compatibles. 
>>>>
>>>> If you need to know what clocks are present, you can walk the DT for 
>>>> all 'clocks' properties matching this clock controller instance. Or
>>>> use 
>>>> 'clock-indices' to define which ones are present.
> 
> Is the idea to use clock-indices and then list all the clock ids in
> there and match them up at driver probe time to register the clocks
> provided by the IO region? Feels like we'll do a lot of parsing at each
> boot to match up structures and register clks with the clk framework.
> 
> If it's like other SoCs then the clk id maps to a hard macro for a type
> of clk, and those hard macros have been glued together with other clks
> and then partitioned into different IO regions to make up a clock
> controller. Or maybe in this case, those clk hard macros have been
> scattered into each IP block like SPI, i2c, uart, etc. so that the clock
> controller doesn't really exist and merely the gates and rate control
> (mux/divider) for the clk that's clocking some particular IP block all
> live inside the IP wrapper. If it's this case then I hope there are a
> bunch of PLLs that are fixed rate so that the i2c clk doesn't have to go
> outside the wrapper to change frequency (of which there should be two
> "standard" frequencies anyway).
> 
>>>>
>>>> Rob
>>>
>>> Some module is divided to sub-modules which are designed in different
>>> h/w blocks for different usage, and if we want to use the same
>>> compatible to present these h/w blocks, we need to move the clock data
>>> provided by these h/w blocks to dts, but we usually use different
>>> compatible to get the h/w blocks data in
>>> Mediatek's clock driver, so do you suggest to register clock provided
>>> by different h/w blocks using same compatible?
>>>
>>
>> The mapping of them is as following:
>> imp_iic_wrap_c:  11007000
>> imp_iic_wrap_e:  11cb1000
>> imp_iic_wrap_s:  11d03000
>> imp_iic_wrap_ws: 11d23000
>> imp_iic_wrap_w:  11e01000
>> imp_iic_wrap_n:  11f02000
>>
> 
> Sure. What is their purpose though? Are they simply a bunch of different
> i2c clks?
> 

That would be need to be answered by MediaTek as I don't have access to any
documentation.

Regards,
Matthias

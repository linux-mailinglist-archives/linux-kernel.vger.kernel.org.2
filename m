Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91F411490
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhITMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhITMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:35:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:34:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so60854978edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jmPHyk4ay/ug+Dxf4+OBmm2M/IVq6xdfv6z1kfmz6X4=;
        b=k8POiYoVtFIC2ywK6xteMDKlWS/z/Mz/tjYABj28RnK7uRbtd9en4Yf34C8b91IRfp
         veN9hiFOrMYFdYH1HQG9GYRfApmBEgjb/BhPAnyrxrE40OH9TaHuGul7xlGsWzWYrkUh
         rrBkTrNJdMGJE6r5vPx1NtwAw8o5+K5V6gFBDdShItVby1LL+I2UKPtA7KRpGQuu2l1d
         QtitFlBxuwNMcYFGD+6THPChlVqiyB5dMjehKIRto9+VEbBd8lRHG9VhAwx2MRF+3qkB
         6IT0/h8PCkoRVkcxuqjgii2Sory/+RnQzHNpkLfthoWBtJn3jzwcK+RfmPOX3QY8kILf
         +cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jmPHyk4ay/ug+Dxf4+OBmm2M/IVq6xdfv6z1kfmz6X4=;
        b=bso8wOe5Zq4HGw0LHAiBip45IVreQ0duPpIOKm9+MTJaKryxp7K/p6sVxlZKYhu3QF
         NQrjizWInHznocG+izAB+v6uQKjr4O++OJxuFbu5bJyswTaRpiGYznPN07JZesQp6xo2
         QO73rbPlB3p5X7cOj9wUya9ocJ5KVWyjXmpCFq6rdfSl2qhbwn0yiJX336TRSywOTMpr
         2OE8WRFiz0ECT5YzgwUZuVOE1pCdA9RlgACXDVfH48lZOU1ochdo68SInfV3Kty0zqOR
         ZNPWEbnoHIC2dK2WmxBfUk22t6BOGrNR45wi2LL1eeGk7qPKD+zIAKwqWnx5CVhaYKM9
         BeLA==
X-Gm-Message-State: AOAM533qLdXq7FEsAhUgVfqTCXTt/xRJjxSEV/KOsZ+BEOM+kQR/3C5A
        41UrghNGLNkAowpa8gVfgSYH8q1m6H6dDg==
X-Google-Smtp-Source: ABdhPJx9ibE/5me085lLqlYWvzrRpYL6jQR9T1y9R8f4AeYy1qh1vbHflSendDAZDYeXxlDl23hhow==
X-Received: by 2002:a05:6402:1508:: with SMTP id f8mr28835441edw.255.1632141260774;
        Mon, 20 Sep 2021 05:34:20 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e22sm7209609edu.35.2021.09.20.05.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:34:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
 <vrcxh2pmt3bl4h.fsf@plvision.eu>
 <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
 <vrcxh2o88nbias.fsf@plvision.eu>
 <1da03714-8f23-1004-e89a-891e4599e04a@linaro.org>
 <vrcxh2mto7bfcb.fsf@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
Date:   Mon, 20 Sep 2021 13:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <vrcxh2mto7bfcb.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2021 13:29, Vadym Kochan wrote:
> 
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
> 
>> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>>> Or, treat cells with length "0" in a special way and allow to update
>>>>> cell info later.you can update irrespective of the length, as long as this is done
>>>> before register.
>>>>
>>>>
>>>>>> };
>>>>>>
>>>>>> some_dev_node {
>>>>>> 	compatible = "xxx";
>>>>>> 	nvmem-cells = <&mac_address>;
>>>>>> 	nvmem-cell-names = "mac-address";
>>>>>> };
>>>>>>
>>>>>> == CODE ==
>>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>>> ==========
>>>>>>
>>>>>>
>>>>>> If you notice the mac_address node reg is 0.
>>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>>> with tlv name.
>>>>>>
>>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>>> update existing cells parsed from OF.
>>>>>
>>>> Lets keep the core code clean for now, I would expect the provider
>>>> driver along with parser function to do update the nodes.
>>>>
>>>> --srini
>>>>
>>> core.c sequence:
>>>
>>> 1) after cells parsed from OF:
>>>
>>> 2) lookup the parser
>>>
>>> 3) parser->cells_parse(ctx, table)
>>>
>>> 3.a) update existing cells matched by name from table
>>>
>>> 4) parser->cells_clean(ctx, table)
>>> /* to free cell's_info allocated by the parser driver */
>>>
>>> as alternative way, I think it would be more generic to
>>> provide nvmem-provider.h API to update the existing cell info,
>>> however it makes sense only when cells were parsed
>>> by the cell parser, in the other situations the
>>> cell should be well defined.
>>>
>>> with this approach the parser driver will be just called
>>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>>> for each parsed cells.
>>
>> TBH, This is an over kill.
>>
>> In nvmem provider driver probe you can parse the tlv data and update the
>> dt nodes before nvmem register.
>>
>> rest of the code should just work as it is.
>>
>> --srini
> 
> You mean to parse TLV in the particular nvmem provider driver (for
> example in at24 driver) ? If so, then it will not allow to parse
> this TLV format from the other kinds of nvmem.

Why not?

Can you also tell us which other nvmem providers are you going to test 
this on?

As long as you represent this parsing function as some library function, 
I do not see any issue.
If any exported symbol is available for this then any nvmem provider 
could use it.

--srini


> 
>>
>>
>>>
> 

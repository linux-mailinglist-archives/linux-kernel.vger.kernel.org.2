Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F274115FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhITNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbhITNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:42:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:41:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j13so61619007edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbUb1RKSMUHlKl2TkDCxbeLrZTB3bEQ9j9H9g+Yx7Jk=;
        b=FBBzDtOx32k5WMHQcMROausuidF2kuvSBrEz/diKHFsgnhJEf5vwuoIX7BKOEFmBjz
         ugJrTxegj5CgusKsIW50++PXrcrKP4HT/APDGAJvfKhMnI+jYFpHin6P9MVRhBKoqUVX
         jPLqDtzBglUKZ2npw6dSnd+MjvUorLVzf97fzyOJW9MxD5nA9VcYv1yGb+92x882rFE8
         MXmpY7vX2NiVWqgOiblNxhylxuVv6S4e+ZGAUtFzsq+roYn9S6kkBaLSYN022MD1gebz
         l8nb+wOhSVlxhqgFhWkkZl3X2xQXFJTTKeUv6h2yvFd3ca3rJ8t2WUoGsY/g35I0hSoH
         uM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbUb1RKSMUHlKl2TkDCxbeLrZTB3bEQ9j9H9g+Yx7Jk=;
        b=SQXjcOOxHAOp5LBAnFMB9qVm2P3zdUN/jMEgbKB0elXUxERpDa7BrQAY+s591LCPa/
         fBRHMV8w51BVaMjANZLK9NkDz18dLgqIOoympkHugU1uKregRbmPosUX1l3Cx3jz1XHa
         Iod0sa2EGMIjiMMkfRimLvrQbQBMlCYTttQCbZiS922FC0qr9OqsUc9VSCjBvZpWSj5H
         N/GMS1xRhB1Gir5lYfOx4yMbFp24+QN/BwBlTrOh/iL5oHB5MTwMXYrZMqCOm+k8B12j
         ax/UZjVQtT4hmD1KtRLLElOWiLbqdCK6+JsPaVrtsXSNbrDNIPe4DY58RWl0FjoTEPMg
         lwHQ==
X-Gm-Message-State: AOAM531lrjsl5AmvwBeCV3EIWhy5Y8XJOh7U7uVAgey1uAjaV43jZDxc
        LtHQujX+5Co2kcdFItRCeyRfpw==
X-Google-Smtp-Source: ABdhPJxvVFcNb+d1yfXrOcxVVV8NBdPfOs6p72adxXeZbSgI08ns+dDsDuQqQ8s+RCgP1Y1lAo+hsg==
X-Received: by 2002:a05:6402:648:: with SMTP id u8mr29541000edx.394.1632145251383;
        Mon, 20 Sep 2021 06:40:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r26sm6176317ejd.85.2021.09.20.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:40:50 -0700 (PDT)
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
 <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
 <vrcxh2lf3rbcjc.fsf@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
Date:   Mon, 20 Sep 2021 14:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <vrcxh2lf3rbcjc.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2021 14:29, Vadym Kochan wrote:
> 
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
> 
>> On 20/09/2021 13:29, Vadym Kochan wrote:
>>>
>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>>>
>>>> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>>>>> Or, treat cells with length "0" in a special way and allow to update
>>>>>>> cell info later.you can update irrespective of the length, as long as this is done
>>>>>> before register.
>>>>>>
>>>>>>
>>>>>>>> };
>>>>>>>>
>>>>>>>> some_dev_node {
>>>>>>>> 	compatible = "xxx";
>>>>>>>> 	nvmem-cells = <&mac_address>;
>>>>>>>> 	nvmem-cell-names = "mac-address";
>>>>>>>> };
>>>>>>>>
>>>>>>>> == CODE ==
>>>>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>>>>> ==========
>>>>>>>>
>>>>>>>>
>>>>>>>> If you notice the mac_address node reg is 0.
>>>>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>>>>> with tlv name.
>>>>>>>>
>>>>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>>>>> update existing cells parsed from OF.
>>>>>>>
>>>>>> Lets keep the core code clean for now, I would expect the provider
>>>>>> driver along with parser function to do update the nodes.
>>>>>>
>>>>>> --srini
>>>>>>
>>>>> core.c sequence:
>>>>>
>>>>> 1) after cells parsed from OF:
>>>>>
>>>>> 2) lookup the parser
>>>>>
>>>>> 3) parser->cells_parse(ctx, table)
>>>>>
>>>>> 3.a) update existing cells matched by name from table
>>>>>
>>>>> 4) parser->cells_clean(ctx, table)
>>>>> /* to free cell's_info allocated by the parser driver */
>>>>>
>>>>> as alternative way, I think it would be more generic to
>>>>> provide nvmem-provider.h API to update the existing cell info,
>>>>> however it makes sense only when cells were parsed
>>>>> by the cell parser, in the other situations the
>>>>> cell should be well defined.
>>>>>
>>>>> with this approach the parser driver will be just called
>>>>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>>>>> for each parsed cells.
>>>>
>>>> TBH, This is an over kill.
>>>>
>>>> In nvmem provider driver probe you can parse the tlv data and update the
>>>> dt nodes before nvmem register.
>>>>
>>>> rest of the code should just work as it is.
>>>>
>>>> --srini
>>>
>>> You mean to parse TLV in the particular nvmem provider driver (for
>>> example in at24 driver) ? If so, then it will not allow to parse
>>> this TLV format from the other kinds of nvmem.
>>
>> Why not?
>>
> 
> Well, I think that nvmem driver and TLV parsing should somehow be
> de-coupled from each other like block devices and FS does. BUT,
> in case this TLV data will be used only on at24 devices then
> may be it is OK.
> 

It has to be decoupled yes, which could be at any level with simple 
library function to a infrastructure level..

In this case with few or single users, doing with an additional 
infrastructure is a bit of over kill IMO.


--srini
>> Can you also tell us which other nvmem providers are you going to test
>> this on?
>>
> 
> Currently I can test only on at24 devices. From the:
> 
> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
> 
> "
> Each ONIE system must include non-volatile storage which contains vital
> product data assigned by the manufacturer. The non-volatile storage
> could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
> sector or any other non-volatile storage medium.
> "
> 
> I am not aware about other nvmem devices which are used for existing
> ONIE supported boards.
> 
>> As long as you represent this parsing function as some library function,
>> I do not see any issue.
>> If any exported symbol is available for this then any nvmem provider
>> could use it.
>>
>> --srini
>>
>>
>>>
>>>>
>>>>
>>>>>
>>>
> 

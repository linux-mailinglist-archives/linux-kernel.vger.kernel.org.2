Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6441B12F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhI1NxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbhI1NxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:53:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:51:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so58075588wra.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mr2XW/ExcapYxP/Bo4qXwpJMhGFNi4fgDwMu2/rJrI0=;
        b=ewnHE/tgkUjMvexYV183LLT3n8rtLClqvwmklt30vsDGsH8tqJ5y61zXyv15nUUN4b
         cMDZzKiREL9qF83rYKrt/iW9E3uiXL5JRKVjKJvgbaHyNofO1LPNxuCXWgdUp7HvRA0D
         dxFoM21AnRLPgO/KoKN1meyELOTpcl9oYfz7/aFAhTIDOSNhMEh8KzHuRjc7dMTBYNAf
         bOOkAXBvkbEeIZSsC8LEh9uQBCivo20VUsFiXaZ4Tsaxm80VOZs/l5SQazRUuKx7oQem
         0v+kHMSbt2Fd1Jgbj4825V3ArXcGRep6VYz5C2nCK7NnE0bpc9eSqFasPNuca9X8/uuk
         MeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mr2XW/ExcapYxP/Bo4qXwpJMhGFNi4fgDwMu2/rJrI0=;
        b=5FlIR+ZiCG06/9mC4PYy0KN/OQR13lTKCqzDiR2uvyUYrfdrs8VTWT04nvhE4bwUoT
         e1Pj2k8urnZQvHb34e467gkf6srKwz00WyUB6WWnzljD1rneYlWUNa1+S/lProUlE96L
         ie1ALT9AiA0ZyMptjX9rzienVIur3Jcs6UcVJ92OY2BbxSfJ151C6uaJ3oxQXQckeZ15
         MAAIkuzBmQsFQEK9crcmRhfgzxvW7zEXKWItf0znns8FhtmQLAp8OkDt/dSGF5rVYz9w
         2ubJUPZGSVQRNLzTwHLjuhT2AGJ7W9Xf54l/UzHMRGaSAjj4+zej5RcNGBGzj99t0xF/
         BM9g==
X-Gm-Message-State: AOAM5328L44i1AS95vM3uyurIzUZTeYMI7a19B1SaeXIISmlWXqHXZc+
        S/h8JumYiPM/ji7/V1/KtqpFZQ==
X-Google-Smtp-Source: ABdhPJztboiKRs3oQxSHpFkZq5VbHxMvwwnjnApD67goEFd4tgtXRrAnkDVGbYH0U181PZXZgsLkGA==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr82981wrf.197.1632837084740;
        Tue, 28 Sep 2021 06:51:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e5sm19777680wrd.1.2021.09.28.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:51:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     John Thomson <john@johnthomson.fastmail.com.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
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
 <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
 <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
 <vrcxh2y27ia23n.fsf@plvision.eu>
 <56fb5c64-4142-03ef-2ea8-fc586fd239e1@linaro.org>
 <vrcxh2tui4akta.fsf@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cbff6b53-d751-0a44-c3de-d31c26ed3d5c@linaro.org>
Date:   Tue, 28 Sep 2021 14:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <vrcxh2tui4akta.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2021 14:31, Vadym Kochan wrote:
>>>> Can I note here that I would like to parse
>>>> TLV data from an SPI-NOR device to NVMEM cells.
>>>> The same general use case (getting mac-address from OEM data).
>>>>
>>>> Was planning to base my work on this series, as well as
>>>> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
>>>> (thanks for pointing that out Srinivas)
>>>>
>>>> Cheers,
>>> What about at least to have just one call in core.c to make it a bit
>>> de-coupled, like:
>> Why do you want to decouple this? the provider driver should be very
>> well aware of the format the data layout.
>>
> In my understanding nvmem device should not aware about the data layout
> (in case it does not rely on device's specific characteristics). Same
> cells layout (TLV, etc) might exist on other nvmem devices.
> 
How would provider driver parse this without even knowing data layout?


>> Its fine to an extent to adding parse_cells() callback in nvmem_config.
>>
> OK, in that case it will require small change in the core.
> 
>>> core.c
>>>
>>> struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>> {
>>> ...
>>>            rval = nvmem_add_cells_from_table(nvmem);
>>>            if (rval)
>>>                    goto err_remove_cells;
>>>
>>> +        rval = nvmem_parse_cells(nvmem, of);
>>> +        if (rval) {
>>> +        /* err handling */
>>> +        }
>>> +
>>>            rval = nvmem_add_cells_from_of(nvmem);
>>>            if (rval)
>>>                    goto err_remove_cells;
>>>
>>>            blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>>>
>>>            return nvmem;
>>>
>>> ...
>>>
>>> }
>>>
>>> somewhere in nvmem-parser.c:
>> However this is totally over kill.
>>
>>> /* retreive parser name from of_node and call appropriate function to parse
>>>      non-fixed cells and update via of_update */
>> This is completely provider drivers job, nothing nvmem core should worry
>> about.
>>
>> If you have concern of having code duplicated then we could make some of
>> the common functions as library functions, But it still is within the
>> scope of provider drivers.
>>
> Do I understand correctly that this parser function should be exported
> from at24.c (in case of ONIE) and not from a separate C module ? Or
> it just means that if there will be more users of this parsing function
> then it might be moved to separate C module ?
yes.
For now am not really sure how many users are for such parsing function.

> 
>> --srini
>>
> BTW, what if such change will be declined by particular nvmem driver
> maintainer ?

You would need some changes to provider driver to be able to flag that 
there is some kind of parsing required anyway.

--srini
> 

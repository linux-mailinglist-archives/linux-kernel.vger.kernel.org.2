Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D7414A10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhIVNFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhIVNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:05:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:03:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u27so9462715edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=joz8xDkWoRh9VhyBdD6YM9MvFcfRdRyEjLr1PaXKoM0=;
        b=SVquRaHPbYJikqGzCE4XhgL0V3uSC8kHfh+74wltT7Bc1FZ/DfyeMIm0B3qCMhHkX+
         HuJbbnCsQQRsfqXKzvO/R8ULnmDyts3qhkK5ZQoIeCQe/jccImkyxLlaRGcNr9L0C4s4
         ZQ6h2+FCfFPkbWKPVgAPS2i+uEDjd/BVwkVyEvI66dnv1B/vw8cudIE9nWM/nwQPnrym
         GbMoXBrBoC1aODqJ9lBBaUDwPE+xEMQ6j189LmhDFEDK+U3DT1ItjHARWAM5yz0HKB0c
         8ZwfasRWf+TUEPPJwt8uxNspG+yp0E9WIi8Nm4+MWbS4Ored7SWRFusbQPpAJgPUpG5b
         cMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joz8xDkWoRh9VhyBdD6YM9MvFcfRdRyEjLr1PaXKoM0=;
        b=ss/6Af4YzqQBlso9H9YeKPXLHkzOaOYg6bIWHftCTx8Hh5txiX9ts1kqdl1xFaqITg
         H7Z0T1VBnpcrakK9JohuJ0hBJyZuOZlZTflLkSbLUTFz5BQOY8zG9u6yI1O60bk1+Q5U
         uQzNPIxQy22YQ/DJxTB1D+qksbfHgoC8LpWbUiz3J4SmqG0FLFqVIK3CpKqfuMVi0jX+
         ikZOJQJMfsgdLlxETsBxtvH17bdYaO4T+kh1XKf56QIbSWJ6KrdkogN3RCarfT1utf2B
         luPtMxnNhQ7dwQrxaDgNdBOvrx7uu5WOx883vk4PWqF/hz3Dv0+DPKv3pdHvAYJA/wIp
         +waQ==
X-Gm-Message-State: AOAM530f7Die89NenVEuxy17SMWeMl3b1UYdNtIYW6dffsz1IB2kEVg8
        YUQqug6vIaIgZwms8piU6F8ukmiRRqegRQ==
X-Google-Smtp-Source: ABdhPJyhYud18CJB2AmEIPTblPIXjVyI+yorXGBl9PJfAwRkaFFlrdr+hHG3BSrqDT5rHIgm/snD8A==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr40085762ejs.230.1632315812147;
        Wed, 22 Sep 2021 06:03:32 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m14sm1036887ejl.74.2021.09.22.06.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 06:03:31 -0700 (PDT)
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-2-qiangqing.zhang@nxp.com>
 <6d91d833-08cc-7ce2-4fe5-3d843a8b31ae@pengutronix.de>
 <181c4037-3c34-0f71-6bb7-a9c11b173064@linaro.org>
 <dbd1c20c-e3be-6c92-52a8-2ad76d0092d0@pengutronix.de>
 <8fc0a5e2-18c0-fa81-3eed-a6d596361633@linaro.org>
 <d580dd06-8bc8-91c9-262b-f6f276b033c2@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <53fd9335-baca-fb52-42f1-2af3b08b5f1f@linaro.org>
Date:   Wed, 22 Sep 2021 14:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d580dd06-8bc8-91c9-262b-f6f276b033c2@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 13:58, Ahmad Fatoum wrote:
> Hi Srini,
> 
> On 22.09.21 14:49, Srinivas Kandagatla wrote:
>>
>>
>> On 22/09/2021 13:31, Ahmad Fatoum wrote:
>>>>>
>>>>> On 08.09.21 12:02, Joakim Zhang wrote:
>>>>>> From: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>>>>>
>>>>>> Some of the nvmem providers encode data for certain type of nvmem cell,
>>>>>> example mac-address is stored in ascii or with delimiter or in reverse order.
>>>>>>
>>>>>> This is much specific to vendor, so having a cell-type would allow nvmem
>>>>>> provider drivers to post-process this before using it.
>>>>> I don't agree with this assessment. Users of the OCOTP so far
>>>>> used this specific encoding. Bootloaders decode the OCOTP this way, but this
>>>>> encoding isn't really an inherent attribute of the OCOTP. A new NXP SoC
>>>>> with a different OTP IP will likely use the same format. Users may even
>>>>> use the same format on an EEPROM to populate a second off-SoC interface, .. etc.
>>>>>
>>>> That is okay.
>>> How would you go about using this same format on an EEPROM?
>>
>> Am guessing that by the time there are more users for such formats, those post-processing functions should be converted into some library functions.
> 
> User A wants to reverse bytes in MAC address. User B stores it in ASCII.
> Both use the exact same EEPROM. How could this ever work when the
> encoding decision is left to the EEPROM driver?

User A and B should mention about this encoding information in there 
NVMEM provider bindings.

Based on that specific post-processing should be selected.

--srini
> 

>>
>> --srini
>>
>>>
>>>>> I'd thus prefer to not make this specific to the OCOTP as all:
>>>>>
>>>>>      * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX    /* ... */
>>
> 
> 

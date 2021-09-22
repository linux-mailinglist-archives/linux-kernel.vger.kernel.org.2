Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2241499D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhIVMvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhIVMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:51:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F42C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:49:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v22so9289023edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDXxF8ENyyHbZZXP3MAIipEvf4FVhC7e66GLAXCcBJ0=;
        b=nNllZFvaQJc5GOkDMTfNXyvDbhDJtEyVUcSBRDcQoSbJpq9cQvbaIADUVGcKXWVdQj
         2SjqWXoZix953IAEiZeJjmGvk1N22UyEwoVYVZmjoCH0FwbpRjcPniMOyJujOiewM+KC
         Ly09Zeig3LgY1xTIFr2GhcXVYPoMh/GvSzIfz4CV2NsLa0i18YcuTzkjrtIDBb/DQ9XM
         +Njt1SpDw4gweXuYbpBu5a9wKMuc0S7UiAoJuUT2Zb2nrFTO8SjFR5J9upYtlXSCOV6f
         c17Ncfd4SX6bxg9IOXt7r9ytqKqZ8jJC8c488JxvBDIQCp9hiqehq3C5r+FKRCrWWX+w
         pm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDXxF8ENyyHbZZXP3MAIipEvf4FVhC7e66GLAXCcBJ0=;
        b=V8N0HeJQBFoSAG8h81WbKPmQM/daaLFktvwN/kadJMzIro43mwQAQQK1SsUOlIrfvE
         YhOQh1Cz3WJAUYMMhw3cTjM8P5hbSBsk803r9gO94cDRTpFVwJe47ALU/7dR+XbzJ7w8
         UC7kZutwOCJtQ7N4TpmKXRtznY8xf2FbvoaZU/C1wa/To/vY1/tU7CW1eKWB97Lj+aaX
         +8fBkn20lM8du0tqczrocbBbVKDvAAUT+3oj6XeuDgAAgHLLb2yV5Hz5c4lK4NLWfOFb
         18nI96veTDjog+nOroF+CGV8VlWqd3ReV/LjLWHN/QLP5EC/Sy/oFWn1Rlliq5f5SOiq
         3g4g==
X-Gm-Message-State: AOAM5313vrHCmm+e2pcBNtGDAFdMy3roqWEiGCCYOn8+IWGzgBaJAmbY
        LtBKlDUiaVoqFAax+oukI5foGOlI6ciF4A==
X-Google-Smtp-Source: ABdhPJwICO2rgY0XkCSnQajdPYkPExG20tbDuE61wiWF5tLtG/ihTxkfIu1eNZYmw67DU1Tjv7ya9A==
X-Received: by 2002:a17:906:7311:: with SMTP id di17mr40454001ejc.517.1632314966073;
        Wed, 22 Sep 2021 05:49:26 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 6sm1024081ejx.82.2021.09.22.05.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:49:25 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8fc0a5e2-18c0-fa81-3eed-a6d596361633@linaro.org>
Date:   Wed, 22 Sep 2021 13:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dbd1c20c-e3be-6c92-52a8-2ad76d0092d0@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2021 13:31, Ahmad Fatoum wrote:
>>>
>>> On 08.09.21 12:02, Joakim Zhang wrote:
>>>> From: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>>>
>>>> Some of the nvmem providers encode data for certain type of nvmem cell,
>>>> example mac-address is stored in ascii or with delimiter or in reverse order.
>>>>
>>>> This is much specific to vendor, so having a cell-type would allow nvmem
>>>> provider drivers to post-process this before using it.
>>> I don't agree with this assessment. Users of the OCOTP so far
>>> used this specific encoding. Bootloaders decode the OCOTP this way, but this
>>> encoding isn't really an inherent attribute of the OCOTP. A new NXP SoC
>>> with a different OTP IP will likely use the same format. Users may even
>>> use the same format on an EEPROM to populate a second off-SoC interface, .. etc.
>>>
>> That is okay.
> How would you go about using this same format on an EEPROM?

Am guessing that by the time there are more users for such formats, 
those post-processing functions should be converted into some library 
functions.

--srini

> 
>>> I'd thus prefer to not make this specific to the OCOTP as all:
>>>
>>>     * #define NVMEM_CELL_ENCODING_MAC_ADDRESS_IMX    /* ... */

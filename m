Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9B41920D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhI0KOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhI0KOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:14:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:12:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x20so6220929wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tTB44XcgmdEQUzd6FNCFDzDAK4JcfXYFGMzJ5hVTb7Y=;
        b=Xl8Mru0fpR9vxtEKAZjxOE6TJyNjJa09s+lSiEmHcFBhuDw1SGPDG1anpt9fiDOpVw
         8r9QZltfQg3f+2QOnhNuD17rnda9VjUJ1yVk3Q8jpqiE9FpgCS7IFFGwJdAqfug6ZYoC
         YGHwoMEbRQDRPpbequ2z+6gczIPOOBoHShkB0udVAj7RohLi6E9T7W2QO2IWwmyFaJru
         OphejVaSrIW2IwlfYfvPXSGus151S4TpVHm+8NAjVpskEsx18rSTSZXJNaJROdCTjkEH
         4R4mW9qItIxDOHJEqEMBqrMg1AFRGTeoDm3+MBnGXxHHYU7CUj/cbUxjHXMt6tGb1VHh
         fGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tTB44XcgmdEQUzd6FNCFDzDAK4JcfXYFGMzJ5hVTb7Y=;
        b=KwnjvJnw2H5uAN/R+PSYrWMYcVAgdp22ocaHCbAfavb5yqVkCjXTYcOnDsBsf6yZxf
         m3xXOB+MrvQKscTxtsr0mO9HBj3LW0Ldcg0MvcEFABlG66vpapak6pYGypvtdQKtK+/N
         Nf3gMxQCKBowaZOi9ji7+4BCPOGAmZBhtXwInIHmPFt06a9hBwNxLDo3eSkPLTop+fXd
         KYXMVzBGbx7wcshHtWoeyYjJelyHa2iLg8luexrDWqLuEELGcHWZdtiPAGs1jWEwLZNO
         Agx6NABspZrazjYIuy3QA6eS+5yBJUg6wATNSGIOwLMg67ti5aXYT0/2IU+GOcfxAoYJ
         xbUQ==
X-Gm-Message-State: AOAM5321i5J6FPC3NRG1MGncM4vTNxysYSFciXxe/+/Bm6YHwCT+oIqo
        jpJURx2vLS6bHsnioM+S6tsSpw==
X-Google-Smtp-Source: ABdhPJzpGZliXWKayiz+97fDqfwNPwktVa8ZlC5EYUsorACL0ru0EtWqKB2t85/rpTiKXb0p+LvMJg==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr26435987wrb.274.1632737553638;
        Mon, 27 Sep 2021 03:12:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 8sm8930867wmj.18.2021.09.27.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:12:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
To:     John Thomson <john@johnthomson.fastmail.com.au>,
        Vadym Kochan <vadym.kochan@plvision.eu>
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
 <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
 <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <65df8099-28a0-fe95-57fc-11c9e90af835@linaro.org>
Date:   Mon, 27 Sep 2021 11:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2021 06:50, John Thomson wrote:
>>> Currently I can test only on at24 devices. From the:
>>>
>>> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
>>>
>>> "
>>> Each ONIE system must include non-volatile storage which contains vital
>>> product data assigned by the manufacturer. The non-volatile storage
>>> could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
>>> sector or any other non-volatile storage medium.
>>> "
>>>
>>> I am not aware about other nvmem devices which are used for existing
>>> ONIE supported boards.
>>>
>>>> As long as you represent this parsing function as some library function,
>>>> I do not see any issue.
>>>> If any exported symbol is available for this then any nvmem provider
>>>> could use it.
>>>>
>>>> --srini
>>>>
> Hi Srinivas,
> 
> Can I note here that I would like to parse
> TLV data from an SPI-NOR device to NVMEM cells.
> The same general use case (getting mac-address from OEM data).
> 
> Was planning to base my work on this series, as well as
> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/

This series is for post-processing nvmem cell data before it gets to 
consumers.
Are you referring to parsing nvmem cell information (offset, name) in 
your usecase like: 
https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html

Or
Are you referring to post-processing nvmem cell data ?


--srini
> (thanks for pointing that out Srinivas)
> 
> Cheers,
> -- John Thomson

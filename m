Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0164112F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhITKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhITKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:37:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E8AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:36:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c22so59452852edn.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=erT+KHY68UKYg3Gicz9ztxbOzi5bhYqhoRSUUgL2FBg=;
        b=eBymerSrPoJeHhz5SlImhD5YfoMhRyAyW79bu1DzisqTBZS6BXkvbyQYSLsUyDsQXd
         IO/FrjbxW3mfFqmWiEF0tPU+UDr8wrvfXcGvUMtoEY6VZI5kHx3ryrY/v2WZCUJl8n15
         SN5S84yUooNPmz14/YyaLTxXNWCFfPsplq41PbNnqkqr8D91drYMcGhFg5a02KUtCNNB
         iQstH6SF2iHcnMfPs2H3zqa5msSvyF+m9T1Z/jCuz7ZIOjiyqUExYVwbjdzGYiOP//5V
         vnX6AkedQDxC4nS+fbZJdGSnUrE+0rScw2y+3wGzukzGsqngXnhzUiYtTAecjmFjtESA
         HQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=erT+KHY68UKYg3Gicz9ztxbOzi5bhYqhoRSUUgL2FBg=;
        b=DVPvnHz8ey/ManlgTEBWQ1tOz4FVfuZSyViFSqN5s3N8vQzaPH3mqyFhgXQtbgoyev
         lyNfYtQ1TyP+4SslDmlEODEoiZqYs96M4JqbH6i17VuT/7DUkGltbBWiHCHgmMsh+mXH
         RpzTRPeeNSxUcNpbca8K5rsbGPd1gbORXOg+QsgouHtAVZlcW9AnqWHvTBv67eFps6LL
         9P85mrZtiNr8DhOi+Dz0WUxCoddfgkAcirJC3yvgnhtNnZCodwTiGoAJaNOTahAgbUMF
         5RrsSwru/7nbHJqTnI2+EgQIAy5MEfGiJjOw93WzVkHPd3xxES+e4Ubj5PmUdR3MOnsw
         jacg==
X-Gm-Message-State: AOAM5308NNQBWStUEh9lve5KyI5G2/CZu/ZrmFYD+hr8D4c+0nT4skjn
        Ob6JtuBOUnSe+mi4HrJ3eIZVtqowOJatww==
X-Google-Smtp-Source: ABdhPJxhz/eHwp5YtMV1ZI4iAe13qnk1FPRJb0UpJ2RtNekgoVm/5QPlqTp3TkuOmbszW5ZXMR+jJQ==
X-Received: by 2002:aa7:d1d3:: with SMTP id g19mr27279440edp.103.1632134169639;
        Mon, 20 Sep 2021 03:36:09 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z3sm5838658eju.34.2021.09.20.03.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 03:36:09 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
Date:   Mon, 20 Sep 2021 11:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <vrcxh2pmt3bl4h.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2021 11:24, Vadym Kochan wrote:
>>>
>>> Probably this might be fixed by lookup nvmem device too ?
>> Honestly, this approach is a total hack to get it working.
>>
>> This is what Am thinking which should look like:
>>
>> ## DT ##
>> eeprom_at24: at24@56 {
>> 	compatible = "atmel,24c32";
>> 	/* Some way to identify that this is a TLV data */
>> 	nvmem-cell-parser-name = "onie-tlv-cells";
>> 	reg = <0x56>;
>>
>> 	mac_address: mac-address {
>> 		/* THIS REG is updated once TLV is parsed */
>> 		reg = <0 0x6>
>> 	};
> I assume these cell nodes should be marked with some property that they
> should be evaluated later, so the cell will be not read
> in case it was not parsed because it may
> exist in nvmem device optionally.
No, we should hit that use case to start with.

nvmem cells are parsed in the core during register path.
Parser should parse the cells before this to keep it simple.

> 
> Or, treat cells with length "0" in a special way and allow to update
> cell info later.you can update irrespective of the length, as long as this is done 
before register.


> 
>> };
>>
>> some_dev_node {
>> 	compatible = "xxx";
>> 	nvmem-cells = <&mac_address>;
>> 	nvmem-cell-names = "mac-address";
>> };
>>
>> == CODE ==
>> ret = of_get_mac_address(dev->of_node, base_mac);
>> ==========
>>
>>
>> If you notice the mac_address node reg is 0.
>> This node "reg" property should be updated ( using of_update_property())
>> by nvmem-provider driver while tlv parsing and by matching the node name
>> with tlv name.
>>
> I assume parser driver can just invoke add_cell_table (with may be
> by adding 'bool update' field to the cell_info struct) and core.c will just
> update existing cells parsed from OF.
> 

Lets keep the core code clean for now, I would expect the provider 
driver along with parser function to do update the nodes.

--srini

>> That way rest of the code will work as usual.
>>
>> If this work for you then we can ask Rob if he foresee any issues in
>> this approach. I already see similar usage in reserved-memory case.

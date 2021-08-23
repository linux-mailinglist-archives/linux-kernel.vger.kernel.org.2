Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89DA3F45D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhHWHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhHWHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:34:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C1C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:33:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so10094690wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RHvw0YidWVbaAnExu+fX8ZpwVEjv8DNNUe3fCJmOO/Y=;
        b=cihGqgYS6WTVC320M39f87DIqKTNtWkRIw4ML9YbV/asEWIzDYqjVz/ox3Y1w2IFel
         MUI76ubdUMuebk9LnrzB1ln/HUq5Qcf9QvFnKy/ZPeqogB/ACo8IU4Eo7BovgpHUJd5J
         wagW48uI5bMp8hcFT2nDGn3+Ortfy5ckk9l7U0zS4DqgUC8o/pyOaQgF4vcVHScnCaGG
         NRkudbTdedeMwdT3lXu4YhcbvNnkJxh6tdKxFutvlPEwCYSmkFgPJm9UgUVxe/w8Cgqk
         /zD2Bhud6rYua4VRYK4COTzrp+65MfOW6xwfV7fFODKYV/mWQnEhGbk3xKbJihnGyQjz
         4xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RHvw0YidWVbaAnExu+fX8ZpwVEjv8DNNUe3fCJmOO/Y=;
        b=IlUwtFnVxo6Douep9Pk5WV48Rk/vSbHmUZEJHIjhAVIunY1obMfHgM23Z0ktwp36r3
         Ac8Dor19/brxFN3gZVu0eU5fKqA9AQ2is9223KjAnAQCur7M07KrJ7CtwMQrV0RtL7c3
         Ui0NIQg+H1J4EcfIRmRt1McaZHC/js3MQIQ+e+kANr0loedCPWpJ1afEH9ltVMhfpFWK
         Mq32dZIp/cw3DxtWdUgHyU7WsNULnPRjNUmVoxK71kU28b54ioCK41VmAJ9/SfsQL1FJ
         IoxskIEZZD0o2Qkdub+QwRcWhdi9GOW88zDqmqYyd6XJ/h1xKDt2FrfUpX+y+n0ZgEpg
         Mpdw==
X-Gm-Message-State: AOAM532veQMf+/T5DITWZKSIvmWehGzix8ANWVdZi1Rm52ZQ3TPPqYpR
        UbzSpnl0DIev1nqo1hb5MacPwg==
X-Google-Smtp-Source: ABdhPJy8/C2rTq4ZpumwaDlzx0P0MOcSI3DkY/gFV083ba/u+F86xPsaT6Gf9OBxOOhLG668rajsQw==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr14777091wmq.120.1629704014921;
        Mon, 23 Aug 2021 00:33:34 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h11sm19672439wmc.23.2021.08.23.00.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 00:33:34 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com
References: <20210819123215.591593-1-abailon@baylibre.com>
 <f7d1205b-e859-e059-c835-c09a85c8c480@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <df9ad6a9-4cf9-dd41-8876-d19bef03d6a5@baylibre.com>
Date:   Mon, 23 Aug 2021 09:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f7d1205b-e859-e059-c835-c09a85c8c480@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 20/08/2021 13:30, Daniel Lezcano wrote:
> Hi Alexandre,
>
> thanks for the proposal.
>
> On 19/08/2021 14:32, Alexandre Bailon wrote:
>> This series add a virtual thermal sensor that uses the hardware thermal sensors,
>> aggregate them to return a temperature.
>>
>> My first aptempt was to do the aggregation in the thermal zone but it was not
>> that easy to do, and, there were some case that would have been conflictual
>> such as setting differents trip for a regular zone and a multisensor zone.
>>
>> Instead, I made a virtual thermal sensor that could registered in a thermal
>> zone, and have its own properties.
>> It could be added in the device tree, with the list of sensors to aggregate,
>> and the type of aggregation to be done.
>>
>> As example:
>>    soc_max_sensor: soc_max_sensor {
>>      compatible = "generic,thermal-aggregator";
>>      #thermal-sensor-cells = <1>;
>>      type = "max";
>>      thermal-sensors = <&lvts 0>, <&lvts 1>, <&lvts 2>, <&lvts 3>,
>>            <&lvts 4>, <&lvts 5>, <&lvts 6>, <&lvts 7>,
>>            <&lvts 8>, <&lvts 9>, <&lvts 10>, <&lvts 11>,
>>            <&lvts 12>, <&lvts 13>, <&lvts 14>, <&lvts 15>,
>>            <&lvts 16>;
>>    };
>>
>> The current series build and work but it would require to be completed
>> aswell a lot of cleanup.
>> Before working on it, I would like to get some feedback and I know if that
>> would an acceptable solution and continue that way.
> Yes, I think it is going to the right direction.
>
> IMO, we can get rid of the thermal_of changes. From a design PoV, the
> patch itself should be the virtual thermal driver without any changes in
> the core code, including thermal_of.
I made that changes in order to be able to get the hw sensors from the 
virtual sensor.
I am not really satisfied of that patch but that the simplest way I 
found to do it.
How would you proceed to get the hw sensor from its device tree phandle 
and id ?

Thanks,
Alexandre

>
> I have some comments on patch 2/2
>
>
>> Follows the following discussion:
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20210617114707.10618-3-ben.tseng@mediatek.com/
>>
>> Alexandre Bailon (2):
>>    thermal: provide a way to get thermal sensor from a device tree node
>>    thermal: add a virtual sensor to aggregate temperatures
>>
>>   drivers/thermal/Kconfig              |   8 ++
>>   drivers/thermal/Makefile             |   1 +
>>   drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
>>   drivers/thermal/thermal_of.c         |  43 +++++++++
>>   include/linux/thermal.h              |  12 +++
>>   5 files changed, 198 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_aggregator.c
>>
>

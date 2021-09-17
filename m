Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29C740F92E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhIQNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhIQNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:33:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB227C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:31:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so15200457wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OwLaIUVHj2AYACgu+1+5bUe7mXh2pDtT9hnzYDXHgJg=;
        b=aiTqnGu9RiBWznAC9/6BxYjDwYLSp8TkdqkvdmBUD1ZVgW0aXoSTz8Z3ikDwZjL8Eb
         wAWyIOcEezKg66cikZ30EBqDel8mdzohme+rewxilnkyNAgrPR6+49UuCJoK4G8vb/1+
         5nzGZYxV60FL3iEsjjRQJnF1sYj2iwwxlgEfpW5hvOUR29oAAeiW0vU9sbuDCI/FoF0p
         nEIjRvB8Dn8jMKeoaiEQgpEzHKXAdpzdIqG65bh9Uev19CgotSx4sl2KedjRVgoDG75p
         rMUUYV0AsuAt/gIjxcpnvKzjBwP1iPBaHKob/ZTh0CyDOf2Gi0gU+0o74NSkjnGlheSY
         H+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OwLaIUVHj2AYACgu+1+5bUe7mXh2pDtT9hnzYDXHgJg=;
        b=cEeXyzppFRxSb2UCDaoXnya3C0xhw4bdeCDMZ8XSVwh5vb0VT7EgtvhaXqeAI2Byh1
         WDeYPXN1Z9ltoGYlUFwS57603o3Gx0ytd8lBWjKMC47oj3tAjFdTycfhbI4nMW8/P6KB
         sVPxVp1stlUoRBhQvAY6tBwFZCD1SVZl8r3ze1JyiZTVFOAJV3nJTawAtP04OEqYRf5v
         0POT6eu+JKJVTLfzynq8LP1uLw82GUb/WjJ3+QiG2Iry88E2w+6WTV9qDE1Z/DmH+2iB
         fm7MHP60ToZu2tKqnvPXFOJw6VUXuoBvqGJVupj5eFGNEpRVwVAtMf+Nk+1I/eEmuOr0
         HefQ==
X-Gm-Message-State: AOAM530TegLqTiVJ0MjfpaELT+LEeDKIwM1bpoKN3N1jjKyf/MMt0Vs2
        cebhJUbwBPLw2jTllEk+h3Ul8A==
X-Google-Smtp-Source: ABdhPJyX2KVt+rCXh/5BQKKXwu3cPht6DuzePGl+EUxU42ZMlDOm33AavCXwztdwI/g87cpqlGOInA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr11893703wrt.57.1631885500481;
        Fri, 17 Sep 2021 06:31:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q11sm6648818wrn.65.2021.09.17.06.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 06:31:39 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
Date:   Fri, 17 Sep 2021 15:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 9/17/21 2:41 PM, Daniel Lezcano wrote:
> On 17/09/2021 09:27, Alexandre Bailon wrote:
>> This series add a virtual thermal sensor.
>> It could be used to get a temperature using some thermal sensors.
>> Currently, the supported operations are max, min and avg.
>> The virtual sensor could be easily extended to support others operations.
>>
>> Note:
>> Currently, thermal drivers must explicitly register their sensors to make them
>> available to the virtual sensor.
>> This doesn't seem a good solution to me and I think it would be preferable to
>> update the framework to register the list of each available sensors.
> Why must the drivers do that ?
Because there are no central place where thermal sensor are registered.
The only other way I found was to update thermal_of.c,
to register the thermal sensors and make them available later to the 
virtual thermal sensor.

To work, the virtual thermal need to get the sensor_data the ops from 
the thermal sensor.
And as far I know, this is only registered in thermal_of.c, in the 
thermal zone data
but I can't access it directly from the virtual thermal sensor.

How would you do it ?

Thanks,
Alexandre
>
>> Changes in v2:
>> - Fix some warnings / errors reported by kernel test robot
>> - rename some struct and functions with a more accurate name
>> - update the dt bindings: rename type attribute to aggregation-function
>> - factorize a little bit the aggregation functions
>>
>> Alexandre Bailon (2):
>>    dt-bindings: Add bindings for the virtual thermal sensor
>>    thermal: add a virtual sensor to aggregate temperatures
>>
>>   .../thermal/virtual,thermal-sensor.yaml       |  67 +++
>>   drivers/thermal/Kconfig                       |   8 +
>>   drivers/thermal/Makefile                      |   1 +
>>   drivers/thermal/virtual-sensor.h              |  51 +++
>>   drivers/thermal/virtual_sensor.c              | 400 ++++++++++++++++++
>>   include/dt-bindings/thermal/virtual-sensor.h  |  15 +
>>   6 files changed, 542 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
>>   create mode 100644 drivers/thermal/virtual-sensor.h
>>   create mode 100644 drivers/thermal/virtual_sensor.c
>>   create mode 100644 include/dt-bindings/thermal/virtual-sensor.h
>>
>

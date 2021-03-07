Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78833000A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCGKIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhCGKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:08:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA73C06174A;
        Sun,  7 Mar 2021 02:08:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u16so8146049wrt.1;
        Sun, 07 Mar 2021 02:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N17PNbdczOJS6zIuPSdPOaVo1ZWkMWNir/xsHjc6uz4=;
        b=OSYtIoCEi5C7aToagDP8tFH/9B6JPjzvbG35UKxr9Hgr8ygXDTwepT0dDlsiX2QaQr
         k/IJSzCUH85tRTdbTFro5BXdpLrkkwAivwkAC68/7ZnjuKIfKB98z98ywZhLue0WpqBG
         cZLxHlfIluFf8D7t6Sgb/hP/LwLHpLNdwtxGklH3qooBqjr0sTyiVdrjrvCNh1HnVK1c
         sWPHG+qsGBzztCOI6XWoCPnL62IY0XqcF0/cOrSEjhsfwVqkc8s3nyY7dxV8KPmhFwqN
         e7jCOif6+AmdMLHxw4JB+9LV5m7GM6XbL7cAOZ93bw1TxLx1pcZmeu4lYQp6LrAqRbVh
         q4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N17PNbdczOJS6zIuPSdPOaVo1ZWkMWNir/xsHjc6uz4=;
        b=owDCkLnxyHEKOjqn2dGXr5czwP3aoWHyTrCWXecbOpcEFu/qm9IbXGvyqSMMd7NFHH
         9G5kfA+7HCW8vHyVqtg0ORwlbFgdCaSbJkxNe5sGDxYKO53U6qlJj3gdf1Ocqu0MvslW
         iQI/mDIx9zC5vXhZA148A48s1cVKNzrx2iAPcjmxmgjd6Mw7J8m3yp6kloRkvNpZS8bO
         dk2EFnGeGwS3kwAnXDA0h3Z/gipC/8i+INTixU7JrMprjROCAEHz1PzPTYACCNUIWjli
         3MPDhcao2HkslDEutFHGKBkrY+lBFOQ6+UXaqHbSQI1LGtTvFzTYISnk2dJMRA/lOqTc
         uJww==
X-Gm-Message-State: AOAM531zh63TpI8GW/QE2KgP/rFBr9WLhR0CYJ/53CvGHYjTceH9HcpL
        hNNBvt5Wm+ApjTk+BRsMvqk6/F/JY6ktiA==
X-Google-Smtp-Source: ABdhPJzunfTBxlaOe8bLEvew7EDPYDQmvFzCUuPc1vhOOlR1YocuZWXOYAkiOftoHRF4MbLthk6pZQ==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr17960638wrx.166.1615111702051;
        Sun, 07 Mar 2021 02:08:22 -0800 (PST)
Received: from [192.168.1.10] (224.red-2-138-103.dynamicip.rima-tde.net. [2.138.103.224])
        by smtp.gmail.com with ESMTPSA id o11sm13501387wrq.74.2021.03.07.02.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 02:08:21 -0800 (PST)
Subject: Re: [PATCH 2/4] mips: bmips: add BCM63268 timer reset definitions
To:     Rob Herring <robh@kernel.org>
Cc:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210225194201.17001-1-noltari@gmail.com>
 <20210225194201.17001-3-noltari@gmail.com>
 <20210306211731.GA1217377@robh.at.kernel.org>
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <f60cc3a8-9629-3659-c3e5-4a42a588b63e@gmail.com>
Date:   Sun, 7 Mar 2021 11:08:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210306211731.GA1217377@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

El 06/03/2021 a las 22:17, Rob Herring escribió:
> On Thu, Feb 25, 2021 at 08:41:59PM +0100, Álvaro Fernández Rojas wrote:
>> Add missing timer reset definitions for BCM63268.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
>>   include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
>> index 6a6403a4c2d5..d87a7882782a 100644
>> --- a/include/dt-bindings/reset/bcm63268-reset.h
>> +++ b/include/dt-bindings/reset/bcm63268-reset.h
>> @@ -23,4 +23,8 @@
>>   #define BCM63268_RST_PCIE_HARD	17
>>   #define BCM63268_RST_GPHY	18
>>   
>> +#define BCM63268_TRST_SW	29
>> +#define BCM63268_TRST_HW	30
>> +#define BCM63268_TRST_POR	31
> 
> Numbering should be local to the provider, so shouldn't this be 0-2?
> Unless these numbers correspond to something in the h/w (bit positions
> for example).

Numbering corresponds to bit positions in the HW:
     uint32        ClkRstCtl;
#define POR_RESET_STATUS            (1 << 31)
#define HW_RESET_STATUS             (1 << 30)
#define SW_RESET_STATUS             (1 << 29)
#define USB_REF_CLKEN               (1 << 18)
#define UTO_EXTIN_CLKEN             (1 << 17)
#define UTO_CLK50_SEL               (1 << 16)
#define FAP2_PLL_CLKEN              (1 << 15)
#define FAP2_PLL_FREQ_SHIFT         12
#define FAP1_PLL_CLKEN              (1 << 11)
#define FAP1_PLL_FREQ_SHIFT         8
#define WAKEON_DSL                  (1 << 7)
#define WAKEON_EPHY                 (1 << 6)
#define DSL_ENERGY_DETECT_ENABLE    (1 << 4)
#define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)
#define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)
#define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)
#define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)

http://datashed.science/misc/bcm/gpl/broadcom-sdk-416L05/shared/opensource/include/bcm963xx/63268_map_part.h

> 
>> +
>>   #endif /* __DT_BINDINGS_RESET_BCM63268_H */
>> -- 
>> 2.20.1
>>

Best regards,
Álvaro.

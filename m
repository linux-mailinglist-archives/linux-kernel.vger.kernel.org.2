Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3A44F135
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhKMEaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKME36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:29:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4129C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:27:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y5so10124924pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dihtd0Vnp/rZO5LQCW93aavoGyTzYqfehYYeK45wdfc=;
        b=qhOeVWh7hZBLXxy9qU8IXd2aWSDmVpIm09dA8YEfBck3QdYBIBKh2ldoJXqDIPlGgU
         ff9AtnH5gelUZtgIvwiNB5Nu8LKC9CawFdAkeh9ZXcJWs7ZrqbBpgdXgBEi1ENU3UxxA
         B4z54M4EZzR06YEwekrfoAtBc1XX2edgPoxewynPzHc/5wgIh/TyFV/t3CKFCtSbVBM/
         fe5TJKq0UZO9jOnFtSofqG+SulSHYnAixb5/Egv7kL2zh5rt6ZXQxSxmzl9llCmhQeNs
         Hpv+f4efW6btXisqyncE6aS0N8YWg/I0gZjIv+QGL/sx31u9oeO+QMPNktMSPLgfT629
         fHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dihtd0Vnp/rZO5LQCW93aavoGyTzYqfehYYeK45wdfc=;
        b=JCivQO9RiOewtZeJCaJXpV4ZrIiegFYB54vVaF5iibAHZ1xxJSmg2T5d5uOtkOf057
         Cct+8ZRdS6FPU7wIkvtE2TH/PzX5IHkcRQuc8lbltbwDtZ3Yey7DnbaoQsXBf9ObIHRa
         VP6aIu7f9KP4h9vvI1+pO50ctRsrOeRf/8ezNNJuzACklV2BOJfcIzYIAirQ20R2LUET
         vdY0W5C+++drKD3tTfcuSoGi2Z2BbIyBEhH4bARbPClo8Si19BVlnpoq6RJEAIYX9aqS
         wo1L5urWSWpoHGiea88zOgVShDHJavffup0NR7rplvlozQ99pFD58MeCUkdhpcUNcFfl
         6m3w==
X-Gm-Message-State: AOAM530/J0bff+IP59GkyX1ipcSgqukSGGZrq4s/rqXClj3MweF54+sd
        R4KJ4nm8TP34TOVcSQ45jFY=
X-Google-Smtp-Source: ABdhPJxZIAVujV/ZIzZqY3zJpm6j8b2FjaW/R2GrghADUhDbcDeXRRMCFLSIDw4L800HDGMCKeoSKg==
X-Received: by 2002:a63:2b48:: with SMTP id r69mr13144720pgr.421.1636777626111;
        Fri, 12 Nov 2021 20:27:06 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-193-225.oc.oc.cox.net. [68.4.193.225])
        by smtp.gmail.com with ESMTPSA id v13sm8621746pfu.38.2021.11.12.20.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 20:27:05 -0800 (PST)
Message-ID: <a82f3028-ea64-b3a9-4b14-8474ebb78d79@gmail.com>
Date:   Fri, 12 Nov 2021 20:27:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] arm64: defconfig: Enable additional Broadcom STB drivers
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nishanth Menon <nm@ti.com>, Fabio Estevam <festevam@gmail.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211029191505.22593-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211029191505.22593-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2021 12:15 PM, Florian Fainelli wrote:
> Enable the following drivers as modular:
> 
> - NAND controller with CONFIG_MTD_NAND_BRCMNAND
> - AHCI/SATA controller driver with CONFIG_AHCI_BRCM
> - Starfighter 2 Ethernet switch driver with CONFIG_NET_DSA_BCM_SF2
> - USB drivers (OHCI, EHCI, XHCI) with CONFIG_USB_BRCMSTB
> - Watchdog with CONFIG_BCM7038_WDT
> - PWM with CONFIG_PWM_BRCMSTB
> - SYSTEMPORT Ethernet controller with CONFIG_SYSTEMPORT
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to defconfig-arm64/next.
-- 
Florian

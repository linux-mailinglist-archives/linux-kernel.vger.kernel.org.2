Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7C3F4116
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHVTMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhHVTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:12:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FCC061575;
        Sun, 22 Aug 2021 12:12:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so325121pjt.0;
        Sun, 22 Aug 2021 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HqLZmepQrKc9lx/z79M6Ifhxm7Ymq86aEQN8GvgSv6g=;
        b=X3yQc6GnrI6r7AnR/mfCNcjXqy+BU5BYcuUxpvM58lspw5iipOWSTgIh5brI8lsusH
         /xauYGJn9piNjwYgmoa7SL/ztltx+XKI3bi8GIvl0+3ASaVjkB0Tm06Wjox0Dm/fBpC9
         0uqRHJJwZ2ShJNrR4ERs1kwVdN1jzj/4zie3gpZl6IaIgIne/JYBD/fC7jgnsAb95Fn6
         kUjs+c7clZUCXYMtsQeZTDGR7y7Ypr7PemHP3hmp1d8VKVOQ5y8HutalhtbuYUOL1x+W
         sZC+p15f4CloQ4U7R3j2NKKv/5j5PZI7XiWNrckDp86waAlBCYclCxOzIuXfcFPG5jOG
         HpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HqLZmepQrKc9lx/z79M6Ifhxm7Ymq86aEQN8GvgSv6g=;
        b=QnKQ9s+oSNBdrQmpu6dJhpluBWNNgYfzI0DUxYbHU/C8TSh/feCuHuK9318wxO/nhh
         uW73ZgcKS1M2GBF07KsLzMMk5gc1iB7Zi7QbK8g48Vnu6sEKff0Rx+ohBkohYcASTOTu
         l4FJS6ZSMBR1WDU9XiyOEkcR/3NFj7iU7MqWyMxrcS1pnBv53G01h2DO06aMPQmQy68P
         D5qSDEMWDijnUk8WmwBznHsJ18dcvhyrfM2DgEC125deQwV3EzE37tDNAQnhFvCMFyzN
         O29p67ldppxyB8Max6i3kYQ2lkZZvxJljHlQG/pxhz9QkgHZ0LECLrEL5tnuBZyruIrH
         aDNg==
X-Gm-Message-State: AOAM533A/ZCgz7FW6TaH1aGZbdC9uKRm5HP0oItdiaEqmkf4sFPOGZZ4
        YLqYDOtUvM9OfALxXmqZMig=
X-Google-Smtp-Source: ABdhPJwD6IqDxQ/V4tvshJc+8M1kmIbPfg9RNGWammXPYoviFSDArmXwwDAOrgxg30KkyhWwRgWZag==
X-Received: by 2002:a17:902:aa06:b0:12f:66dc:be7f with SMTP id be6-20020a170902aa0600b0012f66dcbe7fmr6831383plb.9.1629659532350;
        Sun, 22 Aug 2021 12:12:12 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id u25sm13115374pfn.209.2021.08.22.12.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 12:12:11 -0700 (PDT)
Message-ID: <f8510e24-3f1d-47e2-3981-7415f0926a1d@gmail.com>
Date:   Sun, 22 Aug 2021 21:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v5 0/5] ARM: dts: NSP: add Meraki MX64/MX65 series
Content-Language: en-US
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210806204446.2981299-1-mnhagan88@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210806204446.2981299-1-mnhagan88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2021 10:44 PM, Matthew Hagan wrote:
> Changes from v2:
>    - Introduce boards to Makefile in same patch as the board dts is added
>      (Vladimir Oltean)
>    - Use alphabetical ordering for labels (Vladimir Oltean)
>    - Remove address-cells and size-cells in qca8337 switch nodes (Vladimir
>      Oltean)
>    - Remove "cpu" labels from switch nodes' CPU ports (Vladimir Oltean)
>    - Various LED fixes, utilising dt-bindings/leds/common.h and correctly
>      specifying LEDs in the form "led-N" and with the color/function/
>      function-enumerator properties.
>    - Fix PWM LEDs and corresponding pinctrl bindings. (Vladimir Oltean)
> 
> The following changes were submitted as a separate series:
>    - Introduce patches to disable QSPI by default and enable where used
>      (Vladimir Oltean)
>    - Move mdio@18032000 node from board related file to SoC (Vladimir
>      Oltean)
>    - In addition to above, relocate mdio-mux to bcm-nsp.dtsi and fix
>      the resulting usb3_phy issues
> 
> Changes from v3:
>    - Sort labels on mx64 a0 dts files into alphabetical order as well
>    - move include directives for input/input.h and leds/common.h to
>      bcm958625-mx6x-common.dtsi
>    - Whitespace fixes in bcm958625-mx6x-common.dtsi
>    - rename "senao_nvram" partition to "nvram"
> 
> Changes from v4:
>    - Move chosen and memory nodes from bcm958625-mx6x-common.dtsi to
>      each .dts file (Arnd Bergmann).
>    - Append [@<unit-address>] to memory nodes.
>    - Create Ax stepping-specific dtsi for Ax devices (Arnd Bergmann).
>    - Append read-only property to at24 eeprom node.
>    - Remove L2 properties which should be defined at platform-level.
>    - Correct NAND node names.

I applied patch 1 first such that we don't get warnings when we apply 
patches from there on during bisection builds.
-- 
Florian

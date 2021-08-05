Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5833E10A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhHEI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhHEI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:57:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F8C061765;
        Thu,  5 Aug 2021 01:57:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so9913476pji.5;
        Thu, 05 Aug 2021 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uBGvDrKwcptU4eI40KiqTkmrFiw969jPWA+k2q+CekM=;
        b=kNboybg+6Kjx5JPc/fxOD0oELVczHRj++IDC4hjC0/OJk4oKrRyTu8M/whUk444G3z
         z+fRzPQgeChY0IafDiRl71BHTnwukeLwafgpiosx++y30fCAqhxNrfr7UiEYDTKFvXr2
         dqkQ+2Ld7LKQhj2ZzLXZejyt4Gq4hF4mWUougONkFY4DVy5NPITwb4kBmKAwwOQU6jCS
         TrXao+msXwv0tXe0VFsDyhbi2/VrcLkNZA/Zg8EGlLXevzJnbH51b45b8ax4LMNkWFOS
         5JhMONx+HcEtJwUORLuXLTA3HKm6vfMZfEJqpBIWJr0rKaIiwF5PZsUGvLMAlTf9WRFZ
         1clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uBGvDrKwcptU4eI40KiqTkmrFiw969jPWA+k2q+CekM=;
        b=pXGvNwVZnva4tM3ot8La1v6+h0vxKvVzHhm6/GynrF6qbJOzAyw5DTOlev0UHOBwK7
         jFES3dsO0r7nz08Vuq2c+DNYn7TBH6tPznN9j5eSVQm5fqxRD24zsXzQ9TSUEKE0qkn1
         WWSVGdyv00q84T658wljKv943cMKjazPV9rY9i2X07k66M9Bp0yUnUmh1bRZ+M6VHxac
         YdKylDPBtX9caj9osrO8jtj7PnMF1KQe5d6Kn5YmysIH8+qnFdoixGKFfosKi2sVjumb
         3Ea/eRc/0kv8YqckyAYO9zu1XOv0da2VNWoFb/bAbTqbEaA+/ScERdNrdtmILeJFi4s9
         sOEQ==
X-Gm-Message-State: AOAM5320ABO5INq83n5B49zcW7EByVArp8FU3ZYfZDoPV+PqI9dgYU7v
        v+Jn7TFugLGb7UvkYeNEbuA=
X-Google-Smtp-Source: ABdhPJwGKr4kXuL4EeyTRjdfibpMy6P+YgIwbVDl7RF3M2FKtZcBxPa+YY9mfpLYTvKBD5tas4xFWg==
X-Received: by 2002:a17:902:6bc8:b029:117:6a8a:f7af with SMTP id m8-20020a1709026bc8b02901176a8af7afmr375795plt.51.1628153827200;
        Thu, 05 Aug 2021 01:57:07 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id h20sm5911451pfn.173.2021.08.05.01.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 01:57:06 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] ARM: dts: NSP: add Meraki MX64/MX65 series
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210625095000.3358973-1-mnhagan88@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fefad5f1-a2be-0feb-6170-d1bf5a1d86a2@gmail.com>
Date:   Thu, 5 Aug 2021 01:57:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210625095000.3358973-1-mnhagan88@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/2021 2:49 AM, Matthew Hagan wrote:
> Changes from v2:
>   - Introduce boards to Makefile in same patch as the board dts is added
>     (Vladimir Oltean)
>   - Use alphabetical ordering for labels (Vladimir Oltean)
>   - Remove address-cells and size-cells in qca8337 switch nodes (Vladimir
>     Oltean)
>   - Remove "cpu" labels from switch nodes' CPU ports (Vladimir Oltean)
>   - Various LED fixes, utilising dt-bindings/leds/common.h and correctly
>     specifying LEDs in the form "led-N" and with the color/function/
>     function-enumerator properties.
>   - Fix PWM LEDs and corresponding pinctrl bindings. (Vladimir Oltean)
> 
> The following changes were submitted as a separate series:
>   - Introduce patches to disable QSPI by default and enable where used
>     (Vladimir Oltean)
>   - Move mdio@18032000 node from board related file to SoC (Vladimir
>     Oltean)
>   - In addition to above, relocate mdio-mux to bcm-nsp.dtsi and fix
>     the resulting usb3_phy issues
> 
> Changes from v3:
>   - Sort labels on mx64 a0 dts files into alphabetical order as well
>   - move include directives for input/input.h and leds/common.h to
>     bcm958625-mx6x-common.dtsi
>   - Whitespace fixes in bcm958625-mx6x-common.dtsi
>   - rename "senao_nvram" partition to "nvram"
> 
> Matthew Hagan (4):
>    ARM: dts: NSP: Add common bindings for MX64/MX65
>    ARM: dts: NSP: Add DT files for Meraki MX64 series
>    ARM: dts: NSP: Add DT files for Meraki MX65 series
>    dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65

Matt, should I be expecting a v5 based on Arnd's comments?
-- 
Florian

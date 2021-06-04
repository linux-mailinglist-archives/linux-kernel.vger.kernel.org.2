Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2659C39B62D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFDJqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:46:32 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42835 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:46:31 -0400
Received: by mail-wr1-f41.google.com with SMTP id c5so8611231wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/1v6g0udvrZSDxAh/sWiC9TGRYFd7RSGLxMoHfmDZ4=;
        b=Ky76IkwDoptsX4+XCqf405H4RW5CROeTW89HLAJlgZturlc9/FUMQvhGmgBp/vDjO1
         BHumpBEpuBwMW4NQWaxbxu2kH7EBhJTYaZdgkKXNs7gXH6XuECyomGxlIr6bx3kPtDn6
         9SlB03+fvIEI4Fho1rGm+fksuC6/YDWs9+drof/C6fWH7CCn1mWZNF5waZfiOcqoqLbb
         3wMxdup6Unuokt0kU+yW7JLvydJZGZ1NrMEn4RpcEiKmp0478H3Fz0R83gVG4v2C9XtR
         b8jC4hF/YbP7+JkMeGPrfLFwR1s1xz+8tKpFOW8Th6Uqw0JW0MfS6mG0OyoM4+N8n+bL
         6XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K/1v6g0udvrZSDxAh/sWiC9TGRYFd7RSGLxMoHfmDZ4=;
        b=IKcbADaNLJEZnPo5COxIz3iezLfODW7ev17ox9sJqC7xU174Jq0mLxkKMT8C7E21F4
         PNzRN3LHKhQdxgP+37ZCF3Fgic+wmFkhoNIt6RRKJFNknkaNHtc17ltQP5ksEiQijLYH
         95YS77/ZoSv6lDLvEQ8QMMpT35exqROYPF9PUO7SAsBub75LPOR4YrMR/3eUTDGtqGUa
         6Jl+dOp40QVeaJVo8lECrxl00l4pIY6Hr289/2hvY0cDfIv/ViZISuL2w6Msnv5fLmNY
         qfPNso10/mHpcNkOfJ04Z3dURvw9Gjqxg5986AHOYhwZY84NeMq8wsHJLX703rwAwwzh
         NvTA==
X-Gm-Message-State: AOAM5327usmiH6uuqgkb5b3ObjQgqUxc0KUc3z1iMe+ZmCLZMsD4VC5Y
        JY9xGTpj9HS//Ere0PrCH3/p0A==
X-Google-Smtp-Source: ABdhPJy7ahHw/N5+oUmV1PiBVP74IC1Ex3ShvSK+MK8vhFmSaSrzBC4NYDkrNxiO5YqaUP1vh4ziDg==
X-Received: by 2002:adf:a503:: with SMTP id i3mr2975724wrb.334.1622799825012;
        Fri, 04 Jun 2021 02:43:45 -0700 (PDT)
Received: from [10.1.3.29] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v18sm6800749wrb.10.2021.06.04.02.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 02:43:44 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64: dts: meson-sm1-odroid-c4: fix hub_5v regulator
 gpio
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
References: <20210601090140.261768-1-narmstrong@baylibre.com>
 <20210601090140.261768-4-narmstrong@baylibre.com>
 <CAFBinCB+SyCmxrjJLcuy=mLsChPZ9i_1TsaWkL3kuhPO1wGwWw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <802340ba-edd1-d148-4c6b-e2eae9c2a096@baylibre.com>
Date:   Fri, 4 Jun 2021 11:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB+SyCmxrjJLcuy=mLsChPZ9i_1TsaWkL3kuhPO1wGwWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/06/2021 20:07, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> As described in the Odroid-C4 schematics, the HUB_5V regulator is controlled
>> by GPIOH_8 and in Open Drain since this GPIO doesn't support Push-Pull.
>>
>> Fixes: 326e57518b0d ("arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> my interpretation of page 32 of the schematics [0] is that GPIOH_8 manages VCC5V
> GPIOH_4 is connected as RST_N to the RESET# pad of the USB hub -> this
> seems to match the original regulator definition

You're right, but GPIOH_4 is already a GPIO HOG, so this regulator doesn't make any sense then,
and the GPIO for the VCC_5V regulator is missing, like in patch 5.

So I'll add:
+&vcc_5v {
+	gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+	enable-active-high;
+};

in odroid.dtsi instead in this patch.

Not sure what to do about the regulator-hub_5v.

Neil

> 
> 
> [0] https://wiki.odroid.com/_media/odroid-c4/odroid-c4_rev1.0.pdf
> 


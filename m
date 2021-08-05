Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA373E1899
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbhHEPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbhHEPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:46:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DCC061254;
        Thu,  5 Aug 2021 08:44:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c16so7131907wrp.13;
        Thu, 05 Aug 2021 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YBz32Zc1hS/Utm9NDrz5XfahFXSnSf4FuPBsWrfn/uI=;
        b=dRF1c9/iNO/iVAApPWP7U5HVVhiv2M/PKerE0/OipM5SjXj9f0T7MXkcxNt5JK91eZ
         1G6954Dft7l/4YukvC6uzB0Yv3bP5+KOZ9rsfz1Kg26TW6Db8T16G2rkTd0GBQfowg9I
         lBqkbUarYZwuAXrJYoLspjtJ0poMp6MCQkOU2OdzwqSVD2LMgBxe9QvuHL2jVKDsbEZo
         jnlzGy/3u8bTL2Ayx1eAKReL5ZUjuuplumMx9MPujoHrOzb4Goutx0+GgAYmXMz3IPAg
         VIjzj4TQ4rh16Sfz4xj6puFUvudt4PnYNuhT9v3jlojmdDz/B6HLF/jTej0wAQ/EZZwZ
         3uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBz32Zc1hS/Utm9NDrz5XfahFXSnSf4FuPBsWrfn/uI=;
        b=kGVAamBqW0kE1RtobxGHEAlKHb4Au/pm/xXpAKOFlaEZzrQQvpjHeya7wwxyEUwtsy
         JHqGRzVIx3Cnv7NL32GXp8hg8VTrQK5Tl06cCtw3V3HxxZOHPtJYYj1mzIfxOUTOBgh7
         ONCszwytQsP3a0rfbCneig2TTV99XzgIQoI2cXoGAD7ptFqZ0pt1f9ONPKgsJ579PW+J
         XF15LObhocuUGoYBNhPIifU6E7bLGZCYa8aZ6q3bhMvqZ2Dd8b1v0aXXZE0014EakpsC
         VhXKtUHTaD0+Bio0sjYkQZkmOOOhZYVD0ZH8Ym24hAD+bYco77PeGMCNd3jF3En7c0Kq
         MBqg==
X-Gm-Message-State: AOAM532TsbK1sK6MQ6nA4JnBAktbJySjhMUsH8dKu8XZgHBZu8Hzb4EX
        ps9DuluAzw6qZBbet2RrAMI=
X-Google-Smtp-Source: ABdhPJzNORHs8XIHw6I8Pf3K2O0fqWTFwMp8h4ii9PDd1CqMokAZ+7r6d+RapJOhfI2M4l6lyRzl3g==
X-Received: by 2002:adf:ef4b:: with SMTP id c11mr5983081wrp.35.1628178283614;
        Thu, 05 Aug 2021 08:44:43 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id g16sm7692559wro.63.2021.08.05.08.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:44:43 -0700 (PDT)
Subject: Re: [v6 2/2] arm64: dts: mediatek: Correct UART0 bus clock of MT8192
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
 <20210727023205.20319-3-chun-jie.chen@mediatek.com>
 <CAATdQgC-X6pijkgTBsWJJKp__J6N=7JNKHQJmOMvTAjivwPM5w@mail.gmail.com>
 <a48525422d4c953a2dac2a907895c20b9fd6d232.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <913973ef-e3ee-5015-a010-b436fe620e1c@gmail.com>
Date:   Thu, 5 Aug 2021 17:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a48525422d4c953a2dac2a907895c20b9fd6d232.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2021 04:43, Chun-Jie Chen wrote:
> On Wed, 2021-07-28 at 14:14 +0800, Ikjoon Jang wrote:
>> Hi,
>>
>> On Tue, Jul 27, 2021 at 10:43 AM Chun-Jie Chen
>> <chun-jie.chen@mediatek.com> wrote:
>>>
>>> infra_uart0 clock is the real one what uart0 uses as bus clock.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index c7c7d4e017ae..9810f1d441da 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -327,7 +327,7 @@
>>>                                      "mediatek,mt6577-uart";
>>>                         reg = <0 0x11002000 0 0x1000>;
>>>                         interrupts = <GIC_SPI 109
>>> IRQ_TYPE_LEVEL_HIGH 0>;
>>> -                       clocks = <&clk26m>, <&clk26m>;
>>> +                       clocks = <&clk26m>, <&infracfg
>>> CLK_INFRA_UART0>;
>>>                         clock-names = "baud", "bus";
>>>                         status = "disabled";
>>>                 };
>>
>> There're many other nodes still having only clk26m. Will you update
>> them too?
>>
> 
> Others will be updated by IP owner.
> 

As it seems we will have some time before this can be merged, could you help
work with the other IP owners to get one big patch that updates all clocks?

Thanks a lot,
Matthias

> Best Regards,
> Chun-Jie
> 
>>> --
>>> 2.18.0
>>> _______________________________________________
>>> Linux-mediatek mailing list
>>> Linux-mediatek@lists.infradead.org
>>>
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!1bIz6X2EiFbigCImzQmbqtezIFfl1LRBuPOYTqBdl5wfx8b-zp0zQP68R7RhaIcAAXXF$
>>>  

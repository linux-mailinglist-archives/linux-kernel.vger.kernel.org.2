Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A784C454D11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhKQS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbhKQS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:28:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AADC061570;
        Wed, 17 Nov 2021 10:25:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 137so122365wma.1;
        Wed, 17 Nov 2021 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G7G8W0BwjuPQUTXmQCbe21vRGF/FX9hA/NUXXvMNUjA=;
        b=bNJZubZrX9lNwlAaeq6JY34hjksclyRVH4bz88ZHSTUulSsCKkizYd38z4TPV15nx9
         G9uVCl/6Blbv41M2mN7lK+91g8T0lJIET9KfbAvwGV+KBQ46v/Y4MaT1oQZfKeJIJ2uB
         2041ZRN39sxrqXFgldaYqNzm1x0fu9X5nn6HRdDFJUl89bNnt9d7Me9zvRIle5F6PPqc
         zTZwWOvWw6BTlXoFHEHL+fnZyFlN0suNcXwuH/PqXC60Tb7Y1rfDLN820NPcS4MkS0fc
         jN7iGJbsdYeUeeQaUf3UirkNVykZsvbkDPJq8tbb9vSQbQw5AtgxBEH/rEYok+ITn4mD
         IGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G7G8W0BwjuPQUTXmQCbe21vRGF/FX9hA/NUXXvMNUjA=;
        b=e9snnRhBgo0/WkQepMB2A4OKziF4yzeWBavNUyyt0EZY/s/7X1u2qdXGd4E38Eeu2/
         JulGLEbrZaQDh9E1wYXqkMhCN5OAFY4NJIjgvhb5FOtG5kygpViyWSpK7tpkabTBwxIr
         fzDt9p2XTz4yJzKL5gXlchw+cECxOXMh6JgeI5SdGA6O3AkTsKwgrEulEs/CLAF3aydd
         P8ekyytCMAeg+XXtYzFIHHiaJLjHiRRkW5BkqvbVY+GNqUBmX739nlgz8C3IHjH83/yD
         qDnaxRiPBnsV3vgmE7OcSs+pnxiVov7qJwXNl25f/evXzAD/i6igarqM484wFI1KJ4yD
         vJDA==
X-Gm-Message-State: AOAM530uZvsvoUnVYWwqxg6rxez4afbDt//t4LxtwvIQ8gJtoCJ6lBHk
        OcpCpfPNqM3J+dvowh1ZQM8=
X-Google-Smtp-Source: ABdhPJz7prFVL8Kf87mpUo4bZKTKleodF0ij46ILO/eK+EJgDoglCzg3ljYPbM7CH5KcGXrbrxiOIA==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr2159019wmq.34.1637173547010;
        Wed, 17 Nov 2021 10:25:47 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id 10sm894453wrb.75.2021.11.17.10.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 10:25:46 -0800 (PST)
Message-ID: <174aef7b-64ac-ab45-5283-01662dcc86ce@gmail.com>
Date:   Wed, 17 Nov 2021 19:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] arm64: dts: mt8183: add dpi node to mt8183
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211110192417.4177741-1-fparent@baylibre.com>
 <03de9880-1f1a-b07b-6ec3-279945e08cea@gmail.com>
 <CAOwMV_wmyFiSxdU7BZ-u+OLfStp+4jrwmmo-QaNvZn0HBH7Q1g@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAOwMV_wmyFiSxdU7BZ-u+OLfStp+4jrwmmo-QaNvZn0HBH7Q1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2021 19:21, Fabien Parent wrote:
> Hi Matthias,
> 
> 
> On Wed, Nov 17, 2021 at 6:33 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 10/11/2021 20:24, Fabien Parent wrote:
>>> From: Pi-Hsun Shih <pihsun@chromium.org>
>>>
>>> Add dpi node to mt8183.
>>>
>>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>>> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> index ba4584faca5a..7c283c0b68b5 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> @@ -1443,6 +1443,17 @@ dsi0: dsi@14014000 {
>>>                        phy-names = "dphy";
>>>                };
>>>
>>> +             dpi0: dpi@14015000 {
>>> +                     compatible = "mediatek,mt8183-dpi";
>>> +                     reg = <0 0x14015000 0 0x1000>;
>>> +                     interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
>>> +                     power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>>> +                     clocks = <&mmsys CLK_MM_DPI_IF>,
>>> +                              <&mmsys CLK_MM_DPI_MM>,
>>> +                              <&apmixedsys CLK_APMIXED_TVDPLL>;
>>> +                     clock-names = "pixel", "engine", "pll";
>>
>>
>> We are missing the output port node, don't we?
> 
> The output port node is defined in: [PATCH 2/3] arm64: dts: mediatek:
> mt8183-pumpkin: add HDMI support
> Unlike MT8173, there is no HDMI IP in the MT8183 SoC.
> 

Ok, I missed that because the thread is broken. Would you mind to just resend 
the whole series?

Thanks,
Matthias

>>
>> Regards,
>> Matthias
>>
>>> +             };
>>> +
>>>                mutex: mutex@14016000 {
>>>                        compatible = "mediatek,mt8183-disp-mutex";
>>>                        reg = <0 0x14016000 0 0x1000>;
>>>

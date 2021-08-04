Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEB3E069D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhHDRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbhHDRRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:17:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138CC0617B9;
        Wed,  4 Aug 2021 10:17:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so3079743wrr.2;
        Wed, 04 Aug 2021 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OcuNUS5du1cPG/Bhl2RhgxFiUmmqBvvOg+MihcCyu3U=;
        b=qessE7/60zmeiz1bpGMJaCD1lvSifU42ShPJhKn8OVVWpzgQQzGVBOpCPFZA7vCDr8
         tjdEMrwLfl9NGPBWBXvlzC8TrtPeD8NlrxCSI4QGXh5tG8y+k4Gqnub3kfmmn6M1Odgc
         KShC1mel4OhHm52VDc8A/q9gZgR1fY9HYm0cca2bbhF5E26w2mp7QMKyNH/M56OkX6xO
         fndS6BEntvjLCWXoxxLMxEEEXi+MzK2QVdfBD5zefqY8yJx+GDkdeQf9y5Li8WxPz2OE
         /cfeVMa4vW1rPVkqYufpxmXpGZScvN+uh/zoMEQSjB/mgKJB0ZDckZC3n5x/coRUHQr3
         Ascg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OcuNUS5du1cPG/Bhl2RhgxFiUmmqBvvOg+MihcCyu3U=;
        b=c3ZJCm0tBYho5eSbEyOm7/OQrjJvV8mfPtxAnp7PmD6CRmJ9Zi0wQckpCTDbXZ6WCm
         FS3XLokKRe23xzCBJScULZwB1hobYcz9bMWFCMFcMQ37UMyOmftAxRhZQVLOGnMF75Di
         HGxOQgZjAPtvEIrBIzEKHkxNSbemK5UATE6yDEH7zUGMtQBIdeJJugVXq07Yo/CzRFux
         3u0lFyO1JP16EexAZxWzJM6B6g5NLgNSPJUKOLhKB6C3ujVOkFQxMxpS7qsGq3ONmxxi
         IEvzxct+BZJyXYVubij0yS46YEwOaMOv0JqgmgDPnayVKqQC+R9v0Sh+qS9wCsrnsnZ8
         HOwg==
X-Gm-Message-State: AOAM531a1TLeewmUDNoXaRZNWYhP8Qi6auCjIDl41Ov/4vGrxmxCqQOo
        cpaI6D4oVPpmenLx8vIDNv8B0ZLObhRpXA==
X-Google-Smtp-Source: ABdhPJzODXrVtwYqebGDZKq41DwQ76Sh/ruDhIJ6BoSWFeg4hmebqdIm8zUC4gVLVF9DpvWESHtOvQ==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr459212wrn.52.1628097429876;
        Wed, 04 Aug 2021 10:17:09 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id b14sm3496281wrm.43.2021.08.04.10.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:17:09 -0700 (PDT)
Subject: Re: [PATCH v3 RESEND 1/2] arm64: dts: mt8183: add mediatek,gce-events
 in mutex
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <20210622030741.2120393-1-hsinyi@chromium.org>
 <CAJMQK-hiDDH1ypoDcQYEQZ0Vq3X-mTfZbF7qfRbGtD2zBH=oxw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6d7cd8ec-8a88-81bf-b4ff-60335b8b70bc@gmail.com>
Date:   Wed, 4 Aug 2021 19:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJMQK-hiDDH1ypoDcQYEQZ0Vq3X-mTfZbF7qfRbGtD2zBH=oxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2021 12:27, Hsin-Yi Wang wrote:
> On Tue, Jun 22, 2021 at 11:07 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> mediatek,gce-events is read by mutex node.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Gentle ping on this series. thanks
> 

Both are pushed to v5.14-next/dts64 now. Sorry for the delay.

Matthias

>> ---
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index c5e822b6b77a3..cf22d71161e58 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -1250,6 +1250,8 @@ mutex: mutex@14016000 {
>>                         reg = <0 0x14016000 0 0x1000>;
>>                         interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
>>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>> +                       mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
>> +                                             <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
>>                 };
>>
>>                 larb0: larb@14017000 {
>> --
>> 2.32.0.288.g62a8d224e6-goog
>>

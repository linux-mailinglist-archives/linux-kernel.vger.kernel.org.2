Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18B3603AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhDOHrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhDOHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:47:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E921C061574;
        Thu, 15 Apr 2021 00:47:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j5so21332138wrn.4;
        Thu, 15 Apr 2021 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZE9WdJxd0ITdiZNNPTZzb0rsrIlRH0qZQZUA7zrpRI4=;
        b=oVwFNPIJ5whCaK6HTN9PPePP0+riK/VG2R7QzoE+xbkqSmn0prTJEhV7SzdSVEjBHt
         0HSnMCHC3It33+GS8/9n9s3ljJ/FzmtJ1GcB2nXQ5PSLLKZqOdHWc6BO9F0da50sNM/1
         g1g1AVHASGH+kFPgxyKC4Tw8j/H/eBO7TwWpVgVQ10sGR794chhBqZ++QIvrciZAJRSF
         W43ciRZ7qBXJOHkxVI2snN0GcOPPvXnCcKO/eXguYpTm3P1ADeA9GjFlfXyPGvD/Kiwk
         zdLhwXqAKICAlCCj4O6lsgdJIJroIZrAZpWu1nZ/3Ie+KE6l9XQqG1zxekfZOaVQp/cJ
         yKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZE9WdJxd0ITdiZNNPTZzb0rsrIlRH0qZQZUA7zrpRI4=;
        b=aVT5tPh8iiAPFH9wHjUpubsUkxh41TKJTE/lItM/Kq4hsDdiWMef54SNRZRtgBufMH
         09zbn83+W+1HoYdFj1sThsAG1PI3bjUg5KuIePG1uKC7N4i8T0J14AHz/VEzrE14gSJB
         oafAN7UlR+gp3nBpvdAIMu1ogyGXMhivnZLxIbpTsaFceqxLEeWZApvOR+X53WW9dQVV
         2bxXb7z613JTTCCwlGtMaFIH0zchAqNUmYCrjihz6Y07npebd1sHxtaff+lMjEjoDcft
         Nq0z+2Hgg8sErW5V1sihGv5oAlQdN42buzxmhAN5HgixWPus44BRSUPI1Lff5PluJiR/
         eA9w==
X-Gm-Message-State: AOAM533s0kki8rQxwfg3WSy86eQVf65FgFpwc2qnVYac3tCEztE4XdmE
        NhojAMcJ9qq3dNNZFGtQ8jIf0gyl7ov++Q==
X-Google-Smtp-Source: ABdhPJwdVtBo1w9zqgnQpw8SIxUc4AnTXQl9R/b3vZy8vuxbldXJKVLKj+X+75zeUj6s2YBuKdiY5Q==
X-Received: by 2002:a05:6000:10c7:: with SMTP id b7mr1976287wrx.143.1618472847200;
        Thu, 15 Apr 2021 00:47:27 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id g12sm1782933wru.47.2021.04.15.00.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 00:47:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: dts: mt8183-kukui: fix dtbs_check warnings
To:     Nicolas Boichat <drinkcat@chromium.org>, matthias.bgg@kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20210414144643.17435-1-matthias.bgg@kernel.org>
 <20210414144643.17435-3-matthias.bgg@kernel.org>
 <CANMq1KAxZ+QiRR7LgR22pvhs4us=ne_VtSM-S_byCC0N__6BZA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d87f20bd-2195-663b-dd0b-ea1fa2f28a46@gmail.com>
Date:   Thu, 15 Apr 2021 09:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANMq1KAxZ+QiRR7LgR22pvhs4us=ne_VtSM-S_byCC0N__6BZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 15/04/2021 02:29, Nicolas Boichat wrote:
> On Wed, Apr 14, 2021 at 10:46 PM <matthias.bgg@kernel.org> wrote:
>>
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The dsi children don't have any reg property,
> 
> Confused, see below.
> 
>> so we don't need address and
>> size cells. This makes dtbs_check happy.
>>
>> CC: Hsin-Yi Wang <hsinyi@chromium.org>
>> CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> CC: Nicolas Boichat <drinkcat@chromium.org>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> index ff56bcfa3370..f4dca6a33168 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> @@ -251,8 +251,7 @@ &cpu7 {
>>
>>  &dsi0 {
>>         status = "okay";
>> -       #address-cells = <1>;
>> -       #size-cells = <0>;
>> +
>>         panel: panel@0 {
>>                 /* compatible will be set in board dts */
>>                 reg = <0>;
> 
> ^^ isn't that... a reg property?
> 

Yes, that's my fault. I'm not quite sure why we would need this reg property. In
any case also we have it present "dtbs_check W=1" throws the following warning:
mediatek/mt8183.dtsi:1234.22-1246.5: Warning (avoid_unnecessary_addr_size):
/soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or
child "reg" property


Can you have a look at that?

Regards,
Matthias

>> --
>> 2.30.2
>>

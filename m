Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED5380BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhENOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhENOaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:30:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C54C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:29:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1553710wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajP5fbTlV7Xk8Ece3WpQsvs9eX1/DimIoZ0u1+o/eDg=;
        b=bksMeYi/sY2KQH7SYm+hGmrRM7WJNk8GSHTFjNZe2P5eYDi9vor+MGBvEG2ZLhqcPt
         rLhzii4iojHiiSEeYpogplBuNK7VbgSiSBkgqzome3g/Z7p1cgqDtCRAILgqq383A95H
         UWwzAiDQsCzyTpRJiKtviNEBNiQPfZPDjer0zOtMg9vISA8fKUErWdBTeC8JhesTdzp9
         uVGeeZoPi69Eb3uYS6kSK/JaMTHGSH+T8TLP8sizz316uLgoWq06ilxWOOde4Y7OerkI
         T/7qnYuOaa1VCHsxsliAjyKM/ydOAcwj/0+GujZ5E4iHvTbvX+63j1fvGTEpbuH01m6L
         pLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ajP5fbTlV7Xk8Ece3WpQsvs9eX1/DimIoZ0u1+o/eDg=;
        b=pbz78BGx3ifq8Kb4kpW3i5ssvIpk22cIpe4cnAb1pOX2+KR4R5yU0A3ozA1E4m+Pbs
         oQQ63t1yeQbxP2tKLzrd81kSUC76fabDfufTTBiY6mJ0ANYOD2Al6bTRVj3PYFoZIRwb
         4WxYvkeuNg4AH+UJW8eBVgz1qjTe7YtL1qmdCZVwdzy1Fz8/RzEOyZyaRCkAe09XLhw8
         Ocowbj9BCF77VIXvu59QfTlte5kUjoPbr94es41FFGoUgdzxP/9UkMJooCat5pwb+S5h
         pvqDxkvSuc5UZc6WM8Xf4YcMg9xWb0toBb8+tsXZ7yMDUS/fO1LjjCYPc+JamgTmtnPh
         r9Cg==
X-Gm-Message-State: AOAM5331ctYXw3o6ufIYZsUJFJ8q2z4jLr5LgU/eheCAdjJVXfpG55DI
        wBxKQMJJFnh2aSXbfX0eqXht/2MiXdbrDuQJ
X-Google-Smtp-Source: ABdhPJxNZTxCs6GT6OXAXvuzvpZW/JitfY+kukfZ7CVj3oJCqJN8g/gVdH5KTqhW1yjuEiQolFgwuQ==
X-Received: by 2002:a7b:cd98:: with SMTP id y24mr10053342wmj.4.1621002543926;
        Fri, 14 May 2021 07:29:03 -0700 (PDT)
Received: from [172.20.10.7] ([37.173.48.34])
        by smtp.gmail.com with ESMTPSA id t17sm6740080wrx.40.2021.05.14.07.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:29:03 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board
 dts
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210505073248.3816183-1-narmstrong@baylibre.com>
 <20210505073248.3816183-4-narmstrong@baylibre.com>
 <CAFBinCBa=rHQ+Sho2Lq0cA0dYnhKX4ZJaQUqBcaiOxNzD+bFiA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <089dfcb8-e821-da98-d93f-f3aea3d45ad3@baylibre.com>
Date:   Fri, 14 May 2021 16:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBa=rHQ+Sho2Lq0cA0dYnhKX4ZJaQUqBcaiOxNzD+bFiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2021 22:20, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Wed, May 5, 2021 at 9:32 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Banana Pi BPI-M5 is a credit card format SBC with the following features:
>> - Amlogic S905X3 quad core Cortex-A55
>> - Mali-G31 GPU
>> - 4GB LPDDR4
>> - 16GB eMMC flash
>> - 4 USB 3.0
>> - 1 GbE ethernet
>> - HDMI output
>> - 2x LEDS
>> - SDCard
>> - 2.5mm Jack with Stereo Audio + CVBS
>> - Infrared Received
>> - ADC Button
>> - GPIO Button
>> - 40 pins header + 3pins debug header
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> one nit-pick below, but still this gets my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>> +       /*
>> +        * WARNING: The USB Hub on the BPI-M54 needs a reset signal
> s/BPI-M5/BPI-M54/
> I am hoping that Kevin can fix this while applying

I'll send a v3 since I forgot to CC DT maintainers for patch 2 anyway..

Neil

> 
> 
> Best regards,
> Martin
> 


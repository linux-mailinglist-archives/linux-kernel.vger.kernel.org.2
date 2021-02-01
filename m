Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37630A52E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBAKPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBAKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:15:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBBC061574;
        Mon,  1 Feb 2021 02:15:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d16so15878391wro.11;
        Mon, 01 Feb 2021 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANsARq6fL07NGibn8cbk7oUpbzEAXo/i2Ol65lcGXGk=;
        b=auV2FdGYh4MkV590dDE95x07nWp+vQjkQhprR0m03LfdKoR6gqTNf/rdCs03rgO3P3
         5dRPyI0yeutlaDLKS+KOUEIvTHP3j/fAC3lGmwbM4DXDC6wk7B/36RhA6PJNgy0WpdcC
         DS1DQWajtK4tl5W1oCYLX1sV/N6YtnKgXeiVyczFQuRyYs0l7PD7UEeVb/BHZ53i5xfi
         YRSCkQcuvj6/rPuA1cK4h+n0/TUgW8HNG/7w6Rw3tX0Iq1cqs/VcmZAuXEnrl5kQgtVZ
         rtmfkTYNN0qq3BjqP81vzpTeu56W1Wdsd/84ThscRZulmNU6swRBslleHxnSOKRzdLi1
         HLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANsARq6fL07NGibn8cbk7oUpbzEAXo/i2Ol65lcGXGk=;
        b=md9KixQTPUuoOZgESFRZloPY7Fv9QBPMRnWp/b1rHxloYZelD0PXse1Bw0dPxLMm/q
         wEsqaYVYeIWJaXHnOVM6kQi5zn6XXMX0Nmk9LC1dw6arxXG8LiyOTLwMexUBrQtQzdjq
         Js4OWRAONtJme3rr3SWnvcSsU4V6vxxzUkr4ma1nbuS/XA6MRuzI1JQ9h61F2877kJGi
         j/uwTkZMALlpF7jCtwbRVCOb5mqQ3QFphkPKzB6xDkUavdcQNMD76gk7x5m8ChHA+8Dz
         DXA9Gl93VXamei3vTYjooPNVnKNDZFEOuEr+BBYSxaNUfdWwne8o/JRwL7zWsrHiabG2
         UJRw==
X-Gm-Message-State: AOAM532iTp4LEE/LJbkjIEEvxhKZKg7RgDNVoTXVP10xI+4KfTJpYLYn
        EPSs/wrMfOsiVfhCUZHrhn0=
X-Google-Smtp-Source: ABdhPJw2bUOgz+nMZFzakj6FRbaxaWpLQcIPs4OFTUfWc/C3daSngW+6ZM4wCuPndF5BEXIGMZjVag==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr17067580wrx.69.1612174501673;
        Mon, 01 Feb 2021 02:15:01 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id e12sm25284137wrs.67.2021.02.01.02.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 02:15:01 -0800 (PST)
Subject: Re: [PATCH 0/2] Add MediaTek MT8192 clock provider device nodes
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
 <4536e0a3-8e64-d2b0-df83-33705d10359a@gmail.com>
 <1612171903.18201.6.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <61667c50-edee-d9ef-0731-ce59e6c19995@gmail.com>
Date:   Mon, 1 Feb 2021 11:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612171903.18201.6.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

On 01/02/2021 10:31, Weiyi Lu wrote:
> On Sun, 2021-01-31 at 14:27 +0100, Matthias Brugger wrote:
>>
>> On 22/12/2020 14:40, Weiyi Lu wrote:
>>> This series is based on v5.10-rc1, MT8192 dts v6[1] and
>>> MT8192 clock v6 series[2].
>>>
>>> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=373899
>>> [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405295
>>>
>>
>> [1] is already mainline. You could add this patch as a new one to [2]. But
>> please try to improve the series, before sending just a new version with this
>> patch added.
>>
>> Regards,
>> Matthias
>>
> Hi Matthias,
> 
> Actually I'm a little confused now. Stephen suggested me to send clock
> dts separately because dts may not go through his tree.
> So I separated it from the MT8192 clock series since clock v6.
> What do you suggest me to do next time?
> 

Yes, now that you mention that, I remember...
OK, then I'd propose to resend the DTS patches once the clock patches are accepted.

Regards,
Matthias

>>> Weiyi Lu (2):
>>>   arm64: dts: mediatek: Add mt8192 clock controllers
>>>   arm64: dts: mediatek: Correct UART0 bus clock of MT8192
>>>
>>>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 165 ++++++++++++++++++++++-
>>>  1 file changed, 164 insertions(+), 1 deletion(-)
>>>
> 

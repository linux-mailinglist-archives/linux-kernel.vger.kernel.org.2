Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC23D1E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhGVGXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGVGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:23:12 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A8C061575;
        Thu, 22 Jul 2021 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=geimImWkk+j3UI43YmrbXT0NGSrWz41IEgo4SUWY5x0=; b=vyIh5gzNB1430AHxLZ/3RRB97P
        h3ohXM9uO7sST+trD0bY/4oh3g+BNyJ/TnvbagXk7G/C+nwuOedAiLFn51tRUUZddYyFX8pFOxQVc
        UwNMkiqjQQpP6m3mH+oor2vJlvZSpg6JeF2rGIqTFI7zPKrWQ+V4BldVhLfMH3hPGRDFS8hYlp6Jp
        NJkhwIMxdvn3IHGiZphKYAo/omRaLhHZf26fft+gt58oSlKM2zs4TgB7YT6kBp69u1FMYt1kFjPJJ
        IO9+UYaq3W8C9Uwa05V2WK+3Vdgwd7hQLZ2lc11Wf17rjrQFU1RyX1xBmvkzvNROCLxx3O2It8LhA
        RMBX4yMA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:57951 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1m6SkC-0006us-Cm; Thu, 22 Jul 2021 09:03:44 +0200
Subject: Re: [PATCH v2 3/3] drm/panel: Add ilitek ili9341 panel driver
To:     Dillon Min <dillon.minfei@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
 <1626853288-31223-4-git-send-email-dillon.minfei@gmail.com>
 <8e091b9c-764d-d410-559e-3c5e25de2a3c@tronnes.org>
 <CAL9mu0K2yLsG0MXOd4ke8N8zn7311CJ54hL-JcbocJOK+H7W9A@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <1e4743b0-250f-975a-f83d-5d000c6496e3@tronnes.org>
Date:   Thu, 22 Jul 2021 09:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0K2yLsG0MXOd4ke8N8zn7311CJ54hL-JcbocJOK+H7W9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 22.07.2021 04.07, skrev Dillon Min:
> Hi Noralf
> 
> Thanks for your time to review my patch.
> 
> On Thu, 22 Jul 2021 at 01:42, Noralf Trønnes <noralf@tronnes.org> wrote:
>>
>>
>>
>> Den 21.07.2021 09.41, skrev dillon.minfei@gmail.com:
>>> From: Dillon Min <dillon.minfei@gmail.com>
>>>
>>> This driver combine tiny/ili9341.c mipi_dbi_interface driver
>>> with mipi_dpi_interface driver, can support ili9341 with serial
>>> mode or parallel rgb interface mode by register configuration.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
>>> ---
>>
>>> +static const struct of_device_id ili9341_of_match[] = {
>>> +     {
>>> +             .compatible = "st,sf-tc240t-9370-t",
>>> +             .data = &ili9341_stm32f429_disco_data,
>>> +     },
>>> +     {
>>> +             /* porting from tiny/ili9341.c
>>> +              * for original mipi dbi compitable
>>> +              */
>>> +             .compatible = "adafruit,yx240qv29",
>>
>> I don't understand this, now there will be 2 drivers that support the
>> same display?
> 
> There is no reason to create two drivers to support the same display.
> 
> To support only-dbi and dbi+dpi panel at drm/panel or drm/tiny both
> fine with me.
> 
>>
>> AFAICT drm/tiny/ili9341.c is just copied into this driver, is the plan
>> to remove the tiny/ driver? If so I couldn't see this mentioned anywhere.
> 
> Yes, I'd like to merge the code from drm/tiny/ili9341.c to this driver
> (to make a single driver to support different bus).
> 
> I have two purpose to extend the feature drm/tiny/ili9341.c
> 
> - keep compatible = "adafruit,yx240qv29", add bus mode dts bindings (panel_bus)
>   to define the interface which host wants to use. such as
> panel_bus="dbi" or "rgb"
>   or "i80" for this case, i will add dpi code to drm/tiny/ili9341.c.
> 
> - merge tiny/ili9341.c to this driver,remove drm/tiny/ili9341.c, add
> new dts compatible
>   string to support other interfaces. just like what i'm doing now.
> 
> I have no idea about your plan on drm/tiny drivers, actually some of
> these panels under
> the diny folder can support both dbi and dbi+dpi (much faster, need
> more pins). no
> doubt the requirement to support dpi is always there.
> 
> What is your preference?
> 

I have no plans for tiny/, it's just a place to put tiny DRM drivers of
all sorts.

Whether or not to have "full" DRM drivers in panel/ is up to Sam and
Laurent I guess, currently there's only drm_panel drivers in there. I
have no objections to doing that though.

I just wanted to make sure we don't have 2 drivers for the same display.

Noralf.

> Thanks & Regards
> Dillon
> 
>>
>> Noralf.
>>
>>> +             .data = NULL,
>>> +     },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, ili9341_of_match);

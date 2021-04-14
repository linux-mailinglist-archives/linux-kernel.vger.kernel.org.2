Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745C835F7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbhDNPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhDNPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:37:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:37:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so7574486wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hAkF6uQknso9XK+xsWSjedRJvb6wjAXtp/pbQAjABE=;
        b=EvX3F8wO1sVldTauDFFkVpHnThxjQp+z/IkvzXEQlX1pe40orPGvmbYEKeev2z+7Xc
         6BG2jtNbebgSQjRufagQS4F2IrG4IJOUSDJ5Se5ym7MyK8nRTwgtBUJB3euNfAbtL8Mi
         3Vpw5zjhTaxCpI4+hshvjuHlM2LBqWLcRsY7WsaZl4y4yy1DNZuKHCP9e+iwqpYX76LG
         7okaxva6gHCE/vCv4OhQRnY+Vhz2c648Ss1qAi4NJ7HL8nYiLjA3llfQK8dhwRJjl63M
         YeDsb98l5Tz883pquuOdsW1dsCDdZWP4v5s4aR3m5fH3n7E2ZiIGqMQA2xjPF/pJ4Syu
         ErJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1hAkF6uQknso9XK+xsWSjedRJvb6wjAXtp/pbQAjABE=;
        b=i1pbqIWFv1LHo+4vgszTwATOAkoJTrPSrwR4niR4Sx7UyeAwiB8soDuY9rCRWuJmCB
         Qtfq3OZAIGu+gBIYbmXwGeKagPub2aTr2oM8KRbh5ZNY72IofStAiNkfRhTpp7xWauiS
         vFYwQeR8fehmNdFockA0p3i4vwrWduJim3DKEgb5VU0CuNVwL59npz/9Zy5o2n0xJLjU
         63pZnfVIFhUliUx8EmFwkjizbvnAngdy4S0uPpwggOz9ejyee6Z6Rhh91sv91zGjdanh
         PgdgN4PZ/jRVosVMTVb74OWPTZ/sS8nPeOSuWxlmxY+IxQK/K2Q6S+cgodJicoxjuu6c
         PaZg==
X-Gm-Message-State: AOAM530OQzl6fKC7VriSejs12zbfuf1DGCVm931MLp+gBQaWS1wqAUNe
        9phxNXWW1PnwnGHY+bNh92WSBw==
X-Google-Smtp-Source: ABdhPJzIeSQmioyjZMS7P6mdUfGqW8tzHZ3e0kdnEp/GlBwX30sKpco/2AkaSWNywQiFZUQ3AITpmA==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr13876075wrn.178.1618414642498;
        Wed, 14 Apr 2021 08:37:22 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:49d:95f:49d5:fff7? ([2a01:e0a:90c:e290:49d:95f:49d5:fff7])
        by smtp.gmail.com with ESMTPSA id g3sm15176270wrp.46.2021.04.14.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:37:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>, paul@crapouillou.net,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-3-narmstrong@baylibre.com>
 <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
 <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
 <CAG3jFysp+3__TfEyvKSf47q3nYsdRSbkb9LxX2pcJr356yAgKw@mail.gmail.com>
 <911c73a8-47e8-0bae-2bdd-9eb217b25094@baylibre.com>
 <YHak0zr0o0thq/fu@pendragon.ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9f7e7ca9-5c34-91cc-07ab-1a65caf92eac@baylibre.com>
Date:   Wed, 14 Apr 2021 17:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHak0zr0o0thq/fu@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 10:16, Laurent Pinchart wrote:
> Hi Neil,
> 
> On Wed, Apr 14, 2021 at 10:08:46AM +0200, Neil Armstrong wrote:
>> On 14/04/2021 10:06, Robert Foss wrote:
>>> On Wed, 14 Apr 2021 at 08:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> Le 13/04/2021 à 22:21, Robert Foss a écrit :
>>>>> Hey Neil & Phong,
>>>>>
>>>>> Thanks for submitting this series!
>>>>>
>>>>>> +
>>>>>> +static const struct drm_bridge_funcs it66121_bridge_funcs = {
>>>>>> +       .attach = it66121_bridge_attach,
>>>>>> +       .enable = it66121_bridge_enable,
>>>>>> +       .disable = it66121_bridge_disable,
>>>>>> +       .mode_set = it66121_bridge_mode_set,
>>>>>> +       .mode_valid = it66121_bridge_mode_valid,
>>>>>> +       .detect = it66121_bridge_detect,
>>>>>> +       .get_edid = it66121_bridge_get_edid,
>>>>>> +       .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
>>>>>> +       .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
>>>>>> +};
>>>>>
>>>>> I would like to see an implementation of HPD, since it is supported by
>>>>> the hardware[1] (and required by the documentation). IRQ status bit 0
>>>>> seems to be the responsible for notifying us about hot plug detection
>>>>> events.
>>>>
>>>> It's implemented in the IRQ handler with the IT66121_INT_STATUS1_HPD_STATUS event.
>>>
>>> I didn't even get that far :)
>>>
>>> Either way, the HPD support should be exposed in drm_bridge_funcs
>>> (.hpd_enable, .hpd_disable (and possibly .hpd_notify)) and
>>> drm_bridge.ops (DRM_BRIDGE_OP_HPD).
>>
>> Indeed I forgot these calls in the NO_CONNECTOR implementation...
> 
> For new bridges, you should no implement connector creation, only the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR case should be supported.
> 

Right, time to make a clean bridge-only implementation then !

Thanks for your feedbacks,

Neil

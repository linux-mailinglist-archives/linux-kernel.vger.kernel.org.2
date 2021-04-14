Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9838A35EF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhDNILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349934AbhDNIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:09:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD71C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:08:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b136-20020a1c1b8e0000b029012c69da2040so2652947wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRB91qJ9A807fA6EgTPbj2BjYNiQSWg2GBkiUK5aiR8=;
        b=erR68VNgencnw1ay0BO9J47khMJtHxhpoHs+HRe5qPJed6lBCwtxPr4kvsJsJsbQKH
         mprD90Wo+J9FEZ2SjWPXtUWn6B43osZU/1x4zf1AmmNpHqVxD9CzpbyubINrw9mtd3Ab
         Je8BsLoWW92ihcO6a8PWlenQW+x9fpBd12vjMuS8gGTVvIYkL5DOs5nxnOrOLTv4TdX2
         uOcutKO18S89u7BbY+3MFNnPD2cdIDD6cQgTGV1bEbgAdK7tXsOJ3ND1FfJ9c459L1Ps
         ECfjG6n6JDigN/bkEd2hlA8JQKn2b4BVwCa5I4bW/TQIulVj9NZahtiJffPlLca+x6yO
         7a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DRB91qJ9A807fA6EgTPbj2BjYNiQSWg2GBkiUK5aiR8=;
        b=ZH+ZGpUDFQb0VbKtLHErAyjLqo7zihml7TNvcU5tO4TGYQb11z0421woBERbaEgdLu
         J8vSm99uwURsUlb1R6d0XL8fa0DX6HvpqXwv9Pyg0KTM16mTxPEkl9GEPe7sQAlzNenD
         hVhcCJc0ARD0uT43QVX4U6b17Z8AeduBZmrXFC9rh52B+CeXSDFHMv2WacMsggAeCCak
         w4IXcR4dDqaVlYCUTx6bXVW7sRjvguluVtsVYlzBvrQzxEJPOj/JO8bcY+2fYGIe3BHL
         VNRRrpLG4jYumK/arLycqPbVAh9blrfLrBsg9LqFEEYIJ4Hhl9ReHTD7RNd5eQs+eeLK
         PsAg==
X-Gm-Message-State: AOAM530TPh4uNvi2ygVNT9auX5ztAIQTBpG0zwpqCkKROa6pbuSkH2Ec
        t+zyVjX51NGMPuwy03SyIW4Ueg==
X-Google-Smtp-Source: ABdhPJw2zS2TUO/5aptmzskdXk1UWgVzoiPgGA5zMLhLjK+qVAokMWQWCdUB90xaCO3ELneTIMUnAg==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr1742582wmk.78.1618387727586;
        Wed, 14 Apr 2021 01:08:47 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:49d:95f:49d5:fff7? ([2a01:e0a:90c:e290:49d:95f:49d5:fff7])
        by smtp.gmail.com with ESMTPSA id w4sm19560836wrp.58.2021.04.14.01.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:08:47 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        paul@crapouillou.net, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-3-narmstrong@baylibre.com>
 <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
 <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
 <CAG3jFysp+3__TfEyvKSf47q3nYsdRSbkb9LxX2pcJr356yAgKw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <911c73a8-47e8-0bae-2bdd-9eb217b25094@baylibre.com>
Date:   Wed, 14 Apr 2021 10:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG3jFysp+3__TfEyvKSf47q3nYsdRSbkb9LxX2pcJr356yAgKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 10:06, Robert Foss wrote:
> On Wed, 14 Apr 2021 at 08:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Rob,
>>
>> Le 13/04/2021 à 22:21, Robert Foss a écrit :
>>> Hey Neil & Phong,
>>>
>>> Thanks for submitting this series!
>>>
>>>> +
>>>> +static const struct drm_bridge_funcs it66121_bridge_funcs = {
>>>> +       .attach = it66121_bridge_attach,
>>>> +       .enable = it66121_bridge_enable,
>>>> +       .disable = it66121_bridge_disable,
>>>> +       .mode_set = it66121_bridge_mode_set,
>>>> +       .mode_valid = it66121_bridge_mode_valid,
>>>> +       .detect = it66121_bridge_detect,
>>>> +       .get_edid = it66121_bridge_get_edid,
>>>> +       .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
>>>> +       .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
>>>> +};
>>>
>>> I would like to see an implementation of HPD, since it is supported by
>>> the hardware[1] (and required by the documentation). IRQ status bit 0
>>> seems to be the responsible for notifying us about hot plug detection
>>> events.
>>
>> It's implemented in the IRQ handler with the IT66121_INT_STATUS1_HPD_STATUS event.
>>
> 
> I didn't even get that far :)
> 
> Either way, the HPD support should be exposed in drm_bridge_funcs
> (.hpd_enable, .hpd_disable (and possibly .hpd_notify)) and
> drm_bridge.ops (DRM_BRIDGE_OP_HPD).
> 

Indeed I forgot these calls in the NO_CONNECTOR implementation...

Neil

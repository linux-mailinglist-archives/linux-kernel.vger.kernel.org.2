Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BAA35ECFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbhDNGNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347755AbhDNGNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:13:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:13:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so5917039wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/qsaNKElXIqYcGQ3D9DhLtEdzKDUnrwltbMdfbQlx0=;
        b=z5yWzlbbBA5oiAa5E9YPhUpCjJps/8D8DoXo7AUo//kcHKxstSr1W3PiGiDYTBfRc0
         rpoaVDTVB6EWoyuen2alnsuMoBphaebFgJj4YipbWNxMv8KszEayslHsoKRaFOzXAe5L
         GHkVacYvI7DOQhkXxe2CvB0riGW0reg6A3T4sb/dmljJN+Hk7DBVhYMeMkP2rg0QiQcY
         4xi9Vwu/T9ZWqYieGF962BtTz7wNnwm0G6axLl2KhYYhfnhRSpMmg4zl6fntOCNORNfB
         3Zsti8DyeRAbksoa4aNJBMfeqR6X9lMz53VkTycJg5ifitXmVeYGb8dhNvKW/hku4CpX
         xocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/qsaNKElXIqYcGQ3D9DhLtEdzKDUnrwltbMdfbQlx0=;
        b=oqIyVsv56/nqIiMr3OU6jW01WHzXbLLLs8Xz2+MowBKNAbcYb7KShaOhK/nVz+ZvzK
         csR6Mv6qlXzxNiD07fJLjSaw92bt+bc9tLKGmNjle+7OjUZuEFBZ8YSHP+HVi7BaJxgT
         U7+6fPr0mHOYbERAImjRWr6dEv+sU66Y7et0e3MWxVqmA2HmoSZUyWSUwSLO0nJ1hIVo
         Z3aT2EwXKIdTmwH+jIGJCDiiJApX4PWZ484ccUPuGQYnS4VMeHcGeSJKLIXMRRHHxSXk
         maIqUqL1cVPJNeCMHnpOodUewwrCQKhWX7oox3KuwkI0ZTSWjJ0YAfIwF3m2LNJcHP9a
         JR+A==
X-Gm-Message-State: AOAM5317XEvfOgpzbhd4U4Ht65DMyW3jKD9h8bM2cnmKkWmUkja0wykr
        O+y+Jdg0sjGemZ6JqsjxAat/IA==
X-Google-Smtp-Source: ABdhPJwtomDmRAYyV/PE1J2o23D5cj/StMzlkJ7UI2FhKySrxYRdf2Mp0Id9tFDETM2GCVkQPT+JuQ==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr40293249wrq.193.1618380790874;
        Tue, 13 Apr 2021 23:13:10 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e0a:90c:e290:29e7:a4d9:c2b0:1adc])
        by smtp.gmail.com with ESMTPSA id l13sm4324434wmj.3.2021.04.13.23.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 23:13:10 -0700 (PDT)
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <3266977b-9d19-c81d-6fd7-b6fa0714b1ef@baylibre.com>
Date:   Wed, 14 Apr 2021 08:13:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAG3jFysFb+y6ymXsBQatuwtPEYRTBnWTku0EpmNyR2gR5a=Y2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le 13/04/2021 à 22:21, Robert Foss a écrit :
> Hey Neil & Phong,
> 
> Thanks for submitting this series!
> 
>> +
>> +static const struct drm_bridge_funcs it66121_bridge_funcs = {
>> +       .attach = it66121_bridge_attach,
>> +       .enable = it66121_bridge_enable,
>> +       .disable = it66121_bridge_disable,
>> +       .mode_set = it66121_bridge_mode_set,
>> +       .mode_valid = it66121_bridge_mode_valid,
>> +       .detect = it66121_bridge_detect,
>> +       .get_edid = it66121_bridge_get_edid,
>> +       .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
>> +       .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
>> +};
> 
> I would like to see an implementation of HPD, since it is supported by
> the hardware[1] (and required by the documentation). IRQ status bit 0
> seems to be the responsible for notifying us about hot plug detection
> events.

It's implemented in the IRQ handler with the IT66121_INT_STATUS1_HPD_STATUS event.

Neil

> 
> [1] https://rockchip.fr/radxa/IT66121_Programming_Guide.v1.05.pdf
> 
> 
> Rob.
> 

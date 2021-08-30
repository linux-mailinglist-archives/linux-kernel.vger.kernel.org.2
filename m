Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073EF3FB447
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhH3LDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhH3LDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:03:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:02:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z2so30446038lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U47ZNhbRRgXx0CnEmKFbwE8XspFIUA0v3YyvA8YGSlc=;
        b=YJXdkVGLLCxsw0Er3JBKCgpcTkWUeiKAmAtjguXi9mnSX6H6GT2pN7UpOx7n+sNVwv
         GP7AFakKT/g/fSpGEWhw3I9NmLHV1/Q73Xf+JtLcKIIYY50VrGysorcBzFqX9plc41JK
         NCwjCXJKkZeu9/BHYs3QmjaynIEIg98fxZ7Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U47ZNhbRRgXx0CnEmKFbwE8XspFIUA0v3YyvA8YGSlc=;
        b=rB2ygdC7nAtvOgeBFdgHb+HRop6J4zTY+oZQUrqnJ9RiE1/DMLoKktGG7alf7BCZ9o
         lYhWsxDJl0zCM0NIumrjX7qQVfqbmxndE4lr/LMR2nNkqiriH25VtWVGHeEXGWoFjcFP
         fzCeqGajXl+Z/nerAfcYFow8iIvWEH9MUer38TX0IoBYVbuWhV4VmtNkvJPhghiumkZq
         rzIKId9KeWaTum7f6hajOwvsCZ7kVdE93xBaTRrnwVKsAd739cr5bToEDtta4sLrLL7o
         Y/ad4VDL2zr7tFKHuD4Y5Er2PuXFwmR5Z/0Uah/B27YkqVI+IdY/yyIeIKOO8v2SuLew
         xhBQ==
X-Gm-Message-State: AOAM531NJ7ySiYWcmY5d/VHQzsELPSGbC8QI5PVbE0jy5P6eJ0LmEmmU
        aErT2Y6J6Oiyr59L0XJquVOHLvzNePJhGQv2
X-Google-Smtp-Source: ABdhPJwZ9Mk9pxX0WISVDScQy9ccwOGbt9Ia+iDQzusQ43z9CA3ViryA2QPHb5AFNNxiksbq5Dr04Q==
X-Received: by 2002:ac2:5f99:: with SMTP id r25mr16819030lfe.119.1630321354994;
        Mon, 30 Aug 2021 04:02:34 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x3sm1358494lfg.185.2021.08.30.04.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 04:02:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <19a98ebe-507b-d60e-47a3-9ffabfb24ca3@rasmusvillemoes.dk>
Date:   Mon, 30 Aug 2021 13:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <875yvr3j5c.ffs@tglx>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2021 01.01, Thomas Gleixner wrote:
> On Wed, Aug 25 2021 at 23:50, Vladimir Oltean wrote:
> 
>> Some drivers might access regmap in a context where a raw spinlock is
>> held. An example is drivers/irqchip/irq-ls-extirq.c, which calls
>> regmap_update_bits() from struct irq_chip :: irq_set_type, which is a
>> method called by __irq_set_trigger() under the desc->lock raw spin lock.
>>
>> Since desc->lock is a raw spin lock and the regmap internal lock for
>> mmio is a plain spinlock (which can become sleepable on RT), this is an
>> invalid locking scheme and we get a splat stating that this is a
>> "[ BUG: Invalid wait context ]".
>>
>> It seems reasonable for regmap to have an option use a raw spinlock too,
>> so add that in the config such that drivers can request it.
> 
> What's reasonable about that?
> 
> What exactly prevents the regmap locking to use a raw spinlock
> unconditionally?

Perhaps this:

        /*
         * When we write in fast-paths with regmap_bulk_write() don't
allocate
         * scratch buffers with sleeping allocations.
         */
        if ((bus && bus->fast_io) || config->fast_io)
                map->alloc_flags = GFP_ATOMIC;
        else
                map->alloc_flags = GFP_KERNEL;

i.e. the regmap code can actually do allocations under whatever internal
lock it uses. So ISTM that any regmap that uses a raw_spinlock (whether
unconditionally or via Vladimir's opt-in) cannot be used with
regmap_bulk_write().

ISTM using regmap for mmio makes things more complicated than necessary.

Rasmus

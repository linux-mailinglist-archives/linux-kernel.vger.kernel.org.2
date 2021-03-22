Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FE344845
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCVOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230227AbhCVOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6iQUjQycK1sTABfq5tlKr+irKk0x/vcI8pphi4WOdU=;
        b=QTj7pElh4siA1aFKrWoy8lZWxz4doLEBO8K8W8b+mYM6ooeV5ALVwf7ISVPCuqGMvHpOUS
        eiVjRUJTpOxtCrU08t+8xsfr++uHdGUsNbwWsnHSCDt/eioTP19Ma88fnzCif5tas2npsD
        pbGySjWdfOuOYALKegMqYV8qsTfjtrc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-253_AyS7N8OVW-v--eRAzQ-1; Mon, 22 Mar 2021 10:54:58 -0400
X-MC-Unique: 253_AyS7N8OVW-v--eRAzQ-1
Received: by mail-ej1-f71.google.com with SMTP id k16so19967560ejg.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6iQUjQycK1sTABfq5tlKr+irKk0x/vcI8pphi4WOdU=;
        b=iRjuLPmJm4kCo4YSJusjierjyFfJ3CemeDmfoCGlqTL4b+x/joupmLM3kq7kPBa4ro
         FJa9B7Sjm9fgk0pDZLoLWQkj82WuIB35tGTs+j5f7/KLp1V9usEgoljDe09cSmPih64p
         9Ld7rtXeWS11AoXFzhIOhvZ1rjR8sAFo9gO4itiShELwSjYRPz6C0HRVwbaCqIYHZpv3
         KXVubqWBuCDK+8rvOTlAR1/WhauZqfeAO3x0msW68wQC9HC5Nm+Z3MXGchglqxToADvm
         JFT3aK253uceyCg7gE/82nWxODnKILWW1WauQ7OcaiX6JbGfFoHhW1Pj3/F2fjIQ60tg
         WS7Q==
X-Gm-Message-State: AOAM531NMZBmM9jeHWa3VNPJ7Tzv1lpOg8GWKY2NADzm6M3VyLAex8E0
        DqshFlhATwF+o08VcroFKeg6bX0bCUJFxIdgeP3oipWmhHnRVjkA1kdSrk6A6bdl4KRltTUuvnO
        RqZGN9YQdyPI+LygNZdps5lUX
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr135853ejf.55.1616424896961;
        Mon, 22 Mar 2021 07:54:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFJgvoAB5IhBaexAdxZrh2Nx4yd/dRDvJg0PcoQDjNPJcStUY7NDLa0ZRc5dFHgvEe3T69wA==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr135842ejf.55.1616424896822;
        Mon, 22 Mar 2021 07:54:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cy5sm11549738edb.46.2021.03.22.07.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 07:54:56 -0700 (PDT)
Subject: Re: [GIT PULL] Immutable branch between MFD and Extcon due for the
 v5.13 merge window
To:     Lee Jones <lee.jones@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210307151807.35201-1-hdegoede@redhat.com>
 <20210322144025.GW2916463@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <83f9ff3c-ab92-cabf-6746-19b15c3f7661@redhat.com>
Date:   Mon, 22 Mar 2021 15:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210322144025.GW2916463@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/21 3:40 PM, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-extcon-v5.13
> 
> for you to fetch changes up to a908a716696eee75bf85199cde2b0989290536d1:
> 
>   ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c (2021-03-18 11:46:15 +0000)

Thank you.

Mark can you merge this into your ASoC tree and merge patches 7-13 of:
https://lore.kernel.org/alsa-devel/20210307151807.35201-1-hdegoede@redhat.com/

?

Regards,

Hans





> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Extcon due for the v5.13 merge window
> 
> ----------------------------------------------------------------
> Hans de Goede (6):
>       mfd: arizona: Drop arizona-extcon cells
>       extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
>       extcon: arizona: Fix various races on driver unbind
>       extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
>       extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>       ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
> 
>  MAINTAINERS                                        |  3 +-
>  drivers/extcon/Kconfig                             |  8 ---
>  drivers/extcon/Makefile                            |  1 -
>  drivers/mfd/arizona-core.c                         | 20 -------
>  .../soc/codecs/arizona-jack.c                      | 63 +++++++++++-----------
>  5 files changed, 34 insertions(+), 61 deletions(-)
>  rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (98%)
> 


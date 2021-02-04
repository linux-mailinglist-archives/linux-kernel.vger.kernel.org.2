Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3454530F189
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhBDLG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhBDLGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:06:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC3AC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:05:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so3003244wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nMRiKhF7YdCgOeER5/NiAuJBBtviujq5B9oy3dlX03I=;
        b=E70uKg/MRPTULPpl5mj6qG+BRKRrLmajLV1IyZ19uIZ14o/TO3orBt7KBZKXSSr9o4
         ILMkmBADWGfuuqC56MFyXL/r7poT7EPXc1uL9XigvCazGfgHczanfZnspZet3HGp78iH
         /WSHG9ec4B56sDZ/W5tCNTAIar/82/lvb+oCvVQkmbyFIr5N3a5okH2z+BKTqieQLHxK
         6U5n1XP8zu4r4mxfWKmBtWOyha3GQw5nZBXntiwl0q/TXSr8+wNaNXsohop/+A7y1tO/
         Q24NJpckrN5Td8yjGDSVvHk3Ar+ntXwxMtwy+IwzsVtMC24NGL5TnZErOq/S4RNVyWfy
         Ud+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nMRiKhF7YdCgOeER5/NiAuJBBtviujq5B9oy3dlX03I=;
        b=Bbs5RjmEILiXVMjO1EDwIN5eE8n6PlrYyQAID5iB39jNL9CcRNL5fLZ7fH7Ws33vyD
         xJDtQOnBgZoJ6pyVxmbaJrB+kt/hfZB7548rJ0/3rh3I2msEXykjHSduoYQJCeLzKECS
         L82p/x1179Z3Vj7uVMwMfJ6u1ezhSgHmmKVT6AfSC/RCJ/nzxyQWT4+D3BBQXmWio69L
         159cFZdbFRcyHnDVBIszuGL4x5JlTMrBiUkQFRSU/MyTW3gsMPYP2GWaFo7+cWvsO4Yu
         YdmdRVU4VFM7YSAifAelhKZA24q1CtwMQxJW7Ey/gL9fqvFfg3X28gqwYSozoPhKsfb6
         36Vg==
X-Gm-Message-State: AOAM530NqRQAWZFb+ZkI8+dlgQcXXtSQCxvgNmla52GAAnJ8augbd3vI
        yAIt2EwAxz325ButIxuv4aSC0Q==
X-Google-Smtp-Source: ABdhPJxO2JfQyC3D7WqY8EhxrgYNhSNeNcJjRb8nFwiSv4sh1GmXoJNTFTX8W9c5KCuomd1Yom6Qeg==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr8950132wru.159.1612436741988;
        Thu, 04 Feb 2021 03:05:41 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id c62sm5811380wmd.43.2021.02.04.03.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:05:41 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:05:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210204110539.GE2789116@dell>
References: <20210123121313.79530-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210123121313.79530-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jan 2021, Hans de Goede wrote:

> Hi all,
> 
> Here is v4 of my series to rework the arizona codec jack-detect support
> to use the snd_soc_jack helpers instead of direct extcon reporting.
> 
> This is done by reworking the extcon driver into an arizona-jackdet
> library and then modifying the codec drivers to use that directly,
> replacing the old separate extcon child-devices and extcon-driver.
> 
> This brings the arizona-codec jack-detect handling inline with how
> all other ASoC codec driver do this. This was developed and tested on
> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> 
> There are various interdependencies between the patches in this
> series, so IMHO it would be best if this entire series would be merged
> through the MFD tree.
> 
> Note this series applies on top of my "[PATCH v4 0/5] MFD/ASoC: Add
> support for Intel Bay Trail boards with WM5102 codec" series.
> 
> Changes in v4:
> - Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
>   MAINTAINERS section
> - Small codying style tweaks to the "ASoC: arizona-jack: Cleanup logging" patch
> 
> Changes in v3:
> - Move the bugfix patches to earlier in the series so that they
>   apply to drivers/extcon/extcon-arizona.c so that they can be
>   cherry-picked into the stable series
> - Split runtime_pm_get -> runtime_pm_get_sync changes out into their
>   own patch
> - Simply move drivers/extcon/extcon-arizona.c to
>   sound/soc/codecs/arizona-jack.c instead of first adding arizona-jack.c
>   as a copy and then later removing extcon-arizona.c
> - Some other small tweaks, see individual patch changelogs
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (13):
>   mfd: arizona: Drop arizona-extcon cells
>   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
>     has been unplugged
>   extcon: arizona: Fix various races on driver unbind
>   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
>     call
>   extcon: arizona: Always use pm_runtime_get_sync() when we need the
>     device to be awake
>   ASoC/extcon: arizona: Move arizona jack code to
>     sound/soc/codecs/arizona-jack.c
>   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
>   ASoC: arizona-jack: Use arizona->dev for runtime-pm
>   ASoC: arizona-jack: convert into a helper library for codec drivers
>   ASoC: arizona-jack: Use snd_soc_jack to report jack events
>   ASoC: arizona-jack: Cleanup logging
>   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
>     the new jack library

>   ASoC: Intel: bytcr_wm5102: Add jack detect support

Can't apply this patch ...

>  MAINTAINERS                                   |   3 +-
>  drivers/extcon/Kconfig                        |   8 -
>  drivers/extcon/Makefile                       |   1 -
>  drivers/mfd/arizona-core.c                    |  20 -
>  sound/soc/codecs/Makefile                     |   2 +-
>  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
>  sound/soc/codecs/arizona.h                    |  44 ++
>  sound/soc/codecs/wm5102.c                     |  12 +-
>  sound/soc/codecs/wm5110.c                     |  12 +-
>  sound/soc/codecs/wm8997.c                     |  14 +-
>  sound/soc/codecs/wm8998.c                     |   9 +
>  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-

... since this file doesn't exist?

>  12 files changed, 325 insertions(+), 405 deletions(-)
>  rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (76%)
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

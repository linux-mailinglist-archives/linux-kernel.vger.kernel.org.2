Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7E30F1D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhBDLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhBDLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:14:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D8CC0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:13:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b3so3026905wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hDqkZ034GsWBNXf5wCFh1fktNzwoeRLyXm2KKed+4t4=;
        b=mBZTKoHYlY2De5z/mqTT2QRil7LYGw3eCThaEcw+X0pMRocirE4uHgdj2yOv74ZDDM
         zyMgrqbEFXKVuvGuUjZmLgIoNOFy1CYwJY82ZzV0f0cO4RwFmj7ovGKaXJammO5oUSVM
         9M+3q2B5Bxz12ilMlxblEMHSfKP0xKl0eRoWTxnOd3VgY7++Lpise1AfZzqp3+HpPCzM
         //hQSb/Su5sI0RvlWD/c3GdYiRZQQVcmsdmYKbNOabxSDMSly4t0l90zmV8hsYoy16OZ
         oB+h4SfR+Pp95D3/9ozzdhkQu1Nl/iMu9ZoejdS75nURuCA7zVOu0Zuiy3BWJUl+GD9W
         yPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hDqkZ034GsWBNXf5wCFh1fktNzwoeRLyXm2KKed+4t4=;
        b=JPAtOWEShrye8+J00YewO3+QqtR5/ptrdXjjRBA1cgn4N3ohe6Pf5qrToCS1s7R7pu
         bsaASMu6ZMiYMqWmCv3+xVMvKQ+VxPmCDaAyk0STMXejB5cdEua2mMgd5H/zzwqCERFP
         rOdbfeadKVAdiCHNmqpZvw4A0qRjdcZ+YsnLsU1RGRJPiv++HX/IaygQiwDkfWC2oEGd
         nyrIE7HfzZdrrn49rpQCaCJy4JXsGvAuWgsp3ZQI8vmy09tkkz/2eVM9nKFzdawVGYr6
         umifDEG+dGEGV4851MY90d+LrS19Ng80J4V0q0oeDBVk3JbwAdTsYQEm8nP7jYwTWDTo
         DVGQ==
X-Gm-Message-State: AOAM531lFi/SgKIvGyFQuyjEooaOhNOeyleAtJvCqJXYhmhBw6wZPHRY
        V3r65dV0LKc9F+e6i7TfEG7BZQ==
X-Google-Smtp-Source: ABdhPJwBys/RVOGfm9bB2CtIW7htZKhreS+jn/9NWZuUmHKQ3dZHFqkcCAkwCP6avn8JNKjHF0kd9Q==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr8672064wra.370.1612437222674;
        Thu, 04 Feb 2021 03:13:42 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id q6sm7056367wrw.43.2021.02.04.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:13:42 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:13:40 +0000
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
Message-ID: <20210204111340.GF2789116@dell>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210204110539.GE2789116@dell>
 <3c996ea7-57dc-11ba-adc1-15fb7b97f107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c996ea7-57dc-11ba-adc1-15fb7b97f107@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Hans de Goede wrote:

> Hi,
> 
> On 2/4/21 12:05 PM, Lee Jones wrote:
> > On Sat, 23 Jan 2021, Hans de Goede wrote:
> > 
> >> Hi all,
> >>
> >> Here is v4 of my series to rework the arizona codec jack-detect support
> >> to use the snd_soc_jack helpers instead of direct extcon reporting.
> >>
> >> This is done by reworking the extcon driver into an arizona-jackdet
> >> library and then modifying the codec drivers to use that directly,
> >> replacing the old separate extcon child-devices and extcon-driver.
> >>
> >> This brings the arizona-codec jack-detect handling inline with how
> >> all other ASoC codec driver do this. This was developed and tested on
> >> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> >>
> >> There are various interdependencies between the patches in this
> >> series, so IMHO it would be best if this entire series would be merged
> >> through the MFD tree.
> >>
> >> Note this series applies on top of my "[PATCH v4 0/5] MFD/ASoC: Add
> >> support for Intel Bay Trail boards with WM5102 codec" series.
> >>
> >> Changes in v4:
> >> - Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
> >>   MAINTAINERS section
> >> - Small codying style tweaks to the "ASoC: arizona-jack: Cleanup logging" patch
> >>
> >> Changes in v3:
> >> - Move the bugfix patches to earlier in the series so that they
> >>   apply to drivers/extcon/extcon-arizona.c so that they can be
> >>   cherry-picked into the stable series
> >> - Split runtime_pm_get -> runtime_pm_get_sync changes out into their
> >>   own patch
> >> - Simply move drivers/extcon/extcon-arizona.c to
> >>   sound/soc/codecs/arizona-jack.c instead of first adding arizona-jack.c
> >>   as a copy and then later removing extcon-arizona.c
> >> - Some other small tweaks, see individual patch changelogs
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Hans de Goede (13):
> >>   mfd: arizona: Drop arizona-extcon cells
> >>   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
> >>     has been unplugged
> >>   extcon: arizona: Fix various races on driver unbind
> >>   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
> >>     call
> >>   extcon: arizona: Always use pm_runtime_get_sync() when we need the
> >>     device to be awake
> >>   ASoC/extcon: arizona: Move arizona jack code to
> >>     sound/soc/codecs/arizona-jack.c
> >>   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
> >>   ASoC: arizona-jack: Use arizona->dev for runtime-pm
> >>   ASoC: arizona-jack: convert into a helper library for codec drivers
> >>   ASoC: arizona-jack: Use snd_soc_jack to report jack events
> >>   ASoC: arizona-jack: Cleanup logging
> >>   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
> >>     the new jack library
> > 
> >>   ASoC: Intel: bytcr_wm5102: Add jack detect support
> > 
> > Can't apply this patch ...
> > 
> >>  MAINTAINERS                                   |   3 +-
> >>  drivers/extcon/Kconfig                        |   8 -
> >>  drivers/extcon/Makefile                       |   1 -
> >>  drivers/mfd/arizona-core.c                    |  20 -
> >>  sound/soc/codecs/Makefile                     |   2 +-
> >>  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
> >>  sound/soc/codecs/arizona.h                    |  44 ++
> >>  sound/soc/codecs/wm5102.c                     |  12 +-
> >>  sound/soc/codecs/wm5110.c                     |  12 +-
> >>  sound/soc/codecs/wm8997.c                     |  14 +-
> >>  sound/soc/codecs/wm8998.c                     |   9 +
> >>  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
> > 
> > ... since this file doesn't exist?
> 
> As mentioned this is a follow-up series on top of the:
> 
> "[PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec"
> 
> Series, that series adds that file.

Okay, that makes sense.  Thanks.

> Regards,
> 
> Hans
> 
> p.s.
> 
> Do you want a resend of this one, with the new *-bys added too ?

Only this one please.

I'll try to take the other one through now.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CDF30FCF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhBDTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbhBDN6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:58:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC16C061355
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:56:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a16so6001051wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PIhCp8il47YAvxqad9wdbokygqezWUysVvDAkwwnuTQ=;
        b=i5tL/xmNo+KoC4L+J++aT8o9sf0W4gpJ5zTnyIyHO8lfutg+zYLMGr72A2HPstt5ki
         DvBUkuAa0qhUwXb30x6BNaI06P1ROgBYC3Xzp6ovgfbZbqKQGVQHuMz5BkDDRHR7XE/u
         P7YFaJoeJ1OFtsLOZ8U5JgvO3zgSHfxNggH3cD7cuu2gaUBMmbQY/DXZK5x0r9cpX5Od
         i5sFKtVA7sm+QXyr711m6l0lEt4yiaFWzArLzqx4zsy14fu/R1fjwdqQVehbMnjI/3vJ
         RbsqDCJdDmMGGtQ+0pkPkJeL5Z9QYIwyUfzOoTiiBLrxaeeloIJ6meDfX36ZuFhzhp+/
         L3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PIhCp8il47YAvxqad9wdbokygqezWUysVvDAkwwnuTQ=;
        b=kXqBj/IEXMrQPDQJSJLMKDFHsbPUN45REPY8X3NGP9IM6UbN/bpF5mFpucKytT0rzv
         9AyvNrL7JOuIDf/6K73tZ5xnwV+l72/V4Mt/ixhaEyZA6/QUMmwbzHiVUphp3AJwqncQ
         QWZygVMFfvJbhReWj33YRsaf3pna8UsD5+WDFCeFwtZU2SOVMWmoDpFARpfnWQMkfm3S
         F3n7SvCAKIhju6A8/zPwxYrrBBl0yygwHsVrd1XyrCoB7NeoJI0oa+u3++sEsyI96kCM
         8ksnx0saYI+0gfju4ccTBUWGsiFA1mgTVLpu+EXUTObUaJ5pvjDy8nzE5ih1/foIDVow
         GA2w==
X-Gm-Message-State: AOAM5317eRBJKH21aS9tkCPG4KpsHTZNFIukdZfmmmBNJN5EH4BnbBLw
        lnZUY4edFvLcWzEwQ8ndFrRHbA==
X-Google-Smtp-Source: ABdhPJzxt85Icg/KGkiKBlSAEikhPnZG1noHL4jUI+b++S85sT5D34hbYN70ykTecBBOWTCPRwpAgA==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr7686696wmc.168.1612446990254;
        Thu, 04 Feb 2021 05:56:30 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id r13sm6788058wmh.9.2021.02.04.05.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:56:29 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:56:27 +0000
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
Subject: Re: [PATCH v4 5/5] ASoC: Intel: bytcr_wm5102: Add machine driver for
 BYT/WM5102
Message-ID: <20210204135627.GM2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-6-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Hans de Goede wrote:

> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add a new ASoc Machine driver for Intel Baytrail platforms with a
> Wolfson Microelectronics WM5102 codec.
> 
> This is based on a past contributions [1] from Paulo Sergio Travaglia
> <pstglia@gmail.com> based on the Levono kernel [2] combined with
> insights in things like the speaker GPIO from the android-x86 android
> port for the Lenovo Yoga Tablet 2 1051F/L [3].
> 
> [1] https://patchwork.kernel.org/project/alsa-devel/patch/593313f5.3636c80a.50e05.47e9@mx.google.com/
> [2] https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
> [3] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
> 
> The original machine driver from the Android ports was a crude modified
> copy of bytcr_rt5640.c adjusted to work with the WM5102 codec.
> This version has been extensively reworked to:
> 
> 1. Remove all rt5640 related quirk handling. to the best of my knowledge
> this setup is only used on the Lenovo Yoga Tablet 2 series (8, 10 and 13
> inch models) which all use the same setup. So there is no need to deal
> with all the variations with which we need to deal on rt5640 boards.
> 
> 2. Rework clock handling, properly turn off the FLL and the platform-clock
> when they are no longer necessary and don't reconfigure the FLL
> unnecessarily when it is already running. This fixes a number of:
> "Timed out waiting for lock" warnings being logged.
> 
> 3. Add the GPIO controlled Speaker-VDD regulator as a DAPM_SUPPLY
> 
> This only adds the machine driver and ACPI hooks, the BYT-CR detection
> quirk which these devices need will be added in a separate patch.
> 
> BugLink: https://github.com/thesofproject/linux/issues/2485
> Co-authored-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Drop unnecessary configuring of OPCLK
> - Fix error-msg when setting the SYSCLK fails
> ---
>  sound/soc/intel/boards/Kconfig                |  12 +
>  sound/soc/intel/boards/Makefile               |   2 +
>  sound/soc/intel/boards/bytcr_wm5102.c         | 465 ++++++++++++++++++
>  .../intel/common/soc-acpi-intel-byt-match.c   |  16 +
>  4 files changed, 495 insertions(+)
>  create mode 100644 sound/soc/intel/boards/bytcr_wm5102.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

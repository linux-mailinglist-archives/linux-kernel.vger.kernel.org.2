Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1734478D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCVOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhCVOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:40:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:40:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bf3so19673036edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sd3NAlYTlcvi/QMV36ICDUYrz39AstS3COa8JsP44Ys=;
        b=Q5Te0kn+z1zC6N0q+DE5A78qVYm7TD6CMBW5JAjg+LhA4c7rmhfA2DomZwU9wY6Zhf
         hZQUtNWBtKyCmPvnpGM8zalZ/pZKqI5zrsdrswbBcvK3NxiZ6ZWcim7FW4nTlAiA9eF8
         Qc2S7z/q8vwTuRaYhTmOWKDoZy72+UQLFG8jylpYBReD25rKjZgbD9cbhjqN8mFXmTII
         ErO+fbwToXW/WzWd9hhL4FddqZeL5hLyfqUxBP7SUXKpkXk2VfIsNVZ+2FAeU8kLh7x4
         zaSWxxY6b9UrNaYOsu+E5hla26QyqusiXGmmby6Vca39nMfYdDynuYTrC13bzqLienUx
         gZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sd3NAlYTlcvi/QMV36ICDUYrz39AstS3COa8JsP44Ys=;
        b=OwKUv0feTNVBGIQerhouXU46IrzjmVY1vLvHcsJyitP1vQguV//yXUrLQOMFFQ8ohl
         Gsq03mxIy44YKM0Lgn6FmUVC5MMJ1hZN56fV3B86E0k7RY6IgZxf0keJRwPoZSsaV5SY
         u5blV/sA6bWUo4lnKEbDD/GKsr4c0xrOViVoSf9/fDsjmAAFY4q7j9FnZQh+OoXe2013
         rW5euMEpQRqrhUV70pMG0W17W2px6KSAL7yyK7aB+1ScruoFB06rtKyj+Uu4ufAgGxMY
         IIX08hrlj1SrhaSPGDy833ee4Sj45BTNR3+ttg1Zcsd0r4qiLctiNma3yOwZKUkGB/ZL
         Cecg==
X-Gm-Message-State: AOAM532g+iIPv1IOJZcOSEqrIbo8htN4h+KpuwTo67BR31L0leeDwE1x
        8XIC+T2r5gP0Ot9z+tUI+fIReRHQwZHhpQ==
X-Google-Smtp-Source: ABdhPJwIe7HYLh7N874sWXI9W6QN+hPz5NDVkJ/oRhJ20gHSdJ3H+XYwlDc7Cp7XcgYCPoF2KQimkw==
X-Received: by 2002:a05:6402:3495:: with SMTP id v21mr25875834edc.117.1616424027789;
        Mon, 22 Mar 2021 07:40:27 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id i11sm9778388ejc.101.2021.03.22.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:40:27 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:40:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: [GIT PULL] Immutable branch between MFD and Extcon due for the v5.13
 merge window
Message-ID: <20210322144025.GW2916463@dell>
References: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-extcon-v5.13

for you to fetch changes up to a908a716696eee75bf85199cde2b0989290536d1:

  ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c (2021-03-18 11:46:15 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Extcon due for the v5.13 merge window

----------------------------------------------------------------
Hans de Goede (6):
      mfd: arizona: Drop arizona-extcon cells
      extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
      extcon: arizona: Fix various races on driver unbind
      extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
      extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
      ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c

 MAINTAINERS                                        |  3 +-
 drivers/extcon/Kconfig                             |  8 ---
 drivers/extcon/Makefile                            |  1 -
 drivers/mfd/arizona-core.c                         | 20 -------
 .../soc/codecs/arizona-jack.c                      | 63 +++++++++++-----------
 5 files changed, 34 insertions(+), 61 deletions(-)
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (98%)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

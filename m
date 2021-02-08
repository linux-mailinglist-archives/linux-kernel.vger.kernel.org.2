Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883923133FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBHNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBHNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:53:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5DBC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:52:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b3so17212165wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VZVNgaBy9WtB+TiTDDQzLw294M2wGl6oNkLfrcLYn+U=;
        b=t80HXBbS3FExg9kMVN1gaqsa3JSwVXK2vC4CE1rrKREfSvvGrKQLmimOVbwOEOQODf
         Oj9A3gdqo2FqesefGE8/Bt9Oo12qD7VdCUI41sEcrnmkySfGnPUexKOnOUjO6Dc4nhU0
         26UDVl2b4XPZeHGzneLHX7r1Z68n/VTbRG6F4REpyFcmSMp5zZQs1+DAEOexQ9HLYk/J
         smQJZwb9YWzAhn8gvqmIs2Z9BDejcNdx/NxYQT8UmDQmai/VT54ZG0JWFAekXKB6WRkD
         qo/pCY1NSckjJH1v34yUjSZEwLQDrpe2Iv1CWMY6UtHdlFa5jppcVeNxqmcDOLq1rSoh
         NlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VZVNgaBy9WtB+TiTDDQzLw294M2wGl6oNkLfrcLYn+U=;
        b=pfE+ootg4uEpRlh+cOz6wycBiRWYVealX5LZlF20etl1/EM0HSgm6d6iVIykDqqV4S
         gau/QYjgZakrZkDRD0npmm9dv3cFU6nthcu6fyiQjGUvToAtJYI2DiyDnns+GZk+vPG1
         1y+Hp/M6IiDtWJ0MSNBYejRQYiCqHme87ZqLu0f0voN6tH1TYRDAy3Jr9itmYK9mqJTr
         BDz9SofcSqgvo1cQSHJKeFj6j/tM0lKn+S8T1WFNYlEs6vQWUb+0MY51j2FrF7ur+ySk
         Rn6LT+erv2vHCwEmVzDT7ym0Poko1Uxn9wJIBJUHMq3TTBusHQMD7qq9FTsj7YEDbgni
         6bkg==
X-Gm-Message-State: AOAM533/Puzw+vAw79NNtJKIgf7btoSPq+nzlvH1zk2NoaYy9FfsyDqa
        LXvR2xdbs7Y87gCx6M502NTQwg==
X-Google-Smtp-Source: ABdhPJxMZNh+0b1mhkBj7q1g5N/YxnMoEcn9o5I0XhZ7jiPHGIfC7whGXdFvq2wAcb6U1vDCAg4Dow==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr19972073wrb.205.1612792336192;
        Mon, 08 Feb 2021 05:52:16 -0800 (PST)
Received: from dell ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m205sm21161165wmf.40.2021.02.08.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:52:15 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:52:13 +0000
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
Subject: [GIT PULL] Immutable branch from MFD due for the v5.12 merge window
Message-ID: <20210208135213.GB4766@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-asoc-v5.12

for you to fetch changes up to e933836744a2606e6cd42a6a83e5e43da2a60788:

  mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI (2021-02-04 13:55:34 +0000)

----------------------------------------------------------------
Immutable branch between MFD and [XXX] due for the v5.12 merge window

----------------------------------------------------------------
Hans de Goede (3):
      mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
      mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
      mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI

 drivers/mfd/arizona-core.c |  11 ----
 drivers/mfd/arizona-i2c.c  |  11 ++--
 drivers/mfd/arizona-spi.c  | 138 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mfd/arizona.h      |   9 ---
 4 files changed, 141 insertions(+), 28 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

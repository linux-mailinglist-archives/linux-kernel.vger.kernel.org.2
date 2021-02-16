Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A31CE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBPQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBPQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:47:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:46:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m1so15110712wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Fm2TNkLR0VgYR30/rEScedus3Vu7ifcg4n3suQc9Z+M=;
        b=v5HuNWpXB6+K5ogbC40CrbNJZeL2khKZk9UL8woMmYxlxYo/MuKtfOZN+XyrcAAkkL
         00LXOH3dcqA0WQTmogyRBAcRL3/a/1iaIjDMvXxug9NHWsyM5Qoo8YjMsQg84SlX+H7w
         1Mt4t0V7qYcEBwHI9Pilc7AfnoERnevdFMGxF7/ZcPLunUrA3EfiNohvQvSEcyXj3ivm
         6tA8gRfOloh0GrWyVPRchQD5wkki2xMGE8OgOMQ7FHjISjDgZaUYrgkgb2Eom2TQiKs9
         d4pbOe01ZYH68CERZWZej0cLugxMGqf/hhgw2JXG7b4VwsL/a8diuBxhRH+ikJxtRjkg
         O4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Fm2TNkLR0VgYR30/rEScedus3Vu7ifcg4n3suQc9Z+M=;
        b=bZvMhD+SjYHIdFd877i3qj6EEZ8xP4RDQffEV6QF5IOzXwepOmIKLRgr8Ovc7maCU2
         iiyc0KaW6IoE4zqiGK0b6xONMQLOMuOgM9F6FPN3GndKoBuFuq/ji6fH0h64SeHr3juU
         y74y9xba6SI9NuLrYaTwj5FV98Zk4qZsBAtwX8QbgLi8M26T8gBR5QjQfwxgPcQrSK+m
         8Lym9ZNwci/xhgS0W2g46P6lYrYowRT4ifa7EevBSBB3jzgmHRkRpmPcj3AwBbz89Cgt
         BwuDh8H/kSBJw86jId4kAeL8dxZPI4AItFDLIRoxaPMWtsS/V2ITcvWu+AERbGaG95wU
         Y0XQ==
X-Gm-Message-State: AOAM531xlZNCcauYcf7K891LBVarHknaaq6t6+ZlRnrsEZbA7SayregU
        pi8IfWICrbHMNjF5F7oQZEmGxn2ebfm10w==
X-Google-Smtp-Source: ABdhPJz6+GYnbU9ZVH6X9MRKzwp6qGq885s4vxn907M2RAL7beSZTwW4quO2V03NRU6Lwk0JMb1/7A==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr3937182wmy.104.1613494007120;
        Tue, 16 Feb 2021 08:46:47 -0800 (PST)
Received: from dell ([91.110.221.165])
        by smtp.gmail.com with ESMTPSA id v1sm4275835wmj.31.2021.02.16.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:46:46 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:46:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.12
Message-ID: <20210216164645.GC4803@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.12

for you to fetch changes up to 0b5e0f45af403cb6e9df574e1cb52691611dc0b8:

  backlight/video: Use Platform getter/setter functions (2021-02-12 10:01:45 +0000)

----------------------------------------------------------------
 - New Functionality
   - Convert to GPIO descriptors

 - Fix-ups
   - Trivial: Fix coding style: sky81452-backlight
   - Ensure backlight state is known on bring-up; ktd253-backlight
   - Use common Platform API; qcom-wled, fbdev

----------------------------------------------------------------
Julia Lawall (1):
      backlight/video: Use Platform getter/setter functions

Linus Walleij (2):
      backlight: lms283gf05: Convert to GPIO descriptors
      backlight: ktd253: Bring up in a known state

Zheng Yongjun (1):
      backlight: sky81452-backlight: Convert comma to semicolon

 arch/arm/mach-pxa/z2.c                             | 12 ++++--
 drivers/video/backlight/ktd253-backlight.c         | 12 ++----
 drivers/video/backlight/lms283gf05.c               | 43 +++++++++-------------
 drivers/video/backlight/qcom-wled.c                |  2 +-
 drivers/video/backlight/sky81452-backlight.c       |  2 +-
 drivers/video/fbdev/amifb.c                        |  4 +-
 drivers/video/fbdev/da8xx-fb.c                     |  4 +-
 drivers/video/fbdev/imxfb.c                        |  2 +-
 .../omapfb/displays/panel-lgphilips-lb035q02.c     |  6 +--
 drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |  4 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |  4 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |  2 +-
 drivers/video/fbdev/xilinxfb.c                     |  2 +-
 include/linux/spi/lms283gf05.h                     | 16 --------
 15 files changed, 45 insertions(+), 72 deletions(-)
 delete mode 100644 include/linux/spi/lms283gf05.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

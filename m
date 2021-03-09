Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E91332A97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCIPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhCIPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:34:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FAC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:34:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so3900494wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzsw0t26e6RgC3Z//6/tf4qdzaRYRX8gCuMeUSGPexc=;
        b=f0NjAAtkPD27dyFd/dyrvExuFHkunfaEkLs8LRY9YGOYfqqatBqUwXjgNrK9axhn6z
         xwa0YP0K4IQqL/n4oYpJGZ8OnVfcF76CMDiURPJMtndV74YtZle2dLALxDY0LsKx/Llj
         tsG3Buj/Ibdw4qpCNxy1lcl8A1cB5I5UVm9lG/+9jZKExzOMnHGag3o0iwOZj/4euEcn
         4+2Mnng0HiniwIsGSGElcJw7npmS7nEB+6zhL5nRKvCE6y7Ty46rdOgJhidmWyIqWIl/
         YQ5KCwL/y7OzMiM5Q6Nfj2veWAQU4o8+uIIpziIUObNq3PBRDGy6khLDHc7FfUSXeKPT
         Hz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzsw0t26e6RgC3Z//6/tf4qdzaRYRX8gCuMeUSGPexc=;
        b=lKvhw1/pxAM+OtY1C7AU4VgMzo8oIlxyGbVbNe7+hS5UxcPWDnu6varO2zsJ0Aj0Wq
         BMWwxyrAYUNmbpuWnpV/4pd5kyjmcUsUNl1ICeEKfAPr3TdM8msTJhktASO8+wbYb2eF
         zgH9T4lSmEzbb2DL8Waw37lVFu04CU0z8d3hRh8KSB023CKekTAseJMoPclQkXmmcE27
         c5Y/djhpIOkDg0c6mDDzkbhXuOWkp81EgdWxOZOaHXu/b+Aipo2Di779DphpsUpviYFg
         ZETWmbdhncM6r+EDRbnD3pJ/Pcw/0xRRvMv4MCtcxWKxZCGhnH1GdYJeWgCm6IPv8m01
         jArg==
X-Gm-Message-State: AOAM5325cvu1DOvT7w4sXzU4ofCqPrYin3n64CNFlD8pFJOxc8pRIZ4Q
        8oLtXs69JUEMkO8qFdKqKjj7okTuhrexWw==
X-Google-Smtp-Source: ABdhPJyvtARdrMCqNLvCKFczKedLboQLlk3AyeGPSQfdcBppgkMEvuwgsGJiyeyCfpeqWSD6PWSoRg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr4651344wmi.132.1615304095057;
        Tue, 09 Mar 2021 07:34:55 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b15sm4915530wmd.41.2021.03.09.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:34:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.12-rc3
Date:   Tue,  9 Mar 2021 16:34:43 +0100
Message-Id: <20210309153443.16647-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here's a bunch of fixes for the GPIO subsystem. We have two regressions in the
core code spotted right after the merge window, a series of fixes for ACPI GPIO
and a subsequent fix for a related regression in gpio-pca953x + a minor tweak
in .gitignore and a rework of handling of the gpio-line-names to remedy a
regression in stm32mp151.

Please pull!

Best Regards,
Bartosz Golaszewski

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.12-rc3

for you to fetch changes up to b41ba2ec54a70908067034f139aa23d0dd2985ce:

  gpiolib: Read "gpio-line-names" from a firmware node (2021-03-08 11:59:17 +0100)

----------------------------------------------------------------
gpio fixes for v5.12-rc3

- fix two regressions in core GPIO subsystem code: one NULL-pointer dereference
  and one list corruption
- read GPIO line names from fwnode instead of using the generic device
  properties to fix a regression on stm32mp151
- fixes to ACPI GPIO and gpio-pca953x to handle a regression in IRQ handling
  on Intel Galileo
- update .gitignore in GPIO selftests

----------------------------------------------------------------
Andy Shevchenko (4):
      gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
      gpiolib: acpi: Allow to find GpioInt() resource by name and index
      gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2
      gpiolib: Read "gpio-line-names" from a firmware node

Bartosz Golaszewski (1):
      selftests: gpio: update .gitignore

Johan Hovold (2):
      gpio: fix NULL-deref-on-deregistration regression
      gpio: fix gpio-device list corruption

Yang Li (1):
      gpiolib: acpi: Add missing IRQF_ONESHOT

 drivers/gpio/gpio-pca953x.c             | 78 ++++++++++-----------------------
 drivers/gpio/gpiolib-acpi.c             | 21 ++++++---
 drivers/gpio/gpiolib.c                  | 19 ++++----
 include/linux/acpi.h                    | 10 ++++-
 include/linux/gpio/consumer.h           |  2 +
 tools/testing/selftests/gpio/.gitignore |  2 +-
 6 files changed, 58 insertions(+), 74 deletions(-)

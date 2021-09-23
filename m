Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88D415A05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhIWI2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbhIWI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:28:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:26:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d6so14667465wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIHH2K/oKfCd+IwalkmMlifZv1RtkTKjfSBzx6j1QOY=;
        b=2wHT0olraHGog1MKCEg5DWw3cZZNADM7tPhcZVuFe6q70qeR/MFTtfh0z77Ej8CpPl
         HdYi1ZEvx5p31lOla71O37oyP4qSCIKmTN/gLmKIzkQYHAzKjPWDKU5UOHkoJ6TgT/W8
         1l5D2hTFUVsUnS3iJTeuTIDlXwFG7aPzrkyEsbBthueRoazX813aaWNO/+iZjR9+7Q4Q
         2wx0TKi6+3ndpdtayNPFv1nmk3Rbbwlxc/1XvO7mJfj8ZFwWgLj6+AzKbCqfMynVghhI
         R2/f/wNAOmaorgG9jl1J727m92C8H2YaVZ0MS/5mgBhe3gzkDcH+Ge2z6+PeUj2O8mCI
         wVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIHH2K/oKfCd+IwalkmMlifZv1RtkTKjfSBzx6j1QOY=;
        b=e4fCkJIyiK2eeZ/6q4NbABYQY37aHrn25XyI0teyJb+lN6kaYT78LKRX7Kr98iWryd
         ifkj2OazzwLNfguu3xuHa1StLCpF5SJSr0aE/g/+etDleucOepih62xrTb9odYubNlyJ
         7fuuc7QywvUP/BVZmtk0df9oZ5WD2vtE8ipk+ZMqcKyCDNTRsc89O5Ld7GthWgDnV6SP
         XDgZpQFLYOhMveAV5FiXP3TAc2u7M/PvRJTgDPfV70r5+gUTzLx8eSfVLszEegZqxb+F
         r8JWDP4lVKUzWcGWf7V/t52XbROmDIZdyqCh3gAUDo6PpBmKeiee2n5Snxdof/e1yfVs
         UIvQ==
X-Gm-Message-State: AOAM533KSoauGWPYBs8noy/3GlKwlD7Vhip2aHktWE0m20ctot9yNb5M
        7rw9pzfuOsVyv8CbfTGTUxxCbg==
X-Google-Smtp-Source: ABdhPJxj9m6aXmYPAeTiQhOlUCXV4r8Pd0w3SL6FmjjOPzBEpvrrMLrkOIDcttr52mZg5r/Xyv6reA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr14647307wmc.105.1632385604420;
        Thu, 23 Sep 2021 01:26:44 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id c15sm4941524wrc.83.2021.09.23.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 01:26:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.15-rc3
Date:   Thu, 23 Sep 2021 10:26:41 +0200
Message-Id: <20210923082641.32745-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following set of fixes for the GPIO subsystem. Details are in
the signed tag.

Best Regards,
Bartosz Golaszewski

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.15-rc3

for you to fetch changes up to b22a4705e2e60f342b1b851c9ebdb3ea02f21f8f:

  gpio/rockchip: fix get_direction value handling (2021-09-22 11:31:52 +0200)

----------------------------------------------------------------
gpio fixes for v5.15-rc3

- fix a regression in GPIO ACPI on HP ElitePad 1000 G2 where the
  gpio_set_debounce_timeout() now returns a fatal error if the specific
  debounce period is not supported by the driver instead of just emitting
  a warning
- fix return values of irq_mask/unmask() callbacks in gpio-uniphier
- fix hwirq calculation in gpio-aspeed-sgpio
- fix two issues in gpio-rockchip: only make the extended debounce support
  available for v2 and remove a redundant BIT() usage

----------------------------------------------------------------
Hans de Goede (1):
      gpiolib: acpi: Make set-debounce-timeout failures non fatal

Heiko Stuebner (2):
      gpio/rockchip: extended debounce support is only available on v2
      gpio/rockchip: fix get_direction value handling

Kunihiko Hayashi (1):
      gpio: uniphier: Fix void functions to remove return value

Steven Lee (1):
      gpio: gpio-aspeed-sgpio: Fix wrong hwirq in irq handler.

 drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
 drivers/gpio/gpio-rockchip.c     | 4 ++--
 drivers/gpio/gpio-uniphier.c     | 4 ++--
 drivers/gpio/gpiolib-acpi.c      | 6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

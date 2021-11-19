Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FA45716A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhKSPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhKSPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:10:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:07:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t30so18627022wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jqMl8Z0Hf/N/KXYecsVzaYCxNDJh+mMv+jjLKwsb28=;
        b=G55pasOzodUHvhH6LId0UJoQllxGkntw85VTDgTYUqbRnzcJFKgn+r55vywU5JB+rd
         XXvFZSw13rpwa/LxvsU4Z6UOSsOhZJMpT6yYX2ImRhIlWTr+RtxMETDaqKs6Oune/+SM
         Yzh9Ph84fQY8vCIC3nIzEJLvBz2hlJyNdasU8aQEyx76m5pubQhvZRL2q1ynjujo7nkq
         Oi3zai5zTT7WH6/oSLUxnsfnAGzhi14eK517QIO+T3xNvPXzerVgxeHVNrcu5EvjbxpN
         5ovi9K1QB1xmmdr2fhDIPoRVwqtGH5eeqhTgl8Uubg8R2odK8JAGpQAWEl+QVzIQ/j+E
         ACMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jqMl8Z0Hf/N/KXYecsVzaYCxNDJh+mMv+jjLKwsb28=;
        b=Q89pypUqCq0CKl7Or/4zZa4bwcwF/idWxX5Vrb5ASdD3ZwppFgVJpKDyk7GEaMT/LU
         dVCmA75l8Enp0ZCLXRuVOQYEytfGzWcH5KZ1zSegOdIlHPA+1gSj/UTXh/ObkQ0NogMK
         qDLzJcMq6BG0KvuVOk4YNXKVaC11opDhAA+dtE05FWadEU/8BNhEvg8LgWTaznFiUFh6
         /TNVRnLVZtUkXGrfTFsn2mCjsJ+itXdt6eJyJc8u46+wqrKZe5Sb7hRQx1PNjvQ3+koW
         j5Nv30oGBZUiCt7QA51PzqZHHdGltfbnoKBWSdQSv8nttmZQmSzw9/Ovin92De3ft8sq
         8Mow==
X-Gm-Message-State: AOAM533oNDXdwaCoAfEE474RdPMsW11j73/vYR3PoSOlH3k0E72OpwDb
        9vOXz9TeAAXCNjox6THnHopyFA==
X-Google-Smtp-Source: ABdhPJzC2IgYKRKHsRJ1a9sTXbJ7zyfPtn4OHTdf9LMDllVeg2BuC3OTMx+v7hqp+bYdTJyT/ibTjg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr8013629wrt.88.1637334425922;
        Fri, 19 Nov 2021 07:07:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id r62sm3046160wmr.35.2021.11.19.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 07:07:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.16-rc2
Date:   Fri, 19 Nov 2021 16:07:03 +0100
Message-Id: <20211119150703.8326-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following set of fixes for the next RC.

Best Regards,
Bartosz Golaszewski

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.16-rc2

for you to fetch changes up to d6912b1251b47e6b04ea8c8881dfb35a6e7a3e29:

  gpio: rockchip: needs GENERIC_IRQ_CHIP to fix build errors (2021-11-16 09:41:44 +0100)

----------------------------------------------------------------
gpio fixes for v5.16-rc2

- fix a coccicheck warning in gpio-virtio
- fix gpio selftests build issues
- fix a Kconfig issue in gpio-rockchip

----------------------------------------------------------------
Kent Gibson (2):
      selftests: gpio: fix uninitialised variable warning
      selftests: gpio: restore CFLAGS options

Li Zhijian (1):
      selftests: gpio: fix gpio compiling error

Randy Dunlap (1):
      gpio: rockchip: needs GENERIC_IRQ_CHIP to fix build errors

Yang Li (1):
      gpio: virtio: remove unneeded semicolon

 drivers/gpio/Kconfig                            | 1 +
 drivers/gpio/gpio-virtio.c                      | 2 +-
 tools/testing/selftests/gpio/Makefile           | 1 +
 tools/testing/selftests/gpio/gpio-mockup-cdev.c | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

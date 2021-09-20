Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B72411649
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhITOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhITOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:07:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:06:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so28333682wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2SeWerZdXltMhfaTVsZCSNIABxYcOcCcm3hDyprnBE=;
        b=1ldbWaNh+BiIxk7g7i+HjTQHdfnb+yjLErf/mNF0xSPpwyEWsxApwjfXK1whheI0aK
         W1E6VsEy7KpgM/sC8ddOdVaOieimfT+tuvXejannAluyIu+k5UIo7QXxXtIFLJB3AYgd
         7dlchvc5oKEPm8u+t4d0MaZFYfm3zGIukoVOMa3sUezMu9xvKwEoAdM/COwhT8r6r+ts
         cCnTIJXYak+vmUQVeJO1PP0GMbAjk4e5/eNka5lJ0myV9HVfmzPXspwQfBxZ6cQrrLFh
         HdggW5bCI4M8MsnGGVT5wIoGkMLnw5icK4bKMZVliUJmryc3K1fwbkVlWg7mHCv92T9B
         9k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2SeWerZdXltMhfaTVsZCSNIABxYcOcCcm3hDyprnBE=;
        b=68U6YdibzPYFWZvrvukqcxGAyJKvhJTEsGznwQW9doasNj/TIbMY0XjOfeTX63xrH5
         DZfxoKiGykulVHBBCTpQuGhy/jV7M/L7k7rCbfI34uMoKjWzvSbgi+LbxNrsU2oLgmBn
         DcdMOvYAkmAY0rT2IZWgwvYqQSDDKSR4g4789RhSr6B3xe7SbafzE2QsGfsr+eypXZKw
         YEfxiSGS985peH01kgudd5+RXh84Hon/boUvIE8p1sjO6X2UYwqKtraI7u8FT0d36aH1
         Jmt0oBB4LmzPfOxXR3oPKJcpJ/M3ywYqXrtti326IjCvOccPFTLYIugT9JAy7hwTf/S5
         LCdQ==
X-Gm-Message-State: AOAM533hjz4RDi0hfpVca0J0VBzI7USXGrsEHSLjPn/NT/p98BO5P8r7
        zVtHpO4RWZ7+peak7duDTKL1oQ==
X-Google-Smtp-Source: ABdhPJysPjXLxur6W7ycDbArcws+8iD5fvL6oIa1hfq5qrNaDU5lf7XiK0rX9RvmFEC8KWRhn2vEkw==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr29328254wme.104.1632146777179;
        Mon, 20 Sep 2021 07:06:17 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id h18sm15801461wrb.33.2021.09.20.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:06:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jack Winch <sunt.un.morcov@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/8] gpio: implement the configfs testing module
Date:   Mon, 20 Sep 2021 16:05:01 +0200
Message-Id: <20210920140509.5177-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'm respinning this series now because I noticed that I need to start writing
tests for my work on the new libgpiod v2 code to make sense (it's just becoming
too complicated to make even remotely functional without test coverage). At the
same time I don't want to rewrite the tests using gpio-mockup if the goal is to
replace it with gpio-sim anyway.

I fixed issues pointed out by Al Viro and made sure that references are
correctly counted (including error paths) and that memory allocated for the
pending and live groups gets freed.

===

This series adds a new GPIO testing module based on configfs committable items
and sysfs. The goal is to provide a testing driver that will be configurable
at runtime (won't need module reload) and easily extensible. The control over
the attributes is also much more fine-grained than in gpio-mockup.

This series also contains a respin of the patches I sent separately to the
configfs maintainers - these patches implement the concept of committable
items that was well defined for a long time but never actually completed.

Apart from the new driver itself, its selftests and the configfs patches, this
series contains some changes to the bitmap API - most importantly: it adds
devres managed variants of bitmap_alloc() and bitmap_zalloc().

v1 -> v2:
- add selftests for gpio-sim
- add helper programs for selftests
- update the configfs rename callback to work with the new API introduced in
  v5.11
- fix a missing quote in the documentation
- use !! whenever using bits operation that are required to return 0 or 1
- use provided bitmap API instead of reimplementing copy or fill operations
- fix a deadlock in gpio_sim_direction_output()
- add new read-only configfs attributes for mapping of configfs items to GPIO
  device names
- and address other minor issues pointed out in reviews of v1

v2 -> v3:
- use devm_bitmap_alloc() instead of the zalloc variant if we're initializing
  the bitmap with 1s
- drop the patch exporting device_is_bound()
- don't return -ENODEV from dev_nam and chip_name configfs attributes, return
  a string indicating that the device is not available yet ('n/a')
- fix indentation where it makes sense
- don't protect IDA functions which use their own locking and where it's not
  needed
- use kmemdup() instead of kzalloc() + memcpy()
- collected review tags
- minor coding style fixes

v3 -> v4:
- return 'none' instead of 'n/a' from dev_name and chip_name before the device
  is registered
- use sysfs_emit() instead of s*printf()
- drop GPIO_SIM_MAX_PROP as it's only used in an array's definition where it's
  fine to hardcode the value

v4 -> v5:
- drop lib patches that are already upstream
- use BIT() instead of (1UL << bit) for flags
- fix refcounting for the configfs_dirent in rename()
- drop d_move() from the rename() callback
- free memory allocated for the live and pending groups in configfs_d_iput()
  and not in detach_groups()
- make sure that if a group of some name is in the live directory, a new group
  with the same name cannot be created in the pending directory

Bartosz Golaszewski (8):
  configfs: increase the item name length
  configfs: use BIT() for internal flags
  configfs: implement committable items
  samples: configfs: add a committable group
  gpio: sim: new testing module
  selftests: gpio: provide a helper for reading chip info
  selftests: gpio: add a helper for reading GPIO line names
  selftests: gpio: add test cases for gpio-sim

 Documentation/admin-guide/gpio/gpio-sim.rst   |  72 ++
 Documentation/filesystems/configfs.rst        |   6 +-
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sim.c                       | 877 ++++++++++++++++++
 fs/configfs/configfs_internal.h               |  22 +-
 fs/configfs/dir.c                             | 277 +++++-
 include/linux/configfs.h                      |   3 +-
 samples/configfs/configfs_sample.c            | 153 +++
 tools/testing/selftests/gpio/.gitignore       |   2 +
 tools/testing/selftests/gpio/Makefile         |   4 +-
 tools/testing/selftests/gpio/config           |   1 +
 tools/testing/selftests/gpio/gpio-chip-info.c |  57 ++
 tools/testing/selftests/gpio/gpio-line-name.c |  55 ++
 tools/testing/selftests/gpio/gpio-sim.sh      | 229 +++++
 15 files changed, 1744 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.30.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8034327B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCUMdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCUMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0822F61944;
        Sun, 21 Mar 2021 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616329983;
        bh=9YX9ZY5fp0/7OuGATShnCJr/Yw72fmyNYA+7bQ4KpC0=;
        h=Date:From:To:Cc:Subject:From;
        b=LSrR760XL9Uj2sfDYHygaODUZdu//iK8fADofclD0fJMzfhjPLJIQhiXRht25wJ0v
         uWiwhWf5ma3lcqdO0jXEVvm6twHH8L+xjrSqVE642db359j2h/CAyxzEL5qOLR7v04
         mnIPc+UDvWD0d5dxbF1n+Sqvo6nbWVIoAaw6cPcU=
Date:   Sun, 21 Mar 2021 13:33:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging/IIO driver fixes for 5.12-rc4
Message-ID: <YFc8/KJBiKVT2Rt1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc4

for you to fetch changes up to 2cafd46a714af1e55354bc6dcea9dcc13f9475b5:

  staging: vt665x: fix alignment constraints (2021-03-18 10:21:46 +0100)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.12-rc4

Here are some small staging and IIO driver fixes for 5.12-rc4.

They include:
	- MAINTAINERS changes for the move of the staging mailing list
	- comedi driver fixes to get request_irq() to work correctly
	- counter driver fixes for reported issues with iio devices
	- tiny iio driver fixes for reported issues.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: adi-axi-adc: add proper Kconfig dependencies

Dan Carpenter (1):
      iio: adis16400: Fix an error code in adis16400_initial_setup()

Dinghao Liu (1):
      iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler

Edmundo Carmona Antoranz (1):
      staging: vt665x: fix alignment constraints

Fabrice Gasnier (2):
      counter: stm32-timer-cnt: fix ceiling write max value
      counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register

Greg Kroah-Hartman (3):
      Merge tag 'iio-fixes-for-5.12a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus
      MAINTAINERS: move some real subsystems off of the staging mailing list
      MAINTAINERS: move the staging subsystem to lists.linux.dev

Jonathan Albrieux (1):
      iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel

Jonathan Cameron (1):
      iio:adc:stm32-adc: Add HAS_IOMEM dependency

Linus Walleij (1):
      iio: adc: ab8500-gpadc: Fix off by 10 to 3

Tong Zhang (2):
      staging: comedi: cb_pcidas: fix request_irq() warn
      staging: comedi: cb_pcidas64: fix request_irq() warn

Wilfried Wessner (1):
      iio: adc: ad7949: fix wrong ADC result due to incorrect bit mask

William Breathitt Gray (1):
      counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED

Ye Xiang (3):
      iio: hid-sensor-prox: Fix scale not correct issue
      iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
      iio: hid-sensor-temperature: Fix issues of timestamp channel

 MAINTAINERS                                      |  7 ++-
 drivers/counter/stm32-timer-cnt.c                | 55 ++++++++++++++----------
 drivers/iio/adc/Kconfig                          |  3 ++
 drivers/iio/adc/ab8500-gpadc.c                   |  2 +-
 drivers/iio/adc/ad7949.c                         |  2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                 |  2 +-
 drivers/iio/gyro/mpu3050-core.c                  |  2 +
 drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++---
 drivers/iio/imu/adis16400.c                      |  3 +-
 drivers/iio/light/hid-sensor-prox.c              | 13 +++++-
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++---
 drivers/staging/comedi/drivers/cb_pcidas.c       |  2 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c     |  2 +-
 drivers/staging/vt6655/rxtx.h                    |  4 +-
 14 files changed, 75 insertions(+), 48 deletions(-)

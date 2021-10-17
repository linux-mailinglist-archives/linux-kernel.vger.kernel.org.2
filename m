Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9464307B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbhJQKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245276AbhJQKIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23EF61054;
        Sun, 17 Oct 2021 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634465189;
        bh=LLsZemof81lU+lesF80hZEG0WEZN7RiatSlBKGKxGbk=;
        h=Date:From:To:Cc:Subject:From;
        b=krn8pSqnOWloufqahI7/eZDxUmkolTTUPfbEnm16rR2vsAsGFHKUDzXPYgmyinEvd
         KtUtRWGJiTrM8u6eQW29SsK0Cd+c20FLhGwSI8cvj6iBjnMVPsay7N5k86q3VlqZBw
         oh9+FgF6HF8dAGFtSsJC4gSwz0oeSpr/WJLT/HCU=
Date:   Sun, 17 Oct 2021 12:06:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.15-rc6
Message-ID: <YWv1ojsgySFtQr5J@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc6

for you to fetch changes up to 37f12202c5d28291ba5f83ce229771447ce9148f:

  staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask() (2021-10-05 12:35:30 +0200)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.15-rc6

Here are a number of small IIO and staging driver fixes for 5.15-rc6.

They include:
	- vc04_services bugfix for reported problem
	- r8188eu array underflow fix
	- iio driver fixes for a lot of tiny reported issues.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Tachici (3):
      iio: adc: ad7192: Add IRQ flag
      iio: adc: ad7780: Fix IRQ flag
      iio: adc: ad7793: Fix IRQ flag

Arnd Bergmann (1):
      staging: vc04_services: shut up out-of-range warning

Billy Tsai (1):
      iio: adc: aspeed: set driver data when adc probe.

Christophe JAILLET (1):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'

Colin Ian King (1):
      iio: adc: rzg2l_adc: Fix -EBUSY timeout error return

Dan Carpenter (4):
      iio: dac: ti-dac5571: fix an error code in probe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()
      staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask()

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.15a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next

Hui Liu (1):
      iio: mtk-auxadc: fix case IIO_CHAN_INFO_PROCESSED

Jiri Valek - 2N (1):
      iio: light: opt3001: Fixed timeout error when 0 lux

Miquel Raynal (2):
      iio: adc: max1027: Fix wrong shift with 12-bit devices
      iio: adc: max1027: Fix the number of max1X31 channels

Nuno Sá (2):
      iio: adis16475: fix deadlock on frequency set
      iio: adis16480: fix devices that do not support sleep mode

Sean Nyekjaer (1):
      iio: accel: fxls8962af: return IRQ_HANDLED when fifo is flushed

Yang Yingliang (1):
      iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()

 drivers/iio/accel/fxls8962af-core.c                        |  2 +-
 drivers/iio/adc/ad7192.c                                   |  1 +
 drivers/iio/adc/ad7780.c                                   |  2 +-
 drivers/iio/adc/ad7793.c                                   |  2 +-
 drivers/iio/adc/aspeed_adc.c                               |  1 +
 drivers/iio/adc/max1027.c                                  |  3 +--
 drivers/iio/adc/mt6577_auxadc.c                            |  8 ++++++++
 drivers/iio/adc/rzg2l_adc.c                                |  6 ++++--
 drivers/iio/adc/ti-adc128s052.c                            |  6 ++++++
 drivers/iio/common/ssp_sensors/ssp_spi.c                   | 11 +++++++++--
 drivers/iio/dac/ti-dac5571.c                               |  1 +
 drivers/iio/imu/adis16475.c                                |  3 ++-
 drivers/iio/imu/adis16480.c                                | 14 +++++++++++---
 drivers/iio/light/opt3001.c                                |  6 +++---
 drivers/staging/r8188eu/hal/hal_intf.c                     |  2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  |  2 +-
 16 files changed, 52 insertions(+), 18 deletions(-)

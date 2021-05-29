Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA90394C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhE2O2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhE2O2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 543B061157;
        Sat, 29 May 2021 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622298430;
        bh=oFtbwDI1AyvLbbJIuZMSthbSfn24iCR/EAVxWaL1CIo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZLHa+XpkNXyW63cp8JSL8L156p1Uk8zeAcJ3SB/tOAUJBu3Ar5jhyyRS3740SQfy+
         D4VzeEHoZRqzC7UTCzdMwoXmDpBvIqYKfaxsyVmbQX8bqKlKgihYLjJtxf731VNmel
         T1gl1AelgwVNXaWuzvEYMtDOK1F89Z4LOPQNJIjU=
Date:   Sat, 29 May 2021 16:27:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging/IIO driver fixes for 5.13-rc4
Message-ID: <YLJPPF9wg6b1Cssj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc4

for you to fetch changes up to 54732a5322ff1fe0f42f2527fa6f5901a4de5111:

  Merge tag 'iio-fixes-5.13b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-05-22 09:49:59 +0200)

----------------------------------------------------------------
Staging / IIO driver fixes for 5.13-rc4

Here are some small IIO and staging driver fixes for reported issues for
5.13-rc4.

Nothing major here, tiny changes for reported problems, full details are
in the shortlog if people are curious.

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: ad7192: handle regulator voltage error first

Andy Shevchenko (1):
      iio: dac: ad5770r: Put fwnode in error case during ->probe()

Dan Carpenter (1):
      staging: emxx_udc: fix loop in _nbu2ss_nuke()

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-5.13b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus

Jonathan Cameron (5):
      iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
      iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
      iio: adc: ad7192: Avoid disabling a clock that was never enabled.
      iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()
      iio: adc: ad7923: Fix undersized rx buffer.

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Rui Miguel Silva (1):
      iio: gyro: fxas21002c: balance runtime power in error path

YueHaibing (1):
      iio: adc: ad7793: Add missing error code in ad7793_setup()

 drivers/iio/adc/ad7124.c            | 36 ++++++++++++++++++++----------------
 drivers/iio/adc/ad7192.c            | 19 ++++++++++---------
 drivers/iio/adc/ad7768-1.c          |  8 ++++++--
 drivers/iio/adc/ad7793.c            |  1 +
 drivers/iio/adc/ad7923.c            |  4 +++-
 drivers/iio/dac/ad5770r.c           | 16 +++++++++++-----
 drivers/iio/gyro/fxas21002c_core.c  |  2 ++
 drivers/staging/emxx_udc/emxx_udc.c |  4 ++--
 drivers/staging/iio/cdc/ad7746.c    |  1 -
 9 files changed, 55 insertions(+), 36 deletions(-)
